local _, private = ...

local Frame = private.Frame

local Label = private.Frame:extend()
private.Label = Label

function Label:construct(parent, text, size)
    -- Does not call super constructor, creates its own frame
    self.frame = parent:CreateFontString()
    self.frame:SetFont("Fonts\\FRIZQT___CYR.TTF", size or 12)
    self.frame:SetText(text)
end

function Label:setText(text)
    self.frame:SetText(text)
end