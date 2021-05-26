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
    self.frame:SetHeight(180)
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
        self.digsiteFrames[i]:SetPoint('BOTTOMLEFT', 15, 15+20*(DIGSITE_LABELS - i))
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