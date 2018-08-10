local _, private = ...

local Frame = private.Frame
local Button = private.Button
local Race = private.Race

local function createLabel(parent, text, size)
    local label = parent:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", size or 12)
    label:SetText(text)
    return label
end

local Bar = Frame:extend()
private.Bar = Bar

function Bar:construct(name, parent)
    Frame.construct(self, "Frame", name, parent)

    self.fillframe = CreateFrame("Frame", name and name .. "_fill" or "", self.frame)
    self.fillframe:SetPoint("LEFT")
    self.fillframe:Hide()

    local t = self.frame.texture or self.frame:CreateTexture()
    t:SetColorTexture(0.3, 0.3, 0.3, 1)
    t:SetAllPoints(self.frame)
    self.frame.texture = t

    t = self.fillframe.texture or self.fillframe:CreateTexture()
    t:SetColorTexture(0, 1, 0, 1)
    t:SetAllPoints(self.fillframe)
    self.fillframe.texture = t

    self.width = 0
    self.height = 0
    self.fill = 0
end

function Bar:SetFill(part, whole)
    if part == 0 then
        self.fill = 0
        self.fillframe:Hide()
        return
    end

    self.fill = part / whole
    if self.fill > 1 then self.fill = 1 end
    local fillWidth = math.floor(self.fill * self.width)
    if fillWidth == 0 then
        self.fillframe:Hide()
        return
    end

    self.fillframe:Show()
    self.fillframe:SetWidth(fillWidth)
end

function Bar:SetWidth(width)
    self.width = width
    self.frame:SetWidth(width)
    local fillWidth = math.floor(self.fill * self.width)
    if fillWidth == 0 then
        self.fillframe:Hide()
        return
    end

    self.fillframe:Show()
    self.fillframe:SetWidth(fillWidth)
end

function Bar:SetHeight(height)
    self.height = height
    self.frame:SetHeight(height)
    self.fillframe:SetHeight(height)
end

function Bar:SetSize(width, height)
    self:SetWidth(width)
    self:SetHeight(height)
end

local CheckButton = Button:extend()
private.CheckButton = CheckButton

function CheckButton:construct(name, parent, text)
    Button.construct(self, "CheckButton", name, parent, "OptionsCheckButtonTemplate")
    self.frame:SetHitRectInsets(0, -60, 0, 0)
    self.frame:SetScript("OnClick", self.__click)
    self.text = _G[self.frame:GetName() .. "Text"]
    self.text:SetText(text)
end

function CheckButton:SetText(...)
    return self.text:SetText(...)
end

function CheckButton:GetText(...)
    return self.text:GetText(...)
end

local TextureButton = Button:extend()
private.TextureButton = TextureButton

function TextureButton:construct(name, parent, texture, template)
    Button.construct(self, "Button", name, parent, template)

    self.texture = {}
    
    self.texture.normal = self.frame:CreateTexture()
    self.texture.normal:SetTexture(texture)
    self.texture.normal:SetDrawLayer("BACKGROUND")
    self.texture.normal:SetAllPoints()
    
    self.texture.pushed = self.frame:CreateTexture()
    self.texture.pushed:SetTexture("Interface/Buttons/UI-Quickslot-Depress")
    self.texture.pushed:SetAllPoints()
    self.texture.pushed:SetBlendMode("ADD")
    self.texture.pushed:SetDrawLayer("BORDER")
    self.frame:SetPushedTexture(self.texture.pushed)
    
    self.texture.disabled = self.frame:CreateTexture()
    self.texture.disabled:SetTexture(texture)
    self.texture.disabled:SetAllPoints()
    self.texture.disabled:SetDesaturated(true)
    self.texture.disabled:SetVertexColor(0.5, 0.5, 0.5)
    self.texture.disabled:SetDrawLayer("BORDER")
    self.frame:SetDisabledTexture(self.texture.disabled)
    
    self.texture.highlight = self.frame:CreateTexture()
    self.texture.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
    self.texture.highlight:SetAllPoints()
    self.texture.highlight:SetBlendMode("ADD")
    self.texture.highlight:SetDrawLayer("HIGHLIGHT")
    
    self.frame:SetSize(32, 32)

    self.texture.locked = false
end

function TextureButton:SetTexture(texture)
    self.texture.normal:SetTexture(texture)
    self.texture.disabled:SetTexture(texture)
end

local SpellButton = TextureButton:extend()
private.SpellButton = SpellButton

function SpellButton:construct(name, parent, spell, cooldown)
    TextureButton.construct(self, name, parent, nil, "SecureActionButtonTemplate")

    self.spellID = 0

    self.frame:SetAttribute("type", "spell")
    self.frame:SetAttribute("unit", "player")

    self.cooldown = CreateFrame("Cooldown", nil, self.frame)
    self.cooldown:SetSwipeTexture('Interface/Cooldown/cooldown2')
    self.cooldown:SetSwipeColor(0, 0, 0, 0.8)
    self.cooldown:SetAllPoints(self.frame)
    self.cooldown:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self.cooldown.cooldown = cooldown -- self's cooldown frame has a cooldown attribute, which is set to the cooldown argument.
    self.cooldown.spellID = spellID
    self.cooldown:SetScript("OnEvent", self.spellcastEvent)

    if spell then self:SetSpell(spell, cooldown) end
end

function SpellButton:spellcastEvent(event, unit, spellName, spellRank, _, spellID)
    if unit == "player" and spellID == self.spellID then
        self:SetCooldown(GetTime(), self.cooldown)
    end
end

function SpellButton:SetSpell(spellID, cooldown)
    self.spellID = spellID
    
    local spellName = GetSpellInfo(spellID)
    local texture = GetSpellTexture(spellName)
    
    if not self.texture.locked then
        self.texture.normal:SetTexture(texture)
        self.texture.disabled:SetTexture(texture)
    end
    
    self.frame:SetAttribute("spell", spellName)
    
    self.cooldown.cooldown = cooldown
    self.cooldown.spellID = spellID
end

function SpellButton:LockTexture(locked)
    self.texture.locked = locked
end

local ArtifactLine = Button:extend()
private.ArtifactLine = ArtifactLine

function ArtifactLine:construct(name, parent)
    Button.construct(self, "Button", name, parent)

    self.itemLabel = createLabel(self.frame, "Item")
    self.itemLabel:SetPoint("LEFT")

    self.bar = Bar:new(nil, self.frame)
    self.bar:SetSize(80, 10)
    self.bar:SetPoint("RIGHT", -80, 0)

    self.count = createLabel(self.frame, "100")
    self.count:SetPoint("RIGHT", -30, 0)

    self.pristineMark = CreateFrame("Button", nil, self.frame)
    self.pristineMark:SetPoint("RIGHT")
    self.pristineMark:SetSize(16, 16)
    self.pristineMark.incompleteTexture = self.pristineMark:CreateTexture()
    self.pristineMark.incompleteTexture:SetTexture("Interface/MINIMAP/TRACKING/OBJECTICONS")
    self.pristineMark.incompleteTexture:SetDrawLayer("BACKGROUND")
    self.pristineMark.incompleteTexture:SetPoint("TOPLEFT")
    self.pristineMark.incompleteTexture:SetSize(16, 16)
    self.pristineMark.incompleteTexture:SetTexCoord(1/8, 2/8, 1/2, 1)
    self.pristineMark.completeTexture = self.pristineMark:CreateTexture()
    self.pristineMark.completeTexture:SetTexture("Interface/BUTTONS/UI-CheckBox-Check")
    self.pristineMark.completeTexture:SetDrawLayer("BACKGROUND")
    self.pristineMark.completeTexture:SetAllPoints()

    self:SetSize(450, 16)

    self.link = ""
end

function ArtifactLine:SetArtifact(artifact)
    artifact:update()
    local _, link = GetItemInfo(artifact.item)
    self.link = link or "Could not load item."
    self.itemLabel:SetText(link)
    if artifact.pristine then
        self.pristineMark:Show()
        if artifact:isPristineCompleted() then
            self.pristineMark.completeTexture:Show()
            self.pristineMark.incompleteTexture:Hide()
        else
            self.pristineMark.completeTexture:Hide()
            self.pristineMark.incompleteTexture:Show()
        end
    else
        self.pristineMark:Hide()
    end

    if artifact.achieve then
        self.bar:Show()
        self.bar:SetFill(artifact:timesCompleted(), artifact.achieve)
    else
        self.bar:Hide()
    end

    self.count:SetText(artifact:timesCompleted())
end

function ArtifactLine:OnClick()
    ChatEdit_InsertLink(self.link)
end

local RaceFrame = Button:extend()
private.RaceFrame = RaceFrame

local function solveClick(button)
    button.race:getActiveArtifact():solve()
end

local function artifactTooltip(button, tooltip)
    local raceName = button.race.name
    local artifact = button.race:getActiveArtifact()
    local artifactName = artifact.itemName
    local fragments, needed = artifact:getFragments()
    tooltip:AddLine(artifactName)
    tooltip:AddLine(raceName .. " artifact (" .. fragments .. " / " .. needed .. " fragments)", 1, 1, 1)
    tooltip:AddLine(" ")
    tooltip:AddLine("Click to solve this artifact", 0, 1, 0)
end

function RaceFrame:construct(name, parent, race)
    if type(race) == "number" then
        race = Race:getByID(race)
    end
    self.race = race

    Button.construct(self, "Button", name or race.name .. "_frame", parent)
    self:SetSize(620, 50)

    self.icon = CreateFrame("Frame", name and name .. "_icon" or "", self.frame)
    self.icon:SetSize(64, 64)
    self.icon.texture = self.icon:CreateTexture()
    self.icon.texture:SetTexture(race.icon)
    self.icon.texture:SetDrawLayer("BACKGROUND")
    self.icon.texture:SetAllPoints()
    self.icon:SetPoint("LEFT", 0, -10)

    self.raceName = createLabel(self.frame, race.name)
    self.raceName:SetPoint("LEFT", 50, 0)

    self.mainBar = Bar:new(name and name .. "_bar" or nil, self.frame)
    self.mainBar:SetSize(160, 10)
    self.mainBar:SetPoint("LEFT", 190, 0)

    self.mainCount = createLabel(self.frame, "50 / 50")
    self.mainCount:SetPoint("LEFT", 360, 0)

    -- If there is not active artifact, then there is problem.
    self.artifactButton = TextureButton:new(nil, self.frame, nil)
    self.artifactButton:SetSize(32, 32)
    self.artifactButton:SetPoint("LEFT", 435, 0)
    self.artifactButton:SetEnabled(false)
    self.artifactButton.OnClick = solveClick
    self.artifactButton.race = self.race
    self.artifactButton.OnTooltip = artifactTooltip
    self.artifactButton:AttachTooltip()

    self.artifactBar = Bar:new(name and name .. "_artifactbar" or nil, self.frame)
    self.artifactBar:SetSize(50, 10)
    self.artifactBar:SetPoint("LEFT", 480, 0)

    self.artifactCount = createLabel(self.frame, "200 / 200")
    self.artifactCount:SetPoint("LEFT", 540, 0)

    self:AttachTooltip()
    self:Update()
end

function RaceFrame:Update()
    self.race:update()
    local completed, total = self.race:getProgress()
    self.mainBar:SetFill(completed, total)
    self.mainCount:SetText(completed .. " / " .. total)
    if not self.race:getActiveArtifact() then
        self.artifactCount:SetText("")
        self.artifactBar:Hide()
        return
    end
    local fragments, needed = self.race:getActiveArtifact():getFragments()
    self.artifactBar:Show()
    self.artifactBar:SetFill(fragments, needed)
    self.artifactCount:SetText(fragments .. " / " .. needed)
    self.artifactButton:SetEnabled(fragments >= needed)
    self.artifactButton:SetTexture(self.race:getActiveArtifact().icon)
end

function RaceFrame:OnClick()
    private.ArtifactList:LoadRace(self.race)
    self:Update()
    private.ArtifactList:Show()
    private.LinkFrame:Hide()
end

function RaceFrame:OnTooltip(tooltip)
    tooltip:AddLine(self.race.name, 1, 1, 1)
    local completed, total, solves = self.race:getProgress()
    local artifact = self.race:getActiveArtifact()
    if not artifact then
        tooltip:AddLine("You have not discovered this race yet.")
        return
    end
    local fragments, needed = artifact:getFragments()
    tooltip:AddLine(completed .. " / " .. total .. " artifacts solved", 1, 1, 1)
    tooltip:AddLine(solves .. " solves total", 1, 1, 1)
    tooltip:AddLine(" ")
    tooltip:AddLine(artifact.itemName, 1, 1, 1)
    tooltip:AddLine(fragments .. " / " .. needed .. " fragments", 1, 1, 1)
    tooltip:AddLine(" ")
    tooltip:AddLine("Click to open a list of artifacts", 1, 1, 1)
    if fragments >= needed then
        tooltip:AddLine("Click the artifact to solve it", 0, 1, 0)
    end
end

local mainFrameUpdateEvents = {
    --"ARTIFACT_COMPLETE",
    "QUEST_TURNED_IN",
    "CHAT_MSG_CURRENCY",
    "BAG_UPDATE"
}

local MainFrame = Frame:new("Frame", "ExcavatinatorMainFrame")
private.MainFrame = MainFrame

MainFrame.closeButton = Button:new("Button", "ExcavatinatorCloseButton", MainFrame.frame, "UIPanelCloseButton")
MainFrame.closeButton:SetPoint("TOPRIGHT", -5, -5)

MainFrame.collapseButton = TextureButton:new("ExcavatinatorCollapseButton", MainFrame.frame)
MainFrame.collapseButton.texture.normal:SetTexture("Interface/BUTTONS/UI-Panel-SmallerButton-Up")
MainFrame.collapseButton.texture.pushed:SetTexture("Interface/BUTTONS/UI-Panel-SmallerButton-Down")
MainFrame.collapseButton.texture.pushed:SetBlendMode("BLEND")
MainFrame.collapseButton.texture.highlight:SetTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
MainFrame.collapseButton:SetPoint("TOPRIGHT", -35, -5)

MainFrame.fullsizeButton = TextureButton:new("ExcavatinatorFullsizeButton", MainFrame.frame)
MainFrame.fullsizeButton.texture.normal:SetTexture("Interface/BUTTONS/UI-Panel-BiggerButton-Up")
MainFrame.fullsizeButton.texture.pushed:SetTexture("Interface/BUTTONS/UI-Panel-BiggerButton-Down")
MainFrame.fullsizeButton.texture.pushed:SetBlendMode("BLEND")
MainFrame.fullsizeButton.texture.highlight:SetTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
MainFrame.fullsizeButton:SetPoint("TOPRIGHT", -35, -5)
MainFrame.fullsizeButton:Hide()

MainFrame:SetStandardBackdrop()
MainFrame:EnableMouse(true)
MainFrame:SetMovable(true)
MainFrame:SetClampedToScreen(true)
MainFrame:SetScript("OnDragStart", MainFrame.frame.StartMoving)
MainFrame:SetScript("OnDragStop", MainFrame.frame.StopMovingOrSizing)
MainFrame:RegisterForDrag("LeftButton")
MainFrame:SetPoint("CENTER")
MainFrame:SetSize(650, 100)
MainFrame:Hide()

MainFrame.prevPage = CreateFrame("Button", nil, MainFrame.frame)
MainFrame.prevPage:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up")
MainFrame.prevPage:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down")
MainFrame.prevPage:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled")
MainFrame.prevPage:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
MainFrame.prevPage:SetSize(32, 32)
MainFrame.prevPage:SetPoint("TOPLEFT", 10, -10)
MainFrame.prevPage:RegisterForClicks("LeftButtonUp")
MainFrame.prevPage:SetScript("OnClick", function() MainFrame:ShowPage(MainFrame.currentPage - 1) end)

MainFrame.pageLabel = createLabel(MainFrame.frame, "Page")
MainFrame.pageLabel:SetPoint("TOPLEFT", 50, -20)

MainFrame.nextPage = CreateFrame("Button", nil, MainFrame.frame)
MainFrame.nextPage:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up")
MainFrame.nextPage:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down")
MainFrame.nextPage:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled")
MainFrame.nextPage:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
MainFrame.nextPage:SetSize(32, 32)
MainFrame.nextPage:SetPoint("TOPLEFT", 200, -10)
MainFrame.nextPage:RegisterForClicks("LeftButtonUp")
MainFrame.nextPage:SetScript("OnClick", function() MainFrame:ShowPage(MainFrame.currentPage + 1) end)

local crateTexture = GetItemIcon(87399)
MainFrame.crateButton = TextureButton:new("ExcavatinatorCrateButton", MainFrame.frame, crateTexture, "SecureActionButtonTemplate")
MainFrame.crateButton:SetSize(32, 32)
MainFrame.crateButton:SetAttribute("type", "item")
MainFrame.crateButton:SetAttribute("unit", "player")
MainFrame.crateButton:AttachTooltip()
function MainFrame.crateButton:OnTooltip(tooltip)
    tooltip:AddLine("Crate artifact")
    tooltip:AddLine("Click to crate one of your artifacts.", 1, 1, 1)
end

MainFrame.crateLabel = createLabel(MainFrame.frame, "0 (0)")
MainFrame.crateLabel:SetPoint("LEFT", MainFrame.crateButton.frame, "RIGHT", 10, 0)

MainFrame.keystoneCheckbox = CheckButton:new("ExcavatinatorKeystoneCheckbox", MainFrame.frame, "Use keystones")
MainFrame.keystoneCheckbox:SetPoint("BOTTOMLEFT", 30, 70)
MainFrame.keystoneCheckbox:SetHitRectInsets(0, -100, 0, 0)

MainFrame.linkFrameButton = TextureButton:new("ExcavatinatorLinkButton", MainFrame.frame, "Interface/ICONS/inv_belt_18")
MainFrame.linkFrameButton:SetSize(32, 32)
MainFrame.linkFrameButton:SetPoint("BOTTOMRIGHT", -32, 32)
MainFrame.linkFrameButton:AttachTooltip()
function MainFrame.linkFrameButton:OnTooltip(tooltip)
    tooltip:AddLine("Links")
    tooltip:AddLine("Click to manage manual links", 1, 1, 1)
    tooltip:AddLine("between projects and items.", 1, 1, 1)
end

--MainFrame.linksFrameButton:

MainFrame.__hasSetup = false

function MainFrame:__setup()
    self.raceFrames = {}

    local raceCount = GetNumArchaeologyRaces()
    for i=1, raceCount do
        local race = Race:getByID(i)
        self.raceFrames[race.internalName] = RaceFrame:new("ExcavatinatorRaceFrame" .. i, self.frame, race)
    end

    self.pages = {}
    self.currentPage = 0
    self.minified = false

    -- Set up the survey button
    -- This has to be in here, rather than on the outside;
    -- the Survey button depends on the spell information for Survey having become available,
    -- and some other buttons depend on its existence.
    self.surveyButton = SpellButton:new("ExcavatinatorSurveyButton", self.frame, 80451, 3)
    self.surveyButton:SetSize(64, 64)
    local surveyLink = GetSpellLink(80451)
    self.surveyButton:AttachTooltip()

    self.solveButton = TextureButton:new("ExcavatinatorSolveButton", self.frame)
    self.solveButton:SetPoint("BOTTOMLEFT", self.surveyButton.frame, "BOTTOMRIGHT", 18, 0)
    self.solveButton:SetSize(32, 32)
    self.solveButton:Disable()
    self.solveButton:Hide()

    self.solveLabel = createLabel(self.frame, "")
    self.solveLabel:SetPoint("LEFT", self.solveButton.frame, "RIGHT", 10, 0)
    self.solveLabel:Hide()

    function self.surveyButton:OnTooltip(tooltip)
        tooltip:SetHyperlink(surveyLink)
    end

    for i=1, #private.data.pages do
        local pageData = private.data.pages[i]
        if pageData.patch <= private.TOC_VERSION then
            local page = {}
            self.pages[#self.pages+1] = page

            page.title = pageData.title
            for k, v in ipairs(pageData) do
                page[k] = self.raceFrames[v]
            end
        end
    end

    self:ShowPage(1)

    for k, v in pairs(mainFrameUpdateEvents) do
        MainFrame[v] = MainFrame.Update
        MainFrame:RegisterEvent(v)
    end
    MainFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    MainFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

    function self.collapseButton:OnClick()
        MainFrame:SetMinified(true)
    end

    function self.fullsizeButton:OnClick()
        MainFrame:SetMinified(false)
    end

    function self.solveButton:OnClick()
        self.artifact:solve()
    end

    function self.keystoneCheckbox:OnClick()
        ExcavatinatorDB.useKeystones = self:GetChecked()
        MainFrame:Update()
    end

    function self.linkFrameButton:OnClick()
        private.ArtifactList:Hide()
        private.LinkFrame.manuallyOpened = true
        private.LinkFrame:showMainPage()
    end

    self.solveButton:AttachTooltip()
    function self.solveButton:OnTooltip(tooltip)
        local raceName = self.artifact.race.name
        local artifactName = self.artifact.itemName
        local fragments, needed = self.artifact:getFragments()
        tooltip:AddLine(artifactName)
        tooltip:AddLine(raceName .. " artifact (" .. fragments .. " / " .. needed .. " fragments)", 1, 1, 1)
        if self.artifact.pristine then
            if self.artifact:isPristineCompleted() then
                tooltip:AddLine("Pristine artifact completed", 0, 1, 0)
            else
                tooltip:AddLine("Pristine artifact incomplete", 1, 1, 0)
            end
        end
        tooltip:AddLine(" ")
        tooltip:AddLine("Click to solve this artifact", 0, 1, 0)
    end

    if ExcavatinatorDB.useKeystones then
        self.keystoneCheckbox:SetChecked(true)
    end

    self:SetMinified(ExcavatinatorDB.minified)

    self:Update()

    self.__hasSetup = true
end

function MainFrame:Show()
    if not self.__hasSetup then self:__setup() end
    self.frame:Show()
    if not self.minified then private.LinkFrame:showLinkPage(false) end
end

function MainFrame:ShowPage(page)
    for k, v in pairs(self.raceFrames) do
        v:Hide()
    end

    if self.pages[page] then
        self.currentPage = page
        for i, v in ipairs(self.pages[page]) do
            v:SetPoint("TOPLEFT", 30, -35*i)
            v:Show()
        end

        self.pageLabel:SetText(self.pages[page].title)
    else
        self.pageLabel:SetText("")
    end

    self.nextPage:SetEnabled(true)
    self.prevPage:SetEnabled(true)
    if page == 1 then
        self.prevPage:SetEnabled(false)
    elseif page == #self.pages then
        self.nextPage:SetEnabled(false)
    end
end

function MainFrame:SetMinified(minified)
    if minified then
        self:SetSize(300, 100)
        self:ShowPage(0)
        self.prevPage:Hide()
        self.nextPage:Hide()
        self.pageLabel:Hide()
        self.keystoneCheckbox:Hide()
        self.collapseButton:Hide()
        self.fullsizeButton:Show()
        self.surveyButton:ClearAllPoints()
        self.surveyButton:SetPoint("LEFT", 18, 0)
        self.surveyButton:DetachTooltip()
        self.crateButton:ClearAllPoints()
        self.crateButton:SetPoint("TOPLEFT", self.surveyButton.frame, "TOPRIGHT", 18, 0)
        self.linkFrameButton:Hide()
        self.solveButton:Show()
        self.solveLabel:Show()
        private.ArtifactList:Hide()
        private.LinkFrame:Hide()
    else
        self:SetSize(650, 460)
        self:ShowPage(1)
        self.prevPage:Show()
        self.nextPage:Show()
        self.pageLabel:Show()
        self.keystoneCheckbox:Show()
        self.collapseButton:Show()
        self.fullsizeButton:Hide()
        self.surveyButton:ClearAllPoints()
        self.surveyButton:SetPoint("BOTTOM", 0, 30)
        self.surveyButton:AttachTooltip()
        self.crateButton:ClearAllPoints()
        self.crateButton:SetPoint("BOTTOMLEFT", 30, 30)
        self.linkFrameButton:Show()
        self.solveButton:Hide()
        self.solveLabel:Hide()
        private.LinkFrame:showLinkPage(false)
    end
    self.minified = minified
    ExcavatinatorDB.minified = minified
end

function MainFrame:Update(...)
    for k, v in pairs(self.raceFrames) do
        v:Update()
    end

    private.ArtifactList:ReloadRace()

    -- Count crates and crateables
    local crateCount = GetItemCount(87399)
    local crateableCount = 0
    local crateableID = 0
    for i=1, #private.data.crateable do
        local count = GetItemCount(private.data.crateable[i])
        crateableCount = crateableCount + count
        if count > 0 then crateableID = private.data.crateable[i] end
    end

    self.crateLabel:SetText(crateCount .. " (" .. crateableCount .. ")")

    self.solveButton:SetTexture("")
    self.solveButton:Disable()
    self.solveLabel:SetText("")
    for i = 1, GetNumArchaeologyRaces() do
        local race = Race:getByID(i)
        local artifact = race:getActiveArtifact()
        if artifact and artifact:canSolve() then
            self.solveButton.artifact = artifact
            self.solveButton:SetTexture(artifact.icon)
            self.solveButton:Enable()
            self.solveLabel:SetText(artifact.race.name)
            break
        end
    end

    if (InCombatLockdown()) then return end
    if crateableID > 0 then
        self.crateButton:Enable()
        self.crateButton:SetAttribute("item", GetItemInfo(crateableID))
    else
        self.crateButton:Disable()
    end
end

function MainFrame:PLAYER_REGEN_DISABLED()
    self.crateButton:Disable()
    self.collapseButton:Disable()
    self.fullsizeButton:Disable()
end

function MainFrame:PLAYER_REGEN_ENABLED()
    self.crateButton:Enable()
    self.collapseButton:Enable()
    self.fullsizeButton:Enable()
    self:Update()
end

local ArtifactList = Frame:new("Frame", "ExcavatinatorArtifactList", MainFrame.frame)
private.ArtifactList = ArtifactList

ArtifactList:SetSize(500, 515)
ArtifactList:SetPoint("TOPLEFT", MainFrame.frame, "TOPRIGHT")
ArtifactList:SetStandardBackdrop()

ArtifactList.closeButton = CreateFrame("Button", nil, ArtifactList.frame, "UIPanelCloseButton")
ArtifactList.closeButton:SetPoint("TOPRIGHT", -5, -5)

ArtifactList.lines = {}

for i=1, 31 do
    ArtifactList.lines[i] = ArtifactLine:new("ArtifactLine"..i, ArtifactList.frame)
    ArtifactList.lines[i]:SetPoint("TOPLEFT", 10, -(i-1)*16-10)
end

function ArtifactList:LoadRace(race)
    self.race = race
    race:sortArtifacts()
    for i=1, #self.lines do
        self.lines[i]:Hide();
    end
    for i=1, #race.artifacts do
        self.lines[i]:SetArtifact(race.artifacts[i])
        self.lines[i]:Show()
    end
end

function ArtifactList:ReloadRace()
    if not self.race then return end
    self:LoadRace(self.race)
end

ArtifactList:Hide()

local LinkFrame = Frame:new("Frame", "ExcavatinatorLinkFrame", MainFrame.frame)
private.LinkFrame = LinkFrame

-- Create the main links frame
LinkFrame:SetSize(500, 148)
LinkFrame:SetPoint("TOPLEFT", MainFrame.frame, "TOPRIGHT")
LinkFrame:SetStandardBackdrop()
LinkFrame:Hide()

LinkFrame.manuallyOpened = false

LinkFrame.closeButton = Button:new("Button", "ExcavatinatorLinkFrameCloseButton", LinkFrame.frame, "UIPanelCloseButton")
LinkFrame.closeButton:SetPoint("TOPRIGHT", -5, -5)
local _closeFn = LinkFrame.closeButton:GetScript("OnClick")
LinkFrame.closeButton:SetScript("OnClick", function(...)
    _closeFn(...)
    LinkFrame.manuallyOpened = false
end)

LinkFrame.mainPage = Frame:new("Frame", "ExcavatinatorLinkFrameMainPage", LinkFrame.frame)
LinkFrame.mainPage:SetAllPoints()
LinkFrame.mainPage.header = createLabel(LinkFrame.mainPage, "Your links")
LinkFrame.mainPage.header:SetPoint("TOPLEFT", 16, -16)
LinkFrame.mainPage.lines = {}

LinkFrame.linkPage = Frame:new("Frame", "ExcavatinatorLinkFrameLinkPage", LinkFrame.frame)
LinkFrame.linkPage:SetAllPoints()
LinkFrame.linkPage.header = createLabel(LinkFrame.linkPage, "Unmatched project found")
LinkFrame.linkPage.header:SetPoint("TOPLEFT", 16, -16)
LinkFrame.linkPage.lines = {}

LinkFrame.linkPage.projectIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameLinkPageProjectIcon", LinkFrame.linkPage.frame)
LinkFrame.linkPage.projectIcon:SetSize(32, 32)
LinkFrame.linkPage.projectIcon.texture = LinkFrame.linkPage.projectIcon:CreateTexture()
LinkFrame.linkPage.projectIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
LinkFrame.linkPage.projectIcon.texture:SetDrawLayer("BACKGROUND")
LinkFrame.linkPage.projectIcon.texture:SetAllPoints()
LinkFrame.linkPage.projectIcon:SetPoint("TOPLEFT", 16, -36)

LinkFrame.linkPage.projectLabel = createLabel(LinkFrame.linkPage, "This is the project name")
LinkFrame.linkPage.projectLabel:SetPoint("TOPLEFT", 50, -44)

LinkFrame.linkPage.midLabel = createLabel(LinkFrame.linkPage, "Please click the matching item:")
LinkFrame.linkPage.midLabel:SetPoint("TOPLEFT", 16, -84)

LinkFrame.unlinkPage = Frame:new("Frame", "ExcavatinatorLinkFrameUnlinkPage", LinkFrame.frame)
LinkFrame.unlinkPage:SetAllPoints()
LinkFrame.unlinkPage.header = createLabel(LinkFrame.unlinkPage, "Unlink these two?")
LinkFrame.unlinkPage.header:SetPoint("TOPLEFT", 16, -16)
LinkFrame.unlinkPage.lines = {}

LinkFrame.unlinkPage.projectIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameUnlinkPageProjectIcon", LinkFrame.unlinkPage.frame)
LinkFrame.unlinkPage.projectIcon:SetSize(32, 32)
LinkFrame.unlinkPage.projectIcon.texture = LinkFrame.unlinkPage.projectIcon:CreateTexture()
LinkFrame.unlinkPage.projectIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
LinkFrame.unlinkPage.projectIcon.texture:SetDrawLayer("BACKGROUND")
LinkFrame.unlinkPage.projectIcon.texture:SetAllPoints()
LinkFrame.unlinkPage.projectIcon:SetPoint("TOPLEFT", 16, -36)

LinkFrame.unlinkPage.projectLabel = createLabel(LinkFrame.unlinkPage, "This is the project name")
LinkFrame.unlinkPage.projectLabel:SetPoint("TOPLEFT", 50, -44)

LinkFrame.unlinkPage.itemIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameUnlinkPageItemIcon", LinkFrame.unlinkPage.frame)
LinkFrame.unlinkPage.itemIcon:SetSize(32, 32)
LinkFrame.unlinkPage.itemIcon.texture = LinkFrame.unlinkPage.itemIcon:CreateTexture()
LinkFrame.unlinkPage.itemIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
LinkFrame.unlinkPage.itemIcon.texture:SetDrawLayer("BACKGROUND")
LinkFrame.unlinkPage.itemIcon.texture:SetAllPoints()
LinkFrame.unlinkPage.itemIcon:SetPoint("TOPLEFT", 16, -72)

LinkFrame.unlinkPage.itemLabel = createLabel(LinkFrame.unlinkPage, "This is the item name")
LinkFrame.unlinkPage.itemLabel:SetPoint("TOPLEFT", 50, -80)

LinkFrame.unlinkPage.unlinkButton = CreateFrame("Button", "ExcavatinatorLinkFrameUnlinkButton", LinkFrame.unlinkPage.frame, "UIPanelButtonTemplate")
LinkFrame.unlinkPage.unlinkButton:SetWidth(100)
LinkFrame.unlinkPage.unlinkButton:SetText("Unlink")
LinkFrame.unlinkPage.unlinkButton:SetPoint("BOTTOM", 0, 16)
LinkFrame.unlinkPage.unlinkButton.linkFrame = LinkFrame
LinkFrame.unlinkPage.unlinkButton:SetScript("OnClick", function(self)
    local race = private.Race:getByInternalName(self.linkFrame.unlinkPage.raceName)
    race:clearMapping(self.linkFrame.unlinkPage.projectName)
    self.linkFrame:showMainPage()
end)

local function _mainBtnClick(self)
    self.linkFrame.unlinkPage.raceName = self.raceName
    self.linkFrame.unlinkPage.projectName = self.projectName
    self.linkFrame:showUnlinkPage()
end

function LinkFrame:ensureMainPageLines(linecount)
    local minHeight = 0
    for i=#self.mainPage.lines + 1, linecount do
        local button = Button:new("Button", "ExcavatinatorLinkFrameMainPageLine" .. i, LinkFrame.mainPage.frame)
        local width = self:GetWidth()
        button:SetSize(width - 32, 16)
        button:SetPoint("TOPLEFT", 16, -20-20*i)
        button.OnClick = _mainBtnClick

        button.projectIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameProjectIcon" .. i, button.frame)
        button.projectIcon:SetSize(16, 16)
        button.projectIcon.texture = button.projectIcon:CreateTexture()
        button.projectIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
        button.projectIcon.texture:SetDrawLayer("BACKGROUND")
        button.projectIcon.texture:SetAllPoints()
        button.projectIcon:SetPoint("TOPLEFT", 36, 0)

        button.projectLabel = createLabel(button, "This is project number " .. i)
        button.projectLabel:SetPoint("TOPLEFT", 56, 0)

        button.centerLabel = createLabel(button, "<=>")
        button.centerLabel:SetPoint("TOPLEFT", 246, 0)

        button.itemIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameMainPageItemIcon" .. i, button.frame)
        button.itemIcon:SetSize(16, 16)
        button.itemIcon.texture = button.itemIcon:CreateTexture()
        button.itemIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
        button.itemIcon.texture:SetDrawLayer("BACKGROUND")
        button.itemIcon.texture:SetAllPoints()
        button.itemIcon:SetPoint("TOPLEFT", 276, 0)

        button.itemLabel = createLabel(button, "This is item number " .. i)
        button.itemLabel:SetPoint("TOPLEFT", 296, 0)

        button.linkFrame = self

        self.mainPage.lines[#self.mainPage.lines+1] = button

        minHeight = 52+20*i
    end

    if minHeight > self:GetHeight() then
        self:SetHeight(minHeight)
    end
end

local function _linkBtnClick(self)
    self.race:setMapping(self.projectName, self.artifactName)
    self.linkFrame:showLinkPage(self.linkFrame.manuallyOpened)
end

function LinkFrame:ensureLinkPageLines(linecount)
    local minHeight = 0
    for i=#self.linkPage.lines + 1, linecount do
        local button = Button:new("Button", "ExcavatinatorLinkFrameLinkPageLine" .. i, LinkFrame.linkPage.frame)
        local width = self:GetWidth()
        button:SetSize(width - 32, 16)
        button:SetPoint("TOPLEFT", 16, -100-20*i)
        button.OnClick = _linkBtnClick

        button.itemIcon = CreateFrame("Frame", "ExcavatinatorLinkFrameLinkPageItemIcon" .. i, button.frame)
        button.itemIcon:SetSize(16, 16)
        button.itemIcon.texture = button.itemIcon:CreateTexture()
        button.itemIcon.texture:SetTexture("Interface/ICONS/inv_belt_18")
        button.itemIcon.texture:SetDrawLayer("BACKGROUND")
        button.itemIcon.texture:SetAllPoints()
        button.itemIcon:SetPoint("TOPLEFT", 0, 0)

        button.itemLabel = createLabel(button, "This is item number " .. i)
        button.itemLabel:SetPoint("TOPLEFT", 20, 0)

        button.linkFrame = self

        self.linkPage.lines[#self.linkPage.lines+1] = button

        minHeight = 132+20*i
    end

    if minHeight > self:GetHeight() then
        self:SetHeight(minHeight)
    end
end

function LinkFrame:showMainPage()
    for i=1, #self.mainPage.lines do
        self.mainPage.lines[i]:Hide()
    end
    local i = 1
    for raceName, mappings in pairs(ExcavatinatorDB.mappings) do
        for projectName, artifactName in pairs(mappings) do
            if artifactName then
                local artifact = private.Artifact:getByItemName(artifactName)
                self:ensureMainPageLines(i)
                local button = self.mainPage.lines[i]
                button.projectIcon.texture:SetTexture(artifact.icon)
                button.projectLabel:SetText(projectName)
                button.itemIcon.texture:SetTexture(artifact.icon)
                button.itemLabel:SetText(artifactName)
                button.raceName = raceName
                button.projectName = projectName
                button:Show()
                i = i + 1
            end
        end
    end

    self.linkPage:Hide()
    self.unlinkPage:Hide()
    self.mainPage:Show()
    self:Show()
end

local function _findUnlinked()
    for raceName, mappings in pairs(ExcavatinatorDB.mappings) do
        for k, v in pairs(mappings) do
            if not v then
                return raceName, k
            end
        end
    end
end

function LinkFrame:showLinkPage(defaultToMainPage)
    -- If there are any unlinked artifacts, this shows the link page allowing
    -- the player to link one of them.
    -- Otherwise, this shows the main page.
    -- Find a race with an unlinked artifact
    local raceName, projectName = _findUnlinked()
    if raceName then
        local race = Race:getByInternalName(raceName)

        -- Fill the project name and icon
        self.linkPage.projectLabel:SetText(projectName)
        --print("Frame:", projectName, race.unmappedIcons[projectName])
        self.linkPage.projectIcon.texture:SetTexture(race.unmappedIcons[projectName])

        for i=1, #self.linkPage.lines do
            self.linkPage.lines[i]:Hide()
        end

        -- Fill the line labels and icons with the unmatched artifacts
        local i = 1
        for artifactName, artifact in pairs(race.unmappedArtifacts) do
            self:ensureLinkPageLines(i)
            local button = self.linkPage.lines[i]
            button.itemIcon.texture:SetTexture(artifact.icon)
            button.itemLabel:SetText(artifactName)
            button.artifactName = artifactName
            button.race = race
            button.projectName = projectName
            button:Show()
            i = i + 1
        end

        self.mainPage:Hide()
        self.unlinkPage:Hide()
        self.linkPage:Show()
        self:Show()
    elseif defaultToMainPage then
        self:showMainPage()
    else
        self:Hide()
    end
end

function LinkFrame:showUnlinkPage()
    local artifactName = ExcavatinatorDB.mappings[self.unlinkPage.raceName][self.unlinkPage.projectName]

    local artifact = private.Artifact:getByItemName(artifactName)
    self.unlinkPage.projectIcon.texture:SetTexture(artifact.icon)
    self.unlinkPage.projectLabel:SetText(self.unlinkPage.projectName)
    self.unlinkPage.itemIcon.texture:SetTexture(artifact.icon)
    self.unlinkPage.itemLabel:SetText(artifactName)

    self.mainPage:Hide()
    self.linkPage:Hide()
    self.unlinkPage:Show()
    self:Show()
end

--expose = LinkFrame
--LinkFrame:showLinkPage()