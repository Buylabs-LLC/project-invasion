function debugger(msg)
    local monitors = peripheral.find('monitor')

    monitors.write(msg)
end

return debugger