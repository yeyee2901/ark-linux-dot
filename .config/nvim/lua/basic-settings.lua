-- BASIC SETTINGS -----------------------------------------------
local my_options = {
  encoding = 'utf8',
  number = true,
  clipboard = 'unnamedplus', -- Requires xclip (apt)
  mouse = 'a',
  swapfile = false,
  tabstop = 4, -- Default
  softtabstop = 4, -- Default
  shiftwidth = 4, -- Default
  expandtab = true, -- tab turns into spaces
  smartindent = true,
  smarttab = true,
  wrap = false,
  ignorecase = true, -- ignore case for search commands
  timeout = true, -- set keystroke timeout to be longer
  timeoutlen = 2000, -- in this case 2 seconds (pardon, I have slow hand sickness)
  updatetime = 1000,
  hlsearch = false, -- Toggle with <S-h>
  hidden = true,
  termguicolors = true,
  cursorline = true,
  inccommand = 'split',
  signcolumn = 'yes',
  colorcolumn = '0', -- disable color column
  lazyredraw = true,
  splitbelow = true,
  splitright = true,
  laststatus = 3,     -- 3 = global, 2 = each window
}

-- Allow Lua syntax in vimscripts ('l' as in lua)
vim.g.vimsyn_embed = 'l'

vim.cmd 'filetype indent plugin on'
vim.cmd 'syntax on'

-- set all options
for option, value in pairs(my_options) do
  vim.opt[option] = value
end
