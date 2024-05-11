local ADDON_NAME, private = ...

local MainWindow = private.MainWindow

local mainWindow = MainWindow:new()
function showMainWindow()
    mainWindow:open()
end

local function onReady()
    private.loadSettings()
    private.loadMinimapManager()
    private.loadMerchantManager()
    mainWindow:onLoad()
end

--Excavatinator.events.ready:addOnceListener(function()
--end)

if Excavatinator.ready then
    onReady()
else
    Excavatinator.events.ready:addOnceListener(onReady)
end

SLASH_EXCAVATINATOR1 = '/arch'
SlashCmdList["EXCAVATINATOR"] = showMainWindow