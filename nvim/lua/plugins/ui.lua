return {
    {
        "folke/tokyonight.nvim",
        enabled = true,
        lazy = false, -- Load immediately
        priority = 1000, -- Ensure it loads first
        config = function()
            require("tokyonight").setup({
                style = "night", -- Options: "storm", "moon", "night", "day"
                transparent = false, -- Disable transparent background
                terminal_colors = true, -- Use theme colors in terminal
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = { bold = true },
                },
            })
            vim.cmd("colorscheme tokyonight") -- Set the colorscheme
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy", -- Load when Neovim is idle
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    section_separators = "",
                    component_separators = "|",
                },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    separator_style = "slant",
                },
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- For file icons
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30, -- Width of the tree panel
                    side = "left", -- Position of the tree (left or right)
                },
                git = {
                    enable = true, -- Show Git status icons
                    ignore = false, -- Show files ignored by `.gitignore`
                },
                filters = {
                    dotfiles = false, -- Show hidden files (toggleable)
                },
                actions = {
                    open_file = {
                        quit_on_open = true, -- Close the tree when a file is opened
                    },
                },
                renderer = {
                    highlight_opened_files = "all", -- Highlight opened files
                },
            })
        end,
    },
}

