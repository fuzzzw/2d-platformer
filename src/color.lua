local object = require "classic"
local color = object:extend()

function color:new(r,g,b)  -- The constructor
  self.r = r or 0 -- r red
  self.g = g or 0 -- g green
  self.b = b or 0 -- b blue
end

function color:setAll(r,g,b)
  self.r = r or self.r
  self.g = g or self.g
  self.b = b or self.b
end

function color:setR(r)
  self.r = r
end

function color:setG(g)
  self.g = g
end

function color:setB(b)
  self.b = b
end

function color:getR()
  return self.r
end

function color:getG()
  return self.g
end

function color:getB()
  return self.b
end

return color
