require("mp")
require("mp.msg")

-- Copy the current time of the video to clipboard.

WINDOWS = 2
UNIX = 3

local function platform_type()
	local utils = require("mp.utils")
	local workdir = utils.to_string(mp.get_property_native("working-directory"))
	if string.find(workdir, "\\") then
		return WINDOWS
	else
		return UNIX
	end
end

local function command_exists(cmd)
	local pipe = io.popen("type " .. cmd .. ' > /dev/null 2> /dev/null; printf "$?"', "r")
	exists = pipe:read() == "0"
	pipe:close()
	return exists
end

local function get_clipboard_cmd()
	if command_exists("xclip") then
		return "xclip -silent -in -selection clipboard"
	elseif command_exists("wl-copy") then
		return "wl-copy"
	elseif command_exists("pbcopy") then
		return "pbcopy"
	else
		mp.msg.error("No supported clipboard command found")
		return false
	end
end

local function divmod(a, b)
	return a / b, a % b
end

local function set_clipboard(text)
	if platform == WINDOWS then
		mp.commandv("run", "powershell", "set-clipboard", text)
		return true
	elseif platform == UNIX and clipboard_cmd then
		local pipe = io.popen(clipboard_cmd, "w")
		pipe:write(text)
		pipe:close()
		return true
	else
		mp.msg.error("Set_clipboard error")
		return false
	end
end

local function copyTime()
	local time_pos = mp.get_property_number("time-pos")
	local minutes, remainder = divmod(time_pos, 60)
	local hours, minutes = divmod(minutes, 60)
	local seconds = math.floor(remainder)
	local milliseconds = math.floor((remainder - seconds) * 1000)
	local time = string.format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
	if set_clipboard(time) then
		mp.osd_message(string.format("Copied to Clipboard: %s", time))
	else
		mp.osd_message("Failed to copy time to clipboard")
	end
end

--[00:08](file:///home/benz/Downloads/videoplayback.mp4#t=8,9)
--https://www.youtube.com/embed/1?start=2&end=3

-- Replace whitespace with %20
function trim(s)
	return s:gsub("%s", "%%20")
end

local time1

local function Time1()
	local time_pos = mp.get_property_number("time-pos")
	local minutes, remainder = divmod(time_pos, 60)
	local hours, minutes = divmod(minutes, 60)
	local seconds = math.floor(remainder)
	local milliseconds = math.floor((remainder - seconds) * 1000)
	tt = string.format("%02d:%02d:%02d", hours, minutes, seconds)
	time1 = string.format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
	if set_clipboard(time1) then
		mp.osd_message(string.format("t1: %s", time1))
	else
		mp.osd_message("Failed to copy time to clipboard")
	end
end
local function Time2()
	local url = mp.get_property("path")
	local time_pos = mp.get_property_number("time-pos")
	local minutes, remainder = divmod(time_pos, 60)
	local hours, minutes = divmod(minutes, 60)
	local seconds = math.floor(remainder)
	local milliseconds = math.floor((remainder - seconds) * 1000)
	local time2 = string.format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
	timeCopy = string.format("[%s](%s#t=%s,%s)", tt, url, time1, time2)
	if set_clipboard(timeCopy) then
		mp.osd_message(string.format("Ob: %s", timeCopy))
	else
		mp.osd_message("Failed to copy time to clipboard")
	end
end

local function Time3()
	local url = mp.get_property("path")
	local url2 = trim(url)
	local time_pos = mp.get_property_number("time-pos")
	local minutes, remainder = divmod(time_pos, 60)
	local hours, minutes = divmod(minutes, 60)
	local seconds = math.floor(remainder)
	local milliseconds = math.floor((remainder - seconds) * 1000)
	local time2 = string.format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
	timeCopy = string.format("[%s](file://%s#t=%s,%s)", tt, url2, time1, time2)
	if set_clipboard(timeCopy) then
		mp.osd_message(string.format("Ob: %s", timeCopy))
	else
		mp.osd_message("Failed to copy time to clipboard")
	end
end

platform = platform_type()
if platform == UNIX then
	clipboard_cmd = get_clipboard_cmd()
end

mp.add_key_binding("Ctrl+c", "copyTime", copyTime)
mp.add_key_binding("w", "Time1", Time1)
mp.add_key_binding("e", "Time2", Time2)
mp.add_key_binding("E", "Time3", Time3)
