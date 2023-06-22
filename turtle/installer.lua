-- Configuration
local repoOwner = "BuyLabs-LLC"
local repoName = "project-invasion"
local branch = "main" -- Replace with the desired branch name
local authToken = "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" -- Replace with your GitHub personal access token

local baseUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s", repoOwner, repoName, branch)
local folderPath = "turtle" -- Replace with the path to the folder in the repository

local downloadUrls = {
  MODEM = baseUrl .. "/" .. folderPath .. "/modem.lua",
  ROUTER = baseUrl .. "/" .. folderPath .. "/router.lua",
  TURTLE = baseUrl .. "/" .. folderPath .. "/turtles.lua",
  UPDATER = baseUrl .. "/" .. folderPath .. "/updater.lua",
  CONFIG = baseUrl .. "/" .. folderPath .. "/config.lua",
  STATUS = baseUrl .. "/" .. folderPath .. "/status.lua"
}

-- Rest of the code remains the same...

-- Function to download a file from the given URL
local function downloadFile(url, destination)
  local response = http.get(url, nil, { ["Authorization"] = "Bearer " .. authToken })
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
    shell.run("/PJ-Invade/status.lua")
    Sleep(30)
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
local fileType = promptInput("Type (Modem, Router, or Turtle)")

if downloadUrls[fileType] then
  local fileName = fileType:lower() .. ".lua"
  local filePath = "/PJ-Invade/" .. fileName
  downloadFile(downloadUrls[string.upper(fileType)], filePath)
  downloadFile(downloadUrls['UPDATER'], '/PJ-Invade/updater.lua')
  downloadFile(downloadUrls['CONFIG'], '/PJ-Invade/config.lua')
  downloadFile(downloadUrls['STATUS'], '/PJ-Invade/status.lua')
  createStartupScript(filePath)
else
  print("Invalid type entered.")
  return
end

print("Installation complete.")