--  ______  _   __        __     _  ____       ____                         __           
-- / ____/ / | / /       / /    (_)/ __/___   /  _/____  _   __ ____ _ ____/ /___   _____
-- \___ \ /  |/ /______ / /    / // /_ / _ \  / / / __ \| | / // __ `// __  // _ \ / ___/
-- ___/ // /|  //_____// /___ / // __//  __/_/ / / / / /| |/ // /_/ // /_/ //  __// /
--/____//_/ |_/       /_____//_//_/   \___//___//_/ /_/ |___/ \__,_/ \__,_/ \___//_/

--made by SN-Service https://discord.gg/snservice
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'SN-Service'
description "LifeInvader by DerPrince"
version '1.2.0'

escrow_ignore {
    'config.lua',
  }
  
  client_scripts {
    'config.lua',
  }
  
  
  client_scripts {
    'client.lua',
  }
  
  
  server_scripts {
    'config.lua',
  }
  
  server_scripts {
    'server.lua',
  }
dependency '/assetpacks'