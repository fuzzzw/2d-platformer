local drawIt = {}

local function draw(entity, color)
  love.graphics.setColor(color:getR(), color:getG(), color:getB())
  love.graphics.rectangle(
    'fill',
    entity:getX(),
    entity:getY(),
    entity:getWidth(),
    entity:getHeight()
  )
end

function drawIt.entity(entity)
  draw(entity,entity.color)
end

function drawIt.entities(entities)
  for _, entity in ipairs(entities) do
    draw(entity:getCollision(),entity:getColor())
  end
end

function drawIt.debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

return drawIt
