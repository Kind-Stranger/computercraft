local githubBase = "https://raw.githubusercontent.com/Kind-Stranger/computercraft/master/"
local githubContents = "https://api.github.com/repos/Kind-Stranger/computercraft/contents/"
local currentScript = "getbot.lua"

local function list()
  local response, err = http.get(githubContents)
  assert(response, "Failed to list bots: "..(err or "unknown error"))
  local code = response.getResponseCode()
  local contents = response.readAll()
  response.close()
  assert(code == 200, "Failed to list bots (HTTP "..code..")")

  local files = textutils.unserializeJSON(contents)
  assert(files, "Failed to parse bot list")
  for _, file in ipairs(files) do
    if file.type == "file" and file.name:match("%.lua$") and file.name ~= currentScript then
      local botName = file.name:gsub("%.lua$", "")
      print(botName)
    end
  end
end

local function help()
  print("Usage: getbot <bot> [arguments]")
  print("Use 'getbot list' to list available bots.")
  print("Use 'getbot <bot> help' for bot-specific help.")
end

local function download(path)
  local destination = "/"..path
  print("Downloading "..path)
  local response, err = http.get(githubBase..path)
  assert(response, "Failed to download "..path..": "..(err or "unknown error"))
  local code = response.getResponseCode()
  local contents = response.readAll()
  response.close()
  assert(code == 200, "Failed to download "..path.." (HTTP "..code..")")

  local directory = fs.getDir(destination)
  if directory ~= "" then
    fs.makeDir(directory)
  end
  local file = assert(fs.open(destination, "w"), "Failed to open "..destination)
  file.write(contents)
  file.close()
end

local oldRequire = require
function require(moduleName)
  download(moduleName:gsub("%.", "/")..".lua")
  return oldRequire(moduleName)
end

local bot = arg[1]
if bot == "list" then
  list()
  return
end

if bot == nil or bot == "help" then
  help()
  return
end

table.remove(arg, 1) -- Remove "getbot" from the arguments
require(bot)
