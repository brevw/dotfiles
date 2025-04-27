return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    disable = { "latex" },
                },
                indent = {
                    enable = true,
                },
                ensure_installed = { "c", "cpp", "python", "lua", "java", "javascript", "html", "css" }, -- Add desired languages here
                auto_install = true, -- Automatically install missing parsers
                fold = {
                    enable = true,
                },
            })
        end,
    }

}
