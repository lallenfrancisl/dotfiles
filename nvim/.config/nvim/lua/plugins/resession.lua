local function sync_neotree_to_cwd()
  if not package.loaded["neo-tree"] then return end

  vim.schedule(function()
    require("neo-tree.command").execute({
      action = "show",
      source = "filesystem",
      dir = vim.fn.getcwd(),
    })
  end)
end

---@type LazySpec
return {
  "stevearc/resession.nvim",
  config = function(_, opts)
    require("resession").setup(opts)
    require("resession").add_hook("post_load", sync_neotree_to_cwd)
  end,
}
