return {
  "rcarriga/nvim-notify",
  config = function()
    -- Import notify module
    local notify = require("notify")

    -- Set notify.nvim as the default notification manager
    vim.notify = notify

    -- Configure notify.nvim
    notify.setup({
      stages = "fade_in_slide_out",  -- Animation style
      timeout = 3000,                -- Notification timeout in milliseconds
      background_colour = "#000000", -- Background color for notifications
      render = "default",            -- Default render style
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    -- Example: Send a notification (optional)
    vim.notify("Notify.nvim is set up!", "INFO", { title = "Configuration Complete" })
  end,
}

