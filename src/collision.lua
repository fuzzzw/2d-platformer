local Object = require "classic"
local Collision = Object:extend()

function Collision:new(obj)  -- The constructor
  self.x = obj.x or 0 -- x posistion
  self.y = obj.y or 0 -- y posistion
  self.w = obj.w or 0 -- width
  self.h = obj.h or 0 -- height
end

function Collision:check_collision(c)
  local x1 = self.x    local x2 = c.x
  local y1 = self.y    local y2 = c.y
  local w1 = self.w    local w2 = c.w
  local h1 = self.h    local h2 = c.h

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

return Collision
