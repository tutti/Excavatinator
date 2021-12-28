local _, private = ...

local Class = private.Class
local Event = private.Event

local MinimapManager = Class:extend()

function MinimapManager:construct()
    self.hbdPins = LibStub('HereBeDragons-Pins-2.0')
    self.surveys = {}
    self.lastDigsite = 0

    Excavatinator.events.enterDigsite:addListener(function(digsite)
        if digsite.id ~= self.lastDigsite then self.surveys = {} end
        self.lastDigsite = digsite.id
        self:updatePins()
    end)

    Excavatinator.events.leaveDigsite:addListener(function()
        self:updatePins()
    end)

    Excavatinator.events.newDigsiteFind:addListener(function(find)
        self:updatePins()
    end)

    private.WoWEvents.ARCHAEOLOGY_SURVEY_CAST:addListener(function(finds, totalFinds, raceID, success)
        if success == 1 then
            self.surveys = {}
        else
            local playerX, playerY = UnitPosition('player')
            self.surveys[#self.surveys+1] = {
                x = playerX,
                y = playerY,
                result = nil,
            }
        end
        self:updatePins()
    end)

    self.surveyUpdate = Event:new('surveyUpdate')
end

function MinimapManager:updatePins()
    self.hbdPins:RemoveAllMinimapIcons('Excavatinator')
    local finds = Excavatinator:getFindsForCurrentDigsite()
    for i, find in ipairs(finds) do
        self:createPinForFind(find)
    end

    self.surveyUpdate:trigger(#self.surveys > 0 and self.surveys[#self.surveys] or nil)
end

function MinimapManager:createPinForFind(find)
    local possibleNext = true
    for i = 1, #self.surveys do
        if self.surveys[i].result ~= nil then
            local distance = CalculateDistance(self.surveys[i].x, self.surveys[i].y, find.worldX, find.worldY)
            if (self.surveys[i].result == 'green' and distance > 45)
                or (self.surveys[i].result == 'yellow' and distance < 35)
                or (self.surveys[i].result == 'yellow' and distance > 85)
                or (self.surveys[i].result == 'red' and distance < 75)
            then
                possibleNext = false
                break
            end
        end
    end

    local distance = -1

    if #self.surveys > 0 then
        distance = CalculateDistance(self.surveys[#self.surveys].x, self.surveys[#self.surveys].y, find.worldX, find.worldY)
    end

    local icon = CreateFrame('Frame')
    icon:SetWidth(10)
    icon:SetHeight(10)
    icon.texture = icon:CreateTexture()
    icon.texture:SetTexture(457644)
    icon.texture:SetDrawLayer("BACKGROUND")
    if not possibleNext then icon.texture:SetAlpha(0.3) end
    if distance ~= -1 then
        if distance <= 40 then icon.texture:SetVertexColor(0, 255, 0) end
        if distance > 40 and distance <= 80 then icon.texture:SetVertexColor(255, 255, 0) end
        if distance > 80 then icon.texture:SetVertexColor(255, 0, 0) end
    end
    icon.texture:SetAllPoints()
    self.hbdPins:AddMinimapIconMap('Excavatinator', icon, find.mapID, find.mapX, find.mapY, true)
end

function MinimapManager:setLastSurveyResult(result)
    -- Result is one of "red", "yellow", "green"
    if #self.surveys == 0 then return end

    self.surveys[#self.surveys].result = result

    self:updatePins()
end

private.loadMinimapManager = function()
    private.MinimapManager = MinimapManager:new()
end