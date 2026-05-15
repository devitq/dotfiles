return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = {
                "c", "cpp", "go", "rust", "python", "lua", "asm", "nasm",
                "terraform", "hcl", "dockerfile",
                "bash", "json", "yaml", "toml",
                "markdown", "markdown_inline",
                "regex", "vim", "vimdoc",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)
        end,
    },
}
