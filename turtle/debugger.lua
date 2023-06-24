peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

local monitor = peripheral.find('monitor')
term.redirect(monitor)

function debugger(msg)
    print(msg)
    -- term.restore()
end

return debugger