local ADDON_NAME, private = ...

local Event = private.Event

local _, _, _, TOC_VERSION = GetBuildInfo()
private.TOC_VERSION = TOC_VERSION

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