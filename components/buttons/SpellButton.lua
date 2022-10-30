local _, private = ...

local TextureButton = private.TextureButton

local SpellButton = TextureButton:extend()
private.SpellButton = SpellButton

function SpellButton:construct(name, parent, spell)
    TextureButton.construct(self, name, parent, nil, "InsecureActionButtonTemplate")

    self.spellID = 0

    self.frame:SetAttribute("type", "spell")
    self.frame:SetAttribute("unit", "player")
    self.frame:RegisterForClicks("AnyUp", "AnyDown")

    self.cooldown = CreateFrame("Cooldown", nil, self.frame)
    self.cooldown:SetSwipeTexture('Interface/Cooldown/cooldown2')
    self.cooldown:SetSwipeColor(0, 0, 0, 0.8)
    self.cooldown:SetAllPoints(self.frame)
    self.cooldown:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self.cooldown.cooldown = 0
    self.cooldown.spellID = 0
    self.cooldown:SetScript("OnEvent", self.spellcastEvent)

    if spell then self:setSpell(spell, cooldown) end
end

function SpellButton:spellcastEvent(event, unit, _, spellID)
    if unit == "player" and spellID == self.spellID then
        self:SetCooldown(GetTime(), self.cooldown)
    end
end

function SpellButton:setSpell(spellID)
    self.spellID = spellID

    local cooldown = GetSpellBaseCooldown(spellID)
    
    local spellName = GetSpellInfo(spellID)
    local texture = GetSpellTexture(spellName)
    
    self.texture.normal:SetTexture(texture)
    self.texture.disabled:SetTexture(texture)
    
    self.frame:SetAttribute("spell", spellName)
    
    self.cooldown.cooldown = cooldown / 1000
    self.cooldown.spellID = spellID
end