func = {}
local updater = require('/PJ-Invade/updater')
updater()
local config, debug = require('/PJ-Invade/config'), require('/PJ-Invade/debugger')
-- local status = require('/PJ-Invade/status')
local router, firstCheck, connectDown = rednet.lookup(config.network, 'main-router'), false, false
print('Turtle Initialized')
debug('Turtle Initialized', 'success')

peripheral.find("modem", rednet.open)

local function checkIfRouterIsRunning()
    router = rednet.lookup(config.network, 'main-router')
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

-- Commands / things to do

func.up = function()
    if turtle.detectUp() then turtle.digUp() end
    turtle.up()
    return true
end

func.down = function()
    if turtle.detectDown() then turtle.digDown() end
    turtle.down()
    return true
end

func.forward = function()
    if turtle.detect() then turtle.dig() end
    turtle.forward()
    return true
end

func.refuel = function()
    turtle.refuel()
    return true
end

-- Getters

func.getFuelLevel = function()
    return turtle.getFuelLevel()
end

func.getInven = function()
    local iven
    for i in 16 do
        table.insert(iven, turtle.getItemDetail(i))
    end
    return iven
end

func.checkInForwards = function()
    if turtle.detect() then return turtle.inspect() end
    return nil
end

func.checkInDown = function()
    if turtle.detectDown() then return turtle.inspectDown() end
    return nil
end

func.checkInUp = function()
    if turtle.detectUp() then return turtle.inspectUp() end
    return nil
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