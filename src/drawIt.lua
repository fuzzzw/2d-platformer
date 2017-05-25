function drawIt(ent, r, g, b)
  love.graphics.setColor(r, g, b)
  love.graphics.rectangle('fill', ent:getX(), ent:getY(), ent:getW(), ent:getH())
end
