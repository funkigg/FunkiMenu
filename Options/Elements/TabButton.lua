local _, addon = ...

addon.OptionsElements = addon.OptionsElements or {}

function addon.OptionsElements.CreateTabButton(parent, previous, label, onClick)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(110, 24)

    if previous then
        button:SetPoint("TOPLEFT", previous, "TOPRIGHT", 6, 0)
    else
        button:SetPoint("TOPLEFT", parent.tabAnchor, "TOPLEFT", 0, 0)
    end

    button:SetText(label or "Tab")
    button:SetScript("OnClick", onClick)

    return button
end
