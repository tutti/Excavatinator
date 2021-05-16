local _, private = ...

local Frame = private.Frame
local Tooltip = private.Tooltip
local Label = private.Label

local ArtifactIcon = Frame:extend()
private.ArtifactIcon = ArtifactIcon

local R_RARE = 0
local G_RARE = 0.4392
local B_RARE = 1
local R_COMMON = 0.1176
local G_COMMON = 1
local B_COMMON = 0.0471

local function getWrappedDescription(spellID)
    local description = GetSpellDescription(spellID)
    
    local lines = {}
    while #description > 50 do
        local idx = description:find(' ', 50)
        if idx then
            lines[#lines+1] = description:sub(0, idx)
            description = description:sub(idx+1)
        else
            lines[#lines+1] = description
            description = ''
        end
    end
    lines[#lines+1] = description

    local out = lines[1]
    for i=2, #lines do
        out = out .. '\n' .. lines[i]
    end

    return out
end

function ArtifactIcon:construct(parent, index)
    Frame.construct(self, nil, 'ExcavatinatorArtifactStatusIcon' .. index, parent)

    self.frame:SetWidth(32)
    self.frame:SetHeight(32)

    self.frame.texture = self.frame:CreateTexture()
    self.frame.texture:SetDrawLayer('BACKGROUND')
    self.frame.texture:SetAllPoints()

    self.pristineMark = CreateFrame("Frame", nil, self.frame)
    self.pristineMark:SetPoint('CENTER', self.frame, 'TOPRIGHT', -2, -4)
    self.pristineMark:SetWidth(16)
    self.pristineMark:SetHeight(16)
    self.pristineMark.texture = self.pristineMark:CreateTexture()
    self.pristineMark.texture:SetTexture("Interface/MINIMAP/TRACKING/OBJECTICONS")
    self.pristineMark.texture:SetDrawLayer("BACKGROUND")
    self.pristineMark.texture:SetPoint("TOPLEFT")
    self.pristineMark.texture:SetWidth(16)
    self.pristineMark.texture:SetHeight(16)
    self.pristineMark.texture:SetTexCoord(1/8, 2/8, 1/2, 1)

    self.achievementLabel = Label:new(self.frame, '0/20', 10)
    self.achievementLabel.frame:SetPoint('BOTTOMLEFT', self.frame, 'BOTTOMLEFT', -2, -2)

    self.tooltip = Tooltip:new(self.frame, function(tooltip)
        if self.artifact.rarity == 'common' then
            tooltip:AddLine(self.artifact.itemName, R_COMMON, G_COMMON, B_COMMON)
        else
            tooltip:AddLine(self.artifact.itemName, R_RARE, G_RARE, B_RARE)
        end

        if self.artifact.hasBeenCompleted then
            tooltip:AddLine('Completed', 0, 1, 0)
        else
            tooltip:AddLine('Incomplete', 1, 1, 0)
        end

        if self.artifact.rarity == 'common' then
            if self.artifact.hasPristineVersion then
                if self.artifact.pristineHasBeenCompleted then
                    tooltip:AddLine('Pristine artifact completed', 0, 1, 0)
                else
                    tooltip:AddLine('Pristine artifact incomplete', 1, 1, 0)
                end
            end

            tooltip:AddLine(' ')

            if self.artifact.hasAchievement and self.artifact.timesCompleted < self.artifact.achievementRequirement then
                tooltip:AddDoubleLine('Achievement progress:', self.artifact.timesCompleted .. ' / ' .. self.artifact.achievementRequirement, 1, 1, 1, 1, 1, 0)
            else
                tooltip:AddDoubleLine('Times completed:', self.artifact.timesCompleted, 1, 1, 1, 1, 1, 1)
            end
        end

        tooltip:AddLine(' ')
        tooltip:AddLine(getWrappedDescription(self.artifact.spellID), 1, 1, 1)
    end)

    self.listener = function() self:_redraw() end
end

function ArtifactIcon:setArtifact(artifact)
    if self.artifact then
        self.artifact.events.updated:removeListener(self.listener)
    end
    self.artifact = artifact
    self.frame.texture:SetTexture(artifact.icon)
    artifact.events.updated:addListener(self.listener)
    self:_redraw()
end

function ArtifactIcon:_redraw()
    if not self.artifact then return end

    if self.artifact.hasBeenCompleted then
        self.frame.texture:SetDesaturated(false)
        self.frame.texture:SetVertexColor(1, 1, 1)
        self.frame:SetAlpha(1)
    else
        self.frame.texture:SetDesaturated(true)
        self.frame.texture:SetVertexColor(0.5, 0.5, 0.5)
        self.frame:SetAlpha(0.5)
    end

    if self.artifact.hasPristineVersion and not self.artifact.pristineHasBeenCompleted then
        self.pristineMark.texture:Show()
    else
        self.pristineMark.texture:Hide()
    end

    if self.artifact.hasAchievement and self.artifact.timesCompleted < self.artifact.achievementRequirement then
        self.achievementLabel:setText(self.artifact.timesCompleted .. '/' .. self.artifact.achievementRequirement)
        self.achievementLabel.frame:Show()
    else
        self.achievementLabel.frame:Hide()
    end
end