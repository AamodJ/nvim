return {
  {
    "AamodJ/present.nvim",
    config = function()
      vim.keymap.set("n", "<leader>sp", "<cmd>PresentStart<CR>", { desc = "[S]tart [P]resentation" })
    end,
  },
}
