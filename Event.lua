local _, private = ...

local Class = private.Class

local Event = Class:extend()
private.Event = Event

local function createListenable(event)
    local listenable = {}
    setmetatable(listenable, {
        __index = {
            name = event.name,
            addListener = function(sf, listener)
                event:addListener(listener)
            end,
            addOnceListener = function(sf, listener)
                event:addOnceListener(listener)
            end,
            removeListener = function(sf, listener)
                event:removeListener(listener)
            end
        },
        __newindex = function() end,
        __metatable = nil,
    })
    return listenable
end

function Event:construct(name)
    self.name = name
    self.listeners = {}
    self.onceListeners = {}
    self.listenable = createListenable(self)
end

function Event:addListener(listener)
    -- Add a listener that is called every time the event is triggered
    self.listeners[listener] = true
    self.onceListeners[listener] = nil
end

function Event:addOnceListener(listener)
    -- Add a listener that is called only the next time the event is triggered
    self.onceListeners[listener] = true
    self.listeners[listener] = nil
end

function Event:removeListener(listener)
    -- Remove a listener
    self.listeners[listener] = nil
    self.onceListeners[listener] = nil
end

function Event:trigger(...)
    local args = { ... }
    local n = select('#', ...)
    local errors = {}
    for k, v in pairs(self.listeners) do
        xpcall(function() k(unpack(args, 1, n)) end, function(e) errors[#errors+1] = e end)
    end
    for k, v in pairs(self.onceListeners) do
        xpcall(function() k(unpack(args, 1, n)) end, function(e) errors[#errors+1] = e end)
    end
    self.onceListeners = {}

    for i, e in ipairs(errors) do error(e) end
end

-- WoW events: The events the WoW client triggers
local WoWEvents = {}
private.WoWEvents = WoWEvents

local RegisteredWoWEvents = {}

local WoWEventsFrame = CreateFrame("Frame")
WoWEventsFrame:SetScript('OnEvent', function(self, eventName, ...)
    if RegisteredWoWEvents[eventName] then
        RegisteredWoWEvents[eventName]:trigger(...)
    end
end)

local WoWEventsMetatable = {
    __index = function(tbl, k)
        if not RegisteredWoWEvents[k] then
            RegisteredWoWEvents[k] = Event:new(k)
            WoWEventsFrame:RegisterEvent(k)
        end
        return RegisteredWoWEvents[k]
    end
}
setmetatable(WoWEvents, WoWEventsMetatable)