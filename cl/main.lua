local FreezedPlayers = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    TriggerServerEvent('rldev_pexsystem:initplayer')
    FreezedPlayers[GetPlayerServerId()] = false
    print('Loading permissions...')
end)

RegisterNetEvent('rldev_pexsystem:adminmenu')
AddEventHandler('rldev_pexsystem:adminmenu',function(menuOptions)

    lib.registerContext({
        id = 'admin_menu',
        title = 'Admin Menu',
        options = {
          {
            title = 'Revive',
            description = 'Revive a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'revive'
            }
          },
          {
            title = 'TPM',
            description = 'Teleport to Marker',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'tpm'
            }
          },
          {
            title = 'Goto',
            description = 'Teleport to a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'gotoplayer'
            }
          },
          {
            title = 'Bring',
            description = 'Bring a player to you by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'bring'
            }
          },
          {
            title = 'Give Item',
            description = 'Give Item to a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'giveitem'
            }
          },
          {
            title = 'Give Money',
            description = 'Give Money to a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'givemoney'
            }
          },
          {
            title = 'Ban',
            description = 'Ban a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'ban'
            }
          },
          {
            title = 'Kick',
            description = 'Kick a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'kick'
            }
          },
          {
            title = 'Kill',
            description = 'Kill a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'kill'
            }
          },
          {
            title = 'Freeze',
            description = 'Freeze a player by his ID',
            icon = 'circle',
            event = 'rldev_pexsystem:functionevh',
            arrow = false,
            args = {
                command = 'freeze'
            }
          },
        }
    })
    lib.showContext('admin_menu')
end)

RegisterNetEvent('rldev_pexsystem:functionevh')
AddEventHandler('rldev_pexsystem:functionevh',function(args)

    lib.callback('rldev_pexsystem:hasPermission', false, function(permission)
        if(permission == 1) then 
            if(args.command == 'revive') then
              local input = lib.inputDialog(Config.ReviveTitle, {'ID'})
              if not input then return end
              TriggerServerEvent('rldev_pexsystem:revivesecured', tonumber(input[1]))
            end
            if(args.command == 'tpm') then
              TriggerEvent("esx:tpm")
            end
            if(args.command == 'gotoplayer') then
              local input = lib.inputDialog(Config.GotoPlayer, {'ID'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:gotosecured", tonumber(input[1]))
            end
            if(args.command == 'bring') then
              local input = lib.inputDialog(Config.BringPlayer, {'ID'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:bringsecured", tonumber(input[1]))
            end
            if(args.command == 'giveitem') then
              local input = lib.inputDialog(Config.GiveItemPlayer, {'ID', 'Item', 'Count'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:giveitemsecured", tonumber(input[1]), input[2], tonumber(input[3]))
            end
            if(args.command == 'givemoney') then
              local input = lib.inputDialog(Config.GiveMoneyPlayer, {'ID', 'Amount'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:givemoneysecured", tonumber(input[1]), tonumber(input[2]))
            end
            if(args.command == 'ban') then
              local input = lib.inputDialog(Config.BanPlayer, {'ID', 'Reason'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:bansecured", tonumber(input[1]), input[2])
            end
            if(args.command == 'kick') then
              local input = lib.inputDialog(Config.KickPlayer, {'ID', 'Reason'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:kicksecured", tonumber(input[1]), input[2])
            end
            if(args.command == 'kill') then
              local input = lib.inputDialog(Config.KillPlayer, {'ID'})
              if not input then return end
              TriggerServerEvent("rldev_pexsystem:killsecured", tonumber(input[1]))
            end
            if(args.command == 'freeze') then
              local input = lib.inputDialog(Config.FreezePlayer, {'ID'})
              if not input then return end
              if (FreezedPlayers[tonumber(input[1])] == false) then
                FreezedPlayers[tonumber(input[1])] = true
              else
                FreezedPlayers[tonumber(input[1])] = false
              end
              TriggerServerEvent("rldev_pexsystem:freezesecured", tonumber(input[1]), FreezedPlayers[tonumber(input[1])])   
            end
        else
            ESX.ShowNotification(Config.NoPermissionMessage, 'error', 3000)
        end

    end, args.command)
end)
