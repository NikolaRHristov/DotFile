const MODULES_DIR = "D:\\tools\\.pnpm-global\\5\\node_modules\\";

/** @type {import('prettier').Config} */
module.exports = {
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
	trailingComma: "es5",
	useTabs: true,
	vueIndentScriptAndStyle: true,
	plugins: [
		// @TODO: Check for support
		// "@prettier/plugin-lua",
		// @TODO: Check for support
		// "@prettier/plugin-php",
		// @TODO: Check for support
		// "@trivago/prettier-plugin-sort-imports",
		"prettier-plugin-astro",
		// @TODO: Check for support
		// "prettier-plugin-java",
		// @TODO: Check for support
		// "prettier-plugin-kotlin",
		// @TODO: Check for support
		// "prettier-plugin-organize-attributes",
		// @TODO: Check for support
		// "prettier-plugin-autocorrect",
		// @TODO: Check for support
		// "prettier-plugin-pkg",
		// @TODO: Check for support
		// "prettier-plugin-sh",
		// @TODO: Check for support
		// "prettier-plugin-sort-imports",
		// @TODO: Check for support
		// "prettier-plugin-sql",
		// @TODO: Check for support
		// "prettier-plugin-svelte",
		// @TODO: Check for support
		// "prettier-plugin-tailwindcss",
		// @TODO: Check for support
		// "prettier-plugin-toml",
		// @TODO: Check for support
		// "prettier-plugin-packagejson",
	],
	tailwindConfig:
		"D:\\Developer\\Application\\NikolaRHristov\\dot\\.config\\base\\tailwind.js",
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
