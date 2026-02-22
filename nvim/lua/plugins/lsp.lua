return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "scalameta/nvim-metals",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("mason").setup()

            -- Configure Mason to install LSP servers
            require("mason-lspconfig").setup({
                ensure_installed = { "bashls", "pyright", "lua_ls", "clangd", "jdtls", "texlab", "html", "cssls", "jsonls", "ts_ls", "gopls", },
            })

            -- Configure Mason to install Linters
            require("mason-lspconfig").setup({
                ensure_installed = { "eslint" },
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Attach LSP servers

            -- bash
            lspconfig.bashls.setup({
                capabilities = capabilities,
                filetypes = { "sh", "bash" },
                root_dir = lspconfig.util.root_pattern(".git", ".bashrc"),
                settings = {
                    bash = {
                        globPattern = "*.sh",
                        shellcheckPath = "shellcheck", -- Ensure shellcheck is installed
                    },
                },
            })

            -- python
            lspconfig.pyright.setup({
                capabilities = capabilities, -- Add LSP capabilities for autocompletion
                settings = {
                    python = {
                        -- add environment
                        -- pythonPath = "/Users/tliliahmed/miniconda3/bin/python", -- Specify the Python interpreter
                        pythonPath = "/Users/tliliahmed/miniconda3/envs/AML_Task2/bin/python", -- Specify the Python interpreter
                        -- pythonPath = "/usr/bin/python3", -- Specify the Python interpreter
                        analysis = {
                            typeCheckingMode = "basic", -- Adjust type checking (basic/strict/none)
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
            lspconfig.texlab.setup({})

            -- lua
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Recognize `vim` as a global
                        },
                    },
                },
            })

            -- c like languages
            lspconfig.clangd.setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp", "h" },
                root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
            })

            -- rust
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            })

            -- html, css, json, javascript, typescript
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                    },
                },
            })
            lspconfig.eslint.setup({
                capabilities = capabilities,
                settings = {
                    format = { enable = false },
                },
                root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".eslintrc.json", "package.json", ".git"),
            })

            -- java
            lspconfig.jdtls.setup({
                capabilities = capabilities,
                cmd = {
                    "jdtls", -- Command to start jdtls, ensure it's in your PATH
                    "-data", vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"), -- Workspace directory
                },
                root_dir = lspconfig.util.root_pattern("build.xml", ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"), -- Detect project root
                settings = {
                    java = {
                        eclipse = {
                            downloadSources = true,
                        },
                        configuration = {
                            -- ✅ Add External Libraries
                            classpath = {
                                "/Users/tliliahmed/Database Systems/Project 2:3/Project/PaintStore/db2jcc4.jar"
                            },
                            updateBuildConfiguration = "interactive",
                        },
                        maven = {
                            downloadSources = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                        references = {
                            includeDecompiledSources = true,
                        },
                        inlayHints = {
                            parameterNames = {
                                enabled = "all", -- Show parameter names as inlay hints
                            },
                        },
                    },
                },
                init_options = {
                    bundles = {},
                },
            })

            -- Go
            lspconfig.gopls.setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        gofumpt = true, -- Format code with gofumpt (stricter gofmt)
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
            })

            -- Scala
            local metals_config = require("metals").bare_config()
            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            }
            metals_config.capabilities = capabilities
            metals_config.init_options.statusBarProvider = "on"
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt", "java" },
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })

            -- Enable folding globally
            vim.o.foldmethod = "expr"  -- Use expression-based folding
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"  -- Treesitter folding (requires nvim-treesitter)
            vim.o.foldenable = true    -- Enable folding by default
            vim.o.foldlevel = 99       -- Open all folds by default
        end,
    },
}

