local _, private = ...

local Class = private.Class

local Tooltip = Class:extend()
private.Tooltip = Tooltip

function Tooltip:construct(frame, builder)
    self.builder = builder
    self:attach(frame)
end

function Tooltip:attach(frame)
    self.frame = frame
    self.frame:SetScript('OnEnter', function() self:_show() end)
    self.frame:SetScript('OnLeave', function() self:_hide() end)
end

function Tooltip:detach()
    self.frame:SetScript('OnEnter', nil)
    self.frame:SetScript('OnLeave', nil)
    self.frame = nil
end

function Tooltip:_show()
    GameTooltip:SetOwner(self.frame, "ANCHOR_CURSOR")
    GameTooltip:ClearLines()
    self.builder(GameTooltip)
    GameTooltip:Show()
end

function Tooltip:_hide()
    GameTooltip:Hide()
end