---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "es",  -- Keyboard layout
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
		numlock_by_default = true,    -- Automatically enable NumLock on boot
        repeat_rate        = 50,      -- Keyboard repeat rate (characters per second)
        repeat_delay       = 300,     -- Delay before a held key starts repeating (ms)
        
        follow_mouse = 1,  -- Window focus follows mouse movement

        sensitivity = 0,  -- Mouse sensitivity (-1.0 to 1.0), 0 is default

		float_switch_override_focus = false, -- Prevents floating windows from erratic focus stealing
		
        touchpad = {
            disable_while_typing = true, -- Prevents accidental clicks while typing
            natural_scroll       = true, -- Enables "Natural Scrolling" (mobile style)
            tap_to_click         = true, -- Enables clicking by tapping on the touchpad (bracket syntax required due to hyphens in Lua)
        },
    },
    
    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
    gestures = {
        workspace_swipe_distance           = 500,   -- Distance required to complete a swipe
        workspace_swipe_invert             = true,  -- Inverts swipe direction for a more intuitive feel
        workspace_swipe_min_speed_to_force = 30,    -- Minimum speed to trigger a workspace change
        workspace_swipe_cancel_ratio       = 0.5,
        workspace_swipe_create_new         = true,  -- Swiping past the last workspace creates a new one
        workspace_swipe_forever            = true,  -- Allows continuous swiping through all workspaces
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

