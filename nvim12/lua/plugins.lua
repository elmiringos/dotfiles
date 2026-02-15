vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/ishan9299/nvim-solarized-lua" },
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/refractalize/oil-git-status.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua", rev = "7e53aeb" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
})

vim.cmd.packadd("nvim-treesitter")
vim.cmd.packadd("nvim-treesitter-textobjects")

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
    "typst",
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

-- Textobjects setup (new API)
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

-- Textobjects keymaps
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

-- Select textobjects
vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end)

-- Move to next/previous
vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end)


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
      ["!"] = "i",
    },
    working_tree = {
      ["!"] = "i",
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

-- Typst Preview Configuration
require("typst-preview").setup({})
