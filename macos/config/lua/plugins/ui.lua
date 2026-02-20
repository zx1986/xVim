-- UI plugins (ported from vimrc configuration)

return {
  -- Colorscheme: Gruvbox
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
      -- Transparent background (from vimrc.local)
      vim.cmd([[hi Normal ctermbg=none]])
    end,
  },

  -- Alternative colorscheme: Nord
  {
    "arcticicestudio/nord-vim",
    lazy = true,
  },

  -- Alternative colorscheme: Solarized
  {
    "altercation/vim-colors-solarized",
    lazy = true,
  },

  -- Status line: Airline
  {
    "vim-airline/vim-airline",
    lazy = false,
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_theme = "powerlineish"
      vim.g["airline#extensions#branch#enabled"] = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tagbar#enabled"] = 1
      vim.g.airline_skip_empty_sections = 1

      -- Powerline symbols
      if not vim.g.airline_powerline_fonts then
        vim.g["airline#extensions#tabline#left_sep"] = " "
        vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
        vim.g.airline_left_sep = "▶"
        vim.g.airline_left_alt_sep = "»"
        vim.g.airline_right_sep = "◀"
        vim.g.airline_right_alt_sep = "«"
      else
        vim.g["airline#extensions#tabline#left_sep"] = ""
        vim.g["airline#extensions#tabline#left_alt_sep"] = ""
        vim.g.airline_left_sep = ""
        vim.g.airline_left_alt_sep = ""
        vim.g.airline_right_sep = ""
        vim.g.airline_right_alt_sep = ""
      end

      -- Airline symbols
      if not vim.g.airline_symbols then
        vim.g.airline_symbols = {}
      end
      vim.g.airline_symbols.branch = "⎇"
      vim.g.airline_symbols.readonly = "⊘"
      vim.g.airline_symbols.linenr = "␊"
    end,
  },

  {
    "vim-airline/vim-airline-themes",
    lazy = true,
  },

  -- Indent line
  {
    "Yggdroot/indentLine",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.indentLine_enabled = 1
      vim.g.indentLine_concealcursor = ""
      vim.g.indentLine_char = "┆"
      vim.g.indentLine_faster = 1
    end,
  },

  -- Dev icons
  {
    "ryanoasis/vim-devicons",
    lazy = false,
  },

  -- Color highlighter
  {
    "gko/vim-coloresque",
    ft = { "css", "scss", "html", "javascript", "typescript", "vue" },
  },

  -- CSApprox
  {
    "vim-scripts/CSApprox",
    lazy = true,
  },
}
