local _, private = ...

local Class = private.Class
local WoWEvents = private.WoWEvents

local ITEMS = { -- These are the items we want to intercept clicks for (artifact fragment crates)
    [87533] = true, -- Dwarven
    [87534] = true, -- Draenei
    [87535] = true, -- Fossil
    [87536] = true, -- Night Elf
    [87537] = true, -- Nerubian
    [87538] = true, -- Orc
    [87539] = true, -- Tol'vir
    [87540] = true, -- Troll
    [87541] = true, -- Vrykul
    [117386] = true, -- Pandaren
    [117387] = true, -- Mogu
    [117388] = true, -- Mantid
    [142113] = true, -- Arakkoa
    [142114] = true, -- Draenor Clans
    [142115] = true, -- Ogre
    [164625] = true, -- Demon
    [164626] = true, -- Highborne
    [164627] = true, -- Highmountain Tauren
}

local MerchantManager = Class:extend()

function MerchantManager:construct()
    for buttonIndex=1, 10 do
        local originalSplit = _G['MerchantItem' .. buttonIndex .. 'ItemButton'].SplitStack
        _G['MerchantItem' .. buttonIndex .. 'ItemButton'].SplitStack = function(self, split)
            local itemIndex = self:GetID()
            local itemID = GetMerchantItemID(itemIndex)
            if not ITEMS[itemID] then return originalSplit(self, split) end
            private.MerchantManager:buyItem(itemIndex, split)
        end
    end

    hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, mouseButton)
        local bagSpace = GetContainerNumFreeSlots(0) + GetContainerNumFreeSlots(1) + GetContainerNumFreeSlots(2) + GetContainerNumFreeSlots(3) + GetContainerNumFreeSlots(4)
        local purchaseableItems = math.min(bagSpace, Excavatinator.numberOfCrates)
        if purchaseableItems == 0 then return end
        StackSplitFrame:OpenStackSplitFrame(purchaseableItems, self, "BOTTOMLEFT", "TOPLEFT", 1)
    end)

    StaticPopupDialogs['EXCAVATINATOR_BULK_BUY_TIP'] = {
        text = 'Tip: Excavatinator enables bulk buy (shift+click) of fragment crates.',
        button1 = 'OK',
    }

    WoWEvents.MERCHANT_SHOW:addListener(function() self:openMerchant() end)
    WoWEvents.MERCHANT_CLOSED:addListener(function() self:cancel() end)

    self.updateFrame = CreateFrame('Frame')
    self.updateFrame:SetScript('OnUpdate', function(tbl, elapsed) self:onUpdate(elapsed) end)
    self.timeElapsed = 0

    self.buyItemIndex = nil
    self.buyItemQuantity = 0
end

function MerchantManager:openMerchant()
    local isFragmentMerchant = false
    for i=1, GetMerchantNumItems() do
        if ITEMS[GetMerchantItemID(i)] then isFragmentMerchant = true end
    end
    if isFragmentMerchant and not private.settings.hasShownBulkBuyTip then
        StaticPopup_Show('EXCAVATINATOR_BULK_BUY_TIP')
        private.settings.hasShownBulkBuyTip = true
    end
end

function MerchantManager:buyItem(itemIndex, count)
    self.buyItemIndex = itemIndex
    self.buyItemQuantity = count
end

function MerchantManager:cancel()
    self.buyItemIndex = nil
    self.buyItemQuantity = 0
end

function MerchantManager:onUpdate(elapsed)
    self.timeElapsed = self.timeElapsed + elapsed
    if self.timeElapsed < 0.2 then return end
    self.timeElapsed = self.timeElapsed - 0.2

    if self.buyItemIndex and self.buyItemQuantity > 0 then
        BuyMerchantItem(self.buyItemIndex)
        self.buyItemQuantity = self.buyItemQuantity - 1
        if self.buyItemQuantity <= 0 then
            self.buyItemIndex = nil
            self.buyItemQuantity = 0
        end
    end
end

private.loadMerchantManager = function()
    private.MerchantManager = MerchantManager:new()
end