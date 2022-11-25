const MODULES_DIR = "C:\\Users\\nhris\\AppData\\Roaming\\npm\\node_modules\\";

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
		`${MODULES_DIR}@trivago/prettier-plugin-sort-imports`,
		`${MODULES_DIR}prettier-plugin-sort-imports`,
		`${MODULES_DIR}prettier-plugin-tailwindcss`,
		`${MODULES_DIR}@prettier/plugin-php`,
		`${MODULES_DIR}@prettier/plugin-lua`,
		`${MODULES_DIR}@prettier/plugin-php`,
		`${MODULES_DIR}prettier-plugin-astro`,
		`${MODULES_DIR}prettier-plugin-java`,
		`${MODULES_DIR}prettier-plugin-kotlin`,
		`${MODULES_DIR}prettier-plugin-pkg`,
		`${MODULES_DIR}prettier-plugin-sh`,
		`${MODULES_DIR}prettier-plugin-svelte`,
		`${MODULES_DIR}prettier-plugin-toml`,
	],
	tailwindConfig:
		"D:\\Developer\\app\\nikolaxhristov\\dot\\.config\\base\\tailwind.js",
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
};
