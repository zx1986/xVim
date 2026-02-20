-- Vim Options (macOS version)

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
opt.mouse = "c"  -- Disable mouse clicks

-- macOS clipboard: use system clipboard via pbcopy/pbpaste
opt.clipboard = "unnamed"

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

-- macOS: enable providers (installed via brew/pip/gem/npm)
-- Python3: pip3 install pynvim
-- Node:    npm install -g neovim
-- Ruby:    gem install neovim
-- (do NOT set loaded_*_provider = 0 here — leave for brew to resolve)
