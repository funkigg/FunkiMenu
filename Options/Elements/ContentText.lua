local _, addon = ...

addon.OptionsElements = addon.OptionsElements or {}

function addon.OptionsElements.CreateContentText(parent)
    local contentText = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    contentText:SetPoint("TOPLEFT", parent.subtabAnchor, "BOTTOMLEFT", 0, -16)
    contentText:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -14, 14)
    contentText:SetJustifyH("LEFT")
    contentText:SetJustifyV("TOP")
    contentText:SetText("Placeholder content")

    return contentText
end
