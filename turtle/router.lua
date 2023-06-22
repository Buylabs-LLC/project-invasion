local Config = require('/PJ-Invade/config')

function run()
    -- Initialize router with network
    rednet.open('top')
    rednet.host('pj-invade', 'main-router')


end

return run