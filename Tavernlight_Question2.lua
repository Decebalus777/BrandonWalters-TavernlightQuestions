-- Q2 - Fix or improve the implementation of the below method

-- This method is designed to print names of ALL guilds that have less than a specified max number of members.
-- That info is returned from a database using a query, and then we return each name.

-- Is that query correct?
-- Is formatting this way a good idea?
-- It seems to only return and print ONE guild name, we should be printing all? Loop?
-- What exactly does resultId return?

-- this method is supposed to print names of all guilds that have less than memberCount max members
function printSmallGuildNames(memberCount)
  -- Consolidate all formatting and query forming into one line, sacrifices some clutter for ease of access and keeping the database call itself cleaner.
  local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
  
  -- Query our database and store the result, a data structure containing all guild names that match the criteria.
  local resultId = db.storeQuery(selectGuildQuery)
  
  if resultId == true then
    -- Iterate through returned table in pairs, feeding each guild's info in to get the name before printing.
    for i,guildInfo in pairs(resultId) do
      local guildName = result.getString(guildInfo, "name")
      print(guildName)
    end
  end
end
