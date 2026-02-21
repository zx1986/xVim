-- Vim Options (ported from vimrc.bootstrap and vimrc.local)

local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Fix backspace indent
opt.backspace = { "indent", "eol", "start" }

-- Tabs and indentation
opt.tabstop = 4
opt.softtabstop = 0
opt.shiftwidth = 4
opt.expandtab = true

-- Line numbers
opt.number = true
opt.cursorline = true
opt.cursorcolumn = true

-- Search settings
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- File formats
opt.fileformats = { "unix", "dos", "mac" }

-- Shell
if vim.env.SHELL then
  opt.shell = vim.env.SHELL
else
  opt.shell = "/bin/sh"
end

-- UI settings
opt.showcmd = true
opt.wildmenu = true
opt.mouse = "c"  -- Disable mouse clicks (as per vimrc.local)
opt.clipboard = ""  -- Don't use system clipboard (as per vimrc.local)

-- Visual settings
opt.ruler = true
opt.laststatus = 2
opt.termguicolors = true
opt.background = "dark"

-- List characters
opt.list = true
opt.listchars = {
  trail = "·",
  precedes = "«",
  extends = "»",
  tab = "▸ ",
  eol = "↲",
}

-- Visual bell
opt.errorbells = false
opt.visualbell = true

-- Buffers
opt.hidden = true

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Update time
opt.updatetime = 300

-- Sign column
opt.signcolumn = "yes"

-- Command height
opt.cmdheight = 2

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Session management
vim.g.session_directory = "~/.config/nvim/session"
vim.g.session_autoload = "no"
vim.g.session_autosave = "no"
vim.g.session_command_aliases = 1

-- Disable providers we don't use
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
