local _, private = ...

local Frame = private.Frame

local Button = Frame:extend()
private.Button = Button

function Button:construct(type, name, parent, template)
    Frame.construct(self, type or 'Button', name, parent, template)

    self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self.frame.wrapper = self
    if not template then self.frame:SetScript("OnClick", self._click) end
end

function Button:_click(...)
    self.wrapper:onClick(...)
end

function Button:onClick(...) end