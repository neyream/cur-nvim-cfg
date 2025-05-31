-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Цветовая схема
  {
    'olivercederborg/poimandres.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require('poimandres').setup()
    -- end,
    -- init = function()
    --   vim.cmd("colorscheme poimandres")
    -- end
  },

  {
    "genzyy/embark-lua.nvim",
    name = "embark",
  },
    {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },
  -- Telescope (поиск)
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Файловый менеджер
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },

  -- Комментарии
  {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup({ create_mappings = false })
    end
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    version = 'v1.10.0', -- Добавьте эту строку!
    config = true,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  -- LSP Zero (база)
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false, -- Загружать сразу
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.preset('recommended')
      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'nvimtools/none-ls.nvim',
    }
  },

  -- Автодополнение
  {
    'hrsh7th/nvim-cmp',
    -- event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end
  },

  -- Настройка LSP серверов
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'lua_ls' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  }
                }
              }
            })
          end,
          clangd = function()
            require('lspconfig').clangd.setup({
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--completion-style=detailed",
              }
            })
          end
        }
      })
    end
  },

  -- Улучшения для clangd (C++)
  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    config = function()
      require('clangd_extensions').setup({
        server = {
          capabilities = require('cmp_nvim_lsp').default_capabilities()
        }
      })
    end
  },

  -- Linting и форматирование
  {
    'jose-elias-alvarez/null-ls.nvim',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.cppcheck.with({
            extra_args = { '--enable=warning,style,performance,portability' },
          }),
          null_ls.builtins.formatting.clang_format.with({
            extra_args = { '-style=file' },
          }),
        },
      })
    end
  },

  -- Отладчик (DAP)
  {
    'mfussenegger/nvim-dap',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    config = function()
      local dap = require('dap')

      -- Настройка для C++ (требует lldb)
      dap.adapters.lldb = {
        type = 'executable',
        command = 'codelldb', -- Убедитесь что в PATH
        name = 'codelldb'
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        }
      }

      -- Горячие клавиши
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
      vim.keymap.set('n', '<F10>', dap.step_over)
      vim.keymap.set('n', '<F11>', dap.step_into)
    end
  },

  -- UI для отладчика
  {
    'rcarriga/nvim-dap-ui',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    dependencies = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" },
    config = function()
      require('dapui').setup()
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end
  },

  -- Виртуальный текст для отладки
  {
    'theHamsta/nvim-dap-virtual-text',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  },

  -- Статусбар
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'poimandres'
        }
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    -- event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  }
})
