local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
local turtle = {}
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
        if not turtle[id] then
            turtle[id] = true
            print('Added a new turtle to the local db')
        end
        print('MSG')
        print(msg)
    end
end