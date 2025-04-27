-- Autocommands are used to execute specific actions automatically in response to events like opening files,
-- saving files, or switching buffers.
-- Define Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Highlight text on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",  -- Remove trailing spaces
})

-- Set specific options for Markdown files
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.wrap = false        -- Enable line wrapping
    vim.opt.spell = true       -- Enable spell checking
  end,
})

-- Reload files automatically if changed outside Neovim
autocmd("FocusGained", {
  command = "checktime",
})

-- Automatically create parent directories on save
autocmd("BufWritePre", {
  callback = function()
    local filepath = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(filepath) == 0 then
      vim.fn.mkdir(filepath, "p")
    end
  end,
})

-- Open help files in a vertical split for better visibility
autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",  -- Open help files in a vertical split
})

