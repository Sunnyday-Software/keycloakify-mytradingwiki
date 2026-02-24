import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { keycloakify } from "keycloakify/vite-plugin";
import tailwindcss from "@tailwindcss/vite";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        react(),
        keycloakify({
            themeName: "mytradingwiki",
            accountThemeImplementation: "none",
            // For runtime env vars - passed to Keycloak server via -e flags
            environmentVariables: [
                { name: "ASTRO_APP_URL", default: "http://localhost:4321" },
                { name: "ASTRO_INFO_REDIRECT_TIMEOUT_MS", default: "5000" }
            ],
            // Also set as extraThemeProperties for local dev (bypass env var substitution issues)
            extraThemeProperties: [
                "ASTRO_APP_URL=http://localhost:4321",
                "ASTRO_INFO_REDIRECT_TIMEOUT_MS=5000"
            ]
        }),
        tailwindcss()
    ],
    resolve: {
        preserveSymlinks: true,
        alias: {
            "@shared": path.resolve(
                __dirname,
                "node_modules/@sunny-pirate/mytradingwiki-assets"
            )
        }
    }
});
