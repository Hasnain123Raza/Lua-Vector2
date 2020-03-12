--[[
	
	MADE BY HASNAIN RAZA
	
	Vector2 is a simple two dimensional vector mathematics class.
	
	DEMO (all features)
	
	local a, b, c = Vector2.new(1, 1), Vector2.new(2, 2), Vector2.new(3, 3)
	
	print(a + b)
	print(a:addVectors(b))
	print(Vector2.addVectors(a, b))
	
	print(a - b)
	print(a:subtractVectors(b))
	print(Vector2.subtractVectors(a, b))
		
	print(a * b)
	print(a:multiplyVectors(b))
	print(Vector2.multiplyVectors(a, b))
		
	print(a / b)
	print(a:divideVectors(b))
	print(Vector2.divideVectors(a, b))
	
	print(-c)
	
	print(a + 1)
	print(a:addScalar(1))
	print(Vector2.addScalar(a, b))
	
	print(a - 1)
	print(a:subtractScalar(1))
	print(Vector2.subtractScalar(a, b))
	
	print(a * 1)
	print(a:multiplyScalar(1))
	print(Vector2.multiplyScalar(a, b))
	
	print(a / 1)
	print(a:multiplyScalar(1))
	print(Vector2.multiplyScalar(a, b))
	
	print(c.magnitude)
	print(c:getMagnitude())
	print(Vector2.getMagnitude(c))
	
	print(c.unit)
	print(c:getUnitVector())
	print(Vector2.getUnitVector(c))
	
	print(a == b)
	print(a:equals(b, 0.01))
	print(Vector2.equals(a, b, 0.01))
	
	print(
		c:mapVector(function(x, y)
			return (x + y), (x - y)
		end)
	)
	
	It is recommended that you rely on arithmetic operators rather than calling functions
	because error handling is done primarily on the operators.
	
--]]


local MODULE = {}

--// CONSTANTS //--



--// VARIABLES //--



--// CONSTRUCTOR //--

function MODULE.new(x, y)
	
	--[[
		
		Creates a new Vector2 object.
		
	--]]
	
	-- Handle Input --
	if (x) and (type(x) ~= "number") then error("number expected, got " .. type(x)) end
	if (y) and (type(y) ~= "number") then error("number expected, got " .. type(y)) end
	----
	
	local dataTable = setmetatable(
		{
			x = x or 0,
			y = y or 0,
			className = "Vector2"
		},
		MODULE
	)
	
	local proxyTable = setmetatable(
		{
			
		},
		{
			__index = function(self, index)
					
				--[[
					
					Appropriately handles indexes to Vector2 objects.
					
				--]]
				
				if (index == "magnitude") then
					return MODULE.getMagnitude(self)
				elseif (index == "unit") then
					return MODULE.getUnitVector(self)
				else
					return (dataTable[index])
				end
				
			end,
			
			__newindex = function(self, index, newValue)
									
				--[[
					
					Appropriately handles editing properties of Vector2 objects.
					
				--]]
				
				if (index == "x") or (index == "y") then
					if (newValue) and (type(newValue) ~= "number") then
						error("number expected, got " .. type(index))
					else
						dataTable[index] = newValue
					end
				else
					error(newValue .. " cannot be assigned")
				end
				
			end,
			
			__unm = function(self)
									
				--[[
					
					Appropriately handles unary operator and returns the result.
					
				--]]
				
				return (self * -1)
				
			end,
			
			__add = function(self, value)
									
				--[[
					
					Appropriately adds value to this Vector2 object and returns the result.
					
				--]]
				
				if (type(value) == "number") then
					return MODULE.addScalar(self, value)
				elseif (type(value) == "table") then
					if (value.className) and (value.className == "Vector2") then
						return MODULE.addVectors(self, value)
					else
						error("attempt to perform arithmetic (add) on " .. self.className .. " and unknown")
					end
				else
					error("attempt to perform arithmetic (add) on " .. self.className .. " and " .. type(value))
				end
				
			end,
			
			__sub = function(self, value)
									
				--[[
					
					Appropriately subtracts value from this Vector2 objec and returns the resultt.
					
				--]]
				
				if (type(value) == "number") then
					return MODULE.subtractScalar(self, value)
				elseif (type(value) == "table") then
					if (value.className) and (value.className == "Vector2") then
						return MODULE.subtractVectors(self, value)
					else
						error("attempt to perform arithmetic (subtract) on " .. self.className .. " and unknown")
					end
				else
					error("attempt to perform arithmetic (subtract) on " .. self.className .. " and " .. type(value))
				end
				
			end,
			
			__mul = function(self, value)
									
				--[[
					
					Appropriately multiplies Vector2 object with value and returns the result.
					
				--]]
				
				if (type(value) == "number") then
					return MODULE.multiplyScalar(self, value)
				elseif (type(value) == "table") then
					if (value.className) and (value.className == "Vector2") then
						return MODULE.multiplyVectors(self, value)
					else
						error("attempt to perform arithmetic (multiply) on " .. self.className .. " and unknown")
					end
				else
					error("attempt to perform arithmetic (multiply) on " .. self.className .. " and " .. type(value))
				end
				
			end,
			
			__div = function(self, value)
									
				--[[
					
					Appropriately divides Vector2 object with value and returns the result.
					
				--]]
				
				if (type(value) == "number") then
					return MODULE.divideScalar(self, value)
				elseif (type(value) == "table") then
					if (value.className) and (value.className == "Vector2") then
						return MODULE.divideVectors(self, value)
					else
						error("attempt to perform arithmetic (divide) on " .. self.className .. " and unknown")
					end
				else
					error("attempt to perform arithmetic (divide) on " .. self.className .. " and " .. type(value))
				end
				
			end,
			
			__eq = function(self, value)
									
				--[[
					
					Returns true if the two Vector2 objects are within an epsilon of 0.01.
					
				--]]
				
				return MODULE.equals(self, value, 0.01)
				
			end,
			
			__tostring = function(self)
									
				--[[
					
					Returns a string representing the Vector2 object.
					
				--]]
				
				return ("( " .. self.x .. ", " .. self.y .. ")")
				
			end
		}
	)
	
	return proxyTable
	
end

--// METHODS //--

function MODULE.addVectors(firstVector2, secondVector2)
	
	--[[
		
		Adds two Vector2 objects.
		
	--]]
	
	return MODULE.new(firstVector2.x + secondVector2.x, firstVector2.y + secondVector2.y)
	
end

function MODULE.subtractVectors(firstVector2, secondVector2)
	
	--[[
		
		Subtracts two Vector2 objects.
		
	--]]
	
	return MODULE.new(firstVector2.x - secondVector2.x, firstVector2.y - secondVector2.y)
	
end

function MODULE.multiplyVectors(firstVector2, secondVector2)
	
	--[[
		
		Multiplies two Vector2 objects.
		
	--]]
	
	return MODULE.new(firstVector2.x * secondVector2.x, firstVector2.y * secondVector2.y)
	
end

function MODULE.divideVectors(firstVector2, secondVector2)
	
	--[[
		
		Divides two Vector2 objects.
		
	--]]
	
	return MODULE.new(firstVector2.x / secondVector2.x, firstVector2.y / secondVector2.y)
	
end

function MODULE.addScalar(vector2, scalar)
	
	--[[
		
		Adds a scalar to Vector2 object.
		
	--]]
	
	return MODULE.new(vector2.x + scalar, vector2.y + scalar)
	
end

function MODULE.subtractScalar(vector2, scalar)
	
	--[[
		
		Subtracts a scalar from Vector2 object.
		
	--]]
	
	return MODULE.new(vector2.x - scalar, vector2.y - scalar)
	
end

function MODULE.multiplyScalar(vector2, scalar)
	
	--[[
		
		Multiplies a Vector2 object with a scalar.
		
	--]]
	
	return MODULE.new(vector2.x * scalar, vector2.y * scalar)
	
end

function MODULE.divideScalar(vector2, scalar)
	
	--[[
		
		Divides a Vector2 object with a scalar.
		
	--]]
	
	return MODULE.new(vector2.x / scalar, vector2.y / scalar)
	
end

function MODULE.mapVector(vector2, mapFunction)
	
	--[[
		
		Maps the values of a Vector2 object with a mapping function.
		
	--]]
	
	local x, y = mapFunction(vector2.x, vector2.y)
	return MODULE.new(x, y)
	
end

function MODULE.equals(firstVector2, secondVector2, epsilon)
	
	--[[
		
		Returns true if the two Vector2 objects are within epsilon difference.
		
	--]]
	
	return ((firstVector2 - secondVector2).magnitude < epsilon)
	
end

function MODULE.getMagnitude(vector2)
		
	--[[
		
		Returns the magnitude of a Vector2 object.
		
	--]]
	
	return math.sqrt(
		vector2.x^2 +
		vector2.y^2
	)
	
end

function MODULE.getUnitVector(vector2)
		
	--[[
		
		Returns a unit Vector2 object for some Vector2.
		
	--]]
	
	return (vector2/vector2.magnitude)
	
end

--// INSTRUCTIONS //--

MODULE.__index = MODULE

return MODULE
