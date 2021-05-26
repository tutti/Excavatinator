local _, private = ...

local Event = private.Event
local Frame = private.Frame
local Window = private.Window
local Button = private.Button
local TextureButton = private.TextureButton
local CheckButton = private.CheckButton
local RaceLine = private.RaceLine
local PageController = private.PageController
local SurveyButton = private.SurveyButton
local CrateManager = private.CrateManager
local RaceDetailsWindow = private.RaceDetailsWindow
local MiniWindow = private.MiniWindow

local Page = Frame:extend()

function Page:construct(pageName, parent, races)
    Frame.construct(self, nil, 'ExcavatinatorMainWindowPage' .. pageName, parent)

    self.name = pageName

    self.frame:SetPoint('TOPLEFT', 30, -35)
    self.frame:SetWidth(480)
    self.frame:SetHeight(35*#races)

    self.events = {
        raceClicked = Event:new('raceClicked'),
    }

    self.raceLines = {}

    for i, race in ipairs(races) do
        self.raceLines[i] = RaceLine:new(self.frame, race)
        self.raceLines[i].frame:SetPoint('TOPLEFT', 0, -35*(i-1))
        self.raceLines[i].events.click:addListener(function() self.events.raceClicked:trigger(race) end)
    end
end

local MainWindow = Window:extend()
private.MainWindow = MainWindow

function MainWindow:construct()
    Window.construct(self, 'ExcavatinatorMainWindow')
    self:makeDraggable()
    
    self.frame:SetWidth(540)
    self.frame:SetHeight(285)
    self.frame:SetPoint('CENTER')
    self.frame:Hide()

    local _self = self

    self.closeButton = Button:new("Button", "ExcavatinatorMainWindowCloseButton", self.frame, "UIPanelCloseButton")
    self.closeButton.frame:SetPoint("TOPRIGHT", -5, -5)
    self.closeButton.frame:SetScript('OnClick', function()
        private.settings.showMainWindow = false
        _self.frame:Hide()
    end)

    self.collapseButton = TextureButton:new("ExcavatinatorCollapseButton", self.frame)
    self.collapseButton.texture.normal:SetTexture("Interface/BUTTONS/UI-Panel-SmallerButton-Up")
    self.collapseButton.texture.pushed:SetTexture("Interface/BUTTONS/UI-Panel-SmallerButton-Down")
    self.collapseButton.texture.pushed:SetBlendMode("BLEND")
    self.collapseButton.texture.highlight:SetTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
    self.collapseButton.frame:SetPoint("TOPRIGHT", -35, -5)

    function self.collapseButton.onClick()
        self.miniWindow:open()
    end

    self.miniWindow = MiniWindow:new(self)
end

function MainWindow:onLoad()
    self.pages = {
        Page:new(EXPANSION_NAME7, self.frame, {
            Excavatinator:getRaceByKey('drust'),
            Excavatinator:getRaceByKey('zandalari'),
        }),
        Page:new(EXPANSION_NAME6, self.frame, {
            Excavatinator:getRaceByKey('demonic'),
            Excavatinator:getRaceByKey('highmountaintauren'),
            Excavatinator:getRaceByKey('highborne'),
        }),
        Page:new(EXPANSION_NAME5, self.frame, {
            Excavatinator:getRaceByKey('arakkoa'),
            Excavatinator:getRaceByKey('draenorclans'),
            Excavatinator:getRaceByKey('ogre'),
        }),
        Page:new(EXPANSION_NAME4, self.frame, {
            Excavatinator:getRaceByKey('pandaren'),
            Excavatinator:getRaceByKey('mogu'),
            Excavatinator:getRaceByKey('mantid'),
        }),
        Page:new(EXPANSION_NAME3, self.frame, {
            Excavatinator:getRaceByKey('tolvir'),
        }),
        Page:new(EXPANSION_NAME2, self.frame, {
            Excavatinator:getRaceByKey('nerubian'),
            Excavatinator:getRaceByKey('vrykul'),
        }),
        Page:new(EXPANSION_NAME1, self.frame, {
            Excavatinator:getRaceByKey('draenei'),
            Excavatinator:getRaceByKey('orc'),
        }),
        Page:new(EXPANSION_NAME0, self.frame, {
            Excavatinator:getRaceByKey('dwarf'),
            Excavatinator:getRaceByKey('nightelf'),
            Excavatinator:getRaceByKey('troll'),
            Excavatinator:getRaceByKey('fossil')
        }),
    }

    self.detailsWindow = RaceDetailsWindow:new(self.frame)

    self.pageController = PageController:new(self.frame, self.pages)
    self.pageController.frame:SetPoint('TOPLEFT', 10, -10)
    self.pageController.events.raceClicked:addListener(function(race) self.detailsWindow:open(race) end)

    self.surveyButton = SurveyButton:new(self.frame)
    self.surveyButton.frame:SetWidth(64)
    self.surveyButton.frame:SetHeight(64)
    self.surveyButton.frame:SetPoint('BOTTOM', 0, 30)

    self.keystoneCheckbox = CheckButton:new("ExcavatinatorKeystoneCheckbutton", self.frame, "Use keystones")
    self.keystoneCheckbox.frame:SetPoint("BOTTOMLEFT", 30, 70)
    self.keystoneCheckbox.frame:SetHitRectInsets(0, -100, 0, 0)
    self.keystoneCheckbox.frame:SetChecked(private.settings.useKeystones)

    self.keystoneCheckbox.events.updated:addListener(function(val)
        private.settings.useKeystones = val
        private.events.settingsChanged:trigger()
    end)

    self.crateManager = CrateManager:new(self.frame)
    self.crateManager.frame:SetPoint('BOTTOMLEFT', 30, 30)

    if private.settings.showMainWindow then self.frame:Show() end

    self.miniWindow:onLoad()
end

function MainWindow:open()
    private.settings.showMainWindow = true
    self.frame:Show()
end