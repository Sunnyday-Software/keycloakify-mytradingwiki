# Keycloak Setup for MyTradingWiki

## Docker Compose Setup

### Start Keycloak
```bash
docker compose -f docker-compose.keycloak.yml up -d
```

### Stop Keycloak
```bash
docker compose -f docker-compose.keycloak.yml down
```

### View Logs
```bash
docker compose -f docker-compose.keycloak.yml logs -f keycloak
```

---

## Realm Configuration

### Realm Details
- **Realm Name**: `mytradingwiki-dev` (development)
- **Realm Name**: `mytradingwiki` (production)
- **Display Name**: MyTradingWiki Development
- **Login Theme**: `keycloakify-starter` (custom theme)

### Access URLs

**Development**:
- Admin Console: http://localhost:8080/admin
- Realm Account: http://localhost:8080/realms/mytradingwiki-dev/account
- Auth Server: http://localhost:8080

**Production**:
- Admin Console: https://auth.mytradingwiki.com/admin
- Realm Account: https://auth.mytradingwiki.com/realms/mytradingwiki/account
- Auth Server: https://auth.mytradingwiki.com

---

## OIDC Client Configuration

### Client Details

**Client ID**: `mytradingwiki-app`
**Client Secret** (Development): `4cSuRceu7MZeJHCtTh1In5shmt7auzNx`
**Protocol**: OpenID Connect
**Access Type**: Confidential (requires client secret)

### Client Settings

```json
{
  "clientId": "mytradingwiki-app",
  "enabled": true,
  "publicClient": false,
  "protocol": "openid-connect",
  "standardFlowEnabled": true,
  "directAccessGrantsEnabled": true,
  "redirectUris": [
    "http://localhost:4321/*",
    "https://www.mytradingwiki.com/*"
  ],
  "webOrigins": [
    "http://localhost:4321",
    "https://www.mytradingwiki.com"
  ]
}
```

---

## Astro App Environment Variables

Add to `.env.local` or `.env.development`:

```bash
# Keycloak OIDC Configuration
PUBLIC_OIDC_AUTH_SERVER_URL=http://localhost:8080/realm/mytradingwiki-dev
KEYCLOAK_CLIENT_ID=mytradingwiki-app
KEYCLOAK_CLIENT_SECRET=4cSuRceu7MZeJHCtTh1In5shmt7auzNx
```

For production (`.env.production`):

```bash
# Keycloak OIDC Configuration
PUBLIC_OIDC_AUTH_SERVER_URL=https://auth.mytradingwiki.com/realm/mytradingwiki
KEYCLOAK_CLIENT_ID=mytradingwiki-app
KEYCLOAK_CLIENT_SECRET=<production-secret-here>
```

---

## Authentication Flow

### 1. User Registration (Astro App → Sunnyday Backend → Keycloak)

```
User fills form → Astro POST /api/auth/register
              → Sunnyday Backend creates user in Keycloak
              → Keycloak sends verification email
              → Astro shows "Check your email" page
```

### 2. Email Verification & Login (Email → Keycloak → Astro)

```
User clicks email link → Keycloak verification endpoint
                      → Keycloak shows login page (custom theme)
                      → User enters credentials
                      → Keycloak sets cookie (domain: .mytradingwiki.com)
                      → Keycloak redirects to: http://localhost:4321/{locale}/dashboard
                      → User lands on dashboard, authenticated
```

**Email Link Format**:
```
http://localhost:8080/realms/mytradingwiki-dev/login-actions/action-token
  ?key={verification_token}
  &client_id=mytradingwiki-app
  &redirect_uri=http://localhost:4321/en/dashboard
```

**Important**: The backend must include `redirect_uri` parameter with user's locale (`/en/`, `/it/`, etc.)

---

## Cookie Configuration

### Development (localhost)

Cookie domain: `localhost`
Secure flag: `false` (HTTP allowed)
SameSite: `Lax`

### Production

Cookie domain: `.mytradingwiki.com`
Secure flag: `true` (HTTPS only)
SameSite: `Lax`

**Cookie Name**: Set by Keycloak (usually `KEYCLOAK_SESSION`, `KEYCLOAK_IDENTITY`)

---

## Admin Credentials

**Development**:
- Username: `admin`
- Password: `admin`

**Production**:
- Use secure credentials (not documented here)

---

## Troubleshooting

### Theme Not Loading

1. Verify theme JAR is mounted:
   ```bash
   docker exec mytradingwiki-keycloak ls -lh /opt/keycloak/providers/
   ```

2. Check Keycloak logs for theme loading:
   ```bash
   docker logs mytradingwiki-keycloak 2>&1 | grep -i theme
   ```

3. Restart Keycloak:
   ```bash
   docker compose -f docker-compose.keycloak.yml restart keycloak
   ```

### Invalid Redirect URI Error

1. Verify redirect URIs are configured:
   ```bash
   docker exec mytradingwiki-keycloak /opt/keycloak/bin/kcadm.sh \
     get clients/<client-id> -r mytradingwiki-dev --fields redirectUris
   ```

2. Add missing URI if needed

### CORS Errors

1. Verify web origins include Astro app URL
2. Check browser console for specific CORS error
3. Ensure Astro app's `/api/auth/session` endpoint allows Keycloak origin

---

## Manual Realm Configuration (if needed)

If automatic init script fails, configure manually via admin console:

1. **Create Realm**:
   - Admin Console → Create Realm
   - Name: `mytradingwiki-dev`
   - Enabled: true

2. **Set Theme**:
   - Realm Settings → Themes
   - Login Theme: `keycloakify-starter`
   - Save

3. **Create Client**:
   - Clients → Create Client
   - Client ID: `mytradingwiki-app`
   - Client Protocol: openid-connect
   - Access Type: confidential
   - Valid Redirect URIs: `http://localhost:4321/*`
   - Web Origins: `http://localhost:4321`
   - Save

4. **Get Client Secret**:
   - Clients → mytradingwiki-app → Credentials tab
   - Copy secret value

---

## Updating Theme

When you make changes to the Keycloakify theme:

1. **Build theme**:
   ```bash
   cd ../keycloakify-mytradingwiki
   yarn build-keycloak-theme
   ```

2. **Restart Keycloak** (theme JAR is volume-mounted, so restart picks up changes):
   ```bash
   cd ../solutions-dreamlab-trademind
   docker compose -f docker-compose.keycloak.yml restart keycloak
   ```

3. **Clear browser cache** and reload login page

---

## Production Deployment

For production deployment to `auth.mytradingwiki.com`:

1. Update Docker Compose with production settings:
   - Use production Keycloak image
   - Configure SSL certificates
   - Use secure database credentials
   - Update environment variables

2. Create production client with production redirect URIs

3. Configure DNS to point `auth.mytradingwiki.com` to Keycloak server

4. Update Astro app `.env.production` with production Keycloak URL and credentials

---

**Last Updated**: 2025-11-23
**Realm**: mytradingwiki-dev
**Client**: mytradingwiki-app
**Theme**: keycloakify-starter