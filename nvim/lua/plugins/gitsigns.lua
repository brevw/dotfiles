return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Loads the plugin only when you open a file
    config = function()
        require('gitsigns').setup({
            -- This enables the inline blame feature you are looking for
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- Places the blame text at the end of the line
                delay = 500,           -- Half-second delay so it doesn't flicker while typing
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        })
    end,
    -- Setting up a few handy keybindings for git blame
    keys = {
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame Inline" },
        { "<leader>gh", "<cmd>Gitsigns blame_line<cr>", desc = "Git Blame Full Detail (Float)" },
    }
}
