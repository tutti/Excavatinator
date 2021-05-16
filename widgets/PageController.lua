local _, private = ...

local Event = private.Event
local Frame = private.Frame
local Label = private.Label

local PageController = Frame:extend()
private.PageController = PageController

function PageController:construct(parent, pages)
    Frame.construct(self, nil, 'ExcavatinatorPageController', parent)

    self.frame:SetWidth(222)
    self.frame:SetHeight(32)

    self.currentIndex = 1
    self.pages = pages

    self.label = Label:new(self.frame, "Page")
    self.label.frame:SetPoint("TOPLEFT", 40, -10)

    self.prevPage = CreateFrame("Button", nil, self.frame)
    self.prevPage:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up")
    self.prevPage:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down")
    self.prevPage:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled")
    self.prevPage:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
    self.prevPage:SetSize(32, 32)
    self.prevPage:SetPoint("TOPLEFT", 0, 0)
    self.prevPage:RegisterForClicks("LeftButtonUp")
    self.prevPage:SetEnabled(false)
    self.prevPage:SetScript("OnClick", function() self:goToPrevPage() end)

    self.nextPage = CreateFrame("Button", nil, self.frame)
    self.nextPage:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up")
    self.nextPage:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down")
    self.nextPage:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled")
    self.nextPage:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
    self.nextPage:SetSize(32, 32)
    self.nextPage:SetPoint("TOPLEFT", 190, 0)
    self.nextPage:RegisterForClicks("LeftButtonUp")
    self.nextPage:SetScript("OnClick", function() self:goToNextPage() end)

    self.events = {
        raceClicked = Event:new('raceClicked'),
    }

    for i=1, #pages do
        pages[i].events.raceClicked:addListener(function(race) self.events.raceClicked:trigger(race) end)
    end

    self:updatePages()
end

function PageController:goToPrevPage()
    self.currentIndex = self.currentIndex - 1
    self:updatePages()
end

function PageController:goToNextPage()
    self.currentIndex = self.currentIndex + 1
    self:updatePages()
end

function PageController:updatePages()
    for i=1, #self.pages do
        if i == self.currentIndex then self.pages[i].frame:Show() else self.pages[i].frame:Hide() end
    end
    self.label:setText(self.pages[self.currentIndex].name)
    self.prevPage:SetEnabled(self.currentIndex > 1)
    self.nextPage:SetEnabled(self.currentIndex < #self.pages)
end