-- Core plugins (ported from vimrc.bootstrap and vimrc.local.bundles)

return {
  -- File explorer
  {
    "scrooloose/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<F2>", ":NERDTreeFind<CR>", desc = "NERDTree Find", silent = true },
      { "<F3>", ":NERDTreeToggle<CR>", desc = "NERDTree Toggle", silent = true },
    },
    config = function()
      vim.g.NERDTreeChDirMode = 2
      vim.g.NERDTreeIgnore = {
        "node_modules",
        "\\.rbc$",
        "\\~$",
        "\\.pyc$",
        "\\.db$",
        "\\.sqlite$",
        "__pycache__",
      }
      vim.g.NERDTreeSortOrder = { "^__\\.py$", "\\/$", "*", "\\.swp$", "\\.bak$", "\\~$" }
      vim.g.NERDTreeShowBookmarks = 1
      vim.g.nerdtree_tabs_focus_on_files = 1
      vim.g.NERDTreeMapOpenInTabSilent = "<RightMouse>"
      vim.g.NERDTreeWinSize = 50
    end,
  },

  -- NERDTree tabs
  {
    "jistr/vim-nerdtree-tabs",
    dependencies = { "scrooloose/nerdtree" },
    lazy = false,
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gwrite", "Gread", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
    keys = {
      { "<leader>ga", ":Gwrite<CR>", desc = "Git add", silent = true },
      { "<leader>gc", ":Git commit --verbose<CR>", desc = "Git commit", silent = true },
      { "<leader>gsh", ":Git push<CR>", desc = "Git push", silent = true },
      { "<leader>gll", ":Git pull<CR>", desc = "Git pull", silent = true },
      { "<leader>gs", ":Git<CR>", desc = "Git status", silent = true },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame", silent = true },
      { "<leader>gd", ":Gvdiffsplit<CR>", desc = "Git diff", silent = true },
      { "<leader>gr", ":GRemove<CR>", desc = "Git remove", silent = true },
      { "<leader>o", ":.Gbrowse<CR>", desc = "Open on GitHub", silent = true },
    },
  },

  -- GitHub integration
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
    lazy = true,
  },

  -- Git gutter
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Commenting
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Toggle comment" },
    },
  },

  -- Surround
  {
    "tpope/vim-surround",
    keys = {
      { "ys", mode = "n" },
      { "cs", mode = "n" },
      { "ds", mode = "n" },
      { "S", mode = "v" },
    },
  },

  -- Auto pairs
  {
    "Raimondi/delimitMate",
    event = "InsertEnter",
  },

  -- Fuzzy finder
  {
    "junegunn/fzf",
    build = "./install --bin",
  },

  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<C-p>", ":Files<CR>", desc = "FZF Files", silent = true },
      { "<leader>b", ":Buffers<CR>", desc = "FZF Buffers", silent = true },
      { "<leader>e", ":Files<CR>", desc = "FZF Files", silent = true },
      { "<leader>y", ":History:<CR>", desc = "FZF Command History", silent = true },
    },
    config = function()
      vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
      vim.opt.wildmode = { "list:longest", "list:full" }
      vim.opt.wildignore:append({ "*.o", "*.obj", ".git", "*.rbc", "*.pyc", "__pycache__" })
    end,
  },

  -- FZF Lua (alternative)
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "FZF Lua Files" },
    },
  },

  -- Grep tool
  {
    "vim-scripts/grep.vim",
    cmd = "Rgrep",
    keys = {
      { "<leader>f", ":Rgrep<CR>", desc = "Grep search", silent = true },
    },
    config = function()
      vim.g.Grep_Default_Options = "-IR"
      vim.g.Grep_Skip_Files = "*.log *.db"
      vim.g.Grep_Skip_Dirs = ".git node_modules"
    end,
  },

  -- Session management
  {
    "xolox/vim-session",
    dependencies = { "xolox/vim-misc" },
    keys = {
      { "<leader>so", ":OpenSession ", desc = "Open session" },
      { "<leader>ss", ":SaveSession ", desc = "Save session" },
      { "<leader>sd", ":DeleteSession<CR>", desc = "Delete session" },
      { "<leader>sc", ":CloseSession<CR>", desc = "Close session" },
    },
  },

  {
    "xolox/vim-misc",
    lazy = true,
  },

  -- Tagbar
  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
    keys = {
      { "<F4>", ":TagbarToggle<CR>", desc = "Toggle Tagbar", silent = true },
    },
    config = function()
      vim.g.tagbar_autofocus = 1
    end,
  },

  -- Easy align
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "v" }, desc = "Easy align" },
    },
  },

  -- Easy motion
  {
    "easymotion/vim-easymotion",
    keys = {
      { "<leader><leader>", mode = { "n", "v" }, desc = "EasyMotion" },
    },
  },

  -- Multiple cursors
  {
    "terryma/vim-multiple-cursors",
    keys = {
      { "<C-n>", mode = { "n", "v" }, desc = "Multiple cursors" },
    },
  },

  -- Tabular
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- EditorConfig
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- SplitJoin
  {
    "AndrewRadev/splitjoin.vim",
    keys = {
      { "gS", desc = "Split" },
      { "gJ", desc = "Join" },
    },
  },
}
