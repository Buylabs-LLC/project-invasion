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

local function checkActive()
    debug('Activity Checking Initiated', 'info')
    local activeClient = 0
    local totalClients = 0
    for k,v in pairs(turtles) do
        totalClients = totalClients + 1
        debug('Checking active Turtles', 'info')
        local currentTime = os.time('utc')
        local lastpinged = turtles[k].lastpinged
        local difference = currentTime - lastpinged

        debug(difference, 'info')

        if (difference > 0.0005765655517) then
            turtles[k].active = false
            debug('The turtle '..v.id..' has gone inactive', 'err')
        else
            debug('The turtle '..v.id..' is still active', 'succ')
            turtles[k].active = true
            activeClient = activeClient + 1
        end
    end
    for k,v in pairs(masters) do
        totalClients = totalClients + 1
        debug('Checking active Turtles', 'info')
        local currentTime = os.time('utc')
        local lastpinged = v.lastpinged
        local difference = currentTime - lastpinged

        debug(difference, 'info')

        if (difference > 0.0005765655517) then
            masters[k].active = false
            debug('The master '..v.id..' has gone inactive', 'err')
        else
            debug('The master '..v.id..' is still active', 'succ')
            masters[k].active = true
            activeClient = activeClient + 1
        end
    end
    debug('Active clients: '..activeClient.. '/'..totalClients)
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
    checkActive()

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
        elseif strReq == 'dns' then
            debug('DNS Query recived by '..id, 'dns')
        else
            debug('Contacted by an registered party', 'err')
            debug(strReq, 'err')
        end
    end
end