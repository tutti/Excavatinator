local _, private = ...

local DEBUG = false
if DEBUG then print("Excavatinator debugging is ON!") end

local references = {}
local function __cloneTable(tbl)
    if references[tbl] then return references[tbl] end
    local clone = {}
    references[tbl] = clone
    for k, v in pairs(tbl) do
        local _k = type(k) == "table" and __cloneTable(k) or k
        local _v = type(v) == "table" and __cloneTable(v) or v
        clone[_k] = _v
    end
    return clone
end

local function cloneTable(tbl)
    table.wipe(references)
    return __cloneTable(tbl)
end
private.cloneTable = cloneTable

function private.debug(...)
    if DEBUG then print(...) end
end