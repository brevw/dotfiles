return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",            -- Required dependency
    "nvim-telescope/telescope-fzy-native.nvim", -- Optional: FZY sorter for better performance
    "nvim-telescope/telescope-ui-select.nvim",  -- Optional: Improves UI for `vim.ui.select`
  },
  cmd = "Telescope", -- Lazy load on `:Telescope`
  config = function()
    -- Variable to toggle gitignore behavior
    local use_gitignore = true

    -- Function to get dynamic vimgrep_arguments based on toggle state
    local function get_vimgrep_arguments()
      if use_gitignore then
        return {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--ignore", -- Respect .gitignore
        }
      else
        return {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--no-ignore", -- Ignore .gitignore
          "--hidden",    -- Include hidden files
        }
      end
    end

    -- Patch plenary.popup to prevent errors with unsupported keys
    local popup = require("plenary.popup")
    local original_create = popup.create
    popup.create = function(...)
      local opts = select(2, ...)
      if opts and opts.layout_config and opts.layout_config.center then
        opts.layout_config.center.preview_width = nil -- Remove unsupported key
      end
      return original_create(...)
    end

    -- Setup Telescope with dynamic vimgrep_arguments
    require("telescope").setup({
      defaults = {
        prompt_prefix = "🔍 ", -- Icon for search prompt
        selection_caret = "➜ ", -- Icon for selection
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = 0.6 }, -- Only apply preview_width here
          vertical = { width = 0.8 },
        },
        vimgrep_arguments = get_vimgrep_arguments(), -- Use dynamic arguments
        file_ignore_patterns = { "node_modules", "%.git/", "%.cache" }, -- Ignore unnecessary files
        mappings = {
          i = { -- Insert mode mappings
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = "send_to_qflist",
            ["<CR>"] = "select_default",
          },
        },
      },
      pickers = { -- Customize default pickers
        find_files = {
          hidden = true, -- Include hidden files
        },
        live_grep = {
          only_sort_text = true,
        },
      },
      extensions = { -- Load extensions
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Command to toggle gitignore behavior
    vim.api.nvim_create_user_command("ToggleGitIgnore", function()
      use_gitignore = not use_gitignore
      print("Telescope: Respecting .gitignore is now " .. (use_gitignore and "ON" or "OFF"))
      -- Update vimgrep_arguments dynamically
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = get_vimgrep_arguments(),
        },
      })
    end, {})

    -- Load Telescope extensions
    require("telescope").load_extension("fzy_native")  -- enhances sorting performance in Telescope
    require("telescope").load_extension("ui-select")   -- replaces vim.ui.select with a Telescope-powered dropdown picker
  end,
}

