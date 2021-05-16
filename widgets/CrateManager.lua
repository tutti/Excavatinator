local _, private = ...

local Frame = private.Frame
local TextureButton = private.TextureButton
local Label = private.Label
local Tooltip = private.Tooltip

local CrateManager = Frame:extend()
private.CrateManager = CrateManager

function CrateManager:construct(parent)
    Frame.construct(self, nil, (parent and parent:GetName() or 'Excavatinator') .. 'CrateManager', parent)

    self.frame:SetWidth(200)
    self.frame:SetHeight(32)

    local crateTexture = GetItemIcon(87399)
    self.button = TextureButton:new(nil, self.frame, crateTexture, 'InsecureActionButtonTemplate')
    self.button.frame:SetWidth(32)
    self.button.frame:SetHeight(32)
    self.button.frame:SetAttribute("type", "item")
    self.button.frame:SetAttribute("unit", "player")
    self.button.frame:SetPoint('LEFT', 0, 0)

    self.label = Label:new(self.frame, "0 (0)")
    self.label.frame:SetPoint("LEFT", self.button.frame, "RIGHT", 10, 0)

    self.tooltip = Tooltip:new(self.button.frame, function(tooltip)
        tooltip:AddLine('Crate an artifact')
        tooltip:AddLine('Click here to crate one of the', 1, 1, 1)
        tooltip:AddLine("artifacts you've solved.", 1, 1, 1)
    end)

    self:update()
    Excavatinator.events.cratesUpdated:addListener(function() self:update() end)
end

function CrateManager:update()
    if (InCombatLockdown()) then return end
    self.label:setText(Excavatinator.numberOfCrates .. ' (' .. Excavatinator.numberOfCrateableArtifacts .. ')')
    local crateables = Excavatinator:getCrateableArtifacts()
    if #crateables == 0 then
        self.button.frame:Disable()
    else
        self.button.frame:Enable()
        self.button.frame:SetAttribute('item', GetItemInfo(crateables[1]))
    end
end