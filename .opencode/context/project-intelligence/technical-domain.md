<!-- Context: project-intelligence/technical-domain | Priority: critical | Version: 1.0 | Updated: 2026-02-12 -->

# Technical Domain

## Purpose
- Define project-specific Keycloakify + Storybook implementation patterns for `keycloakify-mytradingwiki`.
- Capture the actual interaction model used in stories, `kcContext` overrides, and runtime env propagation.

## Runtime Architecture Snapshot
- Entry point renders only when `window.kcContext` exists; otherwise shows a safe fallback (`No Keycloak Context`).
- `src/kc.gen.tsx` is generated and routes by `themeType` (`login` currently), exposing typed env names/defaults.
- `src/login/KcPage.tsx` switches by `kcContext.pageId`, with custom pages for `info.ftl` and `error.ftl`, and `DefaultPage` for remaining login pages.

## Storybook + Keycloakify Semantics

### 1) Naming IA for Login Flow Stories
- Canonical title builder: `createLoginFlowStoryTitle({ semanticName, pageId })`.
- IA format: `Authentication/Login Flow/{semanticName} ({pageId})`.
- Storybook global sort in preview enforces the Login Flow order and user-facing labels.
- Current aligned semantic names include: `Sign In`, `Password Recovery`, `First Login Confirm Email Address`, `Enrollment Email Verified`, `Post Login Information`.

### 2) Inter-Story Link Strategy via `kcContext.url` Overrides
- Navigation between stories is intentionally mocked by overriding Keycloak URLs inside story-level `kcContext`.
- Link generation helper: `createStorybookStoryHref({ title, exportName })` -> `/?path=/story/{story-id}`.
- Implemented flow examples:
  - `login.ftl` -> password recovery via `url.loginResetCredentialsUrl`.
  - `login-reset-password.ftl` -> sign in via `url.loginUrl`.
  - `login-idp-link-email.ftl` -> verify email via `url.loginAction`.
  - `login-verify-email.ftl` -> info page via `url.loginAction`.
  - `info.ftl` -> sign in via `actionUri` override.

### 3) Env Handling Strategy in Storybook Vite
- Storybook Vite config resolves mode using `STORYBOOK_VITE_MODE` or Storybook `configType` fallback.
- `loadEnv(mode, process.cwd(), ["VITE_", "STORYBOOK_"])` loads both app and Storybook-prefixed vars.
- `envPrefix` is explicitly set to `["VITE_", "STORYBOOK_"]`.
- Loaded env vars are injected into `define` as `import.meta.env.*` for predictable Storybook runtime access.
- Theme env contracts are defined in Keycloakify plugin config and generated into `kc.gen.tsx` (`ASTRO_APP_URL`, `ASTRO_INFO_REDIRECT_TIMEOUT_MS`).

### 4) `pageId` and State Conventions
- Story factory enforces typed `pageId` (`PageId extends KcContext["pageId"]`) and returns a page-specific mock renderer.
- Base mock context is centralized: `themeName` from generated `themeNames[0]` and `properties` from `kcEnvDefaults`.
- Story state naming convention is explicit and scenario-driven (`DefaultState`, `ReturnToSignIn`, `ContinueToInfo`, etc.).
- `kcContext` state overrides prefer minimal deltas (override only the branch needed: `url`, `properties`, `realm`, `message`, `messagesPerField`, etc.).
- App redirect behavior is property-first:
  - `Login`: registration CTA resolves to localized `/{lang}/auth/register` when `ASTRO_APP_URL` exists.
  - `Info`: redirect target prioritizes localized Astro dashboard, then falls back to Keycloak redirect/action/client URLs.
  - `Error`: back-to-application link is shown only when `ASTRO_APP_URL` is present.

## Operational Guardrails
- Treat `src/kc.gen.tsx` as generated source; do not hand-edit.
- Keep new login flow stories under the same IA and sorting hierarchy to preserve navigation predictability.
- For cross-story flow simulation, always link via helper-generated Storybook hrefs instead of hardcoded `path` ids.
- Preserve env key names across Vite plugin config, generated types, and `kcContext.properties` usage.

## Review Together Candidates
- Should non-login pages (for example `register.ftl`, `error.ftl`) be migrated into the same `Authentication/Login Flow/...` naming IA for consistency?
- Should we standardize export-name conventions across all stories (`DefaultState` vs `Default`) to simplify inter-story linking?
- Should `STORYBOOK_` variables remain exposed through `import.meta.env` in all modes, or be restricted to selected keys?

## 📂 Codebase References
- Storybook Vite env merge and define injection: `.storybook/main.ts`
- Storybook IA ordering for login flow: `.storybook/preview.ts`
- Story title and href helper patterns: `src/login/KcPageStory.tsx`
- Login flow link override examples:
  - `src/login/pages/Login.stories.tsx`
  - `src/login/pages/LoginResetPassword.stories.tsx`
  - `src/login/pages/LoginIdpLinkEmail.stories.tsx`
  - `src/login/pages/LoginVerifyEmail.stories.tsx`
  - `src/login/pages/Info.stories.tsx`
- Generated env contract + theme/page wiring: `src/kc.gen.tsx`
- Keycloakify Vite plugin env declaration: `vite.config.ts`
- Page routing by `pageId`: `src/login/KcPage.tsx`
- Redirect/property semantics in page implementations:
  - `src/login/pages/Login.tsx`
  - `src/login/pages/Info.tsx`
  - `src/login/pages/Error.tsx`
