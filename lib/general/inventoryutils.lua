-- /lib/general/inventoryutils.lua --
local itemU = require("lib.general.itemutils")

local function scanFor(name, meta)
  --[[ Search inventory for `name` (simple name)
        (optional) meta matches against "damage" attr.
    -> first slot containing `name` ]]--
  for i=1, 16 do
    item = turtle.getItemDetail(i)
    if item and name == itemU.getSimpleName(item) then
      if not meta then
        return i
      elseif meta == item.damage then
        return i
      end
    end
  end
end

return {
  scanFor = scanFor,
}