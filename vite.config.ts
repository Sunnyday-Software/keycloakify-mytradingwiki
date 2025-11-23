import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { keycloakify } from "keycloakify/vite-plugin";
import tailwindcss from "@tailwindcss/vite";

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        react(),
        keycloakify({

            accountThemeImplementation: "none",
            environmentVariables: [
                /*{ name: "MY_APP_API_URL", default: "http://localhost:8080" },*/
            ]
        }),
        tailwindcss()
    ],
    resolve: {
        preserveSymlinks: true // Enable symlink support for shared assets
    }
});
