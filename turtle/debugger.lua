peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

function debugger(msg, msgType)
    msgType = msgType or 'info'
    local monitor = peripheral.find('monitor')


    if monitor then
        if msgType == 'err' then
            monitor.setTextColor(colors.lightBlue)
        elseif msgType == 'info' then
            monitor.setTextColor(colors.ResetDeepOceanScaler)        
        end
        term.redirect(monitor)
        print(msg)
    end
end

return debugger