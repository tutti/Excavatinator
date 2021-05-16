local _, private = ...

local Event = private.Event
local Button = private.Button
local Bar = private.Bar
local Label = private.Label
local ArtifactSolveButton = private.ArtifactSolveButton
local Tooltip = private.Tooltip

local events = private.events

local RaceLine = Button:extend()
private.RaceLine = RaceLine

function RaceLine:construct(parent, race)
    Button.construct(self, nil, 'ExcavatinatorRaceLine' .. race.id, parent)

    self.race = race

    self.frame:SetWidth(620)
    self.frame:SetHeight(50)
    self.frame:RegisterForClicks('LeftButtonUp')

    self.icon = CreateFrame('Frame', 'ExcavatinatorRaceLineIcon' .. race.id, self.frame)
    self.icon:SetSize(64, 64)
    self.icon.texture = self.icon:CreateTexture()
    self.icon.texture:SetTexture(race.icon)
    self.icon.texture:SetDrawLayer('BACKGROUND')
    self.icon.texture:SetAllPoints()
    self.icon:SetPoint('LEFT', 0, -10)

    self.raceName = Label:new(self.frame, race.name)
    self.raceName.frame:SetPoint("LEFT", 50, 0)

    self.progressBar = Bar:new('ExcavatinatorRaceProgressBar' .. race.id, self.frame)
    self.progressBar:setSize(160, 10)
    self.progressBar.frame:SetPoint("LEFT", 190, 0)

    self.progressLabel = Label:new(self.frame, "50 / 50")
    self.progressLabel.frame:SetPoint("LEFT", 360, 0)

    self.artifactButton = ArtifactSolveButton:new(self.frame)
    self.artifactButton.frame:SetPoint('LEFT', 435, 0)
    self.artifactButton:setRace(race)

    self.artifactBar = Bar:new('ExcavatinatorRaceFragmentBar' .. race.id, self.frame)
    self.artifactBar:setSize(50, 10)
    self.artifactBar.frame:SetPoint("LEFT", 480, 0)

    self.artifactCount = Label:new(self.frame, "200 / 200")
    self.artifactCount.frame:SetPoint("LEFT", 540, 0)

    self.tooltip = Tooltip:new(self.frame, function(tooltip)
        local completed, total, solves = self.race:getProgress(true)

        tooltip:AddLine(self.race.name, 1, 1, 1)
        tooltip:AddDoubleLine('Progress:', completed .. ' / ' .. total, 1, 1, 1, completed == total and 0 or 1, 1, 0)
        tooltip:AddDoubleLine('Total solves:', solves, 1, 1, 1, 1, 1, 1)
        tooltip:AddLine(' ')

        local artifact = self.race:getActiveArtifact()
        if not artifact then return end
        if artifact then
            local fragments, needed, canSolve = artifact:getProgress(private.settings.useKeystones)

            tooltip:AddLine(artifact.spellName, 0, 1, 1)
            tooltip:AddDoubleLine('Fragments:', fragments .. ' / ' .. needed, 1, 1, 1, canSolve and 0 or 1, 1, 0)
            if artifact.hasPristineVersion then tooltip:AddLine(artifact.pristineHasBeenCompleted and 'Pristine artifact complete' or 'Pristine artifact incomplete', artifact.pristineHasBeenCompleted and 0 or 1, 1, 0) end
            if canSolve then tooltip:AddLine('Click artifact icon to solve', 0, 1, 0) end
            tooltip:AddLine(' ')
        end

        tooltip:AddLine('Click to open race details frame', 1, 1, 1)
    end)

    self.events = {
        click = Event:new('click'),
    }

    self.frame:SetScript('OnClick', function() self.events.click:trigger() end)

    self:_redraw()

    self.listener = function() self:_redraw() end
    self.race.events.updated:addListener(self.listener)
    events.settingsChanged:addListener(self.listener)
end

function RaceLine:_redraw()
    local completed, total, solves = self.race:getProgress(true)
    self.progressBar:setFill(completed/total)
    self.progressLabel:setText(completed .. ' / ' .. total)

    local activeArtifact = self.race:getActiveArtifact()
    if activeArtifact then
        local fragments, needed, canSolve = activeArtifact:getProgress(private.settings.useKeystones)
        self.artifactBar.frame:Show()
        self.artifactBar:setFill(fragments/needed)
        self.artifactCount.frame:Show()
        self.artifactCount:setText(fragments .. ' / ' .. needed)
    else
        self.artifactBar.frame:Hide()
        self.artifactCount.frame:Hide()
    end
end