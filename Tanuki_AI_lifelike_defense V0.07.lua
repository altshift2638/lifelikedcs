-- Removed math.randomseed as it's not available in DCS scripting

function MakeAIAircraftRealistic(groupName)
    local group = Group.getByName(groupName)
    if not group then
        env.warning("Group not found: " .. groupName)
        return
    end

    local controller = group:getController()
    if not controller then
        env.warning("No controller for group: " .. groupName)
        return
    end

    controller:setOption(1, 3)  -- Reaction On Threat: Aggressive
    controller:setOption(2, 1)  -- Evade fire enabled
    controller:setOption(3, 1)  -- Evade heat seekers enabled
    controller:setOption(4, 1)  -- Evade radar guided missiles enabled
    controller:setOption(5, 3)  -- Maneuver mode: Aggressive
    controller:setOption(6, 0)  -- ROE: | 0 | Weapons Free || 1 | Return Fire      || 2 | Hold Fire        |


    env.info("Realistic AI behavior applied to: " .. groupName)

    local function applyImperfectManeuvers()
        if not group or not group:isExist() then
            return nil
        end

        local ctrl = group:getController()
        if not ctrl then
            return nil
        end

        if math.random() < 0.3 then
            ctrl:setOption(5, 1)
            env.info("Imperfect maneuver applied to: " .. groupName)

            timer.scheduleFunction(function()
                if group and group:isExist() then
                    local c = group:getController()
                    if c then
                        c:setOption(5, 3)
                        env.info("Maneuver mode reverted to aggressive for: " .. groupName)
                    end
                end
                return nil
            end, {}, timer.getTime() + math.random(3, 7))
        end

        timer.scheduleFunction(applyImperfectManeuvers, {}, timer.getTime() + math.random(5,10))
        return nil
    end

    timer.scheduleFunction(applyImperfectManeuvers, {}, timer.getTime() + math.random(1,3))
    return nil
end

function ApplyLifelikeDefenseToAll()
    for _, group in pairs(coalition.getGroups(coalition.side.BLUE, Group.Category.AIRPLANE)) do
        local delay = math.random(0, 3)
        timer.scheduleFunction(function()
            MakeAIAircraftRealistic(group:getName())
            return nil
        end, {}, timer.getTime() + delay)
    end

    for _, group in pairs(coalition.getGroups(coalition.side.RED, Group.Category.AIRPLANE)) do
        local delay = math.random(0, 3)
        timer.scheduleFunction(function()
            MakeAIAircraftRealistic(group:getName())
            return nil
        end, {}, timer.getTime() + delay)
    end
    return nil
end

local function delayedStart()
    if coalition.getGroups then
        trigger.action.outText("✅ Tanuki AI Defense v0.07 Loaded: Human-like Imperfection Enabled", 10)
        env.info("Tanuki AI: Script initialized, applying to all AI aircraft.")
        ApplyLifelikeDefenseToAll()
    else
        env.warning("Tanuki AI: Coalition not ready, retrying in 5 seconds.")
        timer.scheduleFunction(delayedStart, {}, timer.getTime() + 5)
    end
    return nil
end

timer.scheduleFunction(delayedStart, {}, timer.getTime() + 5)
