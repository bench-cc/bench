local stringutils = {}

function stringutils.lines(text)
	expect(text, "string", 1)
	if text:sub(-1) ~= "\n" then text = text .. "\n" end
	local lines = {}
	for line in text:gmatch("(.-)\n") do
		table.insert(lines, line)
	end
	return lines
end

function stringutils.wrapLines(text, width)
	expect(text, "string", 1)
	expect(width, "number", 2)
	local split = stringutils.lines(text)
	local lines = {}
	for _, line in ipairs(split) do
		local l = ""
		for word in line:gmatch("(%S+)") do
			if #word + #l + 1 > width then
				table.insert(lines, l)
				l = word
			else
				if l == "" then l = word else l = l .. " " .. word end
			end
		end
		table.insert(lines, l)
	end
	return lines
end

function stringutils.fixLength(text, length, pad)
	if type(text) ~= "string" and type(text) ~= "table" then
		return error("expected string/table, got " .. type(text) .. " for arg 1")
	end
	expect(length, "number", 2)
	local pad = expect(pad, "string", 3, true) or " "

	local function padGen(n)
		return pad:rep(math.floor(n / #pad)) .. pad:sub(1, n % #pad)
	end

	if type(text) == "string" then
		return text:sub(1, length) .. padGen(math.max(0, length - #text))
	else
		local out = {}
		for i, line in ipairs(text) do
			out[i] = stringutils.fixLength(line, length, pad)
		end
		return out
	end
end

return stringutils
