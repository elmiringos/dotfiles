require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "gopls",
    "lua_ls",
    "texlab",
    "rust_analyzer",
    "helm_ls",
    "ts_ls",
    "pyright",
    "clangd",
    "tinymist"
  },
  automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Find references' })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover documentation' })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature help' })

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename symbol' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code actions' })
  vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr, desc = 'Format buffer' })
end

-- Configure bashls (Bash Language Server)
vim.lsp.config.bashls = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Configure gopls (Go Language Server)
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- Configure lua_ls (Lua Language Server)
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git', '.luarc.json', '.luarc.jsonc' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Configure texlab (LaTeX Language Server)
vim.lsp.config.texlab = {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'bib', 'plaintex' },
  root_markers = { '.git', '.latexmkrc' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        onSave = true,
      },
    },
  },
}

-- Configure rust_analyzer (Rust Language Server)
vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
}

-- Configure helm_ls (Helm Language Server)
vim.lsp.config.helm_ls = {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_markers = { 'Chart.yaml', '.git' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Configure ts_ls (TypeScript/JavaScript Language Server)
vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Configure pyright (Python Language Server)
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git', 'pyrightconfig.json' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- Configure clangd (C/C++ Language Server)
vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git', '.clangd' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Enable all LSP servers
vim.lsp.enable({
  "bashls",
  "gopls",
  "lua_ls",
  "texlab",
  "rust_analyzer",
  "helm_ls",
  "ts_ls",
  "pyright",
  "clangd",
  "tinymist"
})

-- Enhanced Diagnostic Configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "ee",
      [vim.diagnostic.severity.WARN]  = "ww",
      [vim.diagnostic.severity.HINT]  = "hh",
      [vim.diagnostic.severity.INFO]  = "ii",
    },
  },
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
