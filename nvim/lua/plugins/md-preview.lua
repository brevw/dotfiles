return {
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn.system({"npm", "install"}) -- Ensure npm dependencies are installed
        end,
        ft = { "markdown" }, -- Load only for Markdown files
        config = function()
            vim.g.mkdp_auto_start = 0 -- Do not auto-start preview
            vim.g.mkdp_auto_close = 1 -- Auto-close preview when switching files
            vim.g.mkdp_port = "3000" -- Set the port to 3000
        end,
    },
}

