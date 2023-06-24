function debugger(msg)
    local monitor = peripheral.find('monitor')

    term.redirect(monitor)
    print(msg)
    term.restore()


    -- monitor.writeln(msg)
end

return debugger