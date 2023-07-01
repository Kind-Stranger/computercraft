-- /lib/move/snake.lua --
local arrU = require("lib.general.arrutils")
-- Mid U-Turn definitions --
local midUTR = {"F","F","R","F"}
local midUTL = {"F","F","L","F"}

--[[ Use snake.next to move to next block ]]--

local function turn(hist)
  --[[ Whether to turn right or left
      -> "R" = turn right
      or "L" = turn left
      or "X" = same as last turn (end of snake)
  --]]
  if hist[#hist] == "R" or
     hist[#hist] == "L" then
    print("..snake: Wall twice, reset")
    return "X"
  end
  if hist[1] == "R" then return "L" end
  if hist[1] == "L" then return "R" end
end

local function calcNext(hist)
  --[[ Calculate next move.
      -> "R" = right turn
      or "L" = left turn
      or "F" = move forward
      or "X" = End of snake
  ]]--
  local lastFour = arrU.slice(hist, #hist-3, #hist)
  if arrU.equal(lastFour, midUTR) then
    return "R", {} -- reset hist --
  elseif arrU.equal(lastFour, midUTL) then
    return "L", {} -- reset hist --
  end
  if turtle.detect() then
    print("..snake: Solid block")
    return turn(hist), hist
  end
  return "F", hist
end

local function next(hist)
  --[[ Moves or rotates to next block
      -> lastest_move, updated_history
  ]]--
  local move, hist = calcNext(hist)
  print("..snake: calcNext gave:"..move)
  if move == "X" then
    -- Complete the 180 turn --
    if hist[#hist] == "R" then
      turtle.turnRight()
    else
      turtle.turnLeft()
    end
    -- Set history to trigger next u-turn --
    hist = {hist[1]}
  else
    if move == "R" then
      turtle.turnRight()
    elseif move == "L" then
      turtle.turnLeft()
    else
      moved, err=turtle.forward()
      if not moved then
        print(err)
      end
    end
    table.insert(hist, move)
  end
  return move, hist
end

return {
  next = next,
}