-- local status = require('/PJ-Invade/status')
local updater = require('/PJ-Invade/updater')
updater()
local config, debug = require('/PJ-Invade/config'), require('/PJ-Invade/debugger')
local turtles, masters, contact = {}, {}, {}

local activeClient, totalClients = 0, 0

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')
debug('Router Initialized', 'success')



local function activityHandler(table, key, value, name)
    local currentTime = os.time('utc')
    local lastpinged = value.lastpinged
    local difference = currentTime - lastpinged
    if (difference > 0.0010765655517) then
        table[key].inactitity = value.inactitity + 1
        if (table[key].inactitity >= 2) then
            debug('The '..name..' '..value.id..' has gone inactive', 'err')
            table[key].active = false
            debug('Releasing the data of '..name..' '..value.id, 'info')
            table[key] = nil
        end
    else
        debug('The master '..v.id..' is still active', 'succ')
        table[key].active = true
        activeClient = activeClient + 1
    end
end

local function checkActive()
    activeClient, totalClients = 0, 0
    debug('Activity Checking Initiated', 'info')
    for k,v in pairs(turtles) do
        totalClients = totalClients + 1
        debug('Checking active Turtles', 'info')

        activityHandler(masters, k, v, 'master')
    end
    for k,v in pairs(masters) do
        totalClients = totalClients + 1
        debug('Checking active Masters', 'info')

        activityHandler(masters, k, v, 'master')
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

    debug('New set of data', 'PURPLE')

    updater()
    -- status()
    checkActive()

    id, msg, strReq = rednet.receive()
    if msg then
        if string.upper(strReq) == 'TURTLE' then
            if not turtles[id] then
                turtles[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true, inactitity = 0}
                debug('Added a new turtle to the local db', 'success')
            else
                turtles[id].lastmsg = msg
                turtles[id].lastpinged = os.time('utc')
            end
            -- Add handler here!
        elseif string.upper(strReq) == 'MASTER' then
            if not masters[id] then
                masters[id] = {id = id, lastmsg = msg, lastpinged = os.time('utc'), active = true, inactitity = 0}
                debug('Added a new master to the local db', 'succ')
            else
                masters[id].lastmsg = msg
                masters[id].lastpinged = os.time('utc')
            end
            -- Add handler here!
        elseif strReq == 'dns' then
            debug('DNS Query recived by '..id, 'dns')
        else
            debug('Contacted by an registered party', 'err')
            debug(strReq, 'err')
        end
    end
end