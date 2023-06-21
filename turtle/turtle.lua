-- does not crash

turtle = {}
local tId = 0
local config = require('config')
local routerStatus = 'Waiting for response'
local network = rednet.lookup(config.network)
local router = rednet.lookup(config.network, 'main-router')

local function checkIfRouterIsRunning()
    local WaitTime = 5 -- Seconds
    local firstCheck = false
    local connectDown = false
    while true do
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
        os.sleep(1000 * WaitTime)
    end
end

local function setId()
    print('There is '..#network..' devices registered on the network')
    tId = #network + 1
end

turtle.getInven = function()
    
end

checkIfRouterIsRunning()
setId()
rednet.host(config.network, tId)
os.setComputerLabel(tId.. ' Turtle')
print('Turtle ID: '..tId)
return turtle