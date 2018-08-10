local _, private = ...

local Artifact = private.Artifact
local Race = private.Race

local __processed = false

private.data.crateable = {}

function private.data.process()
    if processed then return end

    for racename, race in pairs(private.data.artifacts) do
        for i=1, #race do
            if race[i].patch <= private.TOC_VERSION and race[i].crate then private.data.crateable[#private.data.crateable+1] = race[i].item end
        end
    end

    -- Find the correct race ordering.
    local raceOrder = 0
    for k, v in pairs(private.data.raceOrder) do
        if k <= private.TOC_VERSION and k > raceOrder then raceOrder = k end
    end
    local races = private.data.raceOrder[raceOrder]

    -- Create race objects for the found races.
    -- The race objects will handle loading artifact data themselves.
    for i=1, #races do
        Race:new(i, races[i])
    end

    processed = true
end