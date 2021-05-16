local _, private = ...

local Event = private.Event
local Button = private.Button

local CheckButton = Button:extend()
private.CheckButton = CheckButton

function CheckButton:construct(name, parent, text)
    Button.construct(self, "CheckButton", name, parent, "OptionsCheckButtonTemplate")
    self.frame:SetHitRectInsets(0, -60, 0, 0)
    self.frame.SetValue = function(tbl) self:onClick(tbl.newValue == '1') end
    self.label = _G[name .. "Text"]
    self.label:SetText(text)
    self.label:SetTextColor(1, 1, 1)
    self.text = text

    self.events = {
        updated = Event:new('updated'),
    }
end

function CheckButton:setText(text)
    self.text = text
    return self.label:SetText(text)
end

function CheckButton:onClick(val)
    self.events.updated:trigger(val)
end