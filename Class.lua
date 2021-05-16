local _, private = ...

local Class = {}
Class.__index = Class
private.Class = Class

function Class:new(...)
    if not rawget(self, "__index") then return error("Can't create new object from object.") end
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

function Class:construct(...) end