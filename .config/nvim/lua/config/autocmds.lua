local augroup = vim.api.nvim_create_augroup

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- optional: auto format on save (handled by conform too, but this is a safe place for extra logic later)
