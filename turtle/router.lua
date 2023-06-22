local Config = require('/PJ-Invade/config')

-- Initialize router with network
function run()
    rednet.open('bottom')
    rednet.host('pj-invade', 'main-router')
    print('Router Initialize')
end

return run