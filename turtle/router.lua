-- local status = require('/PJ-Invade/status')
local updater = require('/PJ-Invade/updater')
updater()
local config, debug = require('/PJ-Invade/config'), require('/PJ-Invade/debugger')
local turtles, masters, contact = {}, {}, {}

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')
debug('Router Initialized', 'success')

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

contact.master = function(fnc)
    for _, v in pairs(masters) do
        return rednet.send(v.id, fnc)
    end
end

local id, msg, strReq
while true do
    updater()
    -- status()

    id, msg, strReq = rednet.receive()
    if msg then
        if string.upper(strReq) == 'TURTLE' then
            if not turtles[id] then
                turtles[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true}
                debug('Added a new turtle to the local db', 'success')
            else
                turtles[id].lastmsg = msg
                turtles[id].lastpinged = os.time('utc')
            end

            debug(textutils.serialiseJSON(msg), 'table')
        elseif string.upper(strReq) == 'MASTER' then
            if not masters[id] then
                masters[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true}
                debug('Added a new master to the local db', 'succ')
                debug('ID: '.. id)
                debug('msg: '.. textutils.serialiseJSON(msg))
            else
                masters[id].lastmsg = msg
                masters[id].lastpinged = os.time('utc')
            end
        else
            debug('Contacted by an registered party', 'err')
            debug(strReq)
        end
    end
end