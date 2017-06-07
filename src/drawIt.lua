function drawIt(ent, r, g, b)
  love.graphics.setColor(r, g, b)
  love.graphics.rectangle('fill', ent:getX(), ent:getY(), ent:getW(), ent:getH())
end

function drawIt_debug(string, debug_pos)
  love.graphics.setColor(255,255,255)
  love.graphics.print(string,0,debug_pos*15)
end

function drawIt_primitives(entity)
  for _, v in ipairs(entity) do
    if v.primitive then
      drawIt(v.coll,255,0,0)
    end
  end
end
