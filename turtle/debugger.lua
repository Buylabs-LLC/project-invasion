function debugger(msg)
    local monitor = peripheral.find('monitor')
    local log = io.open('log', "w+")

    file:white(msg)
    file:close()
    

    monitor.write(msg)
end

return debugger