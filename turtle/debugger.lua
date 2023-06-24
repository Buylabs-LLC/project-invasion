peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

function debugger(msg, msgType)
    msgType = msgType or 'info'
    local monitor = peripheral.find('monitor')


    if monitor then
        if msgType == 'err' or msgType == 'error' then
            monitor.setTextColor(colors.red)
        elseif msgType == 'info' then
            monitor.setTextColor(colors.lightBlue)
        elseif msgType == 'succ' or msgType == 'success' then
            monitor.setTextColor(colors.green)
        end
        term.redirect(monitor)
        print(msg)
    end
end

return debugger