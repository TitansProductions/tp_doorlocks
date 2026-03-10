fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'Titans Productions - Doorlocks'
version '1.0.0'

shared_scripts { 'config.lua', 'locales.lua', 'doorhashes.lua'   }
client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }

dependencies {
    'tp_libs',
}

lua54 'yes'
