-- SECTION: GLOBAL VARS
MY_HOME = os.getenv 'HOME'

-- SECTION: SERVER SETTINGS
vim.fn.sign_define(
  'DiagnosticSignError',
  { text = '', texthl = 'DiagnosticSignError', linehl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' }
)

vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })

vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' })

vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' })

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

vim.diagnostic.config {
  signs = true,
  virtual_text = false,
  update_in_insert = true,
  float = {
    border = 'double',
  },
}

-- SECTION: SERVER SETUP
local lspconfig = require 'lspconfig'

-- update LSP capabilities to include nvim-cmp (completion)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.snippetSupport = true

local custom_on_attach = function(client, _)
  -- Better function signature hinting
  require('lsp_signature').on_attach {
    bind = true, -- Mandatory for config
    doc_lines = 5,
    fix_pos = false,
    hint_enable = true,
    hint_prefix = '<> ',
    hint_scheme = 'String',

    hi_parameter = 'Search',
    max_height = 12,
    max_width = 120,
    handler_opts = {
      border = 'double', -- single/double/shadow
    },

    -- The signature floating_window is reaaaallyy big, and i have to
    -- disable it so I can read the completion pop up menu
    floating_window = false,

    -- WARNING: Glepnir is inactive for > 8 months, so there won't be any
    -- bug fixes
    use_lspsaga = false,
  }

  -- highlight words with same context
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup LSP_DOC_HIGHLIGHT
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHold <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

lspconfig.gopls.setup {
  cmd = { '/home/yeyee/go/bin/gopls' },
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.ccls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
  init_options = {
    diagnostics = {
      onOpen = 0,
      onChange = 1,
      onSave = 0,
    },
    index = {
      comments = 1, -- index only doxygen comment markers
      onChange = true, -- force index file to be not on every save
    },
    cache = {
      directory = '', -- have to disable caching, supaya tidak ada data race
    },
  },
}

-- lspconfig.pyright.setup {
--   capabilities = capabilities,
--   on_attach = custom_on_attach,
-- }

-- ALTERNATIVE: (masih coba-coba)
lspconfig.jedi_language_server.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

-- npm i -g vscode-langservers-extracted
-- lspconfig.html.setup {
--   capabilities = capabilities,
--   on_attach = custom_on_attach,
-- }

-- npm i -g intelephense
lspconfig.intelephense.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

-- npm i -g typescript typescript-language-server
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

-- install locally in the project
lspconfig.eslint.setup {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    nodePath = '',
    onIgnoredFiles = 'off',
    packageManager = 'npm',
    quiet = false,
    rulesCustomizations = {},
    run = 'onType',
    useESLintClass = false,
    validate = 'on',
    workingDirectory = {
      mode = 'auto',
    },
  },
}

-- npm i -g bashls
lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
  filetypes = { 'bash', 'zsh', 'sh' },
}

-- npm i -g vim-language-server
lspconfig.vimls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

-- SUMNEKO LUA
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- require('lspconfig').sumneko_lua.setup {
--   on_attach = custom_on_attach,
--   capabilities = capabilities,

--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         globals = { 'vim', 'use' },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
