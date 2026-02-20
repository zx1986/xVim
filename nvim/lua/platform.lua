-- Platform detection module
-- Usage: local platform = require("platform")

local M = {}

M.is_macos   = vim.fn.has("mac") == 1
M.is_linux   = vim.fn.has("unix") == 1 and not M.is_macos
-- Set NVIM_OFFLINE=1 in environment to activate offline mode (e.g. Ubuntu offline install)
M.is_offline = os.getenv("NVIM_OFFLINE") == "1"

return M
