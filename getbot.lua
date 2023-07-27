local function file_exists(path)
  -- Try to read the file --
  local f = io.open(path, "r")
  if f == nil then
    return false
  else
    io.close(f)
    return true
  end
end

local function pastebin_get(pb, path)
  --[[ Download the file if it
       doesn't already exist   ]]--
  if file_exists(path) then
    assert(shell.execute("rm", path))
  end
  assert(shell.execute("pastebin","get",pb,path),
         "Failed to download "..pb.." to "..path)
end

if arg[0] == "pastebin" then
  -- CraftOS --
  bot = arg[3]
else
  -- Something else? --
  bot = arg[1]
end
if bot == "farmbot" then
  pastebin_get("regPpQh3", "/farm.lua")
  pastebin_get("pGyqsdge", "/lib/farm/croputils.lua")
  pastebin_get("cW5eyKAB", "/lib/general/arrutils.lua")
  pastebin_get("PS9yA7Zf", "/lib/general/inventoryutils.lua")
  pastebin_get("y5qsBzdf", "/lib/general/itemutils.lua")
  pastebin_get("8MmVaKqu", "/lib/general/stringutils.lua")
  pastebin_get("YV5tubHD", "/lib/move/snake.lua")
  print("Download successful!")
elseif bot == "lumberjack" then
  pastebin_get("wqJvr2v9", "/chop.lua")
  pastebin_get("PS9yA7Zf", "/lib/general/inventoryutils.lua")
  pastebin_get("y5qsBzdf", "/lib/general/itemutils.lua")
  pastebin_get("8MmVaKqu", "/lib/general/stringutils.lua")
  print("Download successful!")
else
  print("Unrecognised bot: "..bot)
end
