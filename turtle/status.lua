-- Configuration
local apiUrl = "https://your-nextjs-api-endpoint.com/status"
local updateInterval = 60 -- Update interval in seconds

-- Function to gather computer information
local function getComputerInfo()
  local computerId = os.getComputerID()
  local computerLabel = os.getComputerLabel()
  local peripherals = peripheral.getNames()

  return {
    id = computerId,
    label = computerLabel,
    peripherals = peripherals
  }
end

-- Function to gather Rednet information
local function getRednetInfo()
  local rednetId = os.getComputerID()
  local connectedPeripherals = peripheral.find("modem", rednet.isOpen)

  return {
    id = rednetId,
    connectedPeripherals = connectedPeripherals
  }
end

-- Function to gather connected Rednet computer information
local function getConnectedComputerInfo()
  local connectedComputers = {}

  -- Iterate over connected Rednet peripherals
  for _, peripheralName in ipairs(peripheral.getNames()) do
    if peripheral.getType(peripheralName) == "modem" and rednet.isOpen(peripheralName) then
      rednet.open(peripheralName)

      -- Iterate over all received Rednet messages
      while true do
        local senderId, message = rednet.receive(0.1) -- Timeout of 0.1 seconds
        if senderId then
          local computerLabel = os.getComputerLabel(senderId)

          -- Store connected computer information
          table.insert(connectedComputers, {
            id = senderId,
            label = computerLabel
          })
        else
          break -- No more messages, exit the loop
        end
      end

      rednet.close(peripheralName)
    end
  end

  return connectedComputers
end

-- Function to measure system load (example using os.loadavg)
local function getSystemLoad()
  local loadAvg = os.loadavg()
  return {
    cpuLoad = loadAvg[1],
    memoryLoad = loadAvg[2]
  }
end

-- Function to send the status update
local function sendStatusUpdate()
  -- Gather information
  local computerInfo = getComputerInfo()
  local rednetInfo = getRednetInfo()
  local connectedComputerInfo = getConnectedComputerInfo()
  local systemLoad = getSystemLoad()

  -- Create payload table
  local payload = {
    computerInfo = computerInfo,
    rednetInfo = rednetInfo,
    connectedComputerInfo = connectedComputerInfo,
    systemLoad = systemLoad
  }

  -- Serialize payload to JSON
  local serializedPayload = textutils.serializeJSON(payload)

  -- Make POST request to the API endpoint
  local response = http.post(apiUrl, serializedPayload, { ["Content-Type"] = "application/json" })
  if response then
    local responseData = response.readAll()
    response.close()
    print("Status update sent successfully!")
  else
    print("Failed to send status update.")
  end
end

return sendStatusUpdate()