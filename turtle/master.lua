master = {}
local updater = require('/PJ-Invade/updater')
updater()
local config, debug = require('/PJ-Invade/config'), require('/PJ-Invade/debugger')
print('Master Initialized')
debug('Master Initialized', 'success')

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

while true do
    checkIfRouterIsRunning()
    updater()

    os.sleep(10)

    if router then
        rednet.send(router, {'contact.turtle', "move.up(1)"}, 'master')
    end

    -- status()
end