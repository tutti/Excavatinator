local _, private = ...

local Class = {}
Class.__index = Class
private.Class = Class

function Class:new(...)
    if not rawget(self, "__index") then return error("Can't create new object from object. Did you mean clone()?") end
    local r = {}
    setmetatable(r, self)
    r:construct(...)
    return r
end

function Class:extend()
    if not rawget(self, "__index") then return error("Can't extend object.") end
    local r = {}
    setmetatable(r, self)
    r.__index = r
    return r
end

function Class:super()
    if not rawget(self, "__index") then return getmetatable(getmetatable(self)) end -- Objects have classes, not superclasses.
    return getmetatable(self)
end

function Class:class()
    if rawget(self, __index) then return self end -- If this is called on a class, that class is returned.
    return getmetatable(self)
end

-- If called on an object, returns a clone of that object.
-- If called on a class, returns a clone of the passed object,
-- but with that class as its class.
-- Either way, cloned() is called on the new object.
-- All values in the original are copied to the clone. Table
-- values are deep copied, except for objects in the class system,
-- which are not copied and instead keep their reference.
function Class:clone(original)
    if self.__index then
        local clone = {}
        setmetatable(clone, self)
        for k, v in pairs(original) do
            if type(v) == "table" and (not v.instanceOf or not v:instanceOf(Class)) then
                clone[k] = private.cloneTable(v)
            else
                clone[k] = v
            end
        end
        clone:cloned()
        return clone
    else
        return self:class():clone(self)
    end
end

function Class:instanceOf(class)
    if self == class then return true end
    if self == Class then return class == Class end
    if self.__index then return self:super():instanceOf(class) end
    return self:class():instanceOf(class)
end

function Class:construct(...) end
function Class:cloned() end

local Frame = Class:extend()
private.Frame = Frame

-- This class will pass its function calls on to its frame, if it doesn't
-- have them itself. The __lastFrameKey variable holds the function name that
-- was called, because there's no better way to pass it to the passing function.
local __lastFrameKey
local function __frameIndexFunction(table, key)
    local ownMethod = getmetatable(table)[key]
    if ownMethod then return ownMethod end
    local frame = rawget(table, "frame")
    if frame and frame[key] then
        __lastFrameKey = key
        return table.__callOnFrame
    end
    return nil
end
Frame.__index = __frameIndexFunction

local function frameEventHandler(self, event, ...)
    if self.wrapper[event] and type(self.wrapper[event] == "function") then
        self.wrapper[event](self.wrapper, ...)
    end
end

function Frame:extend()
    local r = Class.extend(self)
    r.__index = __frameIndexFunction
    return r
end

function Frame:construct(type, name, parent, template)
    self.frame = CreateFrame(type or "Frame", name or nil, parent or UIParent, template)
    self.frame.wrapper = self
    self.frame:SetScript("OnEvent", frameEventHandler)
end

function Frame:__callOnFrame(...)
    return self.frame[__lastFrameKey](self.frame, ...)
end

function Frame:__showTooltip(...)
    if self.wrapper.OnTooltip == Frame.OnTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:ClearLines()
    self.wrapper:OnTooltip(GameTooltip)
    GameTooltip:Show()
end

function Frame:__hideTooltip(...)
    if self.wrapper.OnTooltip == Frame.OnTooltip then return end
    GameTooltip:Hide()
end

function Frame:AttachTooltip()
    self.frame:SetScript("OnEnter", self.__showTooltip)
    self.frame:SetScript("OnLeave", self.__hideTooltip)
end

function Frame:DetachTooltip()
    self.frame:SetScript("OnEnter", nil)
    self.frame:SetScript("OnLeave", nil)
end

function Frame:OnTooltip(tooltip)

end

local standardBackdrop = {
    bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 } }

function Frame:SetStandardBackdrop()
    self:SetBackdrop(standardBackdrop)
end

local Button = Frame:extend()
private.Button = Button

function Button:construct(type, name, parent, template, ...)
    Frame.construct(self, type, name, parent, template, ...)

    self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    if not template then self.frame:SetScript("OnClick", self.__click) end
end

function Button:__click(...)
    self.wrapper:OnClick(...)
end

function Button:OnClick(...) end