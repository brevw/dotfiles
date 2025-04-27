return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost", -- Load only when a file is opened
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },       -- Symbol for added lines
          change = { text = "~" },    -- Symbol for changed lines
          delete = { text = "_" },    -- Symbol for deleted lines
          topdelete = { text = "‾" }, -- Symbol for top of a deleted block
          changedelete = { text = "~" }, -- Symbol for changed and deleted lines
        },
        current_line_blame = false, -- Inline blame for the current line
        numhl = false,              -- Disable line number highlighting
        linehl = false,             -- Disable line highlighting
        watch_gitdir = {
          interval = 1000, -- Update interval (milliseconds)
          follow_files = true,
        },
        sign_priority = 6, -- Priority for displaying signs
        update_debounce = 100,
        max_file_length = 40000, -- Disable for files larger than this
        preview_config = {
          border = "rounded", -- Preview window border style
        },
      })
    end,
  },
}
