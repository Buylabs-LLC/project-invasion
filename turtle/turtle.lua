turtle = {}
local updater = require('/PJ-Invade/updater')
updater()
local config, debug = require('/PJ-Invade/config'), require('/PJ-Invade/debugger')
-- local status = require('/PJ-Invade/status')
local router, firstCheck, connectDown = rednet.lookup(config.network, 'main-router'), false, false
print('Turtle Initialized')
debug('Turtle Initialized', 'success')

peripheral.find("modem", rednet.open)

local function checkIfRouterIsRunning()
    if router then
        if not firstCheck then
            debug('Successfully established a connection to the main router!', 'success')
            connectDown = false
            firstCheck = true
        elseif connectDown then
            connectDown = false
            debug('Connection to the router has been restored!', 'success')
        end
    else
        router = rednet.lookup(config.network, 'main-router')
        debug('Failed to establish a connection to the main router!', 'err')
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
        rednet.send(router, {'contact.master', "api.send('Test')"}, 'turtle')
    end

    -- status()
end