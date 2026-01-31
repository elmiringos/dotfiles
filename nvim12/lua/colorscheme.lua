-- Load gruvbox.nvim safely
local status_ok, gruvbox = pcall(require, "gruvbox")
if status_ok then
  gruvbox.setup({
   contrast = "soft",
    transparent_mode = false,
    dim_inactive = true,

    bold = false,
    italic = {
      comments = true,
      strings = false,
    },

    palette_overrides = {},
  })

  vim.opt.background = "dark"
  vim.cmd.colorscheme("gruvbox")
else
  vim.cmd.colorscheme("evening")
  vim.opt.background = "dark"
end

local muted_fg = "#bdae93"
local muted_gray = "#7c6f64"

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end


hl("@keyword",      { fg = muted_gray })
hl("@keyword.function", { fg = muted_gray })
hl("@keyword.return",   { fg = muted_gray })

hl("@function",     { fg = muted_fg })
hl("@function.call",{ fg = muted_fg })

hl("@variable",     { fg = muted_fg })
hl("@variable.builtin", { fg = muted_gray })

hl("@string",       { fg = muted_fg })
hl("@number",       { fg = muted_fg })
hl("@boolean",      { fg = muted_fg })

hl("@constant",     { fg = muted_fg })
hl("@field",        { fg = muted_fg })
hl("@property",     { fg = muted_fg })

hl("@operator",     { fg = muted_gray })
hl("@punctuation",  { fg = muted_gray })
hl("@punctuation.bracket", { fg = muted_gray })

