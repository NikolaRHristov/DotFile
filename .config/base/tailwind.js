const MODULES_DIR = "C:\\Users\\nhris\\AppData\\Roaming\\npm\\node_modules\\";

module.exports = {
	content: [
		"**/public/**/*.html",
		"**/src/**/*.{astro,js,jsx,ts,tsx,vue,svelte}",
	],
	darkMode: "media",
	theme: {
		container: {
			center: true,
		},
	},
	variants: {},
	plugins: [
		require(MODULES_DIR + "@tailwindcss/forms"),
		require(MODULES_DIR + "@tailwindcss/typography"),
		require(MODULES_DIR + "@tailwindcss/line-clamp"),
		require(MODULES_DIR + "@tailwindcss/aspect-ratio"),
	],
};
