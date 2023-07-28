-- Configuration
local repoOwner = "BuyLabs-LLC"
local repoName = "project-invasion"
local branch = "main" -- Replace with the desired branch name
local authToken = "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" -- Replace with your GitHub personal access token

local baseUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s", repoOwner, repoName, branch)
local folderPath = "lua" -- Replace with the path to the folder in the repository

local downloads = {
  ['TURTLE'] = {
    {name = 'main.lua', url = baseUrl .. "/" .. folderPath .. "/turtle/turtle.lua"},
    -- General
    {name = 'config.lua', url = baseUrl .. "/" .. folderPath .. "/turtle/config.lua"},
    {name = 'debugger.lua', url = baseUrl .. "/" .. folderPath .. "/turtle/debugger.lua"},
    {name = 'status.lua', url = baseUrl .. "/" .. folderPath .. "/turtle/status.lua"},
    {name = 'updater.lua', url = baseUrl .. "/" .. folderPath .. "/turtle/updater.lua"},
  },
  ['MASTER'] = {
    {name = 'main.lua', url = baseUrl .. "/" .. folderPath .. "/master/master.lua"},
    {name = 'ws.lua', url = baseUrl .. "/" .. folderPath .. "/master/ws.lua"},
    -- General
    {name = 'config.lua', url = baseUrl .. "/" .. folderPath .. "/master/config.lua"},
    {name = 'debugger.lua', url = baseUrl .. "/" .. folderPath .. "/master/debugger.lua"},
    {name = 'status.lua', url = baseUrl .. "/" .. folderPath .. "/master/status.lua"},
    {name = 'updater.lua', url = baseUrl .. "/" .. folderPath .. "/master/updater.lua"},
  },
  ['ROUTER'] = {
    {name = 'main.lua', url = baseUrl .. "/" .. folderPath .. "/router/router.lua"},
    -- General
    {name = 'config.lua', url = baseUrl .. "/" .. folderPath .. "/router/config.lua"},
    {name = 'debugger.lua', url = baseUrl .. "/" .. folderPath .. "/router/debugger.lua"},
    {name = 'status.lua', url = baseUrl .. "/" .. folderPath .. "/router/status.lua"},
    {name = 'updater.lua', url = baseUrl .. "/" .. folderPath .. "/router/updater.lua"},
  },
}

shell.run('set motd.enabled false')

-- Rest of the code remains the same...

-- Function to download a file from the given URL
local function downloadFile(url, destination)
  local response = http.get(url, { ["Authorization"] = "Bearer " .. authToken })
  if response then
    local fileContent = response.readAll()
    response.close()

    local file = io.open(destination, "w")
    file:write(fileContent)
    file:close() 

    print("Downloaded: " .. destination)
  else
    print("Failed to download: " .. url)
  end
end

local function createStartupScript(filePath)
  local mainScript = string.match(filePath, "(.-)%.lua$")
  local scriptContent = [[
    os.setComputerLabel()
    peripheral.find('monitor', function(name, monitor)
      monitor.clear()
      return true
    end)

    local scripts = {
      {location = '/PJ-Invade/updater.lua', title = 'Updater'},
      -- {location= '/PJ-Invade/status.lua', title="Status"},
      {location = ']]..filePath..[[.lua', title = ']]..mainScript..[['},
    }
    
    local id
    for _, k in pairs(scripts) do
      id = multishell.launch({shell = shell, multishell = multishell, require = require, rednet = rednet, http = http, peripheral = peripheral}, k.location)
      print('Launching '..k.title)
      multishell.setTitle(id, k.title)
    end
  ]]

  local file = io.open("/startup.lua", "w")
  file:write(scriptContent)
  file:close()

  print("Created startup script: /startup.lua")
end

-- Function to prompt for user input
local function promptInput(prompt)
  io.write(prompt .. ": ")
  return io.read()
end

-- Main program logic
local fileType = promptInput("Type (Master, Router, or Turtle)")

if downloads[string.upper(fileType)] then
  local filePath = "/PJ-Invade/"
  for k,v in ipairs(downloads[string.upper(fileType)]) do
    downloadFile(v.url, filePath .. v.name)
  end
  createStartupScript('/PJ-Invade/main.lua')

  local int = 0
  local restartIn = 5 -- Time in seconds

  repeat
    print('Rebooting in '..restartIn - int..' seconds...')
    os.sleep(1)
    int = int + 1
  until int == restartIn
  os.reboot()

else
  print("Invalid type entered.")
  return
end

print("Installation complete.")