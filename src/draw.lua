local draw = {}

local function draw_entity(entity, color)
  love.graphics.setColor(color.r, color.g, color.b)
  love.graphics.rectangle(
    'fill',
    entity.x,
    entity.y,
    entity.w,
    entity.h
  )
end

function draw.entity(entity)
  draw_entity(entity.collision,entity.color)
end

function draw.entities(entities)
  for _, entity in ipairs(entities) do
    draw.entity(entity)
  end
end

function draw.debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

return draw
