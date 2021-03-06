local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use { 'wbthomason/packer.nvim' }

  -- THEME
  use { 'olimorris/onedarkpro.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'romgrk/barbar.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }

  -- IDE
  use { 'onsails/lspkind-nvim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'romgrk/nvim-treesitter-context' }
  use { 'honza/vim-snippets' }
  use { 'SirVer/ultisnips' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-path' }
  use { 'quangnguyen30192/cmp-nvim-ultisnips' }
  use { 'simrat39/symbols-outline.nvim' }

  use { 'neovim/nvim-lspconfig' }
  use { 'ray-x/lsp_signature.nvim' }

  use { 'nvim-treesitter/playground' }

  -- TELESCOPE
  use { 'nvim-lua/plenary.nvim' }
  use { 'fhill2/telescope-ultisnips.nvim' }

  use { 'nvim-telescope/telescope.nvim' }

  -- STARTIFY
  use { 'mhinz/vim-startify' }

  -- FORMATTER
  use { 'mhartington/formatter.nvim' }

  -- GIT SUPERPOWER
  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim' }

  -- NOTE TAKING
  use {
    'nvim-neorg/neorg',
    config = function()
      require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ['core.defaults'] = {}, -- Load all the default modules
          ['core.keybinds'] = { -- Configure core.keybinds
            config = {
              default_keybinds = true,
              neorg_leader = '<Leader>w',
            },
          },
          ['core.norg.concealer'] = {}, -- Allows for use of icons
          ['core.norg.dirman'] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = '~/neorg',
              },
            },
          },
        },
      }
    end,
    requires = 'nvim-lua/plenary.nvim',
  }

  -- CSS COLOR MARKER
  use {
    'norcalli/nvim-colorizer.lua',
  }

  -- COMMENTARY PLUGIN
  use { 'tpope/vim-commentary' }

  -- BRACKET & SURROUND PLUGIN
  use { 'jiangmiao/auto-pairs' }
  use { 'tpope/vim-surround' }

  -- REMOTE EDITING
  use { 'chipsenkbeil/distant.nvim' }

  -- INDENT BLANKLINE
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- GO utils
  use { 'ray-x/go.nvim' }

  -- TOGGLETERM
  use { 
    'akinsho/toggleterm.nvim',
    lock = true,
  }

  -- NOTIFY
  -- use { 'rcarriga/nvim-notify' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require 'dayum.plugins.activate'
