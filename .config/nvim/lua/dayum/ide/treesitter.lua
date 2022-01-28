require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'lua',
    'bash',
    'cpp',
    'c',
    'rust',
    'go',
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'php',
    'python',
    'vim',
    'toml',
    'json',
    'query',
    'jsdoc',
    'latex',
    'comment',
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    enable = true,
    disable = { 'lua' },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
    disable = {
      'python',
      'javascript',
      'typescript',
      'html',
      'css',
      'javascriptreact',
      'typescriptreact',
      'go'
    },
  },
}
