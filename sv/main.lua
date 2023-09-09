local pex = {}
local serverPex = {}

RegisterNetEvent('rldev_pexsystem:initplayer')
AddEventHandler('rldev_pexsystem:initplayer',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local query = MySQL.query.await('SELECT `permission_level` FROM `user_permissions` WHERE `identifier` = ?', { xPlayer.getIdentifier() })
     
    if query then
        if query[1] then
            for i = 1, #query do
                local row = query[i]
                print(row.permission_level)
                pex[xPlayer.getIdentifier()] = row.permission_level
            end
        else
            local insertQuery = MySQL.insert.await('INSERT INTO `user_permissions` (identifier, permission_level) VALUES (?, ?)', {
                xPlayer.getIdentifier(), 1
            })
            pex[xPlayer.getIdentifier()] = 1
            print('Inserting Player Identifier: '..xPlayer.getIdentifier()..' with permission level 1')
        end
    end

end)

lib.addCommand('givepex', {
    help = 'Update player permissions level',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
        {
            name = 'pex_level',
            type = 'number',
            help = 'Permission level to assign',
        },
    },
}, function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args.target)

    if Config.AdminPexId >= pex[xPlayer.getIdentifier()] then 
        return xPlayer.showNotification(Config.NoPermissionMessage)
    else
        pex[xTarget.getIdentifier()] = args.pex_level
        xTarget.showNotification(Config.PermissionsUpdatedMessage)
        xPlayer.showNotification(Config.YouUpdatedPermissionsMessage)
        local query = MySQL.update.await('UPDATE user_permissions SET permission_level = ? WHERE identifier = ?', {
            args.pex_level, xTarget.getIdentifier()
        })
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    retrieveServerPermissions()
end)

function retrieveServerPermissions()
    print('Retrieving server permissions...')
    local query = MySQL.query.await('SELECT * FROM `permission_levels`', {})
     
    if query then
        if query[1] then
            for i = 1, #query do
                local row = query[i]

                serverPex[row.level] = {
                    [Config.Permissions[1]] = row.revive, 
                    [Config.Permissions[2]] = row.tpm, 
                    [Config.Permissions[3]] = row.gotoplayer, 
                    [Config.Permissions[4]] = row.bring,
                    [Config.Permissions[5]] = row.giveitem,
                    [Config.Permissions[6]] = row.givemoney,
                    [Config.Permissions[7]] = row.ban,
                    [Config.Permissions[8]] = row.kick,
                    [Config.Permissions[9]] = row.kill,
                    [Config.Permissions[10]] = row.freeze,
                }

                --for k,v in pairs (serverPex[row.level]) do
                --    print('Group '..tostring(row.level)..' has permission of '..k..' equal to '..serverPex[row.level][k])
                --end
            end
        end
    end
    print('Server permissions retrieved')
end

lib.addCommand('refreshpex', {
    help = 'Refresh permissions list',
    params = { },
}, function(source, args, raw)

    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.AdminPexId >= pex[xPlayer.getIdentifier()] then 
        return xPlayer.showNotification(Config.NoPermissionMessage)
    else
        retrieveServerPermissions()
    end
end)

RegisterCommand("amenu", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if 0 >= pex[xPlayer.getIdentifier()] then 
        return xPlayer.showNotification(Config.NoPermissionMessage)
    else
        TriggerClientEvent('rldev_pexsystem:adminmenu', source)
    end
end, false)

lib.callback.register('rldev_pexsystem:hasPermission', function(source, command)
    local xPlayer = ESX.GetPlayerFromId(source)

    return serverPex[pex[xPlayer.getIdentifier()]][command] or 0
end)

RegisterNetEvent('rldev_pexsystem:revivesecured')
AddEventHandler('rldev_pexsystem:revivesecured',function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (serverPex[pex[xPlayer.getIdentifier()]]['revive']) then
        TriggerClientEvent('esx_ambulancejob:revive', id)
        xPlayer.showNotification(Config.PlayerRevive)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:gotosecured')
AddEventHandler('rldev_pexsystem:gotosecured',function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)

    if (serverPex[pex[xPlayer.getIdentifier()]]['gotoplayer']) then
        local targetCoords = xTarget.getCoords()
	    xPlayer.setCoords(targetCoords)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:bringsecured')
AddEventHandler('rldev_pexsystem:bringsecured',function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)

    if (serverPex[pex[xPlayer.getIdentifier()]]['bring']) then
        local targetCoords = xPlayer.getCoords()
	    xTarget.setCoords(targetCoords)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:giveitemsecured')
AddEventHandler('rldev_pexsystem:giveitemsecured',function(id, item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)

    if (serverPex[pex[xPlayer.getIdentifier()]]['giveitem']) then
        xTarget.addInventoryItem(item, count)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:givemoneysecured')
AddEventHandler('rldev_pexsystem:givemoneysecured',function(id, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)

    if (serverPex[pex[xPlayer.getIdentifier()]]['givemoney']) then
        xTarget.addMoney(amount)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:bansecured')
AddEventHandler('rldev_pexsystem:bansecured',function(id, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)

    if (serverPex[pex[xPlayer.getIdentifier()]]['ban']) then
        BanEventServerside(xTarget, reason)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:kicksecured')
AddEventHandler('rldev_pexsystem:kicksecured',function(id, reason)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (serverPex[pex[xPlayer.getIdentifier()]]['kick']) then
        DropPlayer(id, reason)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:killsecured')
AddEventHandler('rldev_pexsystem:killsecured',function(id)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (serverPex[pex[xPlayer.getIdentifier()]]['kill']) then
        TriggerClientEvent("esx:killPlayer", id)
        xPlayer.showNotification(Config.KilledPlayer)
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)

RegisterNetEvent('rldev_pexsystem:freezesecured')
AddEventHandler('rldev_pexsystem:freezesecured',function(id, var)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)
    if (serverPex[pex[xPlayer.getIdentifier()]]['freeze']) then
        if (var == false) then
            TriggerClientEvent('esx:freezePlayer', id, "freeze")
            xPlayer.showNotification(Config.FreezedPlayer)
            xTarget.showNotification(Config.PlayerGotFreezed)
        else
            TriggerClientEvent('esx:freezePlayer', id, "unfreeze")
            xPlayer.showNotification(Config.UnfreezedPlayer)
            xTarget.showNotification(Config.PlayerGotUnreezed)
        end
    else
        BanEventServerside(xPlayer.getIdentifier(), Config.BanMessageCheater)
    end

end)