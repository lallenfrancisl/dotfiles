---@type LazySpec
return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      providers = {
        lsp = { score_offset = 10 },
        snippets = { score_offset = -10 },
      },
    },
  },
}
