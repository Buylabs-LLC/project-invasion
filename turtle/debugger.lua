function debugger(msg)
    local monitor = peripheral.find('monitor')

    term.redirect(peripheral.wrap(monitor))
    print(msg)
    term.restore()
end

return debugger