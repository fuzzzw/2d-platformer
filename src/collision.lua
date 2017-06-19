local object = require "classic"
local collision = object:extend()

function collision:new(x,y,w,h)  -- The constructor
  self.x = x or 0 -- x posistion
  self.y = y or 0 -- y posistion
  self.w = w or 0 -- width
  self.h = h or 0 -- height
end

function collision:check_collision(c)
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function collision:ground_collision(c, player_velocity_y, approx_y)
  local y1 = self.y    local y2 = c:getY()
  local h1 = self.h

  return y1 < (y2 - h1 + approx_y) and
         y1 > (y2 - h1 - approx_y) and
         player_velocity_y > 0
end

function collision:right_collision(c, approx_x)
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 > (x2 - w1 - approx_x) and
         x1 < (x2 - w1 + approx_x) and
         y1 > y2 - h1 + 2          and
         y1 < y2 + h2 - 2
end

function collision:left_collision(c, approx_x)
  local x1 = self.x    local x2 = c:getX()
  local y1 = self.y    local y2 = c:getY()
  local w1 = self.w    local w2 = c:getW()
  local h1 = self.h    local h2 = c:getH()

  return x1 > (x2 + w2 - approx_x) and
         x1 < (x2 + w2 + approx_x) and
         y1 > y2 - h1 + 2          and
         y1 < y2 + h2 - 2
end

function collision:setAll(x,y,w,h)
  self.x = x or self.x
  self.y = y or self.y
  self.w = w or self.w
  self.h = h or self.h
end

function collision:setX(x)
  self.x = x
end

function collision:setY(y)
  self.y = y
end

function collision:setW(w)
  self.w = w
end

function collision:setH(h)
  self.h = h
end

function collision:getX()
  return self.x
end

function collision:getY()
  return self.y
end

function collision:getW()
  return self.w
end

function collision:getH()
  return self.h
end

return collision
