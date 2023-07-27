local config = require('/pj-invade/config')
local socket = http.websocket(config['WSS'])

local function handleReceivedCode(code)
  -- Execute the received code
  local success, err = pcall(load(code))
  print(code)
  if not success then
    print("Error executing code:", err)
  end
end

local function setupWebSocketConnection()

  socket.onConnected = function()
    print("WebSocket connection established.")
  end

  socket.onDisconnected = function()
    print("WebSocket connection closed.")
  end

  socket.onError = function(error)
    print("WebSocket error:", error)
  end

  socket.onMessage = function(message)
    print("Received message:", message)

    -- Handle the received message as code
    handleReceivedCode(message)
  end

  socket:connect()
end

return setupWebSocketConnection
