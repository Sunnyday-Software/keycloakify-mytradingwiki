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

This theme uses shared assets from the `mytradingwiki-assets` repository via git submodule.

## Initial Setup

After cloning this repository, initialize the submodule:

```bash
git submodule update --init --recursive
```

This will populate the `shared/assets/` directory with the shared assets.

## Updating Shared Assets

To pull the latest changes from the shared assets repository:

```bash
# Pull latest assets
git submodule update --remote shared/assets

# Commit the submodule pointer update
git add shared/assets
git commit -m "chore: update shared assets to latest version"
```

## Making Changes to Shared Assets

If you need to modify files in the shared assets:

1. Navigate to the submodule directory:
   ```bash
   cd shared/assets
   ```

2. Make your changes and commit them:
   ```bash
   git add .
   git commit -m "your commit message"
   git push
   ```

3. Return to the keycloakify root and update the submodule pointer:
   ```bash
   cd ../..
   git add shared/assets
   git commit -m "chore: update shared assets submodule pointer"
   ```

## Troubleshooting

**Issue**: Build fails with missing assets or broken symlinks
**Solution**: Ensure submodule is initialized: `git submodule update --init --recursive`

**Issue**: Submodule shows as modified after pulling
**Solution**: The submodule pointer has been updated. Run `git submodule update` to sync to the correct commit.

# Testing the theme locally

[Documentation](https://docs.keycloakify.dev/testing-your-theme)

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
