local _, private = ...

local Button = private.Button

local TextureButton = Button:extend()
private.TextureButton = TextureButton

function TextureButton:construct(name, parent, texture, template)
    Button.construct(self, "Button", name, parent, template)

    self.texture = {}
    
    self.texture.normal = self.frame:CreateTexture()
    self.texture.normal:SetTexture(texture)
    self.texture.normal:SetDrawLayer("BACKGROUND")
    self.texture.normal:SetAllPoints()
    
    self.texture.pushed = self.frame:CreateTexture()
    self.texture.pushed:SetTexture("Interface/Buttons/UI-Quickslot-Depress")
    self.texture.pushed:SetAllPoints()
    self.texture.pushed:SetBlendMode("ADD")
    self.texture.pushed:SetDrawLayer("BORDER")
    self.frame:SetPushedTexture(self.texture.pushed)
    
    self.texture.disabled = self.frame:CreateTexture()
    self.texture.disabled:SetTexture(texture)
    self.texture.disabled:SetAllPoints()
    self.texture.disabled:SetDesaturated(true)
    self.texture.disabled:SetVertexColor(0.5, 0.5, 0.5)
    self.texture.disabled:SetDrawLayer("BORDER")
    self.frame:SetDisabledTexture(self.texture.disabled)
    
    self.texture.highlight = self.frame:CreateTexture()
    self.texture.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
    self.texture.highlight:SetAllPoints()
    self.texture.highlight:SetBlendMode("ADD")
    self.texture.highlight:SetDrawLayer("HIGHLIGHT")
    
    self.frame:SetSize(32, 32)
end

function TextureButton:setTexture(texture)
    self.texture.normal:SetTexture(texture)
    self.texture.disabled:SetTexture(texture)
end