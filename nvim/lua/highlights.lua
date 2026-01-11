-- Function to remove italic styling from all highlight groups
local function disable_all_italics()
  -- Get all highlight groups
  local highlights = vim.api.nvim_exec2('highlight', { output = true })

  -- Parse and update each highlight group that has italic
  for _, line in ipairs(vim.split(highlights.output, '\n')) do
    local hl_group = line:match('^(%S+)')
    if hl_group and hl_group ~= '' then
      -- Get current highlight definition
      local hl_def = vim.api.nvim_get_hl(0, { name = hl_group })

      -- If it has italic, remove it
      if hl_def.italic then
        hl_def.italic = false
        vim.api.nvim_set_hl(0, hl_group, hl_def)
      end
    end
  end
end

-- Create autocommand to disable italics after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Small delay to ensure colorscheme is fully loaded
    vim.defer_fn(disable_all_italics, 10)
  end,
  desc = "Disable italic styling in all highlight groups"
})

-- Also run on startup to catch the initial colorscheme load
disable_all_italics()

return {
  disable_all_italics = disable_all_italics
}
