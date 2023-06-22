local Config = require('/PJ-Invade/config')

-- Initialize router with network
rednet.open('bottom')
rednet.host('pj-invade', 'main-router')