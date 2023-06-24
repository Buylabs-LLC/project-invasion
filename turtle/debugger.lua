function debugger(msg)
    local monitor = peripheral.find('monitor')

    monitor.writeln(msg)
end

return debugger