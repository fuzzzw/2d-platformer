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
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Collision:ground_collision(c, player_velocity_y, approx_y)
  local y1 = self.y    local y2 = c:getY()
  local h1 = self.h

  return y1 < (y2 - h1 + approx_y) and
         y1 > (y2 - h1 - approx_y) and
         player_velocity_y > 0
end

function Collision:right_collision(c, approx_x)
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 > (x2 - w1 - approx_x) and
         x1 < (x2 - w1 + approx_x) and
         y1 > y2 - h1 + 2          and
         y1 < y2 + h2 - 2
end

function Collision:left_collision(c, approx_x)
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 > (x2 + w2 - approx_x) and
         x1 < (x2 + w2 + approx_x) and
         y1 > y2 - h1 + 2          and
         y1 < y2 + h2 - 2
end

function Collision:setAll(x,y,w,h)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
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
