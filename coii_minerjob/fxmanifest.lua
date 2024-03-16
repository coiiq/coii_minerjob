fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'coii'
description 'Miner Job'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

server_scripts {
    'server/server.lua'
}

dependencies {
    'ox_target',
    'ox_lib'
}