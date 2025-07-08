-- AI Realistic Defend Script by Tanuki Infosec & Nemesis Sims
-- Makes AI planes defend more realistically: not invincible, not passive, just human-like

-- SETTINGS
local AI_GROUP_PREFIX = "AI_PLANE_" -- only affects groups starting with this name

function MakeAIAircraftRealistic(groupName)
    local group = Group.getByName(groupName)
    if not group then
        env.warning("Group not found: " .. groupName)
        return
    end

    local controller = group:getController()
    if not controller then return end

    -- Balanced defense settings
    controller:setOption(AI.Option.Air.id.ReactionOnThreat, AI.Option.Air.val.ReactionOnThreat.Passive)
    controller:setOption(AI.Option.Air.id.EvadeFire, true)
    controller:setOption(AI.Option.Air.id.EvadeHeatSeekers, true)
    controller:setOption(AI.Option.Air.id.EvadeRadarGuidedMissiles, true)

    -- Smooth maneuvering by not forcing aggressive reactions
    controller:setOption(AI.Option.Air.id.Maneuver, AI.Option.Air.val.Maneuver.EvadeFire)

    -- ROE: Return fire only
    controller:setOption(AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.ReturnFire)

    env.info("Realistic defense AI applied to: " .. groupName)
end

function ApplyLifelikeDefenseToAll()
    for _, group in pairs(coalition.getGroups(coalition.side.BLUE, Group.Category.AIRPLANE)) do
        if string.find(group:getName(), AI_GROUP_PREFIX) then
            MakeAIAircraftRealistic(group:getName())
        end
    end
    for _, group in pairs(coalition.getGroups(coalition.side.RED, Group.Category.AIRPLANE)) do
        if string.find(group:getName(), AI_GROUP_PREFIX) then
            MakeAIAircraftRealistic(group:getName())
        end
    end
end

-- Run after mission load
timer.scheduleFunction(function()
    ApplyLifelikeDefenseToAll()
    return nil
end, {}, timer.getTime() + 5)
