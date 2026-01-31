vim.pack.add({
  { src = "lewis6991/gitsigns.nvim" },
  { src = "mason-org/mason.nvim" },
  { src = "neovim/nvim-lspconfig" },
  { src = "williamboman/mason-lspconfig.nvim" },
  { src = "nvim-treesitter/nvim-treesitter" },
  { src = "nvim-lualine/lualine.nvim" },
  { src = "maxmx03/solarized.nvim" },
  { src = "ellisonleao/gruvbox.nvim" },
  { src = "stevearc/oil.nvim" },
  { src = "ibhagwan/fzf-lua", rev = "7e53aeb" },
  { src = "sphamba/smear-cursor.nvim" },
})

require("mason").setup({})
require("gitsigns").setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,
})


require('nvim-treesitter').setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "python",
    "javascript",
    "typescript",
    "rust",
    "go",
    "html",
    "css",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "bash",
    "sql",
    "fish",
    "git_config",
    "gitignore",
  },

  auto_install = true,

  highlight = {
    enable = true,

    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  indent = {
    enable = true,
    disable = { "python" },
  },
})

require("lualine").setup({
  options = {
    theme = "gruvbox",
    icons_enabled = false,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
  },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

-- FZF Configuration
require('fzf-lua').setup({
  winopts = {
    height = 0.9,
    width = 0.9,
    preview = {
      delay = 100
    },
  },
  fzf_colors = {
    ['fg']      = { 'fg', 'CursorLine' },
    ['bg']      = { 'bg', 'Normal' },
    ['hl']      = { 'fg', 'Comment' },
    ['fg+']     = { 'fg', 'Normal' },
    ['bg+']     = { 'bg', 'CursorLine' },
    ['hl+']     = { 'fg', 'Statement' },
    ['info']    = { 'fg', 'PreProc' },
    ['prompt']  = { 'fg', 'Conditional' },
    ['pointer'] = { 'fg', 'Exception' },
    ['marker']  = { 'fg', 'Keyword' },
    ['spinner'] = { 'fg', 'Label' },
    ['header']  = { 'fg', 'Comment' },
    ['gutter']  = { 'bg', 'Normal' },
  }
})

-- Smear Cursor Configuration
require("smear_cursor").setup({
  stiffness = 0.8,
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,
  smear_insert_mode = true,
  legacy_computing_symbols_support = false,
})
