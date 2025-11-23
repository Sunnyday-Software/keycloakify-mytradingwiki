# Keycloakify Asset Migration - Remaining Tasks

## Context
The shared assets repository has been created and the submodule has been added to this keycloakify theme repo. The webapp (solutions-dreamlab-trademind) is being migrated in parallel.

**Assets Repository**: `git@github.com:Sunnyday-Software/mytradingwiki-assets.git`
**Current Branch**: `chore/extract-assets-submodule`
**Submodule Location**: `shared/assets/`

## Completed
✅ Submodule added at `shared/assets`
✅ Vite config updated with `preserveSymlinks: true`
✅ Favicon symlink created: `assets/favicon.svg -> ../shared/assets/assets/icons/favicon.svg`
✅ Build verified and passes

## Remaining Tasks

### Task 1: Review and Integrate Shared Theme Tokens (Optional)
The webapp uses `shared/assets/styles/theme.css` which contains comprehensive CSS variables (design tokens). Review if keycloakify should import these tokens for consistency.

**Current State**: Keycloakify has its own `src/login/main.css` with custom variables:
- `--pf-global--*` variables for PatternFly compatibility
- Custom Tailwind color mappings
- Background image reference

**Decision Needed**:
- Keep keycloakify CSS independent (current approach), OR
- Import shared tokens and map them to PatternFly variables

**If integrating shared tokens**:
```css
/* src/login/main.css */
@import "../../shared/assets/styles/theme.tokens.css"; /* Once refactored */

/* Then map shared tokens to PF variables */
:root {
    --pf-global--primary-color--100: var(--color-emerald-500);
    /* etc */
}
```

### Task 2: Verify Visual Consistency with Webapp
1. **Start Storybook**: `yarn storybook`
2. **Check Login Page**: Verify branding matches webapp
   - Logo colors
   - Primary colors (emerald green)
   - Font families (Exo 2, Open Sans)
   - Background styling
3. **Check Registration Page**: Same verification

**Expected**: Login/registration UI should match webapp branding since both use similar color tokens.

### Task 3: Document Submodule Workflow
Add to `README.md`:

```markdown
## Shared Assets

This theme uses shared assets from the `mytradingwiki-assets` repository via git submodule.

### Initial Setup
```bash
git submodule update --init --recursive
```

### Updating Shared Assets
```bash
# Pull latest assets
git submodule update --remote shared/assets

# Commit the submodule pointer update
git add shared/assets
git commit -m "chore: update shared assets to latest version"
```

### Making Changes to Shared Assets
1. Navigate to `shared/assets/`
2. Make changes and commit in that directory
3. Push changes to the assets repo
4. Return to keycloakify root and update submodule pointer (see above)
```

### Task 4: CI/CD Pipeline Updates (If Applicable)
If you have CI/CD pipelines (GitHub Actions, GitLab CI, etc.), ensure they include:

```yaml
# Example GitHub Actions snippet
steps:
  - name: Checkout code with submodules
    uses: actions/checkout@v4
    with:
      submodules: recursive

  - name: Install dependencies
    run: yarn install

  - name: Build theme
    run: yarn build
```

### Task 5: Cleanup After Webapp Refactor Completes
Once the webapp completes Phase 5 (theme.css refactor into tokens + utilities):

1. **Update submodule**: `git submodule update --remote shared/assets`
2. **Consider importing split stylesheets**:
   ```css
   /* If you want shared tokens */
   @import "../../shared/assets/styles/theme.tokens.css";

   /* If you want shared utilities (optional) */
   @import "../../shared/assets/styles/theme.utilities.css";
   ```
3. **Test build**: `yarn build`
4. **Commit changes**: `git add . && git commit -m "chore: integrate refactored shared theme styles"`

### Task 6: Merge and Deploy
1. **Push branch**: `git push -u origin chore/extract-assets-submodule`
2. **Create PR**: Against `main` branch
3. **Test deployment**: Ensure JAR build includes symlinked assets correctly
4. **Merge**: After approval and successful tests

## Notes
- **Favicon**: Already symlinked to shared assets ✅
- **Submodule Pointer**: Commit hash `f07535a` (initial import)
- **Build Status**: Passing ✅
- **No breaking changes**: Current build still works with existing CSS

## Questions?
- Should we unify theme tokens between webapp and keycloakify?
- Should we use the same theme.css entirely, or keep separate for flexibility?
- Current approach: Shared assets available, but keycloakify uses its own CSS (most flexible)

---

**Created**: 2025-11-23
**Status**: Ready for independent completion
**Branch**: `chore/extract-assets-submodule`