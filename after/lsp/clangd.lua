return {
	cmd = vim.fn.executable 'clang-tidy' == 1 and { 'clangd', '--clang-tidy', '--background-index', '--fallback-style=llvm' }
		or { 'clangd', '--background-index', '--fallback-style=llvm' },
}
