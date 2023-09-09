fx_version 'adamant'

game 'gta5'
lua54 'yes'
author 'Red Light - RedLight Development'
description 'Permissions system created to supply to the ESX basic one'
version '1.10.1'

client_scripts {
	'@es_extended/locale.lua',
	'cl/*.lua',
	'config.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
	'@es_extended/imports.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'sv/*.lua'
}

dependencies {
	'/server:5848',
    '/onesync',
	'es_extended',
	'oxmysql',
	'ox_lib'
}