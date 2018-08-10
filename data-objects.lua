local _, private = ...

local artifactItemIDMap = {}
local artifactItemNameMap = {}
local artifactSpellIDMap = {}
local artifactSpellNameMap = {}

local Artifact = private.Class:extend()
private.Artifact = Artifact

function Artifact:cloned()
    self.itemName = GetItemInfo(self.item) or "unknown"
    self.spellName, _, self.icon = GetSpellInfo(self.spell)

    artifactItemIDMap[self.item] = self
    artifactItemNameMap[self.itemName:lower()] = self
    artifactSpellIDMap[self.spell] = self
    artifactSpellNameMap[self.spellName:lower()] = self

    self.description = self.description or ""
    self.icon = self.icon or ""
    self.keystones = self.keystones or 0
    self.completed = self.completed or 0
    self.firstCompleted = self.firstCompleted or 0
    self.race = ""
end

function Artifact:update()
    self.itemName = GetItemInfo(self.item) or "unknown"
    artifactItemNameMap[self.itemName:lower()] = self
end

function Artifact:isCompleted()
    return self.completed > 0
end

function Artifact:isPristineCompleted()
    if not self.pristine then return false end
    return IsQuestFlaggedCompleted(self.pristine.quest)
end

function Artifact:timesCompleted()
    return self.completed
end

function Artifact:getFragments()
    local activeArtifact = self.race:getActiveArtifact()
    if activeArtifact ~= self then return 0, 0 end

    SetSelectedArtifact(self.race.id)
    while ExcavatinatorDB.useKeystones and SocketItemToArtifact() do end

    local fragments, added, needed = GetArtifactProgress()
    return fragments + added, needed
end

function Artifact:canSolve()
    local activeArtifact = self.race:getActiveArtifact()
    if activeArtifact ~= self then return false end

    SetSelectedArtifact(self.race.id)
    while ExcavatinatorDB.useKeystones and SocketItemToArtifact() do end

    local fragments, added, needed = GetArtifactProgress()
    return fragments + added >= needed
end

function Artifact:solve()
    if not self:canSolve() then return end
    SolveArtifact()
end

function Artifact:getByItemID(itemID)
    return artifactItemIDMap[itemID]
end

function Artifact:getByItemName(itemName)
    return artifactItemNameMap[itemName:lower()]
end

function Artifact:getBySpellID(spellID)
    return artifactSpellIDMap[spellID]
end

function Artifact:getByProjectName(projectName)
    return artifactSpellNameMap[projectName:lower()]
end

function Artifact:getByItem(item)
    if type(item) == "string" then item = item:lower() end
    return artifactItemIDMap[item] or artifactItemNameMap[item]
end

function Artifact:getByName(name)
    return artifactSpellNameMap[name:lower()] or artifactItemNameMap[name:lower()]
end

local raceIDMap = {}
local raceNameMap = {}
local raceInternalNameMap = {}

local Race = private.Class:extend()
private.Race = Race

function Race:construct(raceID, internalName)
    self.id = raceID
    self.internalName = internalName
    self.name, self.icon, self.keystone = GetArchaeologyRaceInfo(raceID)

    raceIDMap[raceID] = self
    raceNameMap[self.name:lower()] = self
    raceInternalNameMap[internalName] = self

    self.artifacts = {}
    self.unmappedArtifacts = {}
    self.unmappedIcons = {}

    for i=1, #private.data.artifacts[internalName] do
        local artifactData = private.data.artifacts[internalName][i]
        if artifactData.patch <= private.TOC_VERSION then
            local artifact = Artifact:clone(artifactData)
            self.artifacts[#self.artifacts+1] = artifact
            artifact.race = self
            self.unmappedArtifacts[artifact.itemName] = artifact
        end
    end

    self:update()
end

function Race:update()
    -- Update information on known artifacts
    local artifactCount = GetNumArtifactsByRace(self.id)
    for i=1, artifactCount do
        local name, description, _, icon, _, keystoneCount, _, _, completionTime, completionCount = GetArtifactInfoByRace(self.id, i)
        --if self.name == "Nerubian" then print(self.name, name) end
        local artifact = Artifact:getByName(self:getMapping(name))
        if artifact then
            artifact:update()
            artifact.description = description
            artifact.icon = icon
            artifact.keystones = keystoneCount
            artifact.completed = math.max(completionCount, artifact.completed)
            artifact.firstCompleted = completionTime
            if artifact.firstCompleted == 0 then artifact.completed = 0 end -- Because apparently the API doesn't quite get this
            self.unmappedArtifacts[artifact.itemName] = nil
        else
            print(self.name, name, icon)
            self:setMapping(name, false)
        end
        self.unmappedIcons[name] = icon
    end
end

function Race:getActiveArtifact()
    local name = GetActiveArtifactByRace(self.id)
    if not name then return nil end
    return Artifact:getByName(self:getMapping(name))
end

function Race:getProgress()
    local completed, total, solves = 0, #self.artifacts, 0
    for i=1, #self.artifacts do
        if self.artifacts[i]:isCompleted() then completed = completed + 1 end
        solves = solves + self.artifacts[i]:timesCompleted()
        if self.artifacts[i].pristine then
            total = total + 1
            if self.artifacts[i]:isPristineCompleted() then completed = completed + 1 end
        end
    end
    return completed, total, solves
end

local function artifactSort(a, b)
    if a.rarity == "rare" and b.rarity == "common" then return true end
    if b.rarity == "rare" and a.rarity == "common" then return false end
    if a.completed ~= b.completed then return a.completed > b.completed end
    return a.itemName < b.itemName
end

function Race:sortArtifacts()
    table.sort(self.artifacts, artifactSort)
end

function Race:getByID(raceID)
    return raceIDMap[raceID]
end

function Race:getByName(raceName)
    return raceNameMap[raceName:lower()]
end

function Race:getByInternalName(internalName)
    return raceInternalNameMap[internalName]
end

function Race:setMapping(from, to)
    if not ExcavatinatorDB.mappings[self.internalName] then ExcavatinatorDB.mappings[self.internalName] = {} end
    ExcavatinatorDB.mappings[self.internalName][from] = to
    self.unmappedArtifacts[to] = nil
end

function Race:getMapping(from)
    if not ExcavatinatorDB.mappings[self.internalName] then return from end
    return ExcavatinatorDB.mappings[self.internalName][from] or from
end

function Race:clearMapping(from)
    if not ExcavatinatorDB.mappings[self.internalName] then return end
    local to = ExcavatinatorDB.mappings[self.internalName][from]
    local artifact = Artifact:getByItemName(to)
    ExcavatinatorDB.mappings[self.internalName][from] = false
    self.unmappedArtifacts[to] = artifact
end