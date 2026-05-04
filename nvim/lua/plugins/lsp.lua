-- LSP and completion configuration (macOS)

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- lspconfig will be loaded later with pcall for proper error handling
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic signs
      local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- LSP keybindings
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
      end

      -- Language server configurations
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        },
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        -- TypeScript/JavaScript (ts_ls replaces deprecated tsserver in nvim 0.11+)
        ts_ls = {
          settings = {},
        },
        -- HTML/CSS/JSON
        html = {},
        cssls = {},
        jsonls = {},
        -- PHP
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000,
              },
            },
          },
        },
        -- Ruby
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
            },
          },
        },
        -- YAML (with Kubernetes schema support)
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = "*.yaml",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
              },
              validate = true,
              completion = true,
              hover = true,
            },
          },
        },
        -- Terraform
        terraformls = {},
      }

      -- Setup LSP servers
      -- Neovim 0.11+ uses vim.lsp.config instead of the deprecated lspconfig framework
      if vim.lsp.config then
        -- New API (nvim 0.11+)
        for server_name, server_config in pairs(servers) do
          vim.lsp.config(server_name, vim.tbl_deep_extend('force', {
            capabilities = capabilities,
            on_attach = on_attach,
          }, server_config))
        end
        vim.lsp.enable(vim.tbl_keys(servers))
      else
        -- Fallback for older Neovim versions
        local lspconfig = require('lspconfig')
        for server_name, server_config in pairs(servers) do
          lspconfig[server_name].setup(vim.tbl_deep_extend('force', {
            capabilities = capabilities,
            on_attach = on_attach,
          }, server_config))
        end
      end
    end,
  },

  -- Mason: LSP server manager
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "gopls",
          "ts_ls",  -- Changed from tsserver (deprecated in nvim 0.11+)
          "html",
          "cssls",
          "jsonls",
          "intelephense",
          "solargraph",
          "yamlls",
          "terraformls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Auto-completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Command-line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Search completion
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  -- CMP sources
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },

  {
    "hrsh7th/cmp-buffer",
    lazy = true,
  },

  {
    "hrsh7th/cmp-path",
    lazy = true,
  },

  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Load custom snippets from snippets directory if exists
      local snippets_path = vim.fn.stdpath("config") .. "/../../../snippets"
      if vim.fn.isdirectory(snippets_path) == 1 then
        require("luasnip.loaders.from_snipmate").lazy_load({ paths = { snippets_path } })
      end
    end,
  },

  {
    "saadparwaiz1/cmp_luasnip",
    lazy = true,
  },

  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- nvim-treesitter removed the 'nvim-treesitter.configs' module in newer versions.
      -- Use pcall to support both old and new API.
      local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts_configs.setup({
          ensure_installed = {
            "lua", "vim", "python", "javascript", "typescript",
            "go", "ruby", "php", "html", "css", "json", "yaml",
            "bash", "markdown",
          },
          sync_install = false,
          auto_install = true,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
        })
      else
        -- New nvim-treesitter API (v1.0+): enable highlight per buffer if parser exists
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
          callback = function()
            pcall(vim.treesitter.start)
          end,
        })
      end
    end,
  },
}
