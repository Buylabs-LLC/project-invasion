local tId = 0
if rednet.isOpen('pj-invade') then
    local network = rednet.lookup("pj-invade")
    local router = rednet.lookup('pj-invade', 'main-router')
else
    print('ERR: THE NETWORK IS NOT OPEN YET, PLEASE START THE MAIN-ROUTER!')
    return 
end

turtle = {}

function checkIfRouterIsRunning()
    local WaitTime = 5 -- Seconds
    local firstCheck = false
    local connectDown = false
    while true do
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
            print('Failed to establish a connection to the main router!')
            connectDown = true
        end
        Wait(1000 * WaitTime)
    end
end

function setId()
    print('There is '...#network...' devices registered on the network')
    
end

checkIfRouterIsRunning()
return turtle