local _, addon = ...

addon.MenuTemplate = {
    title = "FunkiMenu",
    width = 420,
    height = 320,
    tabs = {
        {
            id = "placeholder_tab_1",
            label = "Placeholder Tab 1",
            subtabs = {
                {
                    id = "placeholder_subtab_1",
                    label = "Placeholder Subtab 1",
                    content = "Replace this content in MenuTemplate.lua",
                },
            },
        },
        {
            id = "placeholder_tab_2",
            label = "Placeholder Tab 2",
            subtabs = {
                {
                    id = "placeholder_subtab_2",
                    label = "Placeholder Subtab 2",
                    content = "Add additional subtabs and content as needed.",
                },
            },
        },
    },
}
