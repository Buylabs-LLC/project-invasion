function debugger(msg)
    local monitor = peripheral.find('monitor')

    monitor.write(msg)
end

return debugger