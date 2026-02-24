<p align="center">
    <i>🚀 <a href="https://keycloakify.dev">Keycloakify</a> v11 starter 🚀</i>
    <br/>
    <br/>
</p>

# Quick start

```bash
git clone https://github.com/keycloakify/keycloakify-starter
cd keycloakify-starter
yarn install # Or use an other package manager, just be sure to delete the yarn.lock if you use another package manager.
```

# Shared Assets

This theme uses shared assets from the `mytradingwiki-assets` repository via package dependency.

## Initial Setup

After cloning this repository, install dependencies:

```bash
pnpm install
```

This installs `@sunny-pirate/mytradingwiki-assets` in `node_modules/`.

## Updating Shared Assets

To pull the latest shared assets:

```bash
# Update dependency reference
pnpm update @sunny-pirate/mytradingwiki-assets

# Commit package manifest/lock changes
git add package.json pnpm-lock.yaml
git commit -m "chore: update shared assets package version"
```

## Making Changes to Shared Assets

If you need to modify shared files, do it in:

- `Sunnyday-Software/mytradingwiki-assets`

Then bump the dependency in this repository.

## Troubleshooting

**Issue**: Build fails with missing shared assets
**Solution**: Ensure dependency is installed: `pnpm install`

# Testing the theme locally

[Documentation](https://docs.keycloakify.dev/testing-your-theme)

## Frontend redirect env (local override + production fallback)

This theme supports runtime redirect overrides via `kcContext.properties`.

- `ASTRO_APP_URL`: when present, login/register and info redirects point to the Astro app.
- `ASTRO_INFO_REDIRECT_TIMEOUT_MS`: optional info-page timeout in milliseconds.

Behavior:

- Register link on `login.ftl` is locale-aware: `/{locale}/auth/register`.
- Info-page redirect target is locale-aware first, then falls back to Keycloak URLs.
- If overrides are missing, existing public/Keycloak fallback behavior is preserved.

Local example:

```bash
ASTRO_APP_URL=http://localhost:4321
ASTRO_INFO_REDIRECT_TIMEOUT_MS=2500
```

Detailed guide: `docs/development/keycloak-frontend-redirect-env.adoc`.

# Email theme (HTML)

## Where to edit

-   Templates: `src/email/html/`
-   Tokens (EN/IT/NL): `src/email/messages/messages_en_override.properties`, `src/email/messages/messages_it_override.properties`, `src/email/messages/messages_nl_override.properties`
-   Assets: `src/email/resources/`

## Local preview / test

```bash
npm run test-email-theme
```

Then set **Email theme** to `mytradingwiki` in Keycloak and trigger emails.
Manual QA checklist and expected outputs: `docs/email/local-email-testing.md`.

# How to customize the theme

[Documentation](https://docs.keycloakify.dev/customization-strategies)

# Building the theme

You need to have [Maven](https://maven.apache.org/) installed to build the theme (Maven >= 3.1.1, Java >= 7).  
The `mvn` command must be in the $PATH.

-   On macOS: `brew install maven`
-   On Debian/Ubuntu: `sudo apt-get install maven`
-   On Windows: `choco install openjdk` and `choco install maven` (Or download from [here](https://maven.apache.org/download.cgi))

```bash
npm run build-keycloak-theme
```

Note that by default Keycloakify generates multiple .jar files for different versions of Keycloak.  
You can customize this behavior, see documentation [here](https://docs.keycloakify.dev/features/compiler-options/keycloakversiontargets).

# Deploying the theme

1. Build the theme JARs:
    ```bash
    npm run build-keycloak-theme
    ```
2. Use the generated JAR from `dist_keycloak/` and load it as a Keycloak provider (container mount or Keycloak installation).
3. Run `kc.sh build` after adding the provider, then select the theme in **Realm Settings → Themes**.

## Backend deploy flow (local + production)

### Local operator flow (`solutions-dreamlab-trademind-backend`)

Run from this repository root.

1. Stop running backend app containers (`mytw_api*`):
   ```bash
   docker ps --format '{{.Names}}' | grep '^mytw_api' | xargs -r docker stop
   ```

2. Build and deploy the theme jar:
   ```bash
   npm run build-keycloak-theme
   npm run deploy-backend-theme
   ```

   `deploy-backend-theme` copies the built provider to backend path:
   `../solutions-dreamlab-trademind-backend/keycloak/keycloak-theme/mytradingwiki-theme.jar`

3. Restart backend stack through dpm and launch Quarkus dev:
   ```bash
   cd ../solutions-dreamlab-trademind-backend
   ./dpm.sh app-dev
   ```
   Then select menu option `2`.

4. Verify theme jar is mounted in Keycloak container:
   ```bash
   docker exec -it mytw_keycloak_1 ls -l /opt/keycloak/providers/mytradingwiki-theme.jar
   ```

5. Verify realm `devrealm` uses login theme `mytradingwiki`:
   ```bash
   docker exec -it mytw_keycloak_1 /opt/keycloak/bin/kcadm.sh get realms/devrealm --fields realm,loginTheme
   ```

### Local `.env.development` override (frontend redirects)

`dpm.sh` loads `.env.*` files (including `.env.development`).

Example local file in backend repo:

```bash
# .env.development
ASTRO_APP_URL=http://localhost:4321
ASTRO_INFO_REDIRECT_TIMEOUT_MS=2500
```

### Production flow (manual, no automatic remote push)

For production updates in external repo `keycloak-sunnyday-software`:

1. Build the theme jar in this repository.
2. Manually replace target provider jar with `mytradingwiki-theme.jar` in `keycloak-sunnyday-software`.
3. Commit and push manually in that external repo, following its release process.

This repository does not perform automatic push/deploy to `keycloak-sunnyday-software`.

### Troubleshooting: `KME_API_KEY` Quarkus blocker

If app-dev startup fails with a Quarkus error about `KME_API_KEY`, treat it as backend runtime configuration issue.

- It does not indicate a theme deploy failure.
- Theme deploy is complete once `mytradingwiki-theme.jar` is present in Keycloak providers and `devrealm` has `loginTheme=mytradingwiki`.

For full operator runbook and backend-side checks see:

- `docs/development/keycloak-frontend-redirect-env.adoc`
- `../solutions-dreamlab-trademind-backend/docs/keycloak-env-injection.adoc`

# Initializing the account theme

```bash
npx keycloakify initialize-account-theme
```

# Initializing the email theme

```bash
npx keycloakify initialize-email-theme
```

# GitHub Actions

The starter comes with a generic GitHub Actions workflow that builds the theme and publishes
the jars [as GitHub releases artifacts](https://github.com/keycloakify/keycloakify-starter/releases/tag/v10.0.0).  
To release a new version **just update the `package.json` version and push**.

To enable the workflow go to your fork of this repository on GitHub then navigate to:
`Settings` > `Actions` > `Workflow permissions`, select `Read and write permissions`.
