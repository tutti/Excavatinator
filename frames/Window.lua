local _, private = ...

local Frame = private.Frame

local Window = private.Frame:extend()
private.Window = Window

function Window:construct(name, parent)
    Frame.construct(self, nil, name, parent or UIParent, "BackdropTemplate")
    self.frame:SetBackdrop({
        bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })
end

function Window:makeDraggable()
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)
    self.frame:SetClampedToScreen(true)
    self.frame:SetScript("OnDragStart", self.frame.StartMoving)
    self.frame:SetScript("OnDragStop", self.frame.StopMovingOrSizing)
    self.frame:RegisterForDrag("LeftButton")    
end