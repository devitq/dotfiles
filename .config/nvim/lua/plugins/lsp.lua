local function lsp_keymaps(ev)
    local buf = ev.buf
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "gi", vim.lsp.buf.implementation, "Implementation")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

    if vim.lsp.inlay_hint then
        pcall(vim.lsp.inlay_hint.enable, true, { bufnr = buf })
    end
end

return {
    { "williamboman/mason.nvim", cmd = "Mason", opts = {} },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "mason.nvim" },
        opts = {
            ensure_installed = {
                "clangd",
                "gopls",
                "pyright",
                "lua_ls",
                "rust_analyzer",
                "asm_lsp",
                "terraformls",
                "ansiblels",
                "dockerls",
                "yamlls",
                "jsonls",
                "helm_ls",
            },
            automatic_installation = true,
        },
    },

    -- Keep nvim-lspconfig installed (it provides server definitions),
    -- but DO NOT call require("lspconfig") anymore.
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "hrsh7th/cmp-nvim-lsp", "b0o/schemastore.nvim" },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_keymaps })

            local caps = vim.lsp.protocol.make_client_capabilities()
            local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
                caps = cmp_lsp.default_capabilities(caps)
            end

            vim.lsp.config("clangd", {
                capabilities = caps,
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
            })

            vim.lsp.config("gopls", {
                capabilities = caps,
                settings = {
                    gopls = {
                        staticcheck = true,
                        analyses = { unusedparams = true, nilness = true, shadow = true },
                    },
                },
            })

            vim.lsp.config("pyright", { capabilities = caps })

            vim.lsp.config("lua_ls", {
                capabilities = caps,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                capabilities = caps,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = { command = "clippy" },
                    },
                },
            })

            vim.lsp.config("asm_lsp", {
                capabilities = caps,
                filetypes = { "asm", "nasm" },
            })

            vim.lsp.config("terraformls", { capabilities = caps })
            vim.lsp.config("ansiblels", { capabilities = caps })
            vim.lsp.config("dockerls", { capabilities = caps })

            local k8s_schema = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.0-standalone-strict/all.json"
            local schemastore_ok, schemastore = pcall(require, "schemastore")
            local yaml_schemas = {}
            local json_schemas = {}

            if schemastore_ok then
                yaml_schemas = schemastore.yaml.schemas()
                json_schemas = schemastore.json.schemas()
            end

            yaml_schemas[k8s_schema] = {
                "k8s/**/*.yaml",
                "k8s/**/*.yml",
                "kubernetes/**/*.yaml",
                "kubernetes/**/*.yml",
                "*.k8s.yaml",
                "*.k8s.yml",
            }

            yaml_schemas["https://json.schemastore.org/kustomization.json"] = {
                "kustomization.yaml",
                "kustomization.yml",
            }

            vim.lsp.config("yamlls", {
                capabilities = caps,
                settings = {
                    yaml = {
                        validate = true,
                        format = { enable = true },
                        schemaStore = { enable = false, url = "" },
                        schemas = yaml_schemas,
                    },
                },
            })

            vim.lsp.config("jsonls", {
                capabilities = caps,
                settings = {
                    json = {
                        validate = { enable = true },
                        schemaStore = { enable = false, url = "" },
                        schemas = json_schemas,
                    },
                },
            })

            vim.lsp.config("helm_ls", { capabilities = caps })

            vim.lsp.enable({
                "clangd",
                "gopls",
                "pyright",
                "lua_ls",
                "rust_analyzer",
                "asm_lsp",
                "terraformls",
                "ansiblels",
                "dockerls",
                "yamlls",
                "jsonls",
                "helm_ls",
            })
        end,
    },
}
