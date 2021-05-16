local _, private = ...

local Window = private.Window
local Button = private.Button
local Label = private.Label
local TextureButton = private.TextureButton
local SurveyButton = private.SurveyButton
local CrateManager = private.CrateManager
local ArtifactSolveButton = private.ArtifactSolveButton

local MiniWindow = Window:extend()
private.MiniWindow = MiniWindow

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
    self.frame:SetHeight(100)
    self.frame:SetPoint('CENTER')

    self.frame:Hide()
end

function MiniWindow:onLoad()
    self.surveyButton = SurveyButton:new(self.frame)
    self.surveyButton.frame:SetWidth(64)
    self.surveyButton.frame:SetHeight(64)
    self.surveyButton.frame:SetPoint('TOPLEFT', 18, -18)

    self.crateManager = CrateManager:new(self.frame)
    self.crateManager.frame:SetPoint('TOPLEFT', 100, -18)

    self.artifactButton = ArtifactSolveButton:new(self.frame)
    self.artifactButton.frame:SetPoint('BOTTOMLEFT', 100, 18)
    self.artifactButton.frame:Hide()

    self.raceLabel = Label:new(self.frame, 'Race name')
    self.raceLabel.frame:SetPoint('BOTTOMLEFT', 140, 34)
    self.raceLabel.frame:Hide()

    self.progressLabel = Label:new(self.frame, '100 / 100')
    self.progressLabel.frame:SetPoint('BOTTOMLEFT', 140, 18)
    self.progressLabel.frame:Hide()

    Excavatinator.events.raceUpdated:addListener(function(race) self:_update(race) end)
    private.events.settingsChanged:addListener(function() self:_update(self.race) end)

    if private.settings.showMiniWindow then self.frame:Show() end
end

function MiniWindow:_update(race)
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