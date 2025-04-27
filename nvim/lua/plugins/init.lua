-- Plugin manager and imports
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "folke/lazy.nvim", lazy = false, priority = 1000 }, -- Lazy.nvim (plugin manager itself)
  { import = "plugins.telescope" },                     -- Fuzzy Finder
  { import = "plugins.ui" },                            -- Color Theme (tokyo-night), customized status
                                                        -- lines (lualine), buffer management (bufferline),
                                                        -- file explorer (nvim-tree)
-- { import = "plugins.git"},                           -- git integration
  { import = "plugins.lazygit"},                        -- git integration
  { import = "plugins.lsp"},                            -- lsp
  { import = "plugins.cmp"},                            -- autocomplete
  { import = "plugins.notify"},                         -- GUI notifications
  { import = "plugins.copilot"},                        -- Github Copilot
--{ import = "plugins.which-key"},                      -- key bindings visualizations
  { import = "plugins.treesitter" },                    -- Treesitter
  { import = "plugins.dap" },                           -- Enable Debugging
  { import = "plugins.vimtex" },                        -- Latex integration
  { import = "plugins.md-preview" },                    -- .md file preview
})
