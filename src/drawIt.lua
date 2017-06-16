local drawIt = {}

local function draw(entity, r, g, b)
  love.graphics.setColor(r, g, b)
  love.graphics.rectangle(
    'fill',
    entity:getX(),
    entity:getY(),
    entity:getW(),
    entity:getH()
  )
end

function drawIt.entity(entity)
  draw(
    entity.coll,
    entity.color.red,
    entity.color.green,
    entity.color.blue)
end

function drawIt.entities(entities)
  for _, v in ipairs(entities) do
    draw(v.coll,v.color.red,v.color.green,v.color.blue)
  end
end

function drawIt.debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

return drawIt
