-- ent = entity
function drawIt(ent, r, g, b)
  love.graphics.setColor(r, g, b)
  love.graphics.rectangle('fill', ent:getX(), ent:getY(), ent:getW(), ent:getH())
end

function drawIt_debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

function drawIt_primitives(entities)
  for _, v in ipairs(entities) do
    if v.primitive then
      drawIt(v.coll,v.color.red,v.color.green,v.color.blue)
    end
  end
end
