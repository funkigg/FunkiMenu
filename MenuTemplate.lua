local _, addon = ...

addon.MenuTemplate = {
    title = "Project Menu",
    width = 340,
    buttonHeight = 24,
    padding = 12,
    anchorPoint = "CENTER",
    items = {
        {
            type = "label",
            text = "This is a placeholder scaffold. Replace entries in MenuTemplate.lua.",
        },
        {
            type = "separator",
        },
        {
            type = "button",
            text = "Primary Action",
            onClick = function()
                print("Primary action placeholder")
            end,
        },
        {
            type = "button",
            text = "Secondary Action",
            onClick = function()
                print("Secondary action placeholder")
            end,
        },
        {
            type = "toggle",
            text = "Enable Optional Feature",
            defaultState = false,
            onToggle = function(enabled)
                print("Optional feature state:", enabled and "enabled" or "disabled")
            end,
        },
    },
}
