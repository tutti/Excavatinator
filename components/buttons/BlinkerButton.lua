local _, private = ...

local Button = private.Button
local Label = private.Label
local Tooltip = private.Tooltip

local BlinkerButton = Button:extend()
private.BlinkerButton = BlinkerButton

function BlinkerButton:construct(name, parent, color)
    Button.construct(self, nil, name, parent)

    self.color = color

    self.frame:SetWidth(50)
    self.frame:SetHeight(50)
    self.frame:SetPoint('BOTTOMLEFT', 15, 15)
    self.blinker = CreateFrame('Frame', name .. 'Blinker', self.frame)
    self.blinker:SetWidth(16)
    self.blinker:SetHeight(16)
    self.blinker:SetPoint('TOP', 0, -10)
    self.blinker.texture = self.blinker:CreateTexture()
    self.blinker.texture:SetDrawLayer('BACKGROUND')
    self.blinker.texture:SetAllPoints()
    self.blinker.animationGroup = self.blinker:CreateAnimationGroup()
    self.blinker.animationGroup:SetLooping('BOUNCE')
    self.blinker.animation = self.blinker.animationGroup:CreateAnimation('Alpha')
    self.blinker.animation:SetFromAlpha(1)
    if color == 'red' then
        self.blinker.texture:SetColorTexture(1, 0, 0)
        self.blinker.animation:SetToAlpha(0.4)
        self.blinker.animation:SetDuration(0.6)
    elseif color == 'yellow' then
        self.blinker.texture:SetColorTexture(1, 1, 0)
        self.blinker.animation:SetToAlpha(0.4)
        self.blinker.animation:SetDuration(0.3)
    elseif color == 'green' then
        self.blinker.texture:SetColorTexture(0, 1, 0)
        self.blinker.animation:SetToAlpha(0.7)
        self.blinker.animation:SetDuration(0.12)
    end
    self.blinker.animation:SetSmoothing('IN_OUT')
    self.blinker.animationGroup:Play()
    self.label = Label:new(self.frame, color:sub(1,1):upper()..color:sub(2))
    self.label.frame:SetPoint('TOP',0, -30)
    Tooltip:new(self.frame, function(tooltip)
        tooltip:AddLine('Click to mark your')
        tooltip:AddLine('last survey as ' .. color:upper())
    end)
    --[[self.frame:SetScript('OnClick', function()
        private.MinimapManager:setLastSurveyResult(color)
    end)]]
end

function BlinkerButton:onClick()
    private.MinimapManager:setLastSurveyResult(self.color)
end