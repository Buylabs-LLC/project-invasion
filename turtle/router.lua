local modem = peripheral.find("modem") or error("No modem attached", 0)

if not modem.isWireless() then
    print('This needs to have a wireless modem attached to talk to the turtles!')
    return
else
    print('Well done, this router is able to talk to turtles!')
end

local Config = require('config')
-- Initialize the Modem
--modem.open(Config.Modem.Port)
--local event, side, channel, replyChannel, message, distance

-- -- Initialize router with network
rednet.open('top')
rednet.host('pj-invade', 'main-router')


--repeat
--    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
--until channel == Config.Modem.Port
--print("Received a reply: " .. tostring(message))