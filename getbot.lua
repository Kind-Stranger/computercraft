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
  local d, err
  local downloaded = false
  if not file_exists(path) then
    d=shell.execute("pastebin","get",pb,path)
    if not d then
      error("Failed to download "..pb.." to "..path)
    end
  end
end

if arg[0] == "pastebin" then
  bot = arg[3]
else
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
else
  print("Unrecognised bot: "..bot)
end
