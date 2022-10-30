local _, private = ...

local Event = private.Event
local Button = private.Button

local CheckButton = Button:extend()
private.CheckButton = CheckButton

function CheckButton:construct(name, parent, text)
    Button.construct(self, "CheckButton", name, parent, "SettingsCheckBoxControlTemplate")
    self.frame.CheckBox:SetPoint("LEFT", 0, 0)
    self.frame:SetHitRectInsets(0, 0, 0, 0)
    self.frame.CheckBox:SetScript("OnClick", function() self:onClick(not self.isChecked) end)
    self.frame.Text:SetText(text)
    self.frame.Text:SetTextColor(1, 1, 1)
    self.frame.Text:SetPoint("LEFT", 32, 0)
    self.text = text
    self.isChecked = false

    self.events = {
        updated = Event:new('updated'),
    }
end

function CheckButton:setChecked(checked)
    self.isChecked = checked
    self.frame:SetValue(checked)
end

function CheckButton:setText(text)
    self.text = text
    return self.frame.Text:SetText(text)
end

function CheckButton:onClick(val)
    self:setChecked(val)
    self.events.updated:trigger(val)
end