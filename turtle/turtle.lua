turtle = {}
local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
-- local status = require('/PJ-Invade/status')
local routerStatus, router, firstCheck, connectDown = 'Waiting for response', rednet.lookup(config.network, 'main-router'), false, false
updater()

peripheral.find("modem", rednet.open)

local function checkIfRouterIsRunning()
    if router then
        if not firstCheck then
            routerStatus = 'Successfully established a connection to the main router!'
            print('Successfully established a connection to the main router!')
            connectDown = false
            firstCheck = true
        elseif connectDown then
            connectDown = false
            routerStatus = 'Successfully established a connection to the main router!'
            print('Connection to the router has been restored!')
        end
    else
        routerStatus = 'Failed to establish a connection to the main router!'
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