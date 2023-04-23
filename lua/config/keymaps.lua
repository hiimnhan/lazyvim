-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local opts = { silent = true }
local map = vim.keymap.set
-- Dashboard
-- Add keymap to open alpha dashboard
map("n", "<leader>;", function()
  -- close all open buffers before open dashboard
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if buftype ~= "terminal" then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end

  if Util.has("alpha-nvim") then
    require("alpha").start(true)
  end
end, opts)

if Util.has("mini.bufremove") then
  map("n", "<S-q>", function()
    require("mini.bufremove").delete(0, false)
    local bufs = vim.fn.getbufinfo({ buflisted = true })
    -- open alpha if no buffers are left
    if not bufs[2] and Util.has("alpha-nvim") then
      require("alpha").start(true)
    end
  end, opts)
else
  map("n", "<S-q>", "<cmd>bd<CR>", opts)
end

map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

map("n", "<leader>o", "<Cmd>NeoTreeFocus<CR>", { desc = "Focus Tree" })
