local ADDON_NAME, private = ...

local Event = private.Event

private.loadSettings = function()
    if not ExcavatinatorSettings then
        ExcavatinatorSettings = {
            useKeystones = false,
            hasShownBulkBuyTip = false,
        }
    end
    private.settings = ExcavatinatorSettings
end

local events = {
    settingsChanged = Event:new('settingsChanged'),
}
private.events = events