---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

-- =====================================================================
-- STANDARD WINDOWS & SESSION MANAGEMENT
-- =====================================================================
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("wlogout"), { description = "Exit / Power menu" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "File manager" })
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("thunar"), { description = "Open Thunar file manager" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating mode" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu), { description = "App launcher" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Pseudo-tiling" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { description = "Fullscreen" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

-- =====================================================================
-- EXTRA SYSTEM SCRIPTS
-- =====================================================================
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.config/hypr/scripts/help.sh"), { description = "Help" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/web_search.sh"), { description = "Web search" })
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/settings_menu.sh"), { description = "Settings" })

-- =====================================================================
-- MOVE WINDOW FOCUS (Arrow Keys)
-- =====================================================================
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

-- =====================================================================
-- WORKSPACES CONFIGURATION (Loops 1 to 10)
-- =====================================================================
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move to workspace " .. i })
end

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move to special workspace" })

-- =====================================================================
-- MOUSE BINDS (Scroll & Dragging)
-- =====================================================================
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- =====================================================================
-- MULTIMEDIA HARDWARE KEYS
-- =====================================================================
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, description = "Toggle mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, description = "Toggle mic mute" })

-- Display & Keyboard Brightness keys
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true, description = "Brightness down" })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true, description = "Keyboard Brightness Up" })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true, description = "Keyboard Brightness Down" })

-- Touchpad Hardware Toggle
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("~/.config/hypr/scripts/TouchPad.sh"), { description = "Toggle Touchpad" })

-- Media Player Control (playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next track" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Pause" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })

-- =====================================================================
-- SCREENSHOT SYSTEM KEYBINDINGS
-- =====================================================================
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --now"), { description = "Screenshot now" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --area"), { description = "Screenshot (area)" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --in5"), { description = "Screenshot in 5s" })
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --in10"), { description = "Screenshot in 10s" })
hl.bind("ALT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --active"), { description = "Screenshot active window" })
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/ScreenShot.sh --swappy"), { description = "Screenshot (area) editable" })

