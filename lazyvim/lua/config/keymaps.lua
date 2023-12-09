-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


local Util = require("lazyvim.util")

-- change lazygit to gitui
vim.keymap.set("n", "<leader>gg",
  function() Util.terminal({ "gitui" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end,
  { desc = "gitui (root dir)" })
vim.keymap.set("n", "<leader>gG",
  function() Util.terminal({ "gitui" }, { esc_esc = false, ctrl_hjkl = false }) end,
  { desc = "gitui (cwd)" })

-- add joshuto
local joshuto_output_file = vim.fn.expand("$HOME/.cache/joshuto-output-file")
local function on_joshuto_exit(job_id, code)
  if code == 102 then
    local chosen_file = vim.fn.readfile(joshuto_output_file)[1]
    if chosen_file then
      vim.cmd(string.format("%s %s", 'edit', chosen_file))
    end
  end
end

vim.keymap.set("n", "<leader>e",
  function()
    Util.terminal({ "joshuto", "--file-chooser", "--output-file", joshuto_output_file },
      { on_exit = on_joshuto_exit, cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
  end,
  { desc = "joshuto" })
vim.keymap.set("n", "<leader>E",
  function()
    Util.terminal({ "joshuto", "--file-chooser", "--output-file", joshuto_output_file },
      { cwd = vim.fn.expand("#:p:h"), esc_esc = false, ctrl_hjkl = false })
  end,
  { desc = "joshuto (file)" })
