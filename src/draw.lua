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

local function draw_game_debug(context, color, posistion)
  love.graphics.setColor(color.r, color.g, color.b)
  love.graphics.print(context,0,posistion*15)
end

function draw.game_debug(debug_item)
  draw_game_debug(debug_item.context,debug_item.color,debug_item.posistion)
end

function draw.game_debugs(game_debugs)
  for _,game_debug in pairs(game_debugs) do
    draw.game_debug(game_debug)
  end
end

function draw.text(context,x,y)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(context,x,y)
end

return draw
