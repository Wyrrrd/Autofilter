--control.lua
require("integrations.informatron.control")
require("integrations.wiki.control")

--functions definitions
local function is_filter_empty(inserter)
	for slot = 1,inserter.filter_slot_count do
		if inserter.get_filter(slot) then
			return false
		end
	end
	return true
end

local function get_items_by_contents(inserter,inventory)
	local items = {}
	for item,_ in pairs(inventory.get_contents()) do
		if #items < inserter.filter_slot_count then
			items[#items+1] = item
		end
	end
	return items
end

local function get_items_by_filter(inserter,inventory)
	local items = {}
	for slot = 1,#inventory do
		if #items < inserter.filter_slot_count and inventory.get_filter(slot) then
			items[#items+1] = inventory.get_filter(slot)
		end
	end
	return items
end

local function on_built_entity(event)
	local mode = game.players[event.player_index].mod_settings["autofilter_mode"].value
	if mode ~= "none" then
		local inserter = event.created_entity
		if inserter.type == "inserter" then
			if inserter.filter_slot_count then
				if is_filter_empty(inserter) and inserter.inserter_filter_mode == "whitelist" then
					local pickup = inserter.surface.find_entities_filtered({position = inserter.pickup_position, limit = 1})
					if #pickup > 0 then
						local inventory = pickup[1].get_output_inventory()
						if inventory then
							if mode == "contents" and not inventory.is_empty() then
								for slot,item in pairs(get_items_by_contents(inserter,inventory)) do
									inserter.set_filter(slot,item)
								end
							elseif mode == "filter" and inventory.is_filtered() then
								for slot,item in pairs(get_items_by_filter(inserter,inventory)) do
									inserter.set_filter(slot,item)
								end
							end
						end
					end
				end
			end
		end
	end
end

--event handling
script.on_event(defines.events.on_built_entity, on_built_entity,{{filter="type", type = "inserter"}})