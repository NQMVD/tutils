-- Terminal Multishell for ComputerCraft
-- Maybe use Basalt for the TUI?
--
-- Notes:
-- Render the TUI on events
-- First check if already in multishell or mushell, if so abort

local luce = require("lib.luce")

local tArgs = { ... }
local bExit = false
local tSettings = {}

local tTabs = {}
local bMenuToggle = false

local sMessage = "Welcome to MuShell!"

function init()
	-- set width and height, default to 51x19
	tSettings.width, tSettings.height = term.getSize()
	-- set max tabs
	tSettings.maxTabs = 10
	-- set max tab width
	tSettings.maxTabWidth = 10
end

function createTab()
	if #tTabs < tSettings.maxTabs then
		luce.push(tTabs, { title = string.format("#%d", #tTabs) })
	else
		sMessage = "Max tabs reached!"
	end
end

function closeTab() end

function nextTab() end

function prevTab() end

function promtInput() end

function promtYN() end

function handleKeyboardInput()
	while true do
		local event, key = os.pullEvent("key")

		if key == keys.leftCtrl or param == keys.rightCtrl then
			if sMessage then
				sMessage = nil
			else
				bMenuToggle = not bMenuToggle
			end
		elseif key == keys.rightAlt then
		end

		if bMenuToggle then
			if key == keys.q then
				bExit = true
			elseif key == keys.c then
				createTab()
			elseif key == keys.x then
				closeTab()
			elseif key == keys.right then
				nextTab()
			elseif key == keys.left then
				prevTab()
			end
		end
	end
end

function handleMouseInput()
	while true do
		local event, x, y, button = os.pullEvent("mouse_click")
		if y == 1 and x >= tWindows[1].x and x <= tWindows[1].x + tWindows[1].width then
			local tabIndex = math.floor((x - tWindows[1].x) / (tWindows[1].width / #tWindows[1].tabs)) + 1
			switchTab(1, tabIndex)
		end
	end
end

function renderScreen()
	-- Implement logic to render the entire screen based on the current state
	-- Include rendering for the tab bar
end

-- Start parallel threads for keyboard and mouse input
while not bExit do
	parallel.waitForAny(handleKeyboardInput, handleMouseInput)
	renderScreen()
end
