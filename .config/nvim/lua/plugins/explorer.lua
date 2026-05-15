return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            sources = { "filesystem", "buffers", "git_status" },
            close_if_last_window = true,
            filesystem = {
                follow_current_file = { enabled = true },
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
            },
            window = { width = 32 },
        },
    },
}
