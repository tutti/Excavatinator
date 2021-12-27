local _, private = ...

local Window = private.Window
local Button = private.Button
local Label = private.Label
local Tooltip = private.Tooltip
local TextureButton = private.TextureButton
local SurveyButton = private.SurveyButton
local CrateManager = private.CrateManager
local ArtifactSolveButton = private.ArtifactSolveButton

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

    self.redButton = CreateFrame('Button', 'ExcavatinatorSurveyResultRedButton', self.frame)
    self.redButton:SetWidth(90)
    self.redButton:SetHeight(50)
    self.redButton:SetPoint('BOTTOMLEFT', 15, 15)
    self.redButtonBlinker = CreateFrame('Frame', 'ExcavatinatorSurveyResultRedButtonBlinker', self.redButton)
    self.redButtonBlinker:SetWidth(16)
    self.redButtonBlinker:SetHeight(16)
    self.redButtonBlinker:SetPoint('TOPLEFT', 37, -10)
    self.redButtonBlinker.texture = self.redButtonBlinker:CreateTexture()
    self.redButtonBlinker.texture:SetDrawLayer('BACKGROUND')
    self.redButtonBlinker.texture:SetAllPoints()
    self.redButtonBlinker.texture:SetColorTexture(255, 0, 0)
    self.redButtonBlinker.animationGroup = self.redButtonBlinker:CreateAnimationGroup()
    self.redButtonBlinker.animationGroup:SetLooping('BOUNCE')
    self.redButtonBlinker.animation = self.redButtonBlinker.animationGroup:CreateAnimation('Alpha')
    self.redButtonBlinker.animation:SetFromAlpha(1)
    self.redButtonBlinker.animation:SetToAlpha(0.4)
    self.redButtonBlinker.animation:SetDuration(0.6)
    self.redButtonBlinker.animation:SetSmoothing('IN_OUT')
    self.redButtonBlinker.animationGroup:Play()
    self.redButtonLabel = Label:new(self.redButton, 'Red')
    self.redButtonLabel.frame:SetPoint('TOP',0, -30)
    Tooltip:new(self.redButton, function(tooltip)
        tooltip:AddLine('Click to mark your')
        tooltip:AddLine('last survey as RED')
    end)
    self.redButton:SetScript('OnClick', function()
        private.MinimapManager:setLastSurveyResult('red')
    end)

    self.yellowButton = CreateFrame('Button', 'ExcavatinatorSurveyResultYellowButton', self.frame)
    self.yellowButton:SetWidth(90)
    self.yellowButton:SetHeight(50)
    self.yellowButton:SetPoint('BOTTOMLEFT', 105, 15)
    self.yellowButtonBlinker = CreateFrame('Frame', 'ExcavatinatorSurveyResultYellowButtonBlinker', self.yellowButton)
    self.yellowButtonBlinker:SetWidth(16)
    self.yellowButtonBlinker:SetHeight(16)
    self.yellowButtonBlinker:SetPoint('TOPLEFT', 37, -10)
    self.yellowButtonBlinker.texture = self.yellowButtonBlinker:CreateTexture()
    self.yellowButtonBlinker.texture:SetDrawLayer('BACKGROUND')
    self.yellowButtonBlinker.texture:SetAllPoints()
    self.yellowButtonBlinker.texture:SetColorTexture(255, 255, 0)
    self.yellowButtonBlinker.animationGroup = self.yellowButtonBlinker:CreateAnimationGroup()
    self.yellowButtonBlinker.animationGroup:SetLooping('BOUNCE')
    self.yellowButtonBlinker.animation = self.yellowButtonBlinker.animationGroup:CreateAnimation('Alpha')
    self.yellowButtonBlinker.animation:SetFromAlpha(1)
    self.yellowButtonBlinker.animation:SetToAlpha(0.4)
    self.yellowButtonBlinker.animation:SetDuration(0.3)
    self.yellowButtonBlinker.animation:SetSmoothing('IN_OUT')
    self.yellowButtonBlinker.animationGroup:Play()
    self.yellowButtonLabel = Label:new(self.yellowButton, 'Yellow')
    self.yellowButtonLabel.frame:SetPoint('TOP', 0, -30)
    Tooltip:new(self.yellowButton, function(tooltip)
        tooltip:AddLine('Click to mark your')
        tooltip:AddLine('last survey as YELLOW')
    end)
    self.yellowButton:SetScript('OnClick', function()
        private.MinimapManager:setLastSurveyResult('yellow')
    end)

    self.greenButton = CreateFrame('Button', 'ExcavatinatorSurveyResultGreenButton', self.frame)
    self.greenButton:SetWidth(90)
    self.greenButton:SetHeight(50)
    self.greenButton:SetPoint('BOTTOMLEFT', 195, 15)
    self.greenButtonBlinker = CreateFrame('Frame', 'ExcavatinatorSurveyResultGreenButtonBlinker', self.greenButton)
    self.greenButtonBlinker:SetWidth(16)
    self.greenButtonBlinker:SetHeight(16)
    self.greenButtonBlinker:SetPoint('TOPLEFT', 37, -10)
    self.greenButtonBlinker.texture = self.greenButtonBlinker:CreateTexture()
    self.greenButtonBlinker.texture:SetDrawLayer('BACKGROUND')
    self.greenButtonBlinker.texture:SetAllPoints()
    self.greenButtonBlinker.texture:SetColorTexture(0, 255, 0)
    self.greenButtonBlinker.animationGroup = self.greenButtonBlinker:CreateAnimationGroup()
    self.greenButtonBlinker.animationGroup:SetLooping('BOUNCE')
    self.greenButtonBlinker.animation = self.greenButtonBlinker.animationGroup:CreateAnimation('Alpha')
    self.greenButtonBlinker.animation:SetFromAlpha(1)
    self.greenButtonBlinker.animation:SetToAlpha(0.7)
    self.greenButtonBlinker.animation:SetDuration(0.12)
    self.greenButtonBlinker.animation:SetSmoothing('IN_OUT')
    self.greenButtonBlinker.animationGroup:Play()
    self.greenButtonLabel = Label:new(self.greenButton, 'Green')
    self.greenButtonLabel.frame:SetPoint('TOP', 0, -30)
    Tooltip:new(self.greenButton, function(tooltip)
        tooltip:AddLine('Click to mark your')
        tooltip:AddLine('last survey as GREEN')
    end)
    self.greenButton:SetScript('OnClick', function()
        private.MinimapManager:setLastSurveyResult('green')
    end)

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