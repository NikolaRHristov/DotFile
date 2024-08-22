export default {
	editorConfig: true,
	arrowParens: "always",
	bracketSameLine: true,
	bracketSpacing: true,
	cursorOffset: -1,
	embeddedLanguageFormatting: "auto",
	endOfLine: "lf",
	htmlWhitespaceSensitivity: "css",
	insertPragma: false,
	jsxSingleQuote: false,
	printWidth: 80,
	proseWrap: "always",
	quoteProps: "preserve",
	requirePragma: false,
	semi: true,
	singleQuote: false,

	tabWidth: 4,
	trailingComma: "all",
	useTabs: true,
	vueIndentScriptAndStyle: true,
	plugins: [
		"prettier-plugin-astro",
		"prettier-plugin-organize-attributes",
		"prettier-plugin-sh",
		"prettier-plugin-tailwindcss",
		"prettier-plugin-toml",
		"prettier-plugin-packagejson",
	],
	tailwindConfig: "./tailwind.config.js",
	overrides: [
		{
			files: "*.astro",
			options: {
				parser: "astro",
			},
		},
		{
			files: "*.svelte",
			options: {
				parser: "svelte",
			},
		},
		{
			files: "*.lua",
			options: {
				parser: "lua",
			},
		},
		{
			files: "*.toml",
			options: {
				parser: "toml",
			},
		},
		{
			files: "package.json",
			options: {
				trailingComma: "none",
			},
		},
	],
	svelteSortOrder: "options-scripts-styles-markup",
	svelteStrictMode: true,
	svelteAllowShorthand: true,
	svelteIndentScriptAndStyle: true,
	importOrder: [
		"^@(.*)/(.*)$",
		"^@core/(.*)$",
		"^@server/(.*)$",
		"^@ui/(.*)$",
		"^[./]",
	],
	importOrderSeparation: true,
	importOrderSortSpecifiers: true,
	attributeGroups: ["$DEFAULT", "^data-"],
	attributeSort: "ASC",
	attributeIgnoreCase: false,
};
