--control.lua

--functions definitions
local function concatenate_tables(table1,table2)
	for i = 1,#table2 do
		table1[#table1+1]=table2[i]
	end
	return table1
end

local function string_to_table(str)
	local words = {}
	for word in str:gmatch("([^%s]+)") do
		words[#words+1] = word
	end
	return words
end

local function is_filter_empty(inserter)
	for slot = 1,inserter.filter_slot_count do
		if inserter.get_filter(slot) then
			return false
		end
	end
	return true
end

local function deduplicate_items(items)
	local dedup_items = {}
	local marker = false
	for i=1,#items do
		for j=i+1,#items do
			if items[i] == items[j] then
				marker = true
			end
		end
		if not marker then
			dedup_items[#dedup_items+1]=items[i]
		end
		marker = false
	end
	return dedup_items
end

local function remove_noninsertable_items(items,entity)
	local search_inventories = {
		defines.inventory.fuel,
		defines.inventory.chest,
		defines.inventory.furnace_source,
		defines.inventory.roboport_robot,
		defines.inventory.roboport_material,
		defines.inventory.assembling_machine_input,
		defines.inventory.lab_input,
		defines.inventory.item_main,
		defines.inventory.rocket_silo_rocket,
		defines.inventory.cargo_wagon,
		defines.inventory.turret_ammo,
		defines.inventory.artillery_turret_ammo,
		defines.inventory.artillery_wagon_ammo,
	}
	local insert_items = {}
	local no_inventory_flag = true
	local item_insertable_flag = false

	for i=1,#items do
		for _,search_inventory in pairs(search_inventories) do
			local inventory = entity.get_inventory(search_inventory)
			if inventory then
				no_inventory_flag = false
				if inventory.can_insert(items[i]) then
					item_insertable_flag = true
				end
			end
		end
		if no_inventory_flag then
			insert_items = items
			break
		end
		if item_insertable_flag then
			insert_items[#insert_items+1]=items[i]
			item_insertable_flag = false
		end
	end
	return insert_items
end

local function get_items_by_content(inventory)
	local content_items = {}
	for item,_ in pairs(inventory.get_contents()) do
		content_items[#content_items+1] = item
	end
	return content_items
end

local function get_items_by_filter(inventory)
	local filter_items = {}
	for slot = 1,#inventory do
		if inventory.get_filter(slot) then
			filter_items[#filter_items+1] = inventory.get_filter(slot)
		end
	end
	return filter_items
end

local function get_items_by_transport_line(belt)
	local belt_items = {}
	for i = 1,belt.get_max_transport_line_index() do
		local line = belt.get_transport_line(i)
		if line and line.valid then
			belt_items = concatenate_tables(belt_items,get_items_by_content(line))
		end
	end
	return belt_items
end

local function on_built_entity(event)
	-- Read settings
	local mode = string_to_table(game.players[event.player_index].mod_settings["autofilter_mode"].value)
	local search_inventories = {
		defines.inventory.fuel,
		defines.inventory.chest,
		defines.inventory.furnace_source,
		defines.inventory.roboport_robot,
		defines.inventory.roboport_material,
		defines.inventory.assembling_machine_input,
		defines.inventory.lab_input,
		defines.inventory.item_main,
		defines.inventory.rocket_silo_rocket,
		defines.inventory.cargo_wagon,
		defines.inventory.turret_ammo,
		defines.inventory.artillery_turret_ammo,
		defines.inventory.artillery_wagon_ammo,
	}

	local inserter = event.created_entity
	if inserter and inserter.valid and (inserter.type == "inserter") then
		if inserter.filter_slot_count then
			if is_filter_empty(inserter) and inserter.inserter_filter_mode == "whitelist" then
				local pickup = inserter.surface.find_entities_filtered({position = inserter.pickup_position, force = inserter.force, surface = inserter.surface, limit = 1})
				local drop = inserter.surface.find_entities_filtered({position = inserter.drop_position, force = inserter.force, surface = inserter.surface, limit = 1})
				if pickup[1] and pickup[1].valid then
					-- Prequisites
					local inventory_pickup = pickup[1].get_output_inventory()

					if (pickup[1].type == "transport-belt" or pickup[1].type == "underground-belt" or pickup[1].type == "splitter") then
						local maxlines = pickup[1].get_max_transport_line_index()
					end
					local items = {}
					local check = false

					-- Read each mode element
					for _,step in pairs(mode) do
						if step == "contents" then
							-- Read inventory contents at pickup, write to filter
							if inventory_pickup and not inventory_pickup.is_empty() then
								items = concatenate_tables(items,get_items_by_content(inventory_pickup))
							end
						elseif step == "filter" then
							-- Read inventory filter at pickup, write to filter
							if inventory_pickup and inventory_pickup.is_filtered() then
								items = concatenate_tables(items,get_items_by_filter(inventory_pickup))
							end
						elseif step == "belt" then
							-- Read belt transport lines at pickup, write to filter
							if (pickup[1].type == "transport-belt" or pickup[1].type == "underground-belt" or pickup[1].type == "splitter") and pickup[1].get_max_transport_line_index() then
								items = concatenate_tables(items,get_items_by_transport_line(pickup[1]))
							end
						elseif step == "check" then
							-- Drop inventory insertion check
							if drop[1] and drop[1].valid then
								items = remove_noninsertable_items(items,drop[1])
							end
						end
					end

					-- Filter candidate cleanup
					if #items > 0 then
						-- Deduplication
						items = deduplicate_items(items)

						-- Writing filter until full
						for slot = 1, inserter.filter_slot_count do
							inserter.set_filter(slot,items[slot])
						end
					end
				end
			end
		end
	end
end

--event handling
script.on_event(defines.events.on_built_entity, on_built_entity,{{filter="type", type = "inserter"}})