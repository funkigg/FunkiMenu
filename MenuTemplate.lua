local _, addon = ...

addon.MenuTemplate = {
    title = "Project Placeholder Menu",
    width = 420,
    height = 320,
    tabs = {
        {
            id = "main",
            label = "Main",
            subtabs = {
                {
                    id = "overview",
                    label = "Overview",
                    content = "Replace this with your main overview content.",
                },
                {
                    id = "settings",
                    label = "Settings",
                    content = "Replace this with your settings content.",
                },
            },
        },
        {
            id = "extras",
            label = "Extras",
            subtabs = {
                {
                    id = "notes",
                    label = "Notes",
                    content = "Use this for project-specific notes or info.",
                },
            },
        },
    },
}
