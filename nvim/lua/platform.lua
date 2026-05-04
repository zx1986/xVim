-- Platform detection module (Simplified for macOS only)
local M = {}

M.is_macos = vim.fn.has("mac") == 1
-- Note: is_linux and is_offline removed as per modernization plan.

return M
