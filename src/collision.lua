local Object = require "classic"
local Collision = Object:extend()

function Collision:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.x = obj.x or 0 -- x posistion
  self.y = obj.y or 0 -- y posistion
  self.w = obj.w or 0 -- width
  self.h = obj.h or 0 -- height
end

function Collision:check_collision(collision)
  local x1 = self.x    local x2 = collision.x
  local y1 = self.y    local y2 = collision.y
  local w1 = self.w    local w2 = collision.w
  local h1 = self.h    local h2 = collision.h

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Collision:check_entity(entity)
  return self:check_collision(entity.collision)
end

function Collision:check_entities(entities)
  for _, entity in ipairs(entities) do
    if self:check_entity(entity) then
      return entity
    end
  end

  return nil
end

function Collision:check_boundaries()
  local boundarie_limit = 1
  local which_side

  local x = self.x
  local y = self.y
  local w = self.w
  local h = self.h

  if y <= -boundarie_limit - h then
    which_side = "top"
  elseif y >= love.graphics.getHeight() + h + boundarie_limit then
    which_side = "bottom"
  elseif x <= -boundarie_limit - w then
    which_side = "left"
  elseif x >= love.graphics.getWidth() + boundarie_limit then
    which_side = "right"
  end

  return which_side
end

return Collision
