local kbd = {}

kbd.pressed = {}

function kbd.isPressed(key)
	expect(key, "number", 1)
	return kbd.pressed[key] == true
end

function kbd.daemon()
	while true do
		local e = {os.pullEventRaw()}
		if e[1] == "key" then
			kbd.pressed[e[2]] = true
		elseif e[1] == "key_up" then
			kbd.pressed[e[2]] = nil
		end
	end
end

return kbd
