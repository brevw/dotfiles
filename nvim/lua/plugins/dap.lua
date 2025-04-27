return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "rcarriga/nvim-dap-ui", -- UI for nvim-dap
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python", -- Python DAP integration
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local mason = require("mason")
            local mason_dap = require("mason-nvim-dap")

            -- Setup Mason for DAP
            mason.setup()
            mason_dap.setup({
                ensure_installed = { "python" },
                automatic_setup = true,
            })

            -- Setup Python Debugging
            require("dap-python").setup("python") -- Uses system python interpreter

            -- Setup Java Debugging

            -- Setup nvim-dap-ui
            dapui.setup()

            -- Auto open/close UI on debug start/stop
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Keybindings for Debugging
            vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
            vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
            vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
            vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
            vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end)
            vim.keymap.set("n", "<Leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
            vim.keymap.set("n", "<Leader>du", function() dapui.toggle() end) -- Toggle UI manually
        end,
    },
}
