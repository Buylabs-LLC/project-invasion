local Config = require('/PJ-Invade/config')
local status = require('/PJ-Invade/status')

-- Initialize router with network
rednet.open('bottom')
rednet.host('pj-invade', 'main-router')
print('Router Initialized')




local req
while true do
    req = rednet.request()
    if req then
        print(req)
    end
    -- status()
end