return {
	{"nvim-lua/plenary.nvim"},
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = 'codestral',
				request_timeout = 2.5,
				throttle = 1500, -- Increase to reduce costs and avoid rate limits
				debounce = 600, -- Increase to reduce costs and avoid rate limits
				provider_options = {
					codestral = {
						api_key = 'CODESTRAL_API_KEY',
						end_point = 'https://api.mistral.ai/v1/fim/completions',
						model = 'codestral-latest',
						stream = true,
						template = {
							prompt = function(context_before_cursor, context_after_cursor, opts)
								return '<|fim_prefix|>'
								.. context_before_cursor
								.. '<|fim_suffix|>'
								.. context_after_cursor
								.. '<|fim_middle|>'
							end,
							suffix = false,
						},
						optional = {
							max_tokens = 256,
							stop = { '\n\n' },
							top_p = 0.9,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = {"python", "lua"},
					keymap = {
						-- accept whole completion
						accept = '<C-a>',
						-- accept one line
						accept_line = '<A-a>',
						-- accept n lines (prompts for number)
						-- e.g. "A-z 2 CR" will accept 2 lines
						accept_n_lines = '<A-z>',
						-- Cycle to prev completion item, or manually invoke completion
						prev = '<A-[>',
						-- Cycle to next completion item, or manually invoke completion
						next = '<A-]>',
						dismiss = '<C-d>',
					},
				},
			})
		end
	}
}
