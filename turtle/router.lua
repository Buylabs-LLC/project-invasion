local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
local turtles = {}
-- local status = require('/PJ-Invade/status')
updater()

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')

local id, msg, strReq
while true do
    updater()
    -- status()

    id, msg, strReq = rednet.receive()
    if msg then
        if not turtles[id] then
            turtles[id] = {id = id, lastmsg = msg, lastpinged = os.time('gmt')}
            print('Added a new turtle to the local db')
            print(textutils.serialiseJSON(turtles))
        end
        turtles[id].lastmsg = msg
        turtles[id].lastpinged = os.time('gmt')
        print('last pinged')
        print(turtles[id].lastpinged)
    end
end