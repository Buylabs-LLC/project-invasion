-- Configuration
local repoOwner = "BuyLabs-LLC"
local repoName = "project-invasion"
local branch = "main" -- Replace with the desired branch name
local authToken = "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" -- Replace with your GitHub personal access token

local baseUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s", repoOwner, repoName, branch)
local folderPath = "turtle" -- Replace with the path to the folder in the repository

local downloadUrls = {
  MASTER = baseUrl .. "/" .. folderPath .. "/master.lua",
  ROUTER = baseUrl .. "/" .. folderPath .. "/router.lua",
  TURTLE = baseUrl .. "/" .. folderPath .. "/turtles.lua",
  UPDATER = baseUrl .. "/" .. folderPath .. "/updater.lua",
  CONFIG = baseUrl .. "/" .. folderPath .. "/config.lua",
  STATUS = baseUrl .. "/" .. folderPath .. "/status.lua"
}

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
  local scriptContent = [[
    -- Content of the startup script
    -- Change the file names as necessary
    shell.run("/PJ-Invade/updater.lua")
    print('Waiting 15 seconds before running main scripts')
    os.sleep(15)
    print('running main scripts')
    -- shell.run("/PJ-Invade/status.lua")
    shell.run("/PJ-Invade/]] .. filePath .. [[")
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

if downloadUrls[string.upper(fileType)] then
  local fileName = fileType:lower() .. ".lua"
  local filePath = "/PJ-Invade/" .. fileName
  downloadFile(downloadUrls[string.upper(fileType)], filePath)
  downloadFile(downloadUrls['UPDATER'], '/PJ-Invade/updater.lua')
  downloadFile(downloadUrls['CONFIG'], '/PJ-Invade/config.lua')
  downloadFile(downloadUrls['STATUS'], '/PJ-Invade/status.lua')
  createStartupScript(filePath)

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