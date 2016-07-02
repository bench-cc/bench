local stringutils = require "stringutils"
local pager = require "pager"

local str = ""

for i = 1, 255 do
	str = str .. stringutils.fixLength(i .. ": " .. ((i == 10 and " ") or string.char(i)), 6) .. ((i % 7 == 0 and "\n") or " ")
end

pager.scroll(str .. "\n\n")
