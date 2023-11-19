function PickColor()
  local colors = { "String", "Identifier", "Keyword", "Number" }
  return colors[math.random(#colors)]
end

-- Yay I made my first Lua function!
function Footer()
  local handle = io.popen('date +%U')
  if handle then
    local result = handle:read("*a")
    handle:close()
    return 'Week ' .. result .. 'of 52'
  end
end

function GetTodos()
  local handle = io.popen('task export | jq -r ".[].description"')
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result
  end
end
