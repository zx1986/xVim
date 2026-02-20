-- Language-specific plugins

return {
  -- Go
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
    config = function()
      vim.g.go_list_type = "quickfix"
      vim.g.go_fmt_command = "goimports"
      vim.g.go_fmt_fail_silently = 1

      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_space_tab_error = 0
      vim.g.go_highlight_array_whitespace_error = 0
      vim.g.go_highlight_trailing_whitespace_error = 0
      vim.g.go_highlight_extra_types = 1

      -- Key mappings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "<leader>r", "<Plug>(go-run)", opts)
          vim.keymap.set("n", "<leader>t", "<Plug>(go-test)", opts)
          vim.keymap.set("n", "<leader>gt", "<Plug>(go-coverage-toggle)", opts)
          vim.keymap.set("n", "<leader>i", "<Plug>(go-info)", opts)
          vim.keymap.set("n", "<C-g>", ":GoDecls<cr>", opts)
          vim.keymap.set("n", "<leader>dr", ":GoDeclsDir<cr>", opts)
        end,
      })
    end,
  },


  -- Ruby
  {
    "tpope/vim-rails",
    ft = "ruby",
  },

  {
    "tpope/vim-rake",
    ft = "ruby",
  },

  {
    "tpope/vim-projectionist",
    ft = "ruby",
  },

  {
    "thoughtbot/vim-rspec",
    ft = "ruby",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          vim.keymap.set("n", "<Leader>t", ":call RunCurrentSpecFile()<CR>", { silent = true })
          vim.keymap.set("n", "<Leader>s", ":call RunNearestSpec()<CR>", { silent = true })
          vim.keymap.set("n", "<Leader>l", ":call RunLastSpec()<CR>", { silent = true })
          vim.keymap.set("n", "<Leader>a", ":call RunAllSpecs()<CR>", { silent = true })
        end,
      })
    end,
  },

  {
    "ecomba/vim-ruby-refactoring",
    ft = "ruby",
    branch = "main",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          local opts = { silent = true }
          vim.keymap.set("n", "<leader>rap", ":RAddParameter<cr>", opts)
          vim.keymap.set("n", "<leader>rcpc", ":RConvertPostConditional<cr>", opts)
          vim.keymap.set("n", "<leader>rel", ":RExtractLet<cr>", opts)
          vim.keymap.set("v", "<leader>rec", ":RExtractConstant<cr>", opts)
          vim.keymap.set("v", "<leader>relv", ":RExtractLocalVariable<cr>", opts)
          vim.keymap.set("n", "<leader>rit", ":RInlineTemp<cr>", opts)
          vim.keymap.set("v", "<leader>rrlv", ":RRenameLocalVariable<cr>", opts)
          vim.keymap.set("v", "<leader>rriv", ":RRenameInstanceVariable<cr>", opts)
          vim.keymap.set("v", "<leader>rem", ":RExtractMethod<cr>", opts)
        end,
      })
    end,
  },



  -- TypeScript
  {
    "leafgarland/typescript-vim",
    ft = "typescript",
  },

  {
    "HerringtonDarkholme/yats.vim",
    ft = { "typescript", "typescriptreact" },
    config = function()
      vim.g.yats_host_keyword = 1
    end,
  },

  -- JavaScript
  {
    "jelera/vim-javascript-syntax",
    ft = "javascript",
  },

  -- PHP
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev -o",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function()
          local opts = { silent = true }
          vim.keymap.set("n", "<Leader>u", ":call phpactor#UseAdd()<CR>", opts)
          vim.keymap.set("n", "<Leader>mm", ":call phpactor#ContextMenu()<CR>", opts)
          vim.keymap.set("n", "<Leader>nn", ":call phpactor#Navigate()<CR>", opts)
          vim.keymap.set("n", "<Leader>oo", ":call phpactor#GotoDefinition()<CR>", opts)
          vim.keymap.set("n", "<Leader>oh", ":call phpactor#GotoDefinition('hsplit')<CR>", opts)
          vim.keymap.set("n", "<Leader>ov", ":call phpactor#GotoDefinition('vsplit')<CR>", opts)
          vim.keymap.set("n", "<Leader>ot", ":call phpactor#GotoDefinition('tabnew')<CR>", opts)
          vim.keymap.set("n", "<Leader>K", ":call phpactor#Hover()<CR>", opts)
          vim.keymap.set("n", "<Leader>tt", ":call phpactor#Transform()<CR>", opts)
          vim.keymap.set("n", "<Leader>cc", ":call phpactor#ClassNew()<CR>", opts)
          vim.keymap.set("n", "<Leader>ee", ":call phpactor#ExtractExpression(v:false)<CR>", opts)
          vim.keymap.set("v", "<Leader>ee", ":<C-U>call phpactor#ExtractExpression(v:true)<CR>", opts)
          vim.keymap.set("v", "<Leader>em", ":<C-U>call phpactor#ExtractMethod()<CR>", opts)
        end,
      })
    end,
  },

  {
    "stephpy/vim-php-cs-fixer",
    ft = "php",
  },

  -- HTML/CSS
  {
    "hail2u/vim-css3-syntax",
    ft = { "css", "scss" },
  },

  {
    "tpope/vim-haml",
    ft = { "haml", "sass", "scss" },
  },

  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "vue" },
  },

  -- Vue.js
  {
    "posva/vim-vue",
    ft = "vue",
    config = function()
      vim.g.vue_disable_pre_processors = 1
    end,
  },

  {
    "leafOfTree/vim-vue-plugin",
    ft = "vue",
    config = function()
      vim.g.vim_vue_plugin_load_full_syntax = 1
    end,
  },

  -- Ansible
  {
    "pearofducks/ansible-vim",
    ft = "yaml.ansible",
  },

  -- Terraform
  {
    "hashivim/vim-terraform",
    ft = "terraform",
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_remap_spacebar = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  {
    "hashivim/vim-packer",
    ft = "hcl",
  },

  -- Kubernetes
  {
    "andrewstuart/vim-kubernetes",
    ft = "yaml",
  },

  -- Tmux
  {
    "tmux-plugins/vim-tmux",
    ft = "tmux",
  },



  -- Autoformat Rails
  {
    "KurtPreston/vim-autoformat-rails",
    ft = "ruby",
  },

  -- Matchit
  {
    "vim-scripts/matchit.zip",
    event = "VimEnter",
  },

  -- Cheat.sh
  {
    "dbeniamine/cheat.sh-vim",
    cmd = "Cheat",
  },
}
