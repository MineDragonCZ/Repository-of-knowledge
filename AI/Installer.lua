    local c = require("component")
    local fs = require("filesystem")
    local s = require("shell")
    internet = nil
    hasInternet = c.isAvailable("internet")
    if hasInternet then internet = require("internet") end

-- Functions ------------------------------------------------------------------

    local function onlineCheck() -- Check for internet connection
        if not hasInternet then
            io.stderr:write("No internet connection present. Please install an\nInternet Card\n")
            os.exit(false)
        end
    end

    local function createInstallDirectory() -- Creates `/destinyAI` directory, if it doesn't already exist
        if not fs.isDirectory("/destinyAI") then
            print("Creating \"/destinyAI\" directory")
            local success, msg = fs.makeDirectory("/destinyAI")
            if success == nil then
                io.stderr:write("Failed to created \"/destinyAI\" directory, "..msg)
                os.exit(false)
            end
        end     
    end

    local function createSystemShortcut()
        local aiBinFile = [[
        fs = require("filesystem")
        if fs.exists("/destinyAI/AI.lua") then
            dofile("/destinyAI/AI.lua")
        else
            io.stderr:write("File is not installed\n")
        end]]
        local file = io.open("destiny", "w")
        file:write(aiBinFile)
        file:close()
    end
-- End of Fucntions -----------------------------------------------------------

-- Installation ---------------------------------------------------------------
    onlineCheck()
    createInstallDirectory()
    createSystemShortcut()
    s.execute("wget -f https://raw.githubusercontent.com/Fredyman95/Repository-of-knowledge/main/AI/DestinyAI.lua /destinyAI/AI.lua")

    print([[
    Installation complete!
    Please use the 'destiny' system command to run the DestinyAI.]])