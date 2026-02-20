-- Key Mappings (ported from vimrc.bootstrap and vimrc.local)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = ","

-- jj to Esc (from vimrc.local)
keymap("i", "jj", "<Esc>", opts)

-- Split windows
keymap("n", "<Leader>h", ":split<CR>", opts)
keymap("n", "<Leader>v", ":vsplit<CR>", opts)

-- Window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)

-- Buffer navigation
keymap("n", "<leader>z", ":bp<CR>", opts)
keymap("n", "<leader>q", ":bp<CR>", opts)
keymap("n", "<leader>x", ":bn<CR>", opts)
keymap("n", "<leader>w", ":bn<CR>", opts)
keymap("n", "<leader>c", ":bd<CR>", opts)

-- Tab navigation
keymap("n", "<Tab>", "gt", opts)
keymap("n", "<S-Tab>", "gT", opts)
keymap("n", "<S-t>", ":tabnew<CR>", opts)

-- Set working directory
keymap("n", "<leader>.", ":lcd %:p:h<CR>", opts)

-- Edit/tab edit with current path
keymap("n", "<Leader>e", ":e <C-R>=expand('%:p:h') . '/' <CR>", { noremap = true })
keymap("n", "<Leader>te", ":tabe <C-R>=expand('%:p:h') . '/' <CR>", { noremap = true })

-- Clean search highlight
keymap("n", "<leader><space>", ":noh<cr>", opts)

-- Maintain Visual Mode after shifting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move visual block
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Search mappings: center on match
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Copy/Paste/Cut
if vim.fn.has("unnamedplus") == 1 then
  vim.opt.clipboard = "unnamed,unnamedplus"
end
keymap("n", "YY", '"+y<CR>', opts)
keymap("n", "<leader>p", '"+gP<CR>', opts)
keymap("n", "XX", '"+x<CR>', opts)

-- Terminal emulation
keymap("n", "<leader>sh", ":terminal<CR>", opts)

-- LSP keymaps (will be set up in LSP config)
-- These are just placeholders, actual bindings in lsp.lua
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "[g", vim.diagnostic.goto_prev, opts)
keymap("n", "]g", vim.diagnostic.goto_next, opts)
