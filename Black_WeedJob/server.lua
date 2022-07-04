-- By Black
-- Discord : https://discord.gg/mPqYzkem75
---@author Black.
---@version 1.0

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'weedshop', 'alerte weedshop', true, true)

TriggerEvent('esx_society:registerSociety', 'weedshop', 'weedshop', 'society_weedshop', 'society_weedshop', 'society_weedshop', {type = 'public'})

RegisterServerEvent('weedshop:annonceopen')
AddEventHandler('weedshop:annonceopen', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'WeedShop', '~b~Annonce WeedShop', 'Le WeedShop est ~g~Ouvert, ~w~vient goûter a la meilleure came de la ville  !', 'CHAR_SOCIAL_CLUB', 8)

    end
end)

RegisterServerEvent('weedshop:annonceclose')
AddEventHandler('weedshop:annonceclose', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'WeedShop', '~b~Annonce WeedShop', 'Le WeedShop est ~r~Fermer, ~w~Repasse plus tard pour goûter à la meilleure came de la ville !', 'CHAR_SOCIAL_CLUB', 8)

    end
end)

RegisterServerEvent('weedshop:annoncerecrutement')
AddEventHandler('weedshop:annoncerecrutement', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'WeedShop', '~b~Annonce WeedShop', '~g~Recrutement en cours, ~w~rendez-vous au WeedShop avec une tenue (on sen  fou de votre style) !', 'CHAR_SOCIAL_CLUB', 8)

    end
end)

RegisterServerEvent('weedshop:patronmess')
AddEventHandler('weedshop:patronmess', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'weedshop' then
            TriggerClientEvent('weedshop:infoservice', xPlayers[i], _raison, name, message)
        end
    end
end)

RegisterServerEvent('weedshop:prendreitems')
AddEventHandler('weedshop:prendreitems', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weedshop', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            -- can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', _source, 'objet retiré', count, inventoryItem.label)
            end
        else
            TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
        end
    end)
end)


RegisterNetEvent('weedshop:stockitem')
AddEventHandler('weedshop:stockitem', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weedshop', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "objet déposé "..count..""..inventoryItem.label.."")
        else
            TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
        end
    end)
end)


ESX.RegisterServerCallback('weedshop:inventairejoueur', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('weedshop:prendreitem', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weedshop', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('weedshop:achatfridge')
AddEventHandler('weedshop:achatfridge', function(v, quantite)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    local playerlimite = xPlayer.getInventoryItem(v.item).count

    if playerlimite >= 10 then
        TriggerClientEvent('esx:showNotification', source, "Ton inventaire est plein!")
    
    else
    if playerMoney >= v.prix * quantite then
        xPlayer.addInventoryItem(v.item, quantite)
        xPlayer.removeMoney(v.prix * quantite)

       TriggerClientEvent('esx:showNotification', source, "Tu as acheté ~g~x"..quantite.." ".. v.nom .."~s~ pour ~g~" .. v.prix * quantite.. "$")
    else
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de sous pour acheter ~g~"..quantite.." "..v.nom)
    end
    
end
    
end)
