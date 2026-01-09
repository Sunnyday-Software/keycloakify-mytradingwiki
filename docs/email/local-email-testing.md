# Local Email Template Testing

Use this guide to preview the Keycloak email theme locally with a running Keycloak instance.

## Prerequisites
- Docker running locally
- Node.js per `package.json` engines

## Commands
- `npm run test-email-theme` starts a Keycloak container preconfigured for Keycloakify development.
- `npm run build-keycloak-theme` builds the theme JARs (only needed if you want to test a packaged JAR).

## Steps
1. Start Keycloak:
   ```bash
   npm run test-email-theme
   ```
2. Log in to the Keycloak admin console from the URL printed in the terminal.
3. Open your realm and go to **Realm Settings → Themes**.
4. Set **Email theme** to `mytradingwiki` and save.
5. Trigger an email (for example: verify email or reset password) from the admin console or login flow.

## Where to Edit Templates
- HTML templates: `src/email/html/`
- i18n tokens: `src/email/messages/messages_*.properties`
- Assets: `src/email/resources/`

## Notes
- The HTML email templates use inline styles for email-client compatibility.
- If you update assets, restart the Keycloak container to ensure changes are picked up.
