import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { keycloakify } from "keycloakify/vite-plugin";
import tailwindcss from "@tailwindcss/vite";

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        react(),
        keycloakify({
            themeName: "mytradingwiki",
            accountThemeImplementation: "none",
            environmentVariables: [
                { name: "ASTRO_APP_URL", default: "http://localhost:4321" },
                { name: "SESSION_ENDPOINT", default: "/api/auth/session" }
            ]
        }),
        tailwindcss()
    ],
    resolve: {
        preserveSymlinks: true, // Enable symlink support for shared assets
        alias: {
            '@shared': '/shared/assets'
        }
    }
});
