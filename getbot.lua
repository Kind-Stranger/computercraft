local githubBase = "https://raw.githubusercontent.com/Kind-Stranger/computercraft/master/"

local function github_get(path)
  local url = githubBase..path
  local destination = "/"..path
  local response, err = http.get(url)
  assert(response, "Failed to download "..url..": "..(err or "unknown error"))

  local code = response.getResponseCode()
  local contents = response.readAll()
  response.close()
  assert(code == 200, "Failed to download "..url.." (HTTP "..code..")")

  local directory = fs.getDir(destination)
  if directory ~= "" then
    fs.makeDir(directory)
  end
  local file = assert(fs.open(destination, "w"), "Failed to open "..destination)
  file.write(contents)
  file.close()
end

local bot = arg[1]
if bot == "farmbot" then
  github_get("farm.lua")
  github_get("lib/farm/croputils.lua")
  github_get("lib/general/arrutils.lua")
  github_get("lib/general/inventoryutils.lua")
  github_get("lib/general/itemutils.lua")
  github_get("lib/general/stringutils.lua")
  github_get("lib/move/snake.lua")
  print("Download successful!")
elseif bot == "lumberjack" then
  github_get("chop.lua")
  github_get("lib/general/inventoryutils.lua")
  github_get("lib/general/itemutils.lua")
  github_get("lib/general/stringutils.lua")
  print("Download successful!")
else
  print("Unrecognised bot: "..bot)
end
