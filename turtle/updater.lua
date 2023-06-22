local http = require("http")
local filesystem = require("filesystem")
local textutils = require("textutils")

-- Configuration
local repoOwner = "YourGitHubUsername"
local repoName = "YourGitHubRepoName"
local branch = "main" -- Replace with the desired branch name
local computerPath = "/path/to/computer/folder" -- Replace with the path to your computer's folder
local repoDirectory = "path/to/repo/directory" -- Replace with the path to the directory in the GitHub repository

-- Function to check for updates
local function checkForUpdates()
  local apiUrl = string.format("https://api.github.com/repos/%s/%s/commits/%s", repoOwner, repoName, branch)
  local headers = { ["User-Agent"] = "CC-Tweaked Auto-Updater" }
  local response = http.request(apiUrl, nil, headers)
  local commitData = textutils.unserialiseJSON(response.readAll())
  local latestCommitHash = commitData.sha

  local currentCommitFile = computerPath .. "/current_commit.txt"
  local lastCommit = ""

  -- Read the last stored commit hash
  if filesystem.exists(currentCommitFile) then
    local file = io.open(currentCommitFile, "r")
    lastCommit = file:read("*a")
    file:close()
  end

  if latestCommitHash ~= lastCommit then
    -- Update required
    local treeApiUrl = string.format("https://api.github.com/repos/%s/%s/git/trees/%s?recursive=true", repoOwner, repoName, latestCommitHash)
    local treeResponse = http.request(treeApiUrl, nil, headers)
    local treeData = textutils.unserialiseJSON(treeResponse.readAll())
    local files = treeData.tree

    for _, fileData in ipairs(files) do
      local filePath = fileData.path
      if filePath:find(repoDirectory) == 1 and fileData.type == "blob" then
        local fileName = filePath:sub(#repoDirectory + 2) -- Remove the repoDirectory prefix
        local downloadUrl = fileData.url:gsub("/blob/", "/raw/") -- Convert URL to raw format
        local fileContent = http.get(downloadUrl).readAll()
        local file = io.open(computerPath .. "/" .. fileName, "w")
        file:write(fileContent)
        file:close()

        print("Updated: " .. fileName)
      end
    end

    -- Update the last stored commit hash
    local file = io.open(currentCommitFile, "w")
    file:write(latestCommitHash)
    file:close()

    print("Update complete.")
  else
    print("No updates found.")
  end
end

-- Main program logic
while true do
  checkForUpdates()

  -- Adjust the delay based on your desired update frequency
  sleep(60) -- Wait for 60 seconds before the next update
end
