local _, private = ...

local Frame = private.Frame

local Bar = private.Frame:extend()
private.Bar = Bar

function Bar:construct(name, parent)
    Frame.construct(self, nil, name, parent)

    self.fillFrame = CreateFrame("Frame", name and name .. "_fill" or "", self.frame)
    self.fillFrame:SetPoint("LEFT")
    self.fillFrame:Hide()

    local t = self.frame.texture or self.frame:CreateTexture()
    t:SetColorTexture(0.3, 0.3, 0.3, 1)
    t:SetAllPoints(self.frame)
    self.frame.texture = t

    t = self.fillFrame.texture or self.fillFrame:CreateTexture()
    t:SetColorTexture(0, 1, 0, 1)
    t:SetAllPoints(self.fillFrame)
    self.fillFrame.texture = t

    self.width = 0
    self.height = 0
    self.fill = 0.5

    self:_resize()
end

function Bar:_resize()
    self.frame:SetWidth(self.width)
    self.frame:SetHeight(self.height)
    if self.fill > 0 then
        self.fillFrame:Show()
        self.fillFrame:SetWidth(self.fill * self.width)
        self.fillFrame:SetHeight(self.height)
    else
        self.fillFrame:Hide()
    end
end

function Bar:setSize(width, height)
    self.width = width
    self.height = height
    self:_resize()
end

function Bar:setFill(fill)
    if type(fill) ~= 'number' then return end
    if fill < 0 then fill = 0 end
    if fill > 1 then fill = 1 end
    self.fill = fill
    self:_resize()
end