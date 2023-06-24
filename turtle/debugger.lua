peripheral.find('monitor', function(name, monitor)
    monitor.clear()
    return true
end)

function debugger(msg, msgType)
    msgType = msgType or 'info'
    local monitor = peripheral.find('monitor')


    if monitor then
        if msgType == 'err' then
            local rgbClr = colors.packRGB(0.181, 0.019, 0.07)
            -- local clr = colors.fromBlit(rgbClr)
            monitor.setTextColor(rgbClr)
        elseif msgType == 'info' then
            local rgbClr = colors.packRGB(0.030, 0.105, 0.235)
            -- local clr = colors.fromBlit(rgbClr)
            monitor.setTextColor(rgbClr)        
        end
        term.redirect(monitor)
        print(msg)
    end
end

return debugger