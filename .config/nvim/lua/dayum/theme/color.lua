local onedarkpro = require("onedarkpro")

onedarkpro.setup({
  -- theme = function(), -- Override with "onedark" or "onelight". Alternatively, don't set the option and the theme will use `vim.o.background` to determine what to load
  colors = {}, -- Override default colors. Can specify colors for "onelight" or "onedark" themes
  hlgroups = {}, -- Override default highlight groups
  plugins = { -- Override which plugins highlight groups are loaded
		native_lsp = true,
		polygot = true,
		treesitter = true,
	},
  styles = {
      strings = "italic", -- Style that is applied to strings
      comments = "NONE", -- Style that is applied to comments
      keywords = "bold", -- Style that is applied to keywords
      functions = "bold", -- Style that is applied to functions
      variables = "NONE", -- Style that is applied to variables
  },
  options = {
      bold = true, -- Use the themes opinionated bold styles?
      italic = true, -- Use the themes opinionated italic styles?
      underline = true, -- Use the themes opinionated underline styles?
      undercurl = false, -- Use the themes opinionated undercurl styles?
      cursorline = true, -- Use cursorline highlighting?
      transparency = true, -- Use a transparent background?
      terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
      window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
  }
})

onedarkpro.load()


-- Additional custom highlighting
vim.cmd [[autocmd BufEnter * highlight TelescopeNormal guibg=NONE]]
vim.cmd [[autocmd BufEnter * highlight Normal guibg=NONE]]
vim.cmd [[highlight NormalFloat guibg=NONE]]
vim.cmd [[autocmd BufEnter,VimEnter,FileType NvimTree highlight NvimTreeFolderIcon guibg=NONE]]
vim.cmd [[autocmd BufEnter,VimEnter,FileType NvimTree highlight NvimTreeNormalNC guibg=NONE]]
