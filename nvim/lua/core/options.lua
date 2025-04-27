-- General options
vim.opt.ruler = true           -- Show col and row nbrs in the bottom right
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4            -- Tab width
vim.opt.shiftwidth = 4         -- Indentation width
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Smart indentation
vim.opt.wrap = false           -- Disable line wrapping
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below the cursor
vim.opt.sidescrolloff = 8      -- Horizontal scrolling padding
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard (same register as the one used by the system)
vim.opt.splitright = true      -- Open vertical splits to the right
vim.opt.splitbelow = true      -- Open horizontal splits below
vim.opt.termguicolors = true   -- Enable true colors
vim.opt.ignorecase = true      -- Ignore case in search
vim.opt.smartcase = true       -- Smart case-sensitive search
vim.opt.hlsearch = true        -- Disable search highlight
vim.opt.incsearch = true       -- Incremental search
vim.opt.backup = false         -- Disable backup files
vim.opt.swapfile = false       -- Disable swap files
vim.opt.undodir = vim.fn.stdpath('cache') .. "/undo"
vim.opt.undofile = true        -- Enable persistent undo
vim.opt.updatetime = 300       -- Faster completion

