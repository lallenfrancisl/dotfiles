---@type LazySpec
return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      opts.history = false
      require("luasnip").filetype_extend("vue", { "html" })
    end,
  },
}
