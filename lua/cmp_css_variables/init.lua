local source = {}
local utils = require("cmp_css_variables.utils")

function source.new()
	local self = setmetatable({}, { __index = source })
	self.cache = {}
	return self
end

function source.is_available()
	return vim.g.css_variables_files
		and (
			vim.bo.filetype == "scss"
			or vim.bo.filetype == "sass"
			or vim.bo.filetype == "css"
			or vim.bo.filetype == "less"
			or vim.bo.filetype == "vue"
		)
end

-- function source.get_keyword_pattern()
-- 	return [[\%(\$_\w*\|\%(\w\|\.\)*\)]]
-- end

function source.get_debug_name()
	return "css-variables"
end

function source.get_trigger_characters()
	return { "-" }
end

function source.complete(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()
	local items = {}

	if not self.cache[bufnr] then
		if vim.g.css_variables_files then
			items = utils.get_css_variables(vim.g.css_variables_files)
		end

		if type(items) ~= "table" then
			return callback()
		end
		self.cache[bufnr] = items
	else
		items = self.cache[bufnr]
	end

	callback({ items = items or {}, isIncomplete = false })
end

function source.resolve(_, completion_item, callback)
	callback(completion_item)
end

function source.execute(_, completion_item, callback)
	callback(completion_item)
end

return source
