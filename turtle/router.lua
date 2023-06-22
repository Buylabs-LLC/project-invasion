local Config = require('/PJ-Invade/config')

-- Initialize router with network
rednet.open('top')
rednet.host('pj-invade', 'main-router')