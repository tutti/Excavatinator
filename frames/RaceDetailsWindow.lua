local _, private = ...

local Window = private.Window
local Button = private.Button
local Label = private.Label
local ArtifactIcon = private.ArtifactIcon

local RaceDetailsWindow = Window:extend()
private.RaceDetailsWindow = RaceDetailsWindow

local RARE_ICONS = 10
local COMMON_ICONS = 32

function RaceDetailsWindow:construct(parent)
    Window.construct(self, 'ExcavatinatorRaceDetailsWindow', parent)

    self.frame:SetPoint('TOPLEFT', parent, 'BOTTOMLEFT')
    self.frame:SetPoint('TOPRIGHT', parent, 'BOTTOMRIGHT')
    self.frame:SetHeight(330)

    self.closeButton = Button:new("Button", "ExcavatinatorRaceDetailsCloseButton", self.frame, "UIPanelCloseButton")
    self.closeButton.frame:SetPoint("TOPRIGHT", -5, -5)

    self.raceIcon = CreateFrame('Frame', 'ExcavatinatorRaceDetailsWindowRaceIcon', self.frame)
    self.raceIcon:SetWidth(160)
    self.raceIcon:SetHeight(160)
    self.raceIcon.texture = self.raceIcon:CreateTexture()
    self.raceIcon.texture:SetDrawLayer('BACKGROUND')
    self.raceIcon.texture:SetAllPoints()
    self.raceIcon:SetPoint('TOPLEFT', 55, -40)

    self.raceLabel = Label:new(self.frame, 'Race', 18)
    self.raceLabel.frame:SetPoint('CENTER', self.frame, 'TOPLEFT', 100, -180)
    self.raceLabel.frame:SetWidth(140)

    self.progressLeftLabel = Label:new(self.frame, 'Progress:')
    self.progressLeftLabel.frame:SetPoint('BOTTOMLEFT', 30, 100)
    self.progressRightLabel = Label:new(self.frame, '20 / 20')
    self.progressRightLabel.frame:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMLEFT', 170, 100)

    self.rareProgressLeftLabel = Label:new(self.frame, 'Rares:')
    self.rareProgressLeftLabel.frame:SetPoint('BOTTOMLEFT', 30, 80)
    self.rareProgressRightLabel = Label:new(self.frame, '20 / 20')
    self.rareProgressRightLabel.frame:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMLEFT', 170, 80)

    self.commonProgressLeftLabel = Label:new(self.frame, 'Commons:')
    self.commonProgressLeftLabel.frame:SetPoint('BOTTOMLEFT', 30, 60)
    self.commonProgressRightLabel = Label:new(self.frame, '20 / 20')
    self.commonProgressRightLabel.frame:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMLEFT', 170, 60)

    self.pristineProgressLeftLabel = Label:new(self.frame, 'Pristines:')
    self.pristineProgressLeftLabel.frame:SetPoint('BOTTOMLEFT', 30, 40)
    self.pristineProgressRightLabel = Label:new(self.frame, '20 / 20')
    self.pristineProgressRightLabel.frame:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMLEFT', 170, 40)

    self.totalSolvesLeftLabel = Label:new(self.frame, 'Total solves:')
    self.totalSolvesLeftLabel.frame:SetPoint('BOTTOMLEFT', 30, 20)
    self.totalSolvesRightLabel = Label:new(self.frame, '10000')
    self.totalSolvesRightLabel.frame:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMLEFT', 170, 20)

    self.rareHeader = Label:new(self.frame, 'Rare')
    self.rareHeader.frame:SetPoint('TOPLEFT', 200, -35)

    self.rareIcons = {}
    for i=1, RARE_ICONS do
        self.rareIcons[i] = ArtifactIcon:new(self.frame, i)
        self.rareIcons[i].frame:SetPoint('TOPLEFT', 160 + 40*i, -55)
    end

    self.commonHeader = Label:new(self.frame, 'Common')
    self.commonHeader.frame:SetPoint('TOPLEFT', 200, -115)

    self.commonIcons = {}
    for i=1, COMMON_ICONS do
        self.commonIcons[i] = ArtifactIcon:new(self.frame, i)
        self.commonIcons[i].frame:SetPoint('TOPLEFT', 200 + 40*((i-1) % 8), -135 - 40*math.floor((i-1)/8))
    end

    self.frame:Hide()

    self.listener = function() self:_redraw() end
end

function RaceDetailsWindow:open(race)
    self.raceIcon.texture:SetTexture(race.icon)
    self.raceLabel:setText(race.name)

    if self.race then self.race.events.updated:removeListener(self.listener) end

    self.race = race
    self.artifacts = race:getAllArtifacts()

    race.events.updated:addListener(self.listener)

    self:_redraw()
    self.frame:Show()
end

function RaceDetailsWindow:_redraw()
    local completedRares, totalRares, completedCommons, totalCommons, completedPristines, totalPristines = 0, 0, 0, 0, 0, 0

    -- Divide artifacts into rares and commons, and count completion progress
    local rares, commons = {}, {}
    for i, artifact in ipairs(self.artifacts) do
        if artifact.rarity == 'rare' then
            rares[#rares+1] = artifact
            totalRares = totalRares + 1
            if artifact.hasBeenCompleted then completedRares = completedRares + 1 end
        else
            commons[#commons+1] = artifact
            totalCommons = totalCommons + 1
            if artifact.hasBeenCompleted then completedCommons = completedCommons + 1 end
        end
        if artifact.hasPristineVersion then totalPristines = totalPristines + 1 end
        if artifact.pristineHasBeenCompleted then completedPristines = completedPristines + 1 end
    end
    local completed, total, solves = self.race:getProgress(true)

    -- Update the progress section
    self.progressRightLabel:setText(completed .. ' / ' .. total)
    self.progressRightLabel.frame:SetTextColor(completed == total and 0 or 1, 1, 0)
    self.rareProgressRightLabel:setText(completedRares .. ' / ' .. totalRares)
    self.rareProgressRightLabel.frame:SetTextColor(completedRares == totalRares and 0 or 1, 1, 0)
    self.commonProgressRightLabel:setText(completedCommons .. ' / ' .. totalCommons)
    self.commonProgressRightLabel.frame:SetTextColor(completedCommons == totalCommons and 0 or 1, 1, 0)
    if totalPristines > 0 then
        self.pristineProgressLeftLabel.frame:Show()
        self.pristineProgressRightLabel.frame:Show()
        self.pristineProgressRightLabel:setText(completedPristines .. ' / ' .. totalPristines)
        self.pristineProgressRightLabel.frame:SetTextColor(completedPristines == totalPristines and 0 or 1, 1, 0)
    else
        self.pristineProgressLeftLabel.frame:Hide()
        self.pristineProgressRightLabel.frame:Hide()
    end
    self.totalSolvesRightLabel:setText(solves)

    -- Display all the rares
    for i=1, RARE_ICONS do
        if rares[i] then
            self.rareIcons[i]:setArtifact(rares[i])
            self.rareIcons[i].frame:Show()
        else
            self.rareIcons[i].frame:Hide()
        end
    end

    -- Display all the commons
    for i=1, COMMON_ICONS do
        if commons[i] then
            self.commonIcons[i]:setArtifact(commons[i])
            self.commonIcons[i].frame:Show()
        else
            self.commonIcons[i].frame:Hide()
        end
    end
end