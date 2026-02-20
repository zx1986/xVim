-- Auto commands (ported from vimrc.bootstrap)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Syntax sync from start
augroup("vimrc_sync_fromstart", { clear = true })
autocmd("BufEnter", {
  group = "vimrc_sync_fromstart",
  pattern = "*",
  command = "syntax sync maxlines=200",
})

-- Remember cursor position
augroup("vimrc_remember_cursor_position", { clear = true })
autocmd("BufReadPost", {
  group = "vimrc_remember_cursor_position",
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Text file wrapping
augroup("vimrc_wrapping", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "vimrc_wrapping",
  pattern = "*.txt",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.wrapmargin = 2
    vim.opt_local.textwidth = 79
  end,
})

-- Makefile: use tabs
augroup("vimrc_make_cmake", { clear = true })
autocmd("FileType", {
  group = "vimrc_make_cmake",
  pattern = "make",
  command = "setlocal noexpandtab",
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = "vimrc_make_cmake",
  pattern = "CMakeLists.txt",
  command = "setlocal filetype=cmake",
})

-- Auto read files when changed outside
vim.opt.autoread = true

-- Language-specific indentation
augroup("filetype_indentation", { clear = true })

-- HTML: 2 spaces
autocmd("FileType", {
  group = "filetype_indentation",
  pattern = "html",
  command = "setlocal ts=2 sw=2 expandtab",
})

-- JavaScript: 4 spaces
autocmd("FileType", {
  group = "filetype_indentation",
  pattern = "javascript",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4",
})

-- Python: 4 spaces, colorcolumn at 119
autocmd("FileType", {
  group = "filetype_indentation",
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 8
    vim.opt_local.colorcolumn = "119"
    vim.opt_local.softtabstop = 4
  end,
})

-- Ruby: 2 spaces
autocmd("FileType", {
  group = "filetype_indentation",
  pattern = "ruby",
  command = "setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2",
})

-- Go: tabs, no expand
autocmd("FileType", {
  group = "filetype_indentation",
  pattern = "go",
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4",
})

-- Highlight on yank
augroup("highlight_yank", { clear = true })
autocmd("TextYankPost", {
  group = "highlight_yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
