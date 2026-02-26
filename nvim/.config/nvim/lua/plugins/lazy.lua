
-- ~/.config/nvim/lua/plugins/lazy.lua
-- Установка и загрузка всех плагинов

-- Автоустановка lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- ==========================================
  -- Тема оформления
  -- ==========================================
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,   -- Загрузить первым
    config = function()
      require('catppuccin').setup({ flavour = 'mocha' })
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -- ==========================================
  -- Файловый менеджер
  -- ==========================================
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        window = { width = 30 },
        filesystem = {
          filtered_items = {
            visible = true,        -- Показывать скрытые файлы
            hide_dotfiles = false,
          },
        },
      })
    end,
  },

  -- ==========================================
  -- Терминал
  -- ==========================================
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        size = 15,
        open_mapping = [[<C-`>]],  -- Ctrl + ` для открытия/закрытия
        direction = 'horizontal',   -- horizontal, vertical, tab, float
        shade_terminals = true,
      })
    end,
  },

  -- ==========================================
  -- Строка состояния
  -- ==========================================
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin' },
      })
    end,
  },

  -- ==========================================
  -- Fuzzy finder (поиск файлов и текста)
  -- ==========================================
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Нативный сортировщик (быстрее, нужен make и gcc)
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = 'horizontal',
          file_ignore_patterns = { 'node_modules', '.git/' },
        },
      })
      require('telescope').load_extension('fzf')
    end,
  },

  -- ==========================================
  -- Подсветка синтаксиса (Treesitter)
  -- ==========================================
    {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'lua', 'python', 'javascript', 'typescript',
          'rust', 'go', 'html', 'css', 'json', 'markdown',
          'cpp', 'c'
        },
        highlight    = { enable = true },
        indent       = { enable = true },
        auto_install = true,
      })
    end,
  },

  -- ==========================================
  -- LSP
  -- ==========================================
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',        -- Lua
          'pyright',       -- Python
          'ts_ls',         -- TypeScript / JavaScript
          'rust_analyzer', -- Rust
          'clangd',           -- C++
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        },
      })
    end,
  },

  -- ==========================================
  -- Автодополнение
  -- ==========================================
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',    -- Источник: LSP
      'hrsh7th/cmp-buffer',      -- Источник: текст в буфере
      'hrsh7th/cmp-path',        -- Источник: пути к файлам
      'L3MON4D3/LuaSnip',        -- Снипеты
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp     = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
          ['<Tab>']     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },

  -- ==========================================
  -- Git интеграция
  -- ==========================================
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          map('n', ']c', gs.next_hunk,               'След. изменение')
          map('n', '[c', gs.prev_hunk,               'Пред. изменение')
          map('n', '<leader>hs', gs.stage_hunk,      'Stage hunk')
          map('n', '<leader>hr', gs.reset_hunk,      'Reset hunk')
          map('n', '<leader>hp', gs.preview_hunk,    'Просмотр изменения')
          map('n', '<leader>hb', gs.blame_line,      'Git blame')
        end,
      })
    end,
  },

  -- ==========================================
  -- Автозакрытие скобок и кавычек
  -- ==========================================
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  -- ==========================================
  -- Комментарии (gcc — строка, gc — выделение)
  -- ==========================================
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  -- ==========================================
  -- Подсветка отступов
  -- ==========================================
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = true,
  },

  -- ==========================================
  -- Подсветка цветов (#fff, rgb(), hsl())
  -- ==========================================
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- ==========================================
  -- Которые клавиши (подсказки)
  -- ==========================================
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = true,
  },

}, {
  -- Настройки lazy.nvim
  ui = { border = 'rounded' },
  checker = { enabled = true },  -- Проверять обновления
})
