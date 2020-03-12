# Lua-Vector2
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
