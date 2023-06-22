local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
-- local status = require('/PJ-Invade/status')
updater()

-- Initialize router with network
peripheral.find("modem", rednet.open)
rednet.host(config.network, 'main-router')
print('Router Initialized')




local req
while true do 
    os.sleep(60)
    updater()
    -- status()
    
    print('Yes, i do get ran!')
    
    req = rednet.receive()
    if req then
        print(req)
    end
end