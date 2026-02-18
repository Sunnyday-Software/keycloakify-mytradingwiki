# Local Email Template Testing

Use this guide to preview the Keycloak email theme locally with a running Keycloak instance.

## Prerequisites

-   Docker running locally
-   Node.js per `package.json` engines

## Commands

-   `npm run test-email-theme` starts a Keycloak container preconfigured for Keycloakify development.
-   `npm run build-keycloak-theme` builds the theme JARs (only needed if you want to test a packaged JAR).

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

-   HTML templates: `src/email/html/`
-   i18n tokens: `src/email/messages/messages_*.properties`
-   Assets: `src/email/resources/`

## Notes

-   The HTML email templates use inline styles for email-client compatibility.
-   If you update assets, restart the Keycloak container to ensure changes are picked up.

## Manual QA checklist (expected results)

Gmail Web:

-   Brand logo renders at the top of the card.
-   Title, intro, and context copy match the selected locale (EN/IT/NL).
-   Primary CTA button is visible and clickable.
-   Fallback link panel appears once and shows the full URL.
-   Expiration line shows a human-readable time window.
-   Footer support and signature are visible and aligned with brand copy.

Gmail Mobile:

-   Card fits the viewport width without horizontal scrolling.
-   CTA button is at least 44px tall and readable.
-   Text remains legible; spacing is consistent.
-   Fallback link panel is visible once and the URL is selectable.
