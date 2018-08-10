local excavatinatorName, private = ...

local _, _, _, TOC_VERSION = GetBuildInfo()
private.TOC_VERSION = TOC_VERSION

local isLoaded = false
local loadingScreen = CreateFrame("Frame", "ExcavatinatorLoadingScreen", UIParent)
local loadingMessage = loadingScreen:CreateFontString()
loadingMessage:SetFont("Fonts\\FRIZQT__.TTF", 12)
loadingMessage:SetText("Excavatinator is loading, please hold...")
loadingScreen:SetBackdrop({
    bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 } })
loadingScreen:SetSize(300, 30)
loadingScreen:SetPoint("CENTER")
loadingMessage:SetPoint("CENTER")
loadingScreen:Hide()

local defaultDB = {
    mappings = {}
}

local function dbIntegrity(db)
    if not db then db = defaultDB end
    if not db.mappings then
        db.mappings = defaultDB.mappings
    end
    return db
end

local function testLoaded()
    local loaded = true
    for racename, artifacts in pairs(private.data.artifacts) do
        for i=1, #artifacts do
            if not artifacts[i].loaded then
                local itemName = GetItemInfo(artifacts[i].item)
                if itemName then artifacts[i].loaded = true else loaded = false end
            end
        end
    end
    return loaded
end

local eventFrame = private.Frame:new()
eventFrame:RegisterEvent("ADDON_LOADED")
function eventFrame:ADDON_LOADED(addonName)
    RequestArtifactCompletionHistory()
    if addonName == excavatinatorName then
        --if not ExcavatinatorDB then ExcavatinatorDB = defaultDB end
        ExcavatinatorDB = dbIntegrity(ExcavatinatorDB)
        GetSpellInfo(80451)
        for k, v in pairs(private.data.artifacts) do
            for i = 1, #v do
                local artifact = v[i]
                if artifact.patch <= TOC_VERSION then
                    GetItemInfo(artifact.item)
                    GetSpellInfo(artifact.spell)
                    if artifact.pristine then
                        GetItemInfo(artifact.pristine.item)
                    end
                end
            end
        end
    end
end
local time = 0
function eventFrame:OnUpdate(elapsed)
    if isLoaded then return end
    time = time + elapsed
    if time > 0.5 then
        time = 0
        --local itemName = GetItemInfo(69775) -- Try to query the Vrykul Drinking Horn
        if testLoaded() then
            private.data.process()
            private.MainFrame:Show()
            loadingScreen:Hide()
            isLoaded = true
            self:SetScript("OnUpdate", nil)
        end
    end
end

--eventFrame:SetScript("OnUpdate", eventFrame.OnUpdate)

function showExcavatinator() -- This is the slash command, so it can't have a self reference
    if InCombatLockdown() then
        print("You are in combat! Excavatinator cannot open.")
        return nil
    end
    
    --private.MainFrame:Show()
    if isLoaded then
        private.MainFrame:Show()
    else
        loadingScreen:Show()
        eventFrame:SetScript("OnUpdate", eventFrame.OnUpdate)
    end
end

SLASH_EXCAVATINATOR1 = '/arch'
SlashCmdList["EXCAVATINATOR"] = showExcavatinator