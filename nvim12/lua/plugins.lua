vim.pack.add({
  { src = "lewis6991/gitsigns.nvim" },
  { src = "mason-org/mason.nvim" },
  { src = "neovim/nvim-lspconfig" },
  { src = "williamboman/mason-lspconfig.nvim" },
  { src = "nvim-treesitter/nvim-treesitter" },
  { src = "nvim-lualine/lualine.nvim" },
  { src = "https://github.com/ishan9299/nvim-solarized-lua" },
  { src = "ellisonleao/gruvbox.nvim" },
  { src = "stevearc/oil.nvim" },
  { src = "refractalize/oil-git-status.nvim" },
  { src = "ibhagwan/fzf-lua", rev = "7e53aeb" },
  { src = "sphamba/smear-cursor.nvim" },
})

require("mason").setup({})
require("gitsigns").setup({
  signs = {
    add          = { text = "*" },
    change       = { text = "*" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signs_staged = {
    add          = { text = "+" },
    change       = { text = "+" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true,
})


require("nvim-treesitter").setup({
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

-- define a simple flat theme
local flat_theme = {
  normal = {
    a = { fg = "#ffffff", bg = "#000000" },
    b = { fg = "#ffffff", bg = "#000000" },
    c = { fg = "#ffffff", bg = "#000000" },
  },
  insert = {
    a = { fg = "#ffffff", bg = "#000000" },
    b = { fg = "#ffffff", bg = "#000000" },
    c = { fg = "#ffffff", bg = "#000000" },
  },
  visual = {
    a = { fg = "#ffffff", bg = "#000000" },
    b = { fg = "#ffffff", bg = "#000000" },
    c = { fg = "#ffffff", bg = "#000000" },
  },
  replace = {
    a = { fg = "#ffffff", bg = "#000000" },
    b = { fg = "#ffffff", bg = "#000000" },
    c = { fg = "#ffffff", bg = "#000000" },
  },
  inactive = {
    a = { fg = "#777777", bg = "#000000" },
    b = { fg = "#777777", bg = "#000000" },
    c = { fg = "#777777", bg = "#000000" },
  }
}

require("lualine").setup({
  options = {
    theme = flat_theme,
    icons_enabled = false,
    component_separators = "",
    section_separators = "",
  },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  win_options = {
    signcolumn = "yes:2",
  },
})

require("oil-git-status").setup({
  symbols = {
    index = {
      ["!"] = "",
    },
    working_tree = {
      ["!"] = "",
    },
  },
})

-- FZF Configuration
require("fzf-lua").setup(
  {
    winopts = {
      height = 0.9,
      width = 0.9,
      preview = {
        delay = 100
      },
    },

    fzf_colors = true,  -- Auto-generate from Neovim colorscheme
  }
)

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
