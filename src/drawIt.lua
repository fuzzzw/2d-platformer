local drawIt = {}

local function draw(entity, color)
  love.graphics.setColor(color.r, color.g, color.b)
  love.graphics.rectangle(
    'fill',
    entity.x,
    entity.y,
    entity.w,
    entity.h
  )
end

function drawIt.entity(entity)
  draw(entity.collision,entity.color)
end

function drawIt.entities(entities)
  for _, entity in ipairs(entities) do
    draw(entity.collision,entity.color)
  end
end

function drawIt.debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

return drawIt
