require("demisco.keymaps")
require("demisco.options")
require("demisco.plugins")


local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('demisco.macos')
end
if is_win then
  require('demisco.windows')
end
