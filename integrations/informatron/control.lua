if script.active_mods["informatron"] then
	remote.add_interface("autofilter", {
	  informatron_menu = function(data)
		return autofilter_menu(data.player_index)
	  end,
	  informatron_page_content = function(data)
		return autofilter_page_content(data.page_name, data.player_index, data.element)
	  end
	})
end

function autofilter_menu(player_index)
  return {}
end

function autofilter_page_content(page_name, player_index, element)
  if page_name == "autofilter" then
    element.add{type="button", name="image_autofilter", style="autofilter_logo"}
    element.add{type="label", name="text_autofilter", caption={"autofilter.page_autofilter_text"}}
    element.add{type="label", name="heading_modes", caption={"autofilter.page_modes_heading"}, style="heading_1_label"}
    element.add{type="label", name="heading_contents", caption={"autofilter.page_contents_heading"}, style="heading_2_label"}
    element.add{type="button", name="image_contents", style="autofilter_settings_contents"}
    element.add{type="label", name="text_contents", caption={"autofilter.page_contents_text"}}
    element.add{type="label", name="heading_filter", caption={"autofilter.page_filter_heading"}, style="heading_2_label"}
    element.add{type="button", name="image_filter", style="autofilter_settings_filter"}
    element.add{type="label", name="text_filter", caption={"autofilter.page_filter_text"}}
    element.add{type="label", name="heading_none", caption={"autofilter.page_none_heading"}, style="heading_2_label"}
    element.add{type="button", name="image_none", style="autofilter_settings_none"}
    element.add{type="label", name="text_none", caption={"autofilter.page_none_text"}}
  end
end