local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
local yank_group = augroup('_UserYankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    require('vim.highlight').on_yank {
      timeout = 300,
      on_visual = false,
    }
  end,
})

-- fak yu folding
local folding_group = augroup('_UserFoldingGroup', { clear = true })
autocmd('BufWinEnter', {
  pattern = '*',
  group = folding_group,
  callback = function()
    vim.opt.foldenable = false
    vim.opt.foldmethod = 'manual'
    vim.opt.foldlevelstart = 99
  end,
})

-- INDENTATION AUTOCOMMANDS ----------------------------------
local set_indentation = function(indent)
  vim.opt.tabstop = indent
  vim.opt.softtabstop = indent
  vim.opt.shiftwidth = indent
end

-- C like files
local group_c_files_indent = augroup('_UserCFilesGroup', { clear = true })
autocmd('FileType', {
  group = group_c_files_indent,
  pattern = 'objc,objcpp,lua,php,javascript,typescript,javascriptreact,typescriptreact,html,css',
  callback = function()
    set_indentation(2)
  end,
})

-- Protobuf files untuk gRPC development
local group_protobuf_files_indent = augroup('_UserProtobufGroup', { clear = true })
autocmd('FileType', {
  group = group_protobuf_files_indent,
  pattern = 'proto',
  callback = function()
    set_indentation(2)
  end,
})

-- Dart files untuk flutter development
local group_flutter_files_indent = augroup('_UserFlutterGroup', { clear = true })
autocmd('FileType', {
  group = group_flutter_files_indent,
  pattern = 'dart',
  callback = function()
    set_indentation(2)
  end,
})

-- astro files
local group_astro_files = augroup('_UserAstroGroup', { clear = true })
autocmd('FileType', {
  group = group_astro_files,
  pattern = 'astro',
  callback = function()
    set_indentation(2)
  end
})
