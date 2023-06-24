function debugger(msg)
    local monitors = peripheral.find('monitor')

    print(msg)
    -- print(textutils.serialiseJSON(monitors))

    monitors.write(msg)
end

return debugger