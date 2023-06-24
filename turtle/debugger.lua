peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

function Debugger(msg, msgType)
    if msgType then
        msgType = string.upper(msgType)
    else
        msgType = 'INFO'
    end
    local monitor = peripheral.find('monitor')


    if monitor then
        if msgType == 'ERR' or msgType == 'ERROR' or msgType == 'RED' then
            monitor.setTextColor(colors.red)
        elseif msgType == 'INFO' or msgType == 'INFORMATION' or msgType == 'LIGHTBLUE' then
            monitor.setTextColor(colors.lightBlue)
        elseif msgType == 'SUCC' or msgType == 'SUCCESS' or msgType == 'GREEN' then
            monitor.setTextColor(colors.green)
        elseif msgType == 'TABLE' or msgType == 'ARR' or msgType == 'PINK' then
            monitor.setTextColor(colors.pink)
        elseif msgType == 'UPDATE' or msgType == 'LIME' then
            monitor.setTextColor(colors.lime)
        elseif msgType == 'DNS' or msgType == 'BLUE' then
            monitor.setTextColor(colors.blue)
        else
            monitor.setTextColor(colors.lightBlue)
        end


        term.redirect(monitor)
        print(msg)


        monitor.setTextColor(colors.lightBlue)
    elseif msgType == 'update' then
        print(msg)
    end
end

return Debugger