peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

function debugger(msg)
    local monitor = peripheral.find('monitor')

    if monitor then
        term.redirect(monitor)
        print(msg)
    end
end

return debugger