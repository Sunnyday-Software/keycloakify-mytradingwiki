import type { StorybookConfig } from "@storybook/react-vite";
import { loadEnv, mergeConfig } from "vite";

const config: StorybookConfig = {
    stories: ["../src/**/*.mdx", "../src/**/*.stories.@(js|jsx|mjs|ts|tsx)"],
    addons: [],
    framework: {
        name: "@storybook/react-vite",
        options: {}
    },
    staticDirs: ["../public"],
    viteFinal: async (baseConfig, { configType }) => {
        const mode = process.env.STORYBOOK_VITE_MODE ?? (configType === "PRODUCTION" ? "production" : "development");
        const env = loadEnv(mode, process.cwd(), ["VITE_", "STORYBOOK_"]);

        return mergeConfig(baseConfig, {
            envPrefix: ["VITE_", "STORYBOOK_"],
            define: Object.fromEntries(Object.entries(env).map(([key, value]) => [`import.meta.env.${key}`, JSON.stringify(value)]))
        });
    }
};
export default config;
