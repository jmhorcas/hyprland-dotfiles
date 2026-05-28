-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
-- Environment variables and communication (Always first)
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
-- Authentication agent
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
-- Wallapaper
  hl.exec_cmd("awww-daemon --format xrgb")
-- System utilities
  hl.exec_cmd("swaync")
-- Status bar
  hl.exec_cmd("waybar")
-- Copy-paste utilities
  hl.exec_cmd("wl-paste --type text --watch cliphist store ")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
-- Idle daemon
  hl.exec_cmd("hypridle")
-- Applets
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("blueman-applet")
-- Google Drive
  hl.exec_cmd("rclone mount GoogleDrive: ~/GoogleDrive/MyDrive --vfs-cache-mode full --vfs-cache-max-age 24h --dir-cache-time 1000h")
  --hl.exec_cmd("rclone mount GoogleDrive: ~/GoogleDrive/SharedWithMe --vfs-cache-mode full --vfs-cache-max-age 24h --dir-cache-time 1000h --drive-shared-with-me")  
end)
