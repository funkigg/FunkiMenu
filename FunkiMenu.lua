local addonName, addon = ...

local MenuScaffold = {}
addon.MenuScaffold = MenuScaffold

local DEFAULT_MENU = {
    title = "Placeholder Menu",
    width = 320,
    buttonHeight = 24,
    padding = 12,
    items = {
        {
            type = "label",
            text = "Replace this data with your own menu entries.",
        },
        {
            type = "separator",
        },
        {
            type = "button",
            text = "Placeholder Action",
            onClick = function()
                print("[" .. addonName .. "] Placeholder action triggered.")
            end,
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

local function createBaseFrame(config)
    local frame = CreateFrame("Frame", addonName .. "Frame", UIParent, "BackdropTemplate")
    frame:SetSize(config.width, 120)
    frame:SetPoint(config.anchorPoint or "CENTER")
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

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -config.padding)
    title:SetText(config.title)
    frame.title = title

    return frame
end

local function applyButtonLayout(button, config)
    button:SetHeight(config.buttonHeight)
    button:SetNormalFontObject("GameFontNormal")
    button:SetHighlightFontObject("GameFontHighlight")
end

local function createItemWidget(parent, config, item, previous)
    local anchorX = config.padding
    local anchorY = previous and -6 or -(config.padding * 2 + 10)

    if item.type == "separator" then
        local line = parent:CreateTexture(nil, "ARTWORK")
        line:SetColorTexture(0.6, 0.6, 0.65, 0.7)
        line:SetHeight(1)
        line:SetPoint("TOPLEFT", previous or parent.title, previous and "BOTTOMLEFT" or "BOTTOMLEFT", 0, anchorY)
        line:SetPoint("TOPRIGHT", previous or parent.title, previous and "BOTTOMRIGHT" or "BOTTOMRIGHT", 0, anchorY)
        return line, 8
    end

    if item.type == "label" then
        local label = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        label:SetPoint("TOPLEFT", previous or parent.title, previous and "BOTTOMLEFT" or "BOTTOMLEFT", previous and 0 or -(parent:GetWidth() / 2 - anchorX), anchorY)
        if not previous then
            label:SetPoint("TOPLEFT", parent, "TOPLEFT", anchorX, anchorY)
        end
        label:SetPoint("RIGHT", parent, "RIGHT", -config.padding, 0)
        label:SetJustifyH("LEFT")
        label:SetText(item.text or "Placeholder Label")
        return label, 16
    end

    if item.type == "toggle" then
        local check = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        if previous then
            check:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, anchorY)
        else
            check:SetPoint("TOPLEFT", parent, "TOPLEFT", anchorX, anchorY)
        end

        check.text = check:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        check.text:SetPoint("LEFT", check, "RIGHT", 6, 0)
        check.text:SetText(item.text or "Placeholder Toggle")

        check:SetChecked(item.defaultState == true)
        check:SetScript("OnClick", function(self)
            if item.onToggle then
                item.onToggle(self:GetChecked())
            end
        end)

        return check, config.buttonHeight
    end

    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    if previous then
        button:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, anchorY)
    else
        button:SetPoint("TOPLEFT", parent, "TOPLEFT", anchorX, anchorY)
    end

    button:SetWidth(parent:GetWidth() - config.padding * 2)
    applyButtonLayout(button, config)
    button:SetText(item.text or "Placeholder Button")
    button:SetScript("OnClick", function()
        if item.onClick then
            item.onClick()
        end
    end)

    return button, config.buttonHeight
end

function MenuScaffold:Build(config)
    config = copyDefaults(config, DEFAULT_MENU)

    if self.frame then
        self.frame:Hide()
        self.frame = nil
    end

    local frame = createBaseFrame(config)
    local previous = nil
    local totalHeight = config.padding * 2 + 28

    for _, item in ipairs(config.items or {}) do
        local widget, height = createItemWidget(frame, config, item, previous)
        previous = widget
        totalHeight = totalHeight + (height or config.buttonHeight) + 6
    end

    frame:SetHeight(totalHeight)
    frame:Hide()

    self.frame = frame
    self.config = config

    return frame
end

function MenuScaffold:Show()
    if self.frame then
        self.frame:Show()
    end
end

function MenuScaffold:Hide()
    if self.frame then
        self.frame:Hide()
    end
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
        local baseConfig = addon.MenuTemplate or DEFAULT_MENU
        MenuScaffold:Build(baseConfig)
    end

    MenuScaffold:Toggle()
end
