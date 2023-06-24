local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
local turtles = {}
-- local status = require('/PJ-Invade/status')
updater()

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')

function checkTurtles()
    for k, v in pairs(turtles) do
        local isUp = rednet.send(v.id, 'Checkup')
        print(isUp)
        if not isUp then
            turtles[k].active = false
        end
    end

    print(textutils.serialiseJSON(turtles))
end

local id, msg, strReq
while true do
    updater()
    -- status()
    checkTurtles()

    id, msg, strReq = rednet.receive()
    if msg then
        if not turtles[id] then
            turtles[id] = {id = id, active = true}
            print('Added a new turtle to the local db')
            print(textutils.serialiseJSON(turtles))
        end
        print('MSG')
        print(msg)
    end
end