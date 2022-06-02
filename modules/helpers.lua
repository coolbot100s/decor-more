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