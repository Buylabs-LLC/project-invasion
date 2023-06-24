function debugger(msg)
    local monitor = peripheral.find('monitor')

    monitor.write(msg.. '\n')
end

return debugger