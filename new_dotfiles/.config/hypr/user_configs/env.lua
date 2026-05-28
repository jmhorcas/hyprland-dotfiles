-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Cursors (Keeps size and scaling consistent across desktops and apps)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkit Backends (Forces applications to run natively on Wayland)
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG Specifications (Mandatory for screen sharing, portals, and audio routing)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Specific Apps Performance & Protocols (Essential for modern GUI apps)
hl.env("MOZ_ENABLE_WAYLAND", "1")                  -- Enables native Wayland rendering on Firefox
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")      -- Runs VS Code, Discord, and Electron apps natively without XWayland blurring

-- Theming (Applies consistent dark/light configurations using modern Qt6 backend)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Default System Applications
hl.env("BROWSER", "firefox")