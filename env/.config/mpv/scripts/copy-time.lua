require("mp")
require("mp.msg")
local utils = require("mp.utils")

-- State for the start time (set by 'w')
local start_time_full = nil -- HH:MM:SS.mmm
local start_time_disp = nil -- HH:MM:SS

-- --- Platform Detection ---

local function get_platform()
    local windir = os.getenv("windir")
    if windir and windir ~= "" then
        return "windows"
    end
    -- Simple fallback detection for Unix-likes
    local homedir = os.getenv("HOME")
    if homedir and homedir ~= "" then
        -- Could differentiate Mac vs Linux if needed, but for clipboard tools it's often dynamic
        local f = io.popen("uname -s", "r")
        if f then
            local s = f:read("*a")
            f:close()
            if s and s:find("Darwin") then
                return "mac"
            end
        end
        return "linux"
    end
    return "linux" -- default fallback
end

local platform = get_platform()

-- --- Clipboard Handling ---

local function set_clipboard(text)
    if platform == "windows" then
        -- Uses PowerShell with .NET Clipboard API for reliable handling of special characters
        -- Escaping single quotes as they interfere with the PowerShell command string
        local escaped_text = text:gsub("'", "''")
        
        local ps_command = string.format([[
            Add-Type -AssemblyName PresentationCore;
            [System.Windows.Clipboard]::SetText('%s');
        ]], escaped_text)

        local res = utils.subprocess({
            args = {"powershell", "-NoProfile", "-Command", ps_command},
            cancellable = false
        })
        return res.status == 0
    elseif platform == "mac" then
        local pipe = io.popen("pbcopy", "w")
        if pipe then
            pipe:write(text)
            pipe:close()
            return true
        end
    else
        -- Linux: Try standard tools
        local tools = {"xclip -silent -in -selection clipboard", "wl-copy"}
        for _, tool in ipairs(tools) do
            if os.execute("command -v " .. tool:match("%S+") .. " > /dev/null") then
               local pipe = io.popen(tool, "w")
               if pipe then
                   pipe:write(text)
                   pipe:close()
                   return true
               end
            end
        end
    end
    mp.msg.error("Failed to find a supported clipboard command.")
    return false
end

-- --- Time Formatting ---

local function get_time_components(time_pos)
    if not time_pos then time_pos = 0 end
    local hours = math.floor(time_pos / 3600)
    local minutes = math.floor((time_pos % 3600) / 60)
    local seconds = math.floor(time_pos % 60)
    local milliseconds = math.floor((time_pos % 1) * 1000)
    return hours, minutes, seconds, milliseconds
end

local function get_formatted_strings(time_pos)
    local h, m, s, ms = get_time_components(time_pos)
    local full = string.format("%02d:%02d:%02d.%03d", h, m, s, ms)
    local disp = string.format("%02d:%02d:%02d", h, m, s)
    return full, disp
end

-- --- Commands ---

-- Ctrl+c: Copy current time (HH:MM:SS.mmm)
local function copy_current_time()
    local pos = mp.get_property_number("time-pos")
    local time_full, _ = get_formatted_strings(pos)
    
    if set_clipboard(time_full) then
        mp.osd_message(string.format("Copied to Clipboard: %s", time_full))
    else
        mp.osd_message("Failed to copy time to clipboard")
    end
end

-- w: Set start time
local function set_start_time()
    local pos = mp.get_property_number("time-pos")
    start_time_full, start_time_disp = get_formatted_strings(pos)
    
    if set_clipboard(start_time_full) then
        mp.osd_message(string.format("Start time set: %s (t1)", start_time_full))
    else
        mp.osd_message("Failed to copy start time")
    end
end

-- e / E: Copy segment [DisplayTime](URL#t=Start,End)
-- mode: 'simple' (e) or 'file_proto' (E)
local function copy_segment(mode)
    if not start_time_full then
        mp.osd_message("Please set start time first (Press 'w')")
        return
    end

    local pos = mp.get_property_number("time-pos")
    local end_time_full, _ = get_formatted_strings(pos)
    
    local path = mp.get_property("path")
    if not path then 
        mp.osd_message("No video path found")
        return 
    end

    local final_url = path

    if mode == "file_proto" then
        -- Ensure backslashes are forward slashes
        final_url = final_url:gsub("\\", "/")
        -- URL Encode spaces
        final_url = final_url:gsub(" ", "%%20")
        
        -- Prepend file:// if strictly needed or requested
        -- The original script prepended file://
        -- We will ensure it looks like a URI options
        if not final_url:match("^%a+://") then
            -- If it's a local path
            if final_url:match("^/") then
                 final_url = "file://" .. final_url
            else
                 -- Likely windows path C:/... -> file:///C:/...
                 final_url = "file:///" .. final_url
            end
        end
    end

    local result_text = string.format("[%s](%s#t=%s,%s)", start_time_disp, final_url, start_time_full, end_time_full)
    
    if set_clipboard(result_text) then
        mp.osd_message(string.format("Copied: %s", result_text))
    else
        mp.osd_message("Failed to copy segment")
    end
end

-- --- Bindings ---

mp.add_key_binding("Ctrl+c", "copyTime", copy_current_time)
mp.add_key_binding("w", "Time1", set_start_time)
mp.add_key_binding("e", "Time2", function() copy_segment("simple") end)
mp.add_key_binding("E", "Time3", function() copy_segment("file_proto") end)
