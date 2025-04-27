return {
    {
        "lervag/vimtex", -- LaTeX plugin for Neovim
        config = function()
            vim.g.vimtex_view_method = "skim" -- Use Skim for PDF preview
            vim.g.vimtex_compiler_method = "latexmk" -- Auto-compilation with latexmk

            -- Optional: Show LaTeX errors in quickfix window
            vim.g.vimtex_quickfix_mode = 1

            -- Skim specific settings for SyncTeX
            vim.g.vimtex_view_skim_sync = 1
            vim.g.vimtex_view_skim_reading_bar = 1
        end,
    },
}

