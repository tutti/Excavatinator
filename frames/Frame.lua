local _, private = ...

local Class = private.Class

local Frame = Class:extend()
private.Frame = Frame

function Frame:construct(type, name, parent, template)
    self.frame = CreateFrame(type or "Frame", name or nil, parent or UIParent, template)
end