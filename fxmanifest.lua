fx_version 'cerulean'
 
game 'gta5'

lua54 'yes'
 
version '1.0.0'

client_scripts {
    'config/config_cl.lua',
    'client/*.lua'
}

server_scripts {
    'config/config_sv.lua',
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/js/*.js'
}