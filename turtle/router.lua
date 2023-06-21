-- does not crash

local modem = peripheral.find("modem") or error("No modem attached", 0)

if not modem.isWireless() then
    print('This needs to have a wireless modem attached to talk to the turtles!')
    return
else
    print('Well done, this router is able to talk to turtles!')
end

local Config = require('/pj-invade/config')

-- -- Initialize router with network
rednet.open('top')
rednet.host('pj-invade', 'main-router')