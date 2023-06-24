Config = {}

Config['network'] = 'PJ-Invade'
Config['computerPath'] = '/PJ-Invade'
Config['WSS'] = 'WSS://localhost:5454'
Config['modem'] = {}
Config['modem']['port'] = 57452

Config['downloadUrls'] = {
    MASTER = baseUrl .. "/" .. folderPath .. "/master.lua",
    ROUTER = baseUrl .. "/" .. folderPath .. "/router.lua",
    TURTLE = baseUrl .. "/" .. folderPath .. "/turtle.lua",
    UPDATER = baseUrl .. "/" .. folderPath .. "/updater.lua",
    CONFIG = baseUrl .. "/" .. folderPath .. "/config.lua",
    STATUS = baseUrl .. "/" .. folderPath .. "/status.lua",
    DEBUGGER = baseUrl .. "/" .. folderPath .. "/debugger.lua"
}

Config['gitInfo'] = {}
Config['gitInfo']['repoOwner'] = 'BuyLabs-LLC'
Config['gitInfo']['repoName'] = 'project-invasion'
Config['gitInfo']['branch'] = 'main'
Config['gitInfo']['authToken'] = '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'
Config['gitInfo']['lua'] = 'turtle'

return Config