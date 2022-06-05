-- Creates a copy of a table. why isn't this in standard library? why does lua work like this? 
function table.shallow_copy(t) --thanks google
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end

-- Makes the first letter of a string Uppercase.
function cap(str) --thanks google
    return (str:gsub("^%l", string.upper))
end


function string.insert(str1, str2, pos) --thanks google
  return str1:sub(1,pos)..str2..str1:sub(pos+1)
end

function table.search(table, value)
  for i = 1,#table do
      if table[i] == value then
          return true, i
      end
  end
  return false
end

-- Returns the index of the value in the table, or false if not found
function table.search(table, value)
  for i = 1,#table do
      if table[i] == value then
          return i
      end
  end
  return false
end

-- Returns the slot currently held by the player.
function get_held()
  player = api_get_player_instance()
  hb_index = api_gp(player, "hotbar") + 1
  holding = api_get_slot(player, hb_index)
  return holding
end