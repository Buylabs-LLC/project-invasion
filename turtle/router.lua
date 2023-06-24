local updater = require('/PJ-Invade/updater')
updater()
local config = require('/PJ-Invade/config')
local debug = require('/PJ-Invade/debugger')
local turtles = {}
local masters = {}
-- local status = require('/PJ-Invade/status')

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')
debug('Router Initialized')

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
        if strReq == 'turtle' then
            if not turtles[id] then
                turtles[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true}
                debug('Added a new turtle to the local db')
                debug(textutils.serialiseJSON(turtles))
            end
            turtles[id].lastmsg = msg
            turtles[id].lastpinged = os.time('utc')
        else
            if not masters[id] then
                masters[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true}
                debug('Added a new turtle to the local db')
                debug(textutils.serialiseJSON(masters))
            end
            turtles[id].lastmsg = msg
            masters[id].lastpinged = os.time('utc')
        end
        debug(strReq)
    end
end