local map = vim.keymap.set

-- basics
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- better movement
map({ "n", "v" }, "H", "^", { desc = "Line start" })
map({ "n", "v" }, "L", "$", { desc = "Line end" })

-- diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostic" })
map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics list" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- file tree
map("n", "<leader>tt", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>tf", "<cmd>Neotree reveal<cr>", { desc = "Reveal file in tree" })

-- Git
map("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview file history" })
