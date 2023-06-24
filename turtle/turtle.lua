turtle = {}
local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
-- local status = require('/PJ-Invade/status')
local router, firstCheck, connectDown = rednet.lookup(config.network, 'main-router'), false, false
updater()

peripheral.find("modem", rednet.open)

local function checkIfRouterIsRunning()
    if router then
        if not firstCheck then
            print('Successfully established a connection to the main router!')
            connectDown = false
            firstCheck = true
        elseif connectDown then
            connectDown = false
            print('Connection to the router has been restored!')
        end
    else
        router = rednet.lookup(config.network, 'main-router')
        print('Failed to establish a connection to the main router!')
        connectDown = true
    end
end

turtle.getInven = function()
 
end

while true do
    checkIfRouterIsRunning()
    updater()

    os.sleep(10)

    if router then
        rednet.send(router, 'Hi!')
    end

    -- status()
end