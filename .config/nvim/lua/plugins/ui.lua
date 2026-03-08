return {
  -- theme
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "hard",  -- "hard", "soft", or "" (default medium)
      transparent_mode = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "gruvbox", globalstatus = true },
      sections = {
        lualine_c = { "filename", "diff" },
        lualine_x = { "diagnostics", "filetype" },
      },
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = { borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } },
    },
  },
}

