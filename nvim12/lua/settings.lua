local options = {
  -- Line numbers
  number = true,
  relativenumber = true,

  -- UI
  cursorline = true,
  cursorcolumn = true,
  termguicolors = true,
  signcolumn = "yes",
  mouse = "a",

  -- Tabs and indentation
  expandtab = true,
  tabstop = 4,
  shiftwidth = 2,
  softtabstop = 2,
  smartindent = true,
  smarttab = true,

  -- Search
  ignorecase = true,
  smartcase = true,
  hlsearch = true,
  incsearch = true,

  -- Files
  autoread = true,
  autowrite = true,
  swapfile = false,
  backup = false,
  writebackup = false,
  undofile = true,

  -- Splits
  splitright = true,
  splitbelow = true,

  -- Appearance
  wrap = true,
  scrolloff = 4,

  -- Performance
  updatetime = 300,
  timeoutlen = 500,

  -- Clipboard
  clipboard = "unnamedplus",
}

-- Apply all options
for k, v in pairs(options) do
  vim.opt[k] = v
end
