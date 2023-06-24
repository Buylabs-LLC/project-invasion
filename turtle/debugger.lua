function debugger(msg)
    local monitors = peripheral.find('monitor')

    print(msg)
    print(textutils.serialiseJSON(monitors))

    for _, monitor in pairs(monitors) do
        monitor.write("Hello")
    end
end

return debugger