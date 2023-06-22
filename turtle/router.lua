local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
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
    
    print('Yes, i do get ran!')
    
    id, msg, strReq = rednet.receive()
    if msg then
        print('ID: '..id)
        print('MSG: '..msg)
        print('strReq: '..strReq)
    end
end