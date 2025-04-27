-- ALL KEY_BINGING VISUALIZATION CONFIGS ARE DONC IN THE WHICH-KEY.LUA FILE

-- Set the leader key (this is safe to override)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use the modern keymap API
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }  -- Recommended options

-- Import Neovim's default keymaps implicitly
-- (No action needed, defaults remain intact unless overridden)

-- Custom Key Mappings
vim.api.nvim_set_keymap('n', '<Leader>D', '"_D', { noremap = true })


-- Normal Mode
keymap('n', '<leader>h', ':nohlsearch<CR>', opts) -- Clear search highlight

-- Window Navigation
keymap('n', '<C-h>', '<C-w>h', opts)  -- Move to the left window
keymap('n', '<C-j>', '<C-w>j', opts)  -- Move to the window below
keymap('n', '<C-k>', '<C-w>k', opts)  -- Move to the window above
keymap('n', '<C-l>', '<C-w>l', opts)  -- Move to the right window

-- Resize Splits
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Visual Mode
keymap('v', '<', '<gv', opts) -- Indent left and keep selection
keymap('v', '>', '>gv', opts) -- Indent right and keep selection

-- Overwrite Default Keymaps (Optional)
keymap('n', 'Y', 'y$', opts) -- Redefine `Y` to yank till end of line


-- Reload Core Config Dynamically
--vim.keymap.set('n', '<leader>r', require('core.utils').reload_config, { noremap = true, silent = true })

-- Toggle Relative Numbers
vim.keymap.set('n', '<leader>rn', require('core.utils').toggle_relative_number, { noremap = true, silent = true }) -- NOTE: CAUSES CONFLICT

-- Open URL Under Cursor
vim.keymap.set('n', 'gx', require('core.utils').open_url, { noremap = true, silent = true })

-- Code Folding
vim.keymap.set("n", "zR", ":foldopen!<CR>", { noremap = true, silent = true }) -- Open all folds
vim.keymap.set("n", "zM", ":foldclose!<CR>", { noremap = true, silent = true }) -- Close all folds
vim.keymap.set("n", "zr", ":foldopen<CR>", { noremap = true, silent = true }) -- Open one level of folds

--> FOR PLUGINS
-- Telescope keybindings
-- use ":ToggleGitIgnore" to flip state of either respecting the .gitignore and print the state
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)  -- Find files by name
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)   -- Live grep on text (uses ripgrep)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)     -- List open buffers
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)   -- Help tags
keymap("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts) -- Fuzzy find in current buffer
keymap("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", opts)    -- Quickfix list

-- UI keybindings
-- Buffer Navigation and Closing
-- Buffer Navigation and Closing
keymap('n', '<S-l>', ':bnext<CR>', opts)               -- Go to next buffer
keymap('n', '<S-h>', ':bprevious<CR>', opts)           -- Go to previous buffer
keymap("n", "<leader>bc", ":bdelete<CR>", opts)        -- Close buffer
keymap("n", "<leader>bp", ":BufferLinePick<CR>", opts) -- Pick a buffer by its label
-- Toggle Nvim Tree
-- Key	Action
-- a	Add a new file or folder
-- d	Delete the selected file/folder
-- r	Rename the selected file/folder
-- x	Cut a file/folder
-- p	Paste a cut file/folder
-- o or Enter	Open a file/directory
keymap("n", "<leader>to", ":NvimTreeToggle<CR>", opts)   -- Open/close file explorer
keymap("n", "<leader>tr", ":NvimTreeRefresh<CR>", opts)  -- Refresh the tree
keymap("n", "<leader>tn", ":NvimTreeFindFile<CR>", opts) -- Find current file in the tree

-- Git Integration Bindings
keymap("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() require("gitsigns").next_hunk() end)
  return "<Ignore>"
end, { expr = true, noremap = true, silent = true }) -- Go to next Git hunk

keymap("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() require("gitsigns").prev_hunk() end)
  return "<Ignore>"
end, { expr = true, noremap = true, silent = true }) -- Go to previous Git hunk

-- Git hunk actions
keymap("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts) -- Stage the current hunk
keymap("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts) -- Stage selected hunk
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts) -- Reset the current hunk
keymap("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts) -- Reset selected hunk
keymap("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", opts) -- Stage the entire buffer
keymap("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", opts) -- Reset the entire buffer
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts) -- Preview the current hunk
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)   -- Show blame for the current line
keymap("n", "<leader>gtb", ":Gitsigns toggle_current_line_blame<CR>", opts) -- Toggle inline blame
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", opts)     -- Show diff of the current file
keymap("n", "<leader>gD", ":Gitsigns diffthis ~<CR>", opts)   -- Show diff of the last commit
keymap("n", "<leader>gtd", ":Gitsigns toggle_deleted<CR>", opts) -- Toggle showing deleted lines

-- LSP Bindings
vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition
vim.keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- Go to declaration
vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- Go to implementation
vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- Show references
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- Show hover documentation
vim.keymap.set("n", "<leader>lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- Rename symbol
vim.keymap.set("n", "<leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Code actions
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- Previous diagnostic
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- Next diagnostic
vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Show diagnostics in a float
vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) -- Diagnostics to location list

-- Tabulation Settings
-- use ":lua SetIndentation(i)" to set indentation size to i spaces
function SetIndentation(size)
  vim.opt.expandtab = true
  vim.opt.tabstop = size
  vim.opt.shiftwidth = size
  vim.opt.softtabstop = size
  print("Indentation set to " .. size .. " spaces")
end

-- Debugging Bindings
vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true }) -- Continue
vim.keymap.set("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", { noremap = true, silent = true }) -- Step over
vim.keymap.set("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", { noremap = true, silent = true }) -- Step into
vim.keymap.set("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>", { noremap = true, silent = true }) -- Step out
vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true }) -- Toggle breakpoint
vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", { noremap = true, silent = true }) -- Open REPL
vim.keymap.set("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", { noremap = true, silent = true }) -- Run last configuration

-- VimTex keybindings
vim.keymap.set("n", "\\ll", "<cmd>VimtexCompile<CR>", { noremap = true, silent = true }) -- Start/stop compilation vim.keymap.set("n", "\\lv", "<cmd>VimtexView<CR>", { noremap = true, silent = true }) -- Open PDF viewer
vim.keymap.set("n", "\\lk", "<cmd>VimtexStop<CR>", { noremap = true, silent = true }) -- Stop compilation
vim.keymap.set("n", "\\le", "<cmd>VimtexErrors<CR>", { noremap = true, silent = true }) -- Show errors in quickfix
vim.keymap.set("n", "\\lo", "<cmd>VimtexLog<CR>", { noremap = true, silent = true }) -- Show the log file
vim.keymap.set("n", "\\li", "<cmd>VimtexInfo<CR>", { noremap = true, silent = true }) -- Show project info

-- Markdown Preview keybindings
vim.api.nvim_set_keymap('n', '<leader>mp', ':vsp | term w3m http://localhost:3000/1<CR>', { noremap = true, silent = true })
