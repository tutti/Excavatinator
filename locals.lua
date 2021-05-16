local ADDON_NAME, private = ...

local Event = private.Event

private.loadSettings = function()
    if not ExcavatinatorDB then
        ExcavatinatorDB = {
            useKeystones = false
        }
    end
    private.settings = ExcavatinatorDB
end

local events = {
    settingsChanged = Event:new('settingsChanged'),
}
private.events = events