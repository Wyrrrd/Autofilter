require("integrations.wiki.wiki")

if script.active_mods["wiki"] then
  local initialize_wiki = function()
    remote.call("wiki","register_mod_wiki",autofilter_wiki)
  end
    
  script.on_init(function() initialize_wiki() end)
  script.on_load(function() initialize_wiki() end) 
end