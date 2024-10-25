data:extend({
    {
        type = "bool-setting",
        name = "autofilter_enabled",
        default_value = true,
        setting_type = "runtime-per-user",
        order = "autofilter-a",
    },
    {
        type = "string-setting",
        name = "autofilter_mode",
        default_value = "contents belt",
        setting_type = "runtime-per-user",
        order = "autofilter-b",
    },
})