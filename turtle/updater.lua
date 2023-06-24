-- Configuration
local debug = require('/PJ-Invade/debugger')
local repoOwner = "Buylabs-LLC"
local repoName = "project-invasion"
local branch = "main" -- Replace with the desired branch name
local computerPath = "/PJ-Invade" -- Replace with the path to your computer's folder
local repoDirectory = "turtle" -- Replace with the path to the directory in the GitHub repository
local authToken = "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" -- Replace with your GitHub personal access token

-- Function to check for updates
function checkForUpdates()
  local apiUrl = string.format("https://api.github.com/repos/%s/%s/commits/%s", repoOwner, repoName, branch)
  local headers = {
    ["User-Agent"] = "CC-Tweaked Auto-Updater",
    ["Authorization"] = "Bearer " .. authToken
  }
  local response = http.get(apiUrl, headers)
  local commitData = textutils.unserializeJSON(response.readAll())
  local latestCommitHash = commitData.sha

  local currentCommitFile = computerPath .. "/current_commit.txt"
  local lastCommit = ""

  -- Read the last stored commit hash
  if fs.exists(currentCommitFile) then
    local file = io.open(currentCommitFile, "r")
    lastCommit = file:read("*a")
    file:close()
  end

  if latestCommitHash ~= lastCommit then
    -- Update required
    local treeApiUrl = string.format("https://api.github.com/repos/%s/%s/contents/%s?ref=%s", repoOwner, repoName, repoDirectory, branch)
    local treeResponse = http.get(treeApiUrl, headers)
    local treeData = textutils.unserializeJSON(treeResponse.readAll())

    -- Iterate over the tree elements to find the files
    for _, element in ipairs(treeData) do
      if element.type == "file" then
        local fileName = element.name
        local downloadUrl = element.download_url
        local fileContent = http.get(downloadUrl).readAll()
        local file = io.open(computerPath .. "/" .. fileName, "w")
        file:write(fileContent)
        file:close()

        debug("Updated: " .. fileName, 'update')
      end
    end

    -- Update the last stored commit hash
    local file = io.open(currentCommitFile, "w")
    file:write(latestCommitHash)
    file:close()

    debug("Update complete, now rebooting for the changed to take effect", 'update')
    os.reboot()
  end
end

return checkForUpdates