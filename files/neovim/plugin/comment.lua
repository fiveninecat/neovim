require('nvim_comment').setup()

-- Set keymap to comment or uncomment current line
vim.keymap.set("n", "<leader>c", vim.cmd.CommentToggle)
