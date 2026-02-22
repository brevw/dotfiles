-- Utility functions provide reusable helper methods for tasks that might be repeated in multiple places
-- within your configuration.

local M = {}

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

-- Function to show the selector
local function show_selector(prompt_title, mapping)
    -- Get a selector
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local choices = {}
    for k, _ in pairs(mapping) do
        table.insert(choices, k)
    end

    pickers.new({}, {
        prompt_title = prompt_title,
        finder = finders.new_table {
            results = choices
        },
        sorter = nil,
                -- or can use sorter: conf.generic_sorter({}),
        attach_mappings = function(prompt_buffnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_buffnr)
                local selection = action_state.get_selected_entry()[1]
                for k, v in pairs(mapping) do
                    if selection == k then
                        v()
                        return
                    end
                end
            end)
            return true
        end,
    }):find()
end

-- Optional: bind it to a key
vim.keymap.set("n", "<leader>ss", function()
    local choices = {}
    -- global choices


    -- local choices depend on filetype
    local current_file = vim.fn.expand("%:p")
    local filetype = vim.bo.filetype

    -- Latex
    if filetype == "tex" then
            choices["Toggle Vimtex Autocompile on save"] = function()
                vim.notify("Toggling Vimtex Autocompile on save...")
                vim.cmd(":VimtexCompile")
            end
            choices["View PDF"] = function()
                vim.notify("Opening PDF...")
                current_file = string.gsub(current_file, ".tex", ".pdf")
                vim.cmd(string.format(":!open -a Skim %s", current_file))
            end
    -- Markdown
    elseif filetype == "markdown" then
            choices["Preview"] = function()
                vim.notify("Preview...")
                vim.cmd("MarkdownPreview")
            end
    -- C / C++
    elseif filetype == "cpp" or filetype == "c" then
        choices["Switch between File and Header File"] = function ()
            local file_extension = vim.fn.expand("%:e")
            if file_extension == "cpp" or file_extension == "c" then
                local header_file = string.gsub(current_file, "%." .. file_extension .. "$", ".h")
                if vim.fn.filereadable(header_file) == 1 then
                    vim.cmd(string.format(":e %s", header_file))
                end
            else
                local source_file = string.gsub(current_file, "%.h$", ".cpp")
                if vim.fn.filereadable(source_file) == 1 then
                    vim.cmd(string.format(":e %s", source_file))
                    return
                end
                source_file = string.gsub(current_file, "%.h$", ".c")
                if vim.fn.filereadable(source_file) == 1 then
                    vim.cmd(string.format(":e %s", source_file))
                    return
                end
            end
        end
    -- Tree
    elseif filetype == "NvimTree" then
        -- add scripts
        local path = string.gsub(current_file, "NvimTree_1", "")
        choices["Latex Script"] = function()
            local command = [[osascript \
                              -e 'tell application "iTerm"' \
                              -e 'create window with default profile' \
                              -e 'tell current window' \
                              -e 'tell current session' \
                              -e 'write text "cd ]] .. path .. [["' \
                              -e 'write text "~/dotfiles/scripts/latex.sh"' \
                              -e 'end tell' \
                              -e 'end tell' \
                              -e 'end tell']]

            vim.fn.system(command)
        end
    end
    show_selector("Select", choices)
end, { desc = "Show custom selector" })

return M

