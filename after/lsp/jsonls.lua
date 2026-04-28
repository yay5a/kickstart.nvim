local markdownlint_schema = vim.fn.stdpath 'data'
	.. '/mason/packages/markdownlint/node_modules/markdownlint-cli/node_modules/markdownlint/schema/markdownlint-config-schema.json'
local markdownlint_schema_uri = vim.uv.fs_stat(markdownlint_schema) and vim.uri_from_fname(markdownlint_schema)
	or 'https://raw.githubusercontent.com/DavidAnson/markdownlint/main/schema/markdownlint-config-schema.json'

return {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { '.markdownlint.json' },
					url = markdownlint_schema_uri,
				},
				{
					fileMatch = { '.markdownlint.jsonc' },
					schema = {
						id = 'vscode://schemas/markdownlint-jsonc',
						allowTrailingCommas = true,
						allOf = {
							{ ['$ref'] = markdownlint_schema_uri },
						},
					},
				},
			},
			validate = {
				enable = true,
			},
		},
	},
}
