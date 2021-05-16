local _, private = ...

local SpellButton = private.SpellButton
local Tooltip = private.Tooltip

local SurveyButton = SpellButton:extend()
private.SurveyButton = SurveyButton

function SurveyButton:construct(parent)
    SpellButton.construct(self, (parent and parent:GetName() or 'Excavatinator') .. 'SurveyButton', parent, 80451)

    self.tooltip = Tooltip:new(self.frame, function(tooltip)
        local surveyLink = GetSpellLink(80451)
        tooltip:SetHyperlink(surveyLink)
    end)
end