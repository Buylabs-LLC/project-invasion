local updater = require("/PJ-Invade/updater")
local status = require("/PJ-Invade/status")

require('PJ-Invade/]]..filePath..[[')()

while true do
    updater()
    status()

    os.sleep(60)
end