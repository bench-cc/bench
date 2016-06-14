local stringutils = require "stringutils"

local pagerlib = {}

pagerlib.lorem_ipsum = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc in vestibulum nibh, et fermentum dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur finibus, libero vitae ullamcorper porta, dui ligula ullamcorper velit, et hendrerit nisl velit et tortor. In egestas ante commodo velit aliquet feugiat. Suspendisse volutpat velit arcu, non posuere justo pellentesque ut. Nullam feugiat velit et sem ullamcorper lobortis. Donec a tristique ligula. Ut placerat eu enim at interdum. Sed porttitor dolor lectus, sed tincidunt purus dapibus eget. Sed venenatis cursus quam sed imperdiet. Sed risus purus, lacinia et purus ut, fermentum dapibus elit. Maecenas volutpat erat vel urna viverra, ut rutrum orci lobortis. Suspendisse potenti. Aliquam malesuada lacinia lorem, non semper diam dapibus nec.

Fusce dapibus aliquam elementum. Proin placerat, urna in porttitor posuere, purus lacus lacinia ex, in posuere justo justo nec nisl. Aenean pretium nisi a orci euismod facilisis. Vestibulum diam ex, sollicitudin sit amet nunc a, lacinia tincidunt neque. Donec vitae leo id nisl venenatis volutpat quis quis libero. Nullam odio sapien, aliquam sit amet vulputate et, fringilla vitae urna. Praesent et imperdiet leo, eleifend blandit tortor.

Etiam quis dui accumsan, varius ipsum faucibus, dictum nibh. In fermentum nunc sed quam sodales, nec varius purus faucibus. Mauris sed feugiat libero. Suspendisse dapibus, nulla eget hendrerit vulputate, urna tellus bibendum tellus, sed laoreet felis erat ut purus. Mauris tempor turpis id eros commodo lacinia. In hac habitasse platea dictumst. Aliquam erat volutpat. Cras varius lacinia faucibus. Aliquam non ante ut nibh elementum dignissim in sit amet ligula. Phasellus elementum quis metus eget blandit.

Aliquam semper felis quis eros lobortis, id condimentum purus sodales. In mattis massa nec justo malesuada efficitur. Vivamus varius accumsan lacus, in commodo dolor consectetur sed. Maecenas dignissim venenatis massa nec molestie. Phasellus molestie viverra odio a lacinia. Nunc est purus, blandit vitae interdum in, cursus nec nisl. Curabitur enim lacus, feugiat vitae iaculis at, consectetur vitae felis. Donec sodales id enim at lobortis. Ut in orci hendrerit, blandit nunc ut, sagittis lorem. Morbi commodo libero at est euismod, in pharetra risus finibus.

Nunc nec augue pharetra, congue risus sed, feugiat tellus. Mauris ultrices, metus eu tincidunt volutpat, dui enim blandit orci, non sodales purus arcu sed enim. Duis consectetur enim vitae fringilla ultrices. Sed non nibh hendrerit, pulvinar urna eget, pretium urna. Cras ut ante eu enim eleifend cursus vel et turpis. Nunc aliquam est in nunc elementum sodales non a libero. In sollicitudin at nibh vel sollicitudin. Nullam egestas, quam id malesuada elementum, turpis elit aliquet turpis, a consequat velit nibh iaculis leo.

Vestibulum id aliquet sapien, quis egestas tortor. Nulla convallis sapien non libero vulputate, in scelerisque magna gravida. Sed nibh turpis, vehicula in ornare eu, venenatis semper dolor. Donec ut malesuada diam. Sed in vulputate mi. Curabitur sodales rhoncus sapien, vehicula porta nunc gravida a. Maecenas at tristique nisl. Curabitur id dictum massa. Maecenas volutpat neque eget eleifend ornare. Morbi sem eros, viverra ut nibh at, tristique dapibus arcu. Nam turpis orci, tristique nec pellentesque vel, malesuada quis est. Aenean pretium blandit lacus, eu aliquam mauris fermentum vitae. Sed vitae urna sit amet purus fringilla pellentesque nec a dui. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris in felis in eros condimentum imperdiet in id eros.

Vivamus quis diam varius, tempor sapien sit amet, blandit odio. Phasellus dui odio, elementum ac diam eu, interdum placerat mi. Duis quis tellus at est fermentum aliquam non at nunc. Donec ultrices neque ultricies dictum egestas. Sed lacinia, nisl vitae suscipit eleifend, mi neque dictum mi, ac cursus enim urna non ligula. Praesent elementum volutpat tempus. Phasellus ac mi et nulla porttitor egestas id ut nisi. Sed commodo elit eget velit convallis, vitae consectetur nulla varius. Etiam malesuada porttitor lacus.

Curabitur quis ornare diam. Aliquam sed massa eros. Sed sollicitudin diam nec pretium sagittis. Nullam velit eros, iaculis ut eleifend sit amet, accumsan vel elit. Donec malesuada tempus justo ultrices pulvinar. In convallis nulla id ex laoreet mattis. Nullam in ultrices libero. Etiam vestibulum congue orci vel luctus. Pellentesque eget fringilla massa.

Pellentesque vel diam sit amet tellus pretium tempus id ac magna. Vestibulum magna ipsum, pharetra ac arcu vitae, pharetra rutrum odio. Aliquam finibus, libero non posuere ullamcorper, dolor sapien maximus ipsum, quis pellentesque augue arcu nec sem. Vestibulum ut dapibus nisl. Quisque vel eros imperdiet, feugiat odio vitae, rutrum eros. Vivamus eleifend, elit ut aliquet imperdiet, erat dolor dictum leo, at pellentesque sapien tellus faucibus elit. Donec eu nulla eu lorem consectetur iaculis sed id lectus. Maecenas vehicula orci turpis, in mollis augue maximus vitae. Curabitur in commodo dolor, in efficitur lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras sed lacinia quam, in rhoncus orci. Aliquam erat volutpat. Etiam auctor magna porta lorem consectetur porttitor. Proin molestie turpis non erat convallis, ut elementum odio suscipit. Aenean eu magna vel magna rutrum facilisis rutrum hendrerit enim.

Sed pulvinar consequat velit, vitae gravida augue. Vestibulum tempor hendrerit mauris eget volutpat. Phasellus consectetur lectus vitae dui euismod, in euismod nulla aliquam. Donec venenatis tellus ac varius auctor. Suspendisse in neque ultrices, fringilla nisl quis, blandit risus. In pharetra tempor luctus. Duis molestie egestas odio in ullamcorper. Ut quis massa neque. Vivamus eget risus sit amet urna dapibus tempus consectetur ac turpis.]]

pagerlib.defaultOptions = {
	wrapLines = false,
	clearOnExit = true,
	infoBar = true,
	keys = {
		up = {keys.up},
		down = {keys.down},
		right = {keys.right},
		left = {keys.left},
		pgup = {keys.pageUp},
		pgright = {},
		pgleft = {},
		pgdown = {keys.pageDown},
		quit = {keys.q}
	}
}

local function maxLength(lines)
	local max = 0
	for i, v in ipairs(lines) do
		max = math.max(#v, max)
	end
	return max
end

local function render(lines, scrolly, scrollx, infobar)
	local w, h = term.getSize()
	if infobar then h = h - 1 end
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
	for i = 1, h do
		local line = stringutils.fixLength((lines[i+scrolly] or ""):sub(scrollx + 1), w)
		term.setCursorPos(1, i)
		term.write(line)
	end
	if infobar then
		term.setTextColor(colors.lightGray)
		term.setCursorPos(1, h + 1)
		term.write(stringutils.fixLength(infobar, w))
	end
end

local function contains(tbl, val)
	for i, v in ipairs(tbl) do
		if v == val then return true end
	end
	return false
end

function pagerlib.scroll(text, options)
	expect(text, "string", 1)
	options = setmetatable(expect(options, "table", 2, true) or {}, {__index = pagerlib.defaultOptions})
	setmetatable(options.keys, {__index = pagerlib.defaultOptions.keys})

	local w, h = term.getSize()
	local lines = options.wrapLines and stringutils.wrapLines(text, w) or stringutils.lines(text)
	local scrolly, scrollx = 0, 0
	local run = true
	local maxlen = maxLength(lines)

	local quitKeys = {}
	for i, v in ipairs(options.keys.quit) do
		for k, v2 in pairs(keys) do
			if v == v2 then
				table.insert(quitKeys, k:upper())
			end
		end
	end

	local infoText = "Press " .. table.concat(quitKeys, "/") .. " to exit "

	local function draw()
		local progress = math.floor(math.min(scrolly / (#lines - h), 1) * 100) .. "%"
		render(lines, scrolly, scrollx, stringutils.fixLength(infoText, w):sub(1, -(#progress + 1)) .. progress)
	end

	draw()

	while run do
		local e = {os.pullEvent()}
		if e[1] == "key" then
			if contains(options.keys.up, e[2]) then
				scrolly = math.max(scrolly - 1, 0)
				draw()
			elseif contains(options.keys.down, e[2]) then
				scrolly = math.min(scrolly + 1, #lines - h)
				draw()
			elseif contains(options.keys.pgup, e[2]) then
				scrolly = math.max(scrolly - h, 0)
				draw()
			elseif contains(options.keys.pgdown, e[2]) then
				scrolly = math.min(scrolly + h, #lines - h)
				draw()
			elseif contains(options.keys.left, e[2]) then
				scrollx = math.max(scrollx - 1, 0)
				draw()
			elseif contains(options.keys.right, e[2]) then
				scrollx = math.min(scrollx + 1, maxlen - w)
				draw()
			elseif contains(options.keys.quit, e[2]) then
				run = false
			end
		end
	end

	if options.clearOnExit then
		term.clear()
		term.setCursorPos(1,1)
	end
end

return pagerlib
