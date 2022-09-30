" Highlight after yanking
augroup Yanking
  autocmd!
  autocmd TextYankPost * lua require("vim.highlight").on_yank({timeout = 300, on_visual = false})
augroup END

" C Like files
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

" For protobuf
augroup ProtobufGroup
  autocmd!
  autocmd FileType proto set tabstop=2
  autocmd FileType proto set softtabstop=2
  autocmd FileType proto set shiftwidth=2
augroup END

augroup FlutterGroup
  autocmd!
  autocmd FileType dart set tabstop=2
  autocmd FileType dart set softtabstop=2
  autocmd FileType dart set shiftwidth=2
augroup END
