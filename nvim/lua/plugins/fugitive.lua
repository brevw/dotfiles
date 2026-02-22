return {
    "tpope/vim-fugitive",
    lazy = true,

    -- Load when any of these commands are used
    cmd = {
        "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep",
        "GMove", "GDelete", "GBrowse", "Glog", "Gedit"
    },

    -- Useful keybindings
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff (Split)" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
        { "<leader>gl", "<cmd>Glog<cr>", desc = "Git Log (current file)" },
        { "<leader>gp", "<cmd>Git pull<cr>", desc = "Git Pull" },
        { "<leader>gP", "<cmd>Git push<cr>", desc = "Git Push" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
        { "<leader>ga", "<cmd>Git add %<cr>", desc = "Git Add Current File" },
    },

    -- Optional config hook (if needed later)
    config = function()
        -- You can define autocommands, keymaps, or tweaks here if needed
        vim.cmd([[
            augroup FugitiveCustom
                autocmd!
                autocmd FileType fugitive setlocal nonumber norelativenumber
            augroup END
        ]])
    end,
}
