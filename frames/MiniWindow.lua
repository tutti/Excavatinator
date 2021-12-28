local _, private = ...

local Window = private.Window
local Button = private.Button
local Label = private.Label
local Tooltip = private.Tooltip
local TextureButton = private.TextureButton
local SurveyButton = private.SurveyButton
local CrateManager = private.CrateManager
local ArtifactSolveButton = private.ArtifactSolveButton
local BlinkerButton = private.BlinkerButton

local MiniWindow = Window:extend()
private.MiniWindow = MiniWindow

local DIGSITE_LABELS = 4

function MiniWindow:construct(mainWindow)
    Window.construct(self, 'ExcavatinatorMiniWindow')
    self:makeDraggable()

    self.mainWindow = mainWindow

    local _self = self

    self.closeButton = Button:new("Button", "ExcavatinatorMiniWindowCloseButton", self.frame, "UIPanelCloseButton")
    self.closeButton.frame:SetPoint("TOPRIGHT", -5, -5)
    self.closeButton.frame:SetScript('OnClick', function()
        private.settings.showMiniWindow = false
        _self.frame:Hide()
    end)

    self.fullsizeButton = TextureButton:new("ExcavatinatorFullsizeButton", self.frame)
    self.fullsizeButton.texture.normal:SetTexture("Interface/BUTTONS/UI-Panel-BiggerButton-Up")
    self.fullsizeButton.texture.pushed:SetTexture("Interface/BUTTONS/UI-Panel-BiggerButton-Down")
    self.fullsizeButton.texture.pushed:SetBlendMode("BLEND")
    self.fullsizeButton.texture.highlight:SetTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
    self.fullsizeButton.frame:SetPoint("TOPRIGHT", -35, -5)

    function self.fullsizeButton.onClick()
        self.mainWindow:open()
    end

    self.frame:SetWidth(300)
    self.frame:SetHeight(240)
    self.frame:SetPoint('CENTER')

    self.frame:Hide()
end

function MiniWindow:onLoad()
    self.surveyButton = SurveyButton:new(self.frame)
    self.surveyButton.frame:SetWidth(64)
    self.surveyButton.frame:SetHeight(64)
    self.surveyButton.frame:SetPoint('TOPLEFT', 18, -15)

    self.crateManager = CrateManager:new(self.frame)
    self.crateManager.frame:SetPoint('TOPLEFT', 100, -15)

    self.artifactButton = ArtifactSolveButton:new(self.frame)
    self.artifactButton.frame:SetPoint('TOPLEFT', 100, -47)
    self.artifactButton.frame:Hide()

    self.raceLabel = Label:new(self.frame, 'Race name')
    self.raceLabel.frame:SetPoint('TOPLEFT', 140, -51)
    self.raceLabel.frame:Hide()

    self.progressLabel = Label:new(self.frame, '100 / 100')
    self.progressLabel.frame:SetPoint('TOPLEFT', 140, -66)
    self.progressLabel.frame:Hide()

    self.digsiteFrames = {}
    for i=1, DIGSITE_LABELS do
        self.digsiteFrames[i] = CreateFrame('Frame', 'ExcavatinatorMiniWindowRace' .. i, self.frame)
        self.digsiteFrames[i]:SetWidth(270)
        self.digsiteFrames[i]:SetHeight(20)
        self.digsiteFrames[i]:SetPoint('TOPLEFT', 15, -65-20*i)
        self.digsiteFrames[i].icon = CreateFrame('Frame', nil, self.digsiteFrames[i])
        self.digsiteFrames[i].icon:SetWidth(32)
        self.digsiteFrames[i].icon:SetHeight(32)
        self.digsiteFrames[i].icon.texture = self.digsiteFrames[i].icon:CreateTexture()
        self.digsiteFrames[i].icon.texture:SetDrawLayer('BACKGROUND')
        self.digsiteFrames[i].icon.texture:SetAllPoints()
        self.digsiteFrames[i].icon:SetPoint('TOPLEFT', 0, 0)
        self.digsiteFrames[i].label = Label:new(self.digsiteFrames[i], 'Digsite ' .. i)
        self.digsiteFrames[i].label.frame:SetPoint('TOPLEFT', 30, -4)
        local iconTooltip = Tooltip:new(self.digsiteFrames[i], function(tooltip)
            tooltip:AddLine(self.digsiteFrames[i].raceName)
        end)
    end

    self.redButton = BlinkerButton:new('ExcavatinatorSurveyResultRedButton', self.frame, 'red')
    self.redButton.frame:SetPoint('BOTTOMLEFT', 15, 15)

    self.yellowButton = BlinkerButton:new('ExcavatinatorSurveyResultYellowButton', self.frame, 'yellow')
    self.yellowButton.frame:SetPoint('BOTTOMLEFT', 65, 15)

    self.greenButton = BlinkerButton:new('ExcavatinatorSurveyResultGreenButton', self.frame, 'green')
    self.greenButton.frame:SetPoint('BOTTOMLEFT', 115, 15)

    self.distanceFrame = CreateFrame('Frame', 'ExcavatinatorDistanceFrame', self.frame)
    self.distanceFrame:SetWidth(90)
    self.distanceFrame:SetHeight(30)
    self.distanceFrame:SetPoint('BOTTOMRIGHT', -15, 25)
    Tooltip:new(self.distanceFrame, function(tooltip)
        tooltip:AddLine('The distance you\'ve moved')
        tooltip:AddLine('since your last survey')
    end)

    self.distanceLabel = Label:new(self.distanceFrame, '50', 20)
    self.distanceLabel.frame:SetPoint('TOP')

    self.distanceBarGreen = CreateFrame('Frame', 'ExcavatinatorDistanceFrameGreen', self.distanceFrame)
    self.distanceBarGreen:SetWidth(40)
    self.distanceBarGreen:SetHeight(6)
    self.distanceBarGreen:SetPoint('BOTTOMLEFT')
    self.distanceBarGreen.texture = self.distanceBarGreen:CreateTexture()
    self.distanceBarGreen.texture:SetColorTexture(0, 1, 0, 1)
    self.distanceBarGreen.texture:SetAllPoints(self.distanceBarGreen)

    self.distanceBarYellow = CreateFrame('Frame', 'ExcavatinatorDistanceFrameYellow', self.distanceFrame)
    self.distanceBarYellow:SetWidth(40)
    self.distanceBarYellow:SetHeight(6)
    self.distanceBarYellow:SetPoint('BOTTOMLEFT', 40, 0)
    self.distanceBarYellow.texture = self.distanceBarYellow:CreateTexture()
    self.distanceBarYellow.texture:SetColorTexture(1, 1, 0, 1)
    self.distanceBarYellow.texture:SetAllPoints(self.distanceBarYellow)

    self.distanceBarRed = CreateFrame('Frame', 'ExcavatinatorDistanceFrameRed', self.distanceFrame)
    self.distanceBarRed:SetWidth(10)
    self.distanceBarRed:SetHeight(6)
    self.distanceBarRed:SetPoint('BOTTOMLEFT', 80, 0)
    self.distanceBarRed.texture = self.distanceBarRed:CreateTexture()
    self.distanceBarRed.texture:SetColorTexture(1, 0, 0, 1)
    self.distanceBarRed.texture:SetAllPoints(self.distanceBarRed)

    self.distanceArrow = CreateFrame('Frame', nil, self.distanceFrame)
    self.distanceArrow:SetWidth(24)
    self.distanceArrow:SetHeight(24)
    self.distanceArrow.texture = self.distanceArrow:CreateTexture()
    self.distanceArrow.texture:SetTexture(136431)
    self.distanceArrow.texture:SetDrawLayer("OVERLAY")
    self.distanceArrow.texture:SetAllPoints()
    self.distanceArrow:SetPoint('BOTTOMLEFT', -12, -14)

    self.lastSurvey = nil

    private.MinimapManager.surveyUpdate:addListener(function(survey)
        self.lastSurvey = survey
    end)

    self.frame:SetScript('OnUpdate', function() self:updateDistance() end)

    Excavatinator.events.raceUpdated:addListener(function(race) self:_update(race) end)
    Excavatinator.events.digsitesUpdated:addListener(function() self:_update(self.race) end)
    Excavatinator.events.enterDigsite:addListener(function() self:_update(self.race) end)
    Excavatinator.events.leaveDigsite:addListener(function() self:_update(self.race) end)
    private.events.settingsChanged:addListener(function() self:_update(self.race) end)

    if private.settings.showMiniWindow then self.frame:Show() end
end

function MiniWindow:_update(race)
    local digsites = Excavatinator:getActiveDigsites()
    local currentDigsite = Excavatinator:getCurrentDigsite()
    for i = 1, DIGSITE_LABELS do
        if i > #digsites then
            --self.digsiteFrames[i].icon:Hide()
            --self.digsiteFrames[i].label.frame:Hide()
            self.digsiteFrames[i]:Hide()
        else
            self.digsiteFrames[i]:Show()
            if digsites[i].race then
                self.digsiteFrames[i].icon:Show()
                self.digsiteFrames[i].icon.texture:SetTexture(digsites[i].race.icon)
                self.digsiteFrames[i].raceName = digsites[i].race.name
            else
                self.digsiteFrames[i].icon:Hide()
                self.digsiteFrames[i].raceName = 'Unknown race'
            end
            --self.digsiteFrames[i].label.frame:Show()
            self.digsiteFrames[i].label:setText(digsites[i].name)
            self.digsiteFrames[i].label.frame:SetTextColor(1, 1, digsites[i] == currentDigsite and 0 or 1)
        end
    end

    if not race then return end

    self.race = race
    self.artifactButton:setRace(race)
    self.artifactButton.frame:Show()

    self.raceLabel:setText(race.name)
    self.raceLabel.frame:Show()

    local artifact = race:getActiveArtifact()
    if not artifact then
        self.artifactButton.frame:Hide()
        self.progressLabel.frame:Hide()
    else
        local fragments, needed = artifact:getProgress(private.settings.useKeystones)
        self.progressLabel:setText(fragments .. ' / ' .. needed)
        self.progressLabel.frame:Show()
    end
end

function MiniWindow:open()
    private.settings.showMiniWindow = true
    self.frame:Show()
end

function MiniWindow:updateDistance()
    if not self.lastSurvey then
        self.distanceLabel:setText('--')
        self.distanceArrow:Hide()
        self.distanceBarGreen.texture:SetAlpha(0.2)
        self.distanceBarYellow.texture:SetAlpha(0.2)
        self.distanceBarRed.texture:SetAlpha(0.2)
    else
        local playerX, playerY = UnitPosition('player')
        local distance = math.floor(CalculateDistance(playerX, playerY, self.lastSurvey.x, self.lastSurvey.y))
        self.distanceLabel:setText(distance)
        self.distanceArrow:Show()
        self.distanceArrow:SetPoint('BOTTOMLEFT', min(distance, 90)-12, -14)
        self.distanceBarGreen.texture:SetAlpha(1)
        self.distanceBarYellow.texture:SetAlpha(1)
        self.distanceBarRed.texture:SetAlpha(1)
        self.distanceArrow.texture:SetAlpha(1)

        if self.lastSurvey.result and self.lastSurvey.result ~= 'green' then
            self.distanceBarGreen.texture:SetAlpha(0.2)
        end

        if self.lastSurvey.result and self.lastSurvey.result ~= 'yellow' then
            self.distanceBarYellow.texture:SetAlpha(0.2)
        end

        if self.lastSurvey.result and self.lastSurvey.result ~= 'red' then
            self.distanceBarRed.texture:SetAlpha(0.2)
        end

        if self.lastSurvey.result == 'green' and distance > 45 then
            self.distanceArrow.texture:SetAlpha(0.2)
        end

        if self.lastSurvey.result == 'yellow' and (distance < 35 or distance > 85) then
            self.distanceArrow.texture:SetAlpha(0.2)
        end

        if self.lastSurvey.result == 'red' and distance < 75 then
            self.distanceArrow.texture:SetAlpha(0.2)
        end
    end
end