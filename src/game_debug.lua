local Object = require "classic"
local Color = require "color"
local Game_debug = Object:extend()

function Game_debug:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.context   = obj.context or ""
  self.posistion = obj.posistion or 0
  self.color     = obj.color or Color()
end

return Game_debug
