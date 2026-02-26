local addonName, addon = ...

local MenuScaffold = {}
addon.MenuScaffold = MenuScaffold

local DEFAULT_DATA = {
    title = "Menu Scaffold",
    width = 420,
    height = 320,
    tabs = {
        {
            id = "tab_one",
            label = "Tab One",
            subtabs = {
                { id = "subtab_a", label = "Subtab A", content = "Placeholder content for Subtab A." },
                { id = "subtab_b", label = "Subtab B", content = "Placeholder content for Subtab B." },
            },
        },
        {
            id = "tab_two",
            label = "Tab Two",
            subtabs = {
                { id = "subtab_a", label = "Subtab A", content = "Placeholder content for Tab Two / Subtab A." },
            },
        },
    },
}

local function copyDefaults(target, source)
    if type(source) ~= "table" then
        return target
    end

    target = target or {}
    for key, value in pairs(source) do
        if type(value) == "table" then
            target[key] = copyDefaults(target[key], value)
        elseif target[key] == nil then
            target[key] = value
        end
    end

    return target
end

local function clearButtons(buttons)
    for _, button in ipairs(buttons) do
        button:Hide()
    end
    wipe(buttons)
end

local function setContent(frame, text)
    frame.contentText:SetText(text or "Placeholder content")
end

local function renderSubtabs(frame, tab)
    clearButtons(frame.subtabButtons)
    frame.activeSubtab = nil

    local previous
    for _, subtab in ipairs(tab.subtabs or {}) do
        local button = addon.OptionsElements.CreateSubtabButton(frame, previous, subtab.label, function()
            frame.activeSubtab = subtab.id
            setContent(frame, subtab.content)
        end)

        table.insert(frame.subtabButtons, button)
        previous = button
    end

    if tab.subtabs and tab.subtabs[1] then
        frame.activeSubtab = tab.subtabs[1].id
        setContent(frame, tab.subtabs[1].content)
    else
        setContent(frame, "No subtabs configured for this tab.")
    end
end

local function renderTabs(frame, config)
    clearButtons(frame.tabButtons)
    frame.activeTab = nil

    local previous
    for _, tab in ipairs(config.tabs or {}) do
        local button = addon.OptionsElements.CreateTabButton(frame, previous, tab.label, function()
            frame.activeTab = tab.id
            renderSubtabs(frame, tab)
        end)

        table.insert(frame.tabButtons, button)
        previous = button
    end

    if config.tabs and config.tabs[1] then
        frame.activeTab = config.tabs[1].id
        renderSubtabs(frame, config.tabs[1])
    else
        setContent(frame, "No tabs configured.")
    end
end

function MenuScaffold:Build(data)
    local config = copyDefaults(data, DEFAULT_DATA)

    if self.frame then
        self.frame:Hide()
        self.frame = nil
    end

    local frame = CreateFrame("Frame", addonName .. "ScaffoldFrame", UIParent, "BackdropTemplate")
    frame:SetSize(config.width, config.height)
    frame:SetPoint("CENTER")
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame.tabButtons = {}
    frame.subtabButtons = {}

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -14)
    frame.title:SetText(config.title)

    frame.tabAnchor = CreateFrame("Frame", nil, frame)
    frame.tabAnchor:SetSize(config.width - 24, 24)
    frame.tabAnchor:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -42)

    frame.subtabAnchor = CreateFrame("Frame", nil, frame)
    frame.subtabAnchor:SetSize(config.width - 24, 22)
    frame.subtabAnchor:SetPoint("TOPLEFT", frame.tabAnchor, "BOTTOMLEFT", 0, -8)

    frame.contentText = addon.OptionsElements.CreateContentText(frame)

    renderTabs(frame, config)

    frame:Hide()
    self.frame = frame
    self.config = config

    return frame
end

function MenuScaffold:Toggle()
    if not self.frame then
        return
    end

    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

SLASH_FUNKIMENU1 = "/funkimenu"
SlashCmdList.FUNKIMENU = function()
    if not MenuScaffold.frame then
        MenuScaffold:Build(addon.MenuTemplate or DEFAULT_DATA)
    end

    MenuScaffold:Toggle()
end
