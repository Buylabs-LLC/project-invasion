function debugger(msg)
    local monitors = peripheral.find('monitor')

    print(msg)
    print(monitors)

    for _,monitor in ipairs(monitors) do
        monitor.write(msg)
    end
end

return debugger