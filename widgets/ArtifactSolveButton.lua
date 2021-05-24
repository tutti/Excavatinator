local _, private = ...

local TextureButton = private.TextureButton
local Label = private.Label

local events = private.events

local ArtifactSolveButton = TextureButton:extend()
private.ArtifactSolveButton = ArtifactSolveButton

function ArtifactSolveButton:construct(parent)
    TextureButton.construct(self, parent:GetName() .. 'ArtifactSolveButton', parent)

    self.frame:SetWidth(32)
    self.frame:SetHeight(32)
    self.frame:SetEnabled(false)

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

    self.listener = function() self:redraw() end
    events.settingsChanged:addListener(self.listener)
end

function ArtifactSolveButton:redraw()
    if not self.race then
        self.frame:Hide()
        return
    end
    local artifact = self.race:getActiveArtifact()
    if not artifact then
        self.frame:Hide()
        return
    end

    if artifact.hasPristineVersion and not artifact.pristineHasBeenCompleted then
        self.pristineMark.texture:Show()
    else
        self.pristineMark.texture:Hide()
    end

    if artifact.hasAchievement and artifact.timesCompleted < artifact.achievementRequirement then
        self.achievementLabel:setText(artifact.timesCompleted .. '/' .. artifact.achievementRequirement)
        self.achievementLabel.frame:Show()
    else
        self.achievementLabel.frame:Hide()
    end

    local _, _, canSolve = artifact:getProgress(private.settings.useKeystones)
    self:setTexture(artifact.icon)
    self.frame:Show()
    self.frame:SetEnabled(canSolve)
end

function ArtifactSolveButton:setRace(race)
    if self.race then self.race.events.updated:removeListener(self.listener) end
    self.race = race
    if race then race.events.updated:addListener(self.listener) end
    self:redraw()
end

function ArtifactSolveButton:onClick()
    local artifact = self.race:getActiveArtifact()
    artifact:solve(private.settings.useKeystones)
end