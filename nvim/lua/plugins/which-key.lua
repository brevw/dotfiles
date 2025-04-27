return { {
    "folke/which-key.nvim",
    dependencies = {
        "echasnovski/mini.icons", -- Add mini.icons as a dependency
    },
    config = function()
        require("mini.icons").setup({})
        local which_key = require("which-key")
        which_key.setup({
            -- Add your configuration options here
            plugins = {
                marks = true,   -- Shows marks in the popup
                registers = true, -- Shows registers in the popup
                spelling = {
                    enabled = true, -- Enables spelling suggestions
                    suggestions = 20, -- Maximum suggestions
                },
            },
            key_labels = {
                ["<space>"] = "SPC",
                ["<cr>"] = "RET",
                ["<tab>"] = "TAB",
            },
            window = {
                border = "rounded", -- None, single, double, rounded
                position = "bottom", -- Bottom or top
                margin = { 1, 0, 1, 0 }, -- Extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- Extra window padding [top, right, bottom, left]
            },
            layout = {
                height = { min = 4, max = 25 }, -- Min and max height of the columns
                width = { min = 20, max = 50 }, -- Min and max width of the columns
                spacing = 3, -- Spacing between columns
                align = "left", -- Align columns (left, center, right)
            },
            ignore_missing = true, -- Ignore missing mappings
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- Hide mappings
            show_help = true, -- Show help message on the command line
            triggers = "auto", -- Automatically setup triggers
        })
        -- Register keybindings
        which_key.register({
            -- General
            ["<leader>w"] = { ":w<CR>", "Save file" },
            ["<leader>q"] = { ":q<CR>", "Quit file" },
            ["<leader>h"] = { ":nohlsearch<CR>", "Clear search highlight" },
            ["<leader>r"] = { require("core.utils").reload_config, "Reload config" },
            ["<leader>rn"] = { require("core.utils").toggle_relative_number, "Toggle relative number" },

            -- Telescope
            f = {
                name = "Find",
                f = { "<cmd>Telescope find_files<CR>", "Find files" },
                g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
                b = { "<cmd>Telescope buffers<CR>", "Buffers" },
                h = { "<cmd>Telescope help_tags<CR>", "Help tags" },
                c = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Find in buffer" },
                q = { "<cmd>Telescope quickfix<CR>", "Quickfix" },
            },

            -- Window Navigation
            ["<C-h>"] = { "<C-w>h", "Move left" },
            ["<C-j>"] = { "<C-w>j", "Move down" },
            ["<C-k>"] = { "<C-w>k", "Move up" },
            ["<C-l>"] = { "<C-w>l", "Move right" },

            -- Resize splits
            ["<C-Up>"] = { ":resize +2<CR>", "Increase height" },
            ["<C-Down>"] = { ":resize -2<CR>", "Decrease height" },
            ["<C-Left>"] = { ":vertical resize -2<CR>", "Decrease width" },
            ["<C-Right>"] = { ":vertical resize +2<CR>", "Increase width" },

            -- Buffers
            b = {
                name = "Buffers",
                c = { ":bdelete<CR>", "Close buffer" },
                p = { ":BufferLinePick<CR>", "Pick buffer" },
            },

            -- Git
            g = {
                name = "Git",
                s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
                r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
                S = { ":Gitsigns stage_buffer<CR>", "Stage buffer" },
                R = { ":Gitsigns reset_buffer<CR>", "Reset buffer" },
                p = { ":Gitsigns preview_hunk<CR>", "Preview hunk" },
                b = { ":Gitsigns blame_line<CR>", "Blame line" },
                tb = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle blame" },
                d = { ":Gitsigns diffthis<CR>", "Diff" },
                D = { ":Gitsigns diffthis ~<CR>", "Diff last commit" },
                td = { ":Gitsigns toggle_deleted<CR>", "Toggle deleted lines" },
            },

            -- LSP
            l = {
                name = "LSP",
                d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
                D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
                i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
                r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
                K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation" },
                rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
                ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
                e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics" },
                q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostics list" },
            },
        }, { prefix = "<leader>" })
    end,
},
}
