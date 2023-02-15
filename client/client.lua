ESX = exports['es_extended']:getSharedObject()

_menuPool = NativeUI.CreatePool()

CreateThread(function()
    while true do
        _menuPool:ProcessMenus()
        Citizen.Wait(0)
            if IsControlJustReleased(0, Config.Key) and not  _menuPool:IsAnyMenuOpen() then
                OpenMenu()
            end
    end
end)

function OpenMenu()
     mainmenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_title'], Translation[Config.Locale]['menu_description'])
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    local docs = NativeUI.CreateItem(Translation[Config.Locale]['docs'], Translation[Config.Locale]['docs_descprtion'])
    docs:RightLabel('>>>')
    docs.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        OpenDocsMenu()
    end
    mainmenu:AddItem(docs)
    local wallet = NativeUI.CreateItem(Translation[Config.Locale]['wallet'], Translation[Config.Locale]['wallet_descprtion'])
    wallet:RightLabel('>>>')
    wallet.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        OpenWalletMenu()
    end
    mainmenu:AddItem(wallet)    
    local bill = NativeUI.CreateItem(Translation[Config.Locale]['bill'], Translation[Config.Locale]['bill_description'])
    bill:RightLabel('>>>')
    bill.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        OpenBillMenu()
    end
    mainmenu:AddItem(bill) 
   --[[ local vehicle = NativeUI.CreateItem(Translation[Config.Locale]['vehicle'], Translation[Config.Locale]['vehicle_description'])
    vehicle:RightLabel('>>>')
    vehicle.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        OpenVehicleMenu()
    end
    mainmenu:AddItem(vehicle) --]]
end

function OpenDocsMenu()
     mainmenu = NativeUI.CreateMenu(Translation[Config.Locale]['docs'], Translation[Config.Locale]['docs_descprtion'])
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    local perso = NativeUI.CreateItem(Translation[Config.Locale]['perso'], '')
    perso.Activated = function(sender, index)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
    end
    mainmenu:AddItem(perso)
    local showperso = NativeUI.CreateItem(Translation[Config.Locale]['showperso'], '')
    showperso.Activated = function(sender, index)
        local player, distance = GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
        else
            if Config.useESX then
                ESX.ShowNotification(Translation[Config.Locale]['nonearbyplayer'])
            else
                notify(Translation[Config.Locale]['nonearbyplayer'])
            end
        end
    end
    mainmenu:AddItem(showperso)
    local drive = NativeUI.CreateItem(Translation[Config.Locale]['drive'], '')
    drive.Activated = function(sender, index)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
    end
    mainmenu:AddItem(drive)
    local showdrive = NativeUI.CreateItem(Translation[Config.Locale]['showdrive'], '')
    showdrive.Activated = function(sender, index)
        local player, distance = GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
        else
            if Config.useESX then
                ESX.ShowNotification(Translation[Config.Locale]['nonearbyplayer'])
            else
                notify(Translation[Config.Locale]['nonearbyplayer'])
            end
        end
    end
    mainmenu:AddItem(showdrive)
    local weapon = NativeUI.CreateItem(Translation[Config.Locale]['weapon'], '')
    weapon.Activated = function(sender, index)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
    end	
    mainmenu:AddItem(weapon)
    local showweapon = NativeUI.CreateItem(Translation[Config.Locale]['showweapon'], '')
    showweapon.Activated = function(sender, index)
        local player, distance = GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
        else
            if Config.useESX then
                ESX.ShowNotification(Translation[Config.Locale]['nonearbyplayer'])
            else
                notify(Translation[Config.Locale]['nonearbyplayer'])
            end
        end
    end	
    mainmenu:AddItem(showweapon)
    mainmenu.OnMenuClosed = function(menu)
		OpenMenu()
	end
end

function OpenWalletMenu()
     walletmenu = NativeUI.CreateMenu(Translation[Config.Locale]['wallet'], Translation[Config.Locale]['menu_description'])
    
    _menuPool:Add(walletmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    walletmenu:Visible(true)
    local job = NativeUI.CreateItem('Job:', '')
    ESX.TriggerServerCallback('ams_menu:getJob', function(esxjob, grade)
		job:RightLabel(esxjob .. ' | ' .. grade)
	end)
    walletmenu:AddItem(job)
    local bank = NativeUI.CreateItem('Bank', '')
    ESX.TriggerServerCallback('ams_menu:getBank', function(bankmoney)
        bank:RightLabel(bankmoney)
    end)
    walletmenu:AddItem(bank)
    local money = NativeUI.CreateItem(Translation[Config.Locale]['money'], '')
    ESX.TriggerServerCallback('ams_menu:getMoney', function(playermoney)
        money:RightLabel('$' .. playermoney)
    end)
    walletmenu:AddItem(money)
    walletmenu.OnMenuClosed = function(menu)
		OpenMenu()
	end
end

function OpenBillMenu()
     mainmenu = NativeUI.CreateMenu(Translation[Config.Locale]['bill'], Translation[Config.Locale]['bill_description'])
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    ESX.TriggerServerCallback('esx_billing:getBills', function(bills) 
        for k, v in pairs(bills) do
            local billitem = NativeUI.CreateItem(bills, '')
            mainmenu:AddItem(billitem)
        end
    end)
end

--[[function OpenVehicleMenu()
     mainmenu = NativeUI.CreateMenu('Menu-Name', 'Menu-Description')
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    local motor = NativeUI.CreateItem(Translation[Config.Locale]['engine'], '')
    motor.Activated = function(sender, index)
        local playerPed = GetPlayerPed()

        if GetIsVehicleEngineRunning(playerPed) then
            SetVehicleEngineOn(playerPed, false, false, true)
            SetVehicleUndriveable(playerPed, true)
        elseif not GetIsVehicleEngineRunning(playerPed) then
            SetVehicleEngineOn(playerPed, true, false, true)
            SetVehicleUndriveable(playerPed, false)
        end
    end
    mainmenu:AddItem(motor)
end--]]

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end