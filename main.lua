local ADDON_NAME, private = ...

local MainWindow = private.MainWindow

local mainWindow = MainWindow:new()
function showMainWindow()
    mainWindow:open()
end

Excavatinator.events.ready:addOnceListener(function()
    private.loadSettings()
    mainWindow:onLoad()
end)

SLASH_EXCAVATINATOR41 = '/arch'
SlashCmdList["EXCAVATINATOR4"] = showMainWindow