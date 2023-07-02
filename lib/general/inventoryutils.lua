-- /lib/general/inventoryutils.lua --
local itemU = require("lib.general.itemutils")

local function scanFor(name)
  --[[ Search inventory for `name` (simple name)
    -> first slot containing `name` ]]--
  for i=1, 16 do
    item = turtle.getItemDetails(i)
    if name == itemU.getSimpleName(item) then
      return i
    end
  end
end