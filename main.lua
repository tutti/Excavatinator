local ADDON_NAME, private = ...

local MainWindow = private.MainWindow

local mainWindow = MainWindow:new()
function showMainWindow()
    mainWindow:open()
end

Excavatinator.events.ready:addOnceListener(function()
    private.loadSettings()
    private.loadMinimapManager()
    mainWindow:onLoad()
end)

SLASH_EXCAVATINATOR1 = '/arch'
SlashCmdList["EXCAVATINATOR"] = showMainWindow