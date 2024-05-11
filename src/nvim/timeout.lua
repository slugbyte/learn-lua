-- defer_fn takes a callback and a timeout in ms
local do_something = function()
    vim.notify("stop", vim.log.levels.INFO)
end

vim.notify("start", vim.log.levels.INFO)
vim.defer_fn(do_something, 1000)
