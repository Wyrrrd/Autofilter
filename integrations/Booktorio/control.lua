local autofilter_thread =
{
    name = {"autofilter.menu_autofilter"},
    specified_version = 0,
    topics =
    {
        {
            name  = {"autofilter.title_autofilter"},
            topic =
            {
                {type = "image", spritename = "autofilter-logo"},
                {type = "text", text = "info.page_autofilter_text"}
            }
        },
        {
            name  = {"info.page_modes_heading"},
            topic =
            {
                {type = "title", title = {"info.page_modes_heading"}},
                {type = "subtitle", subtitle = {"info.page_contents_heading"}},
                {type = "image", spritename = "autofilter-settings-contents"},
                {type = "text", text = "info.page_contents_text"},
                {type = "subtitle", subtitle = {"info.page_filter_heading"}},
                {type = "image", spritename = "autofilter-settings-filter"},
                {type = "text", text = "info.page_filter_text"},
                {type = "subtitle", subtitle = {"info.page_none_heading"}},
                {type = "image", spritename = "autofilter-settings-none"},
                {type = "text", text = "info.page_none_text"}
            }
        }
    }
}

local function registerThread()
    if remote.interfaces["Booktorio"] then
        remote.call("Booktorio", "add_thread", autofilter_thread)
    end
end

script.on_init(registerThread)
script.on_configuration_changed(registerThread)