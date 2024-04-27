-- Q1 - Fix or improve the implementation of the below methods

-- These methods are designed to release a player's storage when they log out.
-- If a player's storageValue of 1000 is marked as 1 (which in this context likely means "true"), then we add an event to release that storage
-- by marking it as -1.

-- What does "1000" mean in this context?

-- Marks player's storage as invalid and releases it. Using a defined storageNumber variable makes this more modular.
function releaseStorage(storageNumber, player)
  player:setStorageValue(storageNumber, -1)
end

-- On logout, if a player still has valid storage, add an event to release that storage.
function onLogout(player)
  -- Use a variable to make this check more easily editable/expandable in the future.
  local storageValueToCheck = 1000
  
  if player:getStorageValue(storageValueToCheck) == 1 then
    addEvent(releaseStorage, storageValueToCheck, player)
  end
  
  -- Check to make sure storage has been released. If not, return false to notify systems.
  if player:getStorageValue(storageValueToCheck) == -1 then
    return true
  else
    return false
  end
end