validate = {}

validate.number = function(val)
	if type(val) == 'number' then
		return true
	else
		return false
	end
end

validate.string = function(val)
	if type(val) == 'string' then
		return true
	else
		return false
	end
end


validate.table = function(val)
	if type(val) == 'table' then
		return true
	else
		return false
	end
end


validate.userdata = function(val)
	if type(val) == 'userdata' then
		return true
	else
		return false
	end
end


validate.func = function(val)
	if type(val) == 'function' then
		return true
	else
		return false
	end
end

validate.CFunction = function(val)
	if type(val) == 'CFunction' then
		return true
	else
		return false
	end
end

validate.nothing = function(val)
	if type(val) == 'nil' then
		return true
	else
		return false
	end
end

validate.spesific = function(val1, val2) -- Input {'Something', ['something', 1, 2, 3, 4, 5]}
	if not type(val2) == 'table' then
		print('TYPE ERROR: Invalid value for val2, expected table got '..type(val2))
		return false
	end

	for _,v in ipairs(val2) do
		if not type(v) == 'string' then
			print('TYPE ERROR: Invalid value for a child of val2, expected string got '..type(v))
			return false
		end
		if type(val1) == v then
			return true
		end
	end

	return false
end

return validate
