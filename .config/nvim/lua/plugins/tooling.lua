return {
  -- formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      format_on_save = { timeout_ms = 1500, lsp_fallback = true },
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "gofmt", "goimports" },
        python = { "isort", "black" },
        lua = { "stylua" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "Format buffer" })
    end,
  },

  -- linting (optional but nice)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
        go = { "golangcilint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

