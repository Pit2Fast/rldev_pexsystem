Config = {}

-- ORDER OF PERMISSIONS MUST BE THE SAME AS THE COLUMN NAMES IN THE DATABASE

Config.Permissions = {
    'revive',
    'tpm',
    'gotoplayer',
    'bring',
    'giveitem',
    'givemoney',
    'ban',
    'kick',
    'kill',
    'freeze'
}

Config.AdminPexId = 0 --Must be a number, all levels equal to or above this number will be able to give permissions to other players

-- Confirmation Messages
Config.PlayerRevive = 'You have revived the player!'
Config.PermissionsUpdatedMessage = 'Your permissions have been updated'
Config.YouUpdatedPermissionsMessage = 'You have updated the player permissions'
Config.KilledPlayer = 'You have killed the player'
Config.FreezedPlayer = 'You have freezed the player'
Config.UnfreezedPlayer = 'You have unfreezed the player'
Config.PlayerGotFreezed = 'You have been freezed by a staff member'
Config.PlayerGotUnreezed = 'You have been unfreezed by a staff member'

-- Error Messages
Config.NoPermissionMessage = 'You do not have permissions to do that'
Config.BanMessageCheater = 'You have been banned for trying to exploit the permission system!'

-- Menu Option Names
Config.ReviveTitle = 'Revive Player'
Config.GotoPlayer = 'Go To Player'
Config.BringPlayer = 'Bring Player To You'
Config.GiveItemPlayer = 'Give Item to Player'
Config.GiveMoneyPlayer = 'Give Money to Player'
Config.BanPlayer = 'Ban Player'
Config.KickPlayer = 'Kick Player'
Config.KillPlayer = 'Kill Player'
Config.FreezePlayer = 'Freeze/Unfreeze Player'
Config.KeyBindingDescription = 'Open Admin Menu' --Keybinding description in FiveM Options

function BanEventServerside(xTarget, reason)
    --WRITE HERE YOUR BAN CODE FOR CHEATERS
    --THIS EVENT IS TRIGGERED FROM THE SERVERSIDE
end