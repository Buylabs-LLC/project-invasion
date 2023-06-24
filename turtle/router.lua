local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
local turtles = {}
-- local status = require('/PJ-Invade/status')
updater()

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')

function checkActive()
    for k,v in ipairs(turtles) do
        local currentTime = os.time('utc')
        local lastpinged = turtles[k].lastpinged
        local difference = (currentTime - lastpinged) % 1000

        if not difference > 20 then
            turtles[k].active = false
        end
    end
end

local id, msg, strReq
while true do
    updater()
    -- status()

    id, msg, strReq = rednet.receive()
    if msg then
        if not turtles[id] then
            turtles[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true}
            print('Added a new turtle to the local db')
            print(textutils.serialiseJSON(turtles))
        end
        turtles[id].lastmsg = msg
        turtles[id].lastpinged = os.time('utc')
        print('last pinged')
        print(turtles[id].lastpinged)
        print(textutils.formatTime(turtles[id].lastpinged))
    end
end