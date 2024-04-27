//Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);

    if (!player) {
        player = new Player(nullptr); // The new keyword for this pointer is not resolved with a delete(), memory leak!
        if (!IOLoginData::loadPlayerByName(player, recipient)) 
        {
            delete(player); // Add delete() call before return to solve potential memory leak.
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);

    if (!item) // Since we don't explicitly create new item pointers if !item like we did for player, no risk here.
    {
        delete(player); // Add delete() call before return to solve potential memory leak.
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) 
    {
        IOLoginData::savePlayer(player);
    }

    delete(player); // Add delete() call at the end of the method to solve potential memory leak.
}