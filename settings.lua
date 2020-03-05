data:extend({
    {
        type = "string-setting",
        name = "autofilter_mode",
        default_value = "contents",
        allowed_values = {"contents","filter","none"},
        setting_type = "runtime-per-user",
        order = "a",
    },
})