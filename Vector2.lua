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


local Vector2 = {}

--// METAMETHODS //--

local function umn(self)
	return (self * -1)
end

local function add(self, value)
	if (type(value) == "number") then
		return Vector2.addScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "Vector2") then
			return Vector2.addVectors(self, value)
		else
			error("attempt to perform arithmetic (add) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (add) on " .. self.className .. " and " .. type(value))
	end
end

local function sub(self, value)
	if (type(value) == "number") then
		return Vector2.subtractScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "Vector2") then
			return Vector2.subtractVectors(self, value)
		else
			error("attempt to perform arithmetic (subtract) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (subtract) on " .. self.className .. " and " .. type(value))
	end
end

local function mul(self, value)
	if (type(value) == "number") then
		return Vector2.multiplyScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "Vector2") then
			return Vector2.multiplyVectors(self, value)
		else
			error("attempt to perform arithmetic (multiply) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (multiply) on " .. self.className .. " and " .. type(value))
	end
end

local function div(self, value)
	if (type(value) == "number") then
		return Vector2.divideScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "Vector2") then
			return Vector2.divideVectors(self, value)
		else
			error("attempt to perform arithmetic (divide) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (divide) on " .. self.className .. " and " .. type(value))
	end
end

local function tostringMetamethod(self)
	return ("( " .. self.x .. ", " .. self.y .. ")")
end

local function eq(self, value)
	return Vector2.equals(self, value, 0.01)
end

--// CONSTRUCTOR //--

function Vector2.new(x, y)

	-- Handles Input --
	if (x) and (type(x) ~= "number") then error("number expected, got " .. type(x)) end
	if (y) and (type(y) ~= "number") then error("number expected, got " .. type(y)) end
	----
	
	local dataTable = setmetatable(
		{
			x = x or 0,
			y = y or 0,
			className = "Vector2"
		},
		Vector2
	)
	
	local proxyTable = setmetatable(
		{
			
		},
		{
			__index = function(self, index)
				if (index == "magnitude") then
					return Vector2.getMagnitude(self)
				elseif (index == "unit") then
					return Vector2.getUnitVector(self)
				else
					return (dataTable[index])
				end
			end,
			
			__newindex = function(self, index, newValue)
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
			
			__unm = umn,
			__add = add,
			__sub = sub,
			__mul = mul,
			__div = div,
			__eq = eq,
			__tostring = tostringMetamethod
		}
	)
	
	return proxyTable
	
end

--// METHODS //--

function Vector2.addVectors(firstVector2, secondVector2)
	return Vector2.new(firstVector2.x + secondVector2.x, firstVector2.y + secondVector2.y)
end

function Vector2.subtractVectors(firstVector2, secondVector2)
	return Vector2.new(firstVector2.x - secondVector2.x, firstVector2.y - secondVector2.y)
end

function Vector2.multiplyVectors(firstVector2, secondVector2)
	return Vector2.new(firstVector2.x * secondVector2.x, firstVector2.y * secondVector2.y)
end

function Vector2.divideVectors(firstVector2, secondVector2)
	return Vector2.new(firstVector2.x / secondVector2.x, firstVector2.y / secondVector2.y)
end

function Vector2.addScalar(vector2, scalar)
	return Vector2.new(vector2.x + scalar, vector2.y + scalar)
end

function Vector2.subtractScalar(vector2, scalar)
	return Vector2.new(vector2.x - scalar, vector2.y - scalar)
end

function Vector2.multiplyScalar(vector2, scalar)
	return Vector2.new(vector2.x * scalar, vector2.y * scalar)
end

function Vector2.divideScalar(vector2, scalar)
	return Vector2.new(vector2.x / scalar, vector2.y / scalar)
end

function Vector2.mapVector(vector2, mapFunction)
	local x, y = mapFunction(vector2.x, vector2.y)
	return Vector2.new(x, y)
end

function Vector2.equals(firstVector2, secondVector2, epsilon)
	return ((firstVector2 - secondVector2).magnitude < epsilon)
end

function Vector2.getMagnitude(vector2)
	return math.sqrt(
		vector2.x^2 +
		vector2.y^2
	)
end

function Vector2.getUnitVector(vector2)
	return (vector2/vector2.magnitude)
end

--// INSTRUCTIONS //--

Vector2.__index = Vector2

return Vector2
