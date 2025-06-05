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
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('poimandres')
    end
  },

  -- Стартовый экран
  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },

  -- Поиск
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
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

  -- LSP Base
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
      {'nvimtools/none-ls.nvim'}, -- Объединенная конфигурация
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.preset('recommended')
      
      -- Настройка LSP
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      -- Настройка none-ls
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.cppcheck.with({
            extra_args = { '--enable=warning,style,performance,portability' },
          }),
        },
      })

      -- Автодополнение
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({select = true}),
        }),
      })

      -- Настройка серверов LSP
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {'lua_ls', 'clangd'},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = {'vim'}
                  }
                }
              }
            })
          end,
        }
      })
    end
  },

  -- UI
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'poimandres' }
      })
    end
  },

  -- Автопарные скобки
  {
    'windwp/nvim-autopairs',
    config = true
  },

  -- Табы буферов
  {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
    "genzyy/embark-lua.nvim",
    name = "embark",
  },
})
