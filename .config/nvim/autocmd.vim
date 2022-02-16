" Highlight after yanking
augroup Yanking
  autocmd!
  autocmd TextYankPost * lua require("vim.highlight").on_yank({timeout = 300, on_visual = false})
augroup END

augroup IndentationGroup
  autocmd!
  autocmd FileType objc,objcpp,lua,php,javascript,typescript,javascriptreact,typescriptreact,html,css set tabstop=2
  autocmd FileType objc,objcpp,lua,php,javascript,typescript,javascriptreact,typescriptreact,html,css set softtabstop=2
  autocmd FileType objc,objcpp,lua,php,javascript,typescript,javascriptreact,typescriptreact,html,css set shiftwidth=2
augroup END

" For c like files, clang formatting insist using 2 spaces
augroup NonCIndent
  autocmd!
augroup END

" Vim wiki
augroup VimWikiGroup
  autocmd!
  autocmd FileType vimwiki set tabstop=2
  autocmd FileType vimwiki set softtabstop=2
  autocmd FileType vimwiki set shiftwidth=2
augroup END

" Color Column for specific filetype
augroup ColorColumnAuto
  autocmd!
  autocmd FileType python set colorcolumn=80
  autocmd FileType vimwiki set colorcolumn=80
  autocmd FileType rust set colorcolumn=80
augroup END
