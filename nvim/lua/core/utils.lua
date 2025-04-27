-- Utility functions provide reusable helper methods for tasks that might be repeated in multiple places
-- within your configuration.

local M = {}

-- Reload Neovim configuration
-- Dynamically reloads Neovim without restarting, useful for testing configuration changes.
function M.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  print("Configuration reloaded!")
end

-- Check if a plugin is installed
-- Checks if a specific plugin is installed (useful for conditional plugin configuration).
function M.is_plugin_installed(plugin_name)
  local plugin_path = vim.fn.stdpath('data') .. "/lazy/" .. plugin_name
  return vim.loop.fs_stat(plugin_path) ~= nil
end

-- Toggle relative line numbers
-- Toggles relative line numbers on and off.
function M.toggle_relative_number()
  local current = vim.opt.relativenumber:get()
  vim.opt.relativenumber = not current
end

-- Open URL under the cursor
-- Opens a URL (e.g., in Markdown files or comments) in your default web browser.
function M.open_url()
  local url = vim.fn.expand("<cWORD>")
  vim.fn.jobstart({ "open", url }, { detach = true })  -- macOS-specific; use `xdg-open` on Linux
end

return M

