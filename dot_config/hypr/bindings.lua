-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- wtype syntax, learned the hard way (all three verified by exit code):
--   -k takes ONE keysym, never a chord: "wtype -k ctrl+a" -> Unknown key.
--   -M/-m hold and release a MODIFIER: ctrl shift alt super. Passing a
--     modifier to -k fails -> "-k shift" -> Unknown key 'shift'.
--   -M accepts ONLY modifiers, so Escape must be sent with -k, never -M.
-- Select all, one of the two, held together: ctrl first, then shift.
o.bind("SUPER + A", nil, "wtype -M ctrl a -m ctrl")
o.bind("SUPER + SHIFT + A", nil, "wtype -M ctrl a -M shift -m shift -m ctrl")
-- Escape, reachable without the Touch Bar's Esc row. Plain key press.
o.bind("SUPER + E", nil, "wtype -k Escape")

