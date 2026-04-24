return {
	settings = {
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
		yaml = {
			validate = true,
			completion = true,
			hover = true,
			format = {
				enable = false,
			},
			schemaStore = {
				enable = true,
			},
			schemas = {
				['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
				['https://json.schemastore.org/github-action.json'] = '/action.yml',
				['https://json.schemastore.org/docker-compose.json'] = 'docker-compose*.yml',
				kubernetes = 'k8s/**/*.yaml',
			},
			customTags = {},
		},
	},
}
