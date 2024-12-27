return {
  {
    dir = '~/git-clones/mine/nvim-plugins/present.nvim',
    config = function()
      vim.keymap.set("n", "<leader>sp", "<cmd>PresentStart<CR>", { desc = "[S]tart [P]resentation" })
    end,
  },
}
