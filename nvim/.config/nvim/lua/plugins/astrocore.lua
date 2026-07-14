---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    opts.diagnostics = opts.diagnostics or {}
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}

    local sign_text = vim.tbl_get(opts.diagnostics, "signs", "text") or {}

    opts.diagnostics.virtual_text = {
      prefix = function(diagnostic) return " " .. (sign_text[diagnostic.severity] or "■") end,
      format = function(diagnostic) return " " .. diagnostic.message .. " " end,
    }
    opts.diagnostics.signs = false

    opts.mappings.n["grr"] = {
      function()
        local current_file = vim.api.nvim_buf_get_name(0)
        local cursor = vim.api.nvim_win_get_cursor(0)

        vim.lsp.buf.references(nil, {
          on_list = function(list)
            local references, seen = {}, {}
            for _, item in ipairs(list.items) do
              local key = table.concat({ item.filename, item.lnum, item.col, item.end_lnum, item.end_col }, ":")
              local current = item.filename == current_file
                and item.lnum == cursor[1]
                and cursor[2] + 1 >= item.col
                and cursor[2] + 1 <= (item.end_col or item.col)

              if not current and not seen[key] then
                seen[key] = true
                references[#references + 1] = item
              end
            end

            if #references == 0 then
              vim.notify "No other references found"
            elseif #references == 1 then
              local reference = references[1]
              vim.cmd "normal! m'"
              if reference.filename ~= vim.api.nvim_buf_get_name(0) then
                vim.cmd.edit(vim.fn.fnameescape(reference.filename))
              end
              vim.api.nvim_win_set_cursor(0, { reference.lnum, reference.col - 1 })
              vim.cmd "normal! zv"
            else
              list.items = references
              vim.fn.setqflist({}, " ", list)
              vim.cmd "botright copen"
            end
          end,
        })
      end,
      desc = "Go to references",
    }

    opts.mappings.n["<Leader>Sl"] = {
      function()
        local ok, _ = pcall(function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end)
        if not ok then vim.notify("No session found for this directory", "info") end
      end,
      desc = "Load root session",
    }
  end,
}
