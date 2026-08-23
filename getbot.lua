local githubBase = "https://raw.githubusercontent.com/Kind-Stranger/computercraft/master/"

local function help()
  print("Usage: uprun <bot> [arguments]")
  print("Bots: farm, chop, mine")
  print("Use 'uprun <bot> help' for bot-specific help.")
end

local function download(path)
  local destination = "/"..path
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
if bot == nil or bot == "help" then
  help()
  return
end

table.remove(arg, 1)
require(bot)
