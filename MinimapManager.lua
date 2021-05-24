local _, private = ...

local Class = private.Class

local MinimapManager = Class:extend()

function MinimapManager:construct()
    self.hbdPins = LibStub('HereBeDragons-Pins-2.0')

    Excavatinator.events.enterDigsite:addListener(function()
        local finds = Excavatinator:getFindsForCurrentDigsite()
        for i, find in ipairs(finds) do
            self:createPinForFind(find)
        end
    end)

    Excavatinator.events.leaveDigsite:addListener(function()
        self.hbdPins:RemoveAllMinimapIcons('Excavatinator')
    end)

    Excavatinator.events.newDigsiteFind:addListener(function(find)
        self:createPinForFind(find)
    end)
end

function MinimapManager:createPinForFind(find)
    local icon = CreateFrame('Frame')
    icon:SetWidth(8)
    icon:SetHeight(8)
    icon.texture = icon:CreateTexture()
    icon.texture:SetTexture(134435) -- The shovel for "Survey"
    icon.texture:SetDrawLayer("BACKGROUND")
    icon.texture:SetAllPoints()
    self.hbdPins:AddMinimapIconMap('Excavatinator', icon, find.mapID, find.mapX, find.mapY, true)
end

private.loadMinimapManager = function()
    private.MinimapManager = MinimapManager:new()
end