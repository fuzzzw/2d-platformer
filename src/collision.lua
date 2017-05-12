Collision = {}
function Collision:new(x,y,w,h)  -- The constructor
  local object = {
    x = x or 0,
    y = y or 0,
    w = w or 0,
    h = h or 0
  }
  setmetatable(object, { __index = Collision })  -- Inheritance
  return object
end

function Collision:check_collision(c)
  x1 = self.x    x2 = c:getX()
  y1 = self.y    y2 = c:getY()
  w1 = self.w    w2 = c:getW()
  h1 = self.h    h2 = c:getH()
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Collision:setX(x)
  self.x = x
end

function Collision:setY(y)
  self.y = y
end

function Collision:setW(w)
  self.w = w
end

function Collision:setH(h)
  self.h = h
end

function Collision:getX()
  return self.x
end

function Collision:getY()
  return self.y
end

function Collision:getW()
  return self.w
end

function Collision:getH()
  return self.h
end
