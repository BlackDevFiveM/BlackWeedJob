-- By Black
-- Discord : https://discord.gg/mPqYzkem75
---@author Black.
---@version 1.0

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshweedshopMoney()
end)


Citizen.CreateThread(function()

        local weedshopmap = AddBlipForCoord(377.51, -828.90, 29.30)
        SetBlipSprite(weedshopmap, 140)
        SetBlipColour(weedshopmap, 2)
        SetBlipAsShortRange(weedshopmap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("WeedShop")
        EndTextCommandSetBlipName(weedshopmap)


end)

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(weedshop.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then 
            if (weedshop.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < weedshop.DrawDistance) then
                DrawMarker(weedshop.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, weedshop.Size.x, weedshop.Size.y, weedshop.Size.z, 0,255,0,100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    
end
end)

RMenu.Add('fridgeweedshop', 'main', RageUI.CreateMenu("Frigo", "Pour la consommation perso des clients"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('fridgeweedshop', 'main'), true, true, true, function()    
         
        for k, v in pairs(weedshop.fridgeitem) do
            RageUI.Button(v.nom.." ~r~$"..v.prix.."", nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('weedshop:achatfridge', v, quantite)
            end
            end)

        end
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, weedshop.pos.fridge.position.x, weedshop.pos.fridge.position.y, weedshop.pos.fridge.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au stock")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('fridgeweedshop', 'main'), not RageUI.Visible(RMenu:Get('fridgeweedshop', 'main')))
                    end   
                end
               end 
        end
end)

RMenu.Add('garageweedshop', 'main', RageUI.CreateMenu("Garage", "Pour des go fast ou livraisons !"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garageweedshop', 'main'), true, true, true, function() 
            RageUI.Button("Ranger le véhicule", "Pour ranger le véhicule.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                ESX.ShowAdvancedNotification("Garage", "Le véhicule est arrivé, t'a d'la chance!", "", "CHAR_BIKESITE", 1)
                DeleteEntity(veh)
            end 
            end
            end)         
            RageUI.Button("sultan", "Pour sortir une Sultan.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            ESX.ShowAdvancedNotification("Garage", "Le véhicule arrive, ne l'abîme pas ou j'te goume", "", "CHAR_BIKESITE", 1) 
            Citizen.Wait(2000)   
            spawnuniCar("sultan")
            ESX.ShowAdvancedNotification("Garage", "Abime pas le véhicule !!!", "", "CHAR_BIKESITE", 1) 
            end
            end)
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, weedshop.pos.garage.position.x, weedshop.pos.garage.position.y, weedshop.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garageweedshop', 'main'), not RageUI.Visible(RMenu:Get('garageweedshop', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, weedshop.pos.spawnvoiture.position.x, weedshop.pos.spawnvoiture.position.y, weedshop.pos.spawnvoiture.position.z, weedshop.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Up Atom"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end

RMenu.Add('coffreweedshop', 'main', RageUI.CreateMenu("Coffre", "Pour déposer/récuperer des choses dans le coffre."))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('coffreweedshop', 'main'), true, true, true, function()
            RageUI.Button("Prendre objet", "Pour prendre un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenGetStocksweedshopMenu()
            end
            end)
            RageUI.Button("Déposer objet", "Pour déposer un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenPutStocksweedshopMenu()
            end
            end)
            end, function()
            end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, weedshop.pos.coffre.position.x, weedshop.pos.coffre.position.y, weedshop.pos.coffre.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('coffreweedshop', 'main'), not RageUI.Visible(RMenu:Get('coffreweedshop', 'main')))
                    end   
                end
               end 
        end
end)

function OpenGetStocksweedshopMenu()
    ESX.TriggerServerCallback('weedshop:prendreitem', function(items)
        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'weedshop',
            title    = 'weedshop stockage',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'weedshop',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('weedshop:prendreitems', itemName, count)

                    Citizen.Wait(300)
                    OpenGetStocksweedshopMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStocksweedshopMenu()
    ESX.TriggerServerCallback('weedshop:inventairejoueur', function(inventory)
        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'weedshop',
            title    = 'inventaire',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'weedshop',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('weedshop:stockitem', itemName, count)

                    Citizen.Wait(300)
                    OpenPutStocksweedshopMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end
--vestiaire

RMenu.Add('vestiaireweedshop', 'main', RageUI.CreateMenu("Vestiaire", "Pour prendre votre tenue de service ou reprendre votre tenue civil."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('vestiaireweedshop', 'main'), true, true, true, function()
            RageUI.Button("Tenue civil", "Pour prendre votre tenue civil.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            ESX.ShowNotification('Vous avez repris votre ~b~tenue civil')
            end)
            end
            end)
            
            RageUI.Button("tenue de Service", "Pour prendre votre tenue de Service.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            if skin.sex == 0 then
                clothesSkin = {
                            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                            ['torso_1'] = 237,   ['torso_2'] = 0,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 23,
                            ['pants_1'] = 78,   ['pants_2'] = 2,
                            ['shoes_1'] = 1,   ['shoes_2'] = 0,
                            ['chain_1'] = 0,  ['chain_2'] = 0
                        }
            else
                clothesSkin = {
                            ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
                            ['torso_1'] = 8,    ['torso_2'] = 2,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 5,
                            ['pants_1'] = 44,   ['pants_2'] = 4,
                            ['shoes_1'] = 0,    ['shoes_2'] = 0,
                            ['chain_1'] = 0,    ['chain_2'] = 2
                        }
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            ESX.ShowNotification('Vous avez équipé votre ~b~tenue de Service, tu salis, tu paye !')
            end)

            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, weedshop.pos.vestiaire.position.x, weedshop.pos.vestiaire.position.y, weedshop.pos.vestiaire.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('vestiaireweedshop', 'main'), not RageUI.Visible(RMenu:Get('vestiaireweedshop', 'main')))
                    end   
                end
               end 
        end
end)


local societyweedshopmoney = nil

RMenu.Add('weedshopf6', 'main', RageUI.CreateMenu("WeedShop", "La meilleure came de LA"))
RMenu.Add('weedshopf6', 'patron', RageUI.CreateSubMenu(RMenu:Get('weedshopf6', 'main'), "Option patron", "Option patron"))

Citizen.CreateThread(function()
    while true do
    	

        RageUI.IsVisible(RMenu:Get('weedshopf6', 'main'), true, true, true, function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' and ESX.PlayerData.job.grade_name == 'boss' then	
        RageUI.Button("Option patron", "Option disponible pour le patron", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('weedshopf6', 'patron'))
        end
        RageUI.Button("Facture", "Pour facturer le client", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local amount = KeyboardInput('Veuillez saisir le montant de la facture', '', 4)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_weedshop', 'weedshop', amount)
                    end

            end
            end)
        RageUI.Button("Annonce ouvert", "Pour annoncer l'ouverture du WeedShop", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('weedshop:annonceopen')
            end
            end)
            end, function()
        end)
        RageUI.IsVisible(RMenu:Get('weedshopf6', 'patron'), true, true, true, function()
            if societyweedshopmoney ~= nil then
            RageUI.Button("Montant disponible dans la société :", nil, {RightLabel = "$" .. societyweedshopmoney}, true, function()
            end)
        end
        RageUI.Button("Annonce recrutement", "Pour annoncer des recrutements au WeedShop", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
				TriggerServerEvent('weedshop:annoncerecrutement')
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' then  
                    
                    if IsControlJustPressed(1,167) then
                        RageUI.Visible(RMenu:Get('weedshopf6', 'main'), not RageUI.Visible(RMenu:Get('weedshopf6', 'main')))
                        RefreshweedshopMoney()
                    end   
                
               end 
        end
end)

RegisterNetEvent('weedshop:infoservice')
AddEventHandler('weedshop:infoservice', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO weedshop', '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_SOCIAL_CLUB', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

function RefreshweedshopMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyweedshopMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyweedshopMoney(money)
    societyweedshopmoney = ESX.Math.GroupDigits(money)
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdboss = GetEntityCoords(GetPlayerPed(-1), false)
                local bossdist = Vdist(plycrdboss.x, plycrdboss.y, plycrdboss.z, weedshop.pos.boss.position.x, weedshop.pos.boss.position.y, weedshop.pos.boss.position.z)
		    if bossdist <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weedshop' and ESX.PlayerData.job.grade_name == 'boss' then	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la gestion d'entreprise")
                    if IsControlJustPressed(1,51) then
                        OpenBossActionsweedshopMenu()
                    end   
                end
               end 
        end
end)

function OpenBossActionsweedshopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weedshop',{
        title    = 'Action patron weedshop',
        align    = 'top-left',
        elements = {
            {label = 'Gestion employées', value = 'boss_weedshopactions'},
    }}, function (data, menu)
        if data.current.value == 'boss_weedshopactions' then
            TriggerEvent('esx_society:openBossMenu', 'weedshop', function(data, menu)
                menu.close()
            end)
        end
    end, function (data, menu)
        menu.close()

    end)
end
