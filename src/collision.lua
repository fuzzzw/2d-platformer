local object = require "classic"
local collision = object:extend()

function collision:new(obj)  -- The constructor
  self.x = obj.x or 0 -- x posistion
  self.y = obj.y or 0 -- y posistion
  self.w = obj.w or 0 -- width
  self.h = obj.h or 0 -- height
end

function collision:check_collision(c)
  local x1 = self.x    local x2 = c.x
  local y1 = self.y    local y2 = c.y
  local w1 = self.w    local w2 = c.w
  local h1 = self.h    local h2 = c.h

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function collision:ground_collision(c, player_velocity_y, approx_y)
  local y1 = self.y    local y2 = c.y
  local h1 = self.h

  return y1 < (y2 - h1 + approx_y) and
         y1 > (y2 - h1 - approx_y) and
         player_velocity_y > 0
end

function collision:ceiling_collision(c, player_velocity_y, approx_y)
  local y1 = self.y    local y2 = c.y
                       local h2 = c.h

  return y1 < (y2 - h2 + approx_y) and
         y1 > (y2 - h2 - approx_y) and
         player_velocity_y < 0
end

function collision:right_collision(c, approx_x)
  local x1 = self.x    local x2 = c.x
  local y1 = self.y    local y2 = c.y
  local w1 = self.w    local w2 = c.w
  local h1 = self.h    local h2 = c.h

  return x1 > (x2 - w1 - approx_x) and
         x1 < (x2 - w1 + approx_x) and
         y1 > y2 - h1 + 2          and
         y1 < y2 + h2 - 2
end

function collision:left_collision(c, approx_x)
  local x1 = self.x    local x2 = c.x
  local y1 = self.y    local y2 = c.y
  local w1 = self.w    local w2 = c.w
  local h1 = self.h    local h2 = c.h

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

return collision
