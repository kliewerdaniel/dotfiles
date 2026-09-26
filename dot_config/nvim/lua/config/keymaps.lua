-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fallback for terminals that drop/mangle the Escape key (CSI-timeout issue).
--
-- Why this works: the terminal emulator cannot fix a key it never receives, so
-- the reliable trick is to remap a key that *does* arrive intact. Ctrl-[ is
-- safe to claim because a control key nobody types intentionally is a free
-- slot, and it is the literal ASCII Escape character -- it still emits a real
-- ESC byte, it just skips the keycode-decoding step that goes wrong.
vim.keymap.set("i", "<C-[>", "<Esc>", { desc = "Escape (terminal fallback)" })
