-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------
require("user_configs.monitors")

---------------------
---- MY PROGRAMS ----
---------------------
require("user_configs.programs")

-------------------
---- AUTOSTART ----
-------------------
require("user_configs.autostart")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
require("user_configs.env")

-----------------------
----- PERMISSIONS -----
-----------------------
require("user_configs.permissions")

-----------------------
---- LOOK AND FEEL ----
-----------------------
require("user_configs.look_and_feel")

----------------
----  MISC  ----
----------------
require("user_configs.misc")

---------------
---- INPUT ----
---------------
require("user_configs.input")

---------------------
---- KEYBINDINGS ----
---------------------
require("user_configs.keybindings")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("user_configs.windows_and_workspaces")
