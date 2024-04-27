-- Q3 - Fix or improve the name and the implementation of the below method

-- What is this method trying to do, and how should we rename it to reflect that?
-- It seems like it is removing a specific player from another player's (likely THE player's) party, given a specific player's ID and another player's name.

-- "local" dec is missing on player? 

-- This function removes a specified member of a specific player's party.
function removeMemberFromPlayerParty(playerId, memberName)
  -- Get our player via ID and then get their party.
  local player = Player(playerId)
  local party = player:getParty()

-- Iterate until we find the specific player we want to remove, and then remove from the party. Rename iterators to be more descriptive.
  for i,playerToRemove in pairs(party:getMembers()) do
    if playerToRemove == Player(memberName) then
      -- Use playerToRemove to not have to double-cast Player(memberName)
      party:removeMember(playerToRemove)
    end
  end
end