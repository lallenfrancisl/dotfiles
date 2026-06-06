local function opencode_right_split_width() return 50 end

local function opencode_has_room_on_right() return vim.o.columns - opencode_right_split_width() >= vim.o.columns * 0.7 end

local function opencode_window_opts()
  if opencode_has_room_on_right() then return {
    split = "right",
    width = opencode_right_split_width(),
  } end

  return {
    split = "below",
    height = math.floor(vim.o.lines * 0.35),
  }
end

local function is_opencode_buffer(buf)
  return vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_get_name(buf):find("opencode --port", 1, true) ~= nil
end

local function focus_opencode_input()
  vim.schedule(function()
    if is_opencode_buffer(vim.api.nvim_get_current_buf()) then vim.cmd.startinsert() end
  end)
end

local function find_opencode_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if is_opencode_buffer(buf) then return win end
  end
end

local function find_opencode_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and is_opencode_buffer(buf) then return buf end
  end
end

local function configure_opencode_buffer(buf)
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].buflisted = false
  vim.b[buf].snacks_indent = false
  vim.b[buf].snacks_scope = false

  vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = buf, desc = "Enter terminal normal mode" })
  vim.keymap.set("t", "<LeftMouse>", [[<C-\><C-n><LeftMouse>]], { buffer = buf, desc = "Mouse select terminal output" })
  vim.keymap.set(
    "t",
    "<RightMouse>",
    [[<C-\><C-n><RightMouse>]],
    { buffer = buf, desc = "Mouse select terminal output" }
  )

  vim.t.bufs = vim.tbl_filter(function(tab_buf) return tab_buf ~= buf end, vim.t.bufs or {})
end

local function open_opencode_buffer(buf)
  local opts = opencode_window_opts()

  if opts.split == "right" then
    vim.cmd(("rightbelow %dvsplit"):format(opts.width))
  else
    vim.cmd(("botright %dsplit"):format(opts.height))
  end

  vim.api.nvim_win_set_buf(0, buf)
  configure_opencode_buffer(buf)
  focus_opencode_input()
end

local function update_opencode_window_layout()
  local win = find_opencode_window()

  if not win then return end

  local previous_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(win)

  if opencode_has_room_on_right() then
    vim.cmd.wincmd "L"
    vim.api.nvim_win_set_width(win, opencode_right_split_width())
  else
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(win, math.floor(vim.o.lines * 0.35))
  end

  if vim.api.nvim_win_is_valid(previous_win) then vim.api.nvim_set_current_win(previous_win) end
end

local function start_opencode_server(focus)
  if find_opencode_window() then return end

  local buf = find_opencode_buffer()
  if buf then
    open_opencode_buffer(buf)
    return
  end

  local opts = opencode_window_opts()

  if opts.split == "right" then
    vim.cmd(("rightbelow %dvsplit term://opencode --port"):format(opts.width))
  else
    vim.cmd(("botright %dsplit term://opencode --port"):format(opts.height))
  end

  configure_opencode_buffer(vim.api.nvim_get_current_buf())
  if focus then
    focus_opencode_input()
  else
    vim.cmd.wincmd "p"
  end
end

local function toggle_opencode_window()
  local win = find_opencode_window()

  if win then
    local previous_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(win)

    if #vim.api.nvim_list_wins() > 1 then
      vim.cmd.close()
    else
      vim.cmd.enew()
    end

    if vim.api.nvim_win_is_valid(previous_win) then vim.api.nvim_set_current_win(previous_win) end
    return
  end

  local buf = find_opencode_buffer()
  if buf then
    open_opencode_buffer(buf)
    return
  end

  start_opencode_server(true)
end

---@type LazySpec
return {
  {
    "nickjvandyke/opencode.nvim",
    config = function()
      local group = vim.api.nvim_create_augroup("opencode_window_layout", { clear = true })

      vim.api.nvim_create_autocmd("VimResized", {
        group = group,
        callback = update_opencode_window_layout,
      })

      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
        group = group,
        callback = function(args)
          if is_opencode_buffer(args.buf) then focus_opencode_input() end
        end,
      })

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = start_opencode_server,
        },
      }
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      maps.n["<Leader>Ot"] = {
        toggle_opencode_window,
        desc = "Toggle embedded",
      }
    end,
  },
}
