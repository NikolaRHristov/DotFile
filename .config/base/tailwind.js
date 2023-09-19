const MODULES_DIR = "D:\\tools\\.pnpm-global\\5\\node_modules\\";

export default {
	content: [
		"**/Public/**/*.html",
		"**/Source/**/*.{astro,js,jsx,ts,tsx,vue,svelte}",
	],

	darkMode: "media",

	theme: {
		container: {
			center: true,
		},
	},

	variants: {},

	plugins: [
		require(`${MODULES_DIR}@tailwindcss/forms`),
		require(`${MODULES_DIR}@tailwindcss/typography`),
		require(`${MODULES_DIR}@tailwindcss/aspect-ratio`),
	],
};
