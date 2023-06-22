-- does not crash

turtle = {}
local tId = 0
local config = require('/PJ-Invade/config')
local updater = require('/PJ-Invade/updater')
-- local status = require('/PJ-Invade/status')
local routerStatus = 'Waiting for response'
local network = rednet.lookup(config.network)
local router = rednet.lookup(config.network, 'main-router')
updater()

local function checkIfRouterIsRunning()
    local firstCheck = false
    local connectDown = false

    rednet.isOpen()

    print(config.network)
    print(network)
    print(router)
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
    os.sleep(60)
    updater()
    -- status()
end