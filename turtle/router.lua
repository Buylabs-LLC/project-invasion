local config = require('/PJ-Invade/config')
-- local status = require('/PJ-Invade/status')

-- Initialize router with network
local modem = peripheral.find("modem") or error("No modem attached", 0)
rednet.open(modem)
rednet.host(config.network, 'main-router')
print('Router Initialized')




local req
while true do
    req = rednet.receive()
    if req then
        print(req)
    end
    -- status()
end