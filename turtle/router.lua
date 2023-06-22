-- does not crash
local sides = {'left', 'right', 'back', 'top', 'bottom'}

for _, side in pairs(sides) do
    if peripheral.isPresent(side) and peripheral.getType(side) == "modem" then
        print("Wireless modem found!")
    else
        print("No wireless modem detected.")
        return
    end
end

local Config = require('/PJ-Invade/config')


function run()
    -- Initialize router with network
    rednet.open('top')
    rednet.host('pj-invade', 'main-router')


end


return run()