local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO) -- Set correct sprite
combat:setArea(createCombatArea(AREA_DIAMOND4X4)) -- Added in spells.lua

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

-- Loops our effect so the tornadoes disappear and then reappear as in the video
local function sendEffect(pos, effectId, delay, i, j)
    -- Loop terminator
    if i == j then
        return
    end
    -- Draw the effect and iterate the "loop"
    pos:sendMagicEffect(effectId)
    addEvent(sendEffect, delay, pos, effectId, delay, i + 1, j)
end

-- Initiate drawing the effect around the player.
function onTargetTile(creature, position)
    sendEffect(position, CONST_ME_ICETORNADO, 800, 0, 3)
end

-- Set callbacks
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Entry point method
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
