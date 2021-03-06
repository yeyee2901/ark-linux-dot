--  _   _   _____    ___   __     __  ___   __  __
-- | \ | | | ____|  / _ \  \ \   / / |_ _| |  \/  |
-- |  \| | |  _|   | | | |  \ \ / /   | |  | |\/| |
-- | |\  | | |___  | |_| |   \ V /    | |  | |  | |
-- |_| \_| |_____|  \___/     \_/    |___| |_|  |_|
--

-- SECTION: BASIC SETTINGS
require 'basic-settings'

-- SECTION: KEYMAPS
require 'keymaps'

-- SECTION: IDE experience
require 'dayum.ide'

-- SECTION: PLUGINS
require 'dayum.plugins'

-- SECTION: UI
require 'dayum.theme'

vim.cmd [[source $HOME/.config/nvim/autocmd.vim]]

-- SECTION: GLOBALS
require 'my-globals'
