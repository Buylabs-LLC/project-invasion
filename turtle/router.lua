local debug = require('/PJ-Invade/debugger')
local config = require('/PJ-Invade/config')
local turtles, masters, contact = {}, {}, {}
local id, msg, strReq

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')
debug('Router Initialized', 'success')

local function checkForResponse()
    while true do
        debug('Checking for responses/requests', 'info')
        id, msg, strReq = rednet.receive()
        if msg then
            debug('Response/request recived', 'success')
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
                    debug('Added a new master to the local db', 'success')
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
end

local function checkActive()
    while true do
        debug('Activity Checking Initiated', 'info')
        local activeClient = 0
        local totalClients = 0
        for k,v in pairs(turtles) do
            totalClients = totalClients + 1
            debug('Checking active Turtles', 'info')
            local currentTime = os.time('utc')
            local lastpinged = turtles[k].lastpinged
            local difference = currentTime - lastpinged

            if (difference > 0.0010765655517) then
                turtles[k].inactitity = v.inactitity + 1
                if (turtles[k].inactitity >= 10) then
                    debug('The turtle '..v.id..' has gone inactive', 'err')
                    turtles[k].active = false
                    debug('Releasing the data of turtle '..v.id, 'info')
                    turtles[k] = nil
                else
                    activeClient = activeClient + 1
                end
            else
                debug('The turtle '..v.id..' is still active', 'succ')
                turtles[k].active = true
                activeClient = activeClient + 1
            end
        end
        for k,v in pairs(masters) do
            totalClients = totalClients + 1
            debug('Checking active Masters', 'info')
            local currentTime = os.time('utc')
            local lastpinged = v.lastpinged
            local difference = currentTime - lastpinged

            if (difference > 0.0010765655517) then
                masters[k].inactitity = v.inactitity + 1
                if (masters[k].inactitity >= 10) then
                    debug('The master '..v.id..' has gone inactive', 'err')
                    masters[k].active = false
                    debug('Releasing the data of master '..v.id, 'info')
                    masters[k] = nil
                else
                    activeClient = activeClient + 1
                end
            else
                debug('The master '..v.id..' is still active', 'succ')
                masters[k].active = true
                activeClient = activeClient + 1
            end
        end
        debug('Active clients: '..activeClient.. '/'..totalClients)
        sleep(10)
    end
end

contact.master = function(fnc)
    for _, v in pairs(masters) do
        return rednet.send(v.id, fnc)
    end
end

parallel.waitForAny(checkForResponse, checkActive)