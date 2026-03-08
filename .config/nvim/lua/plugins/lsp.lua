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
      ensure_installed = { "clangd", "gopls", "pyright", "lua_ls" },
      automatic_installation = true,
    },
  },

  -- Keep nvim-lspconfig installed (it provides server definitions),
  -- but DO NOT call require("lspconfig") anymore.
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
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

      vim.lsp.enable({ "clangd", "gopls", "pyright", "lua_ls" })
    end,
  },
}

