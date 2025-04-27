return {
  "github/copilot.vim",
  config = function()
    -- Disable default `<Tab>` mapping
    vim.g.copilot_no_tab_map = true

    -- Set up a custom keybinding to accept Copilot suggestions
    vim.api.nvim_set_keymap("i", "•", 'copilot#Accept("<CR>")', { expr = true, silent = true })

    -- Enable or disable Copilot for specific filetypes
    vim.g.copilot_filetypes = {
      ["*"] = true,       -- Enable for all filetypes by default
      ["markdown"] = false, -- Disable for Markdown files
      ["text"] = false,     -- Disable for plain text files
    }
  end,
}

