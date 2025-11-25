#!/bin/bash
set -e

echo "Waiting for Keycloak to be ready..."
# Simple approach: wait for Keycloak to be fully started
# Docker healthcheck ensures Keycloak is up, but we need to wait for all services
echo "Initial wait: 15 seconds for Keycloak to fully initialize..."
sleep 15

echo "Testing Keycloak availability with kcadm.sh..."
# Use kcadm.sh to test - this is the most reliable way

# Configure admin CLI
/opt/keycloak/bin/kcadm.sh config credentials \
    --server http://keycloak:8080 \
    --realm master \
    --user "${KEYCLOAK_ADMIN}" \
    --password "${KEYCLOAK_ADMIN_PASSWORD}"

# Check if realm exists
REALM_EXISTS=$(/opt/keycloak/bin/kcadm.sh get realms/mytradingwiki-dev 2>&1 | grep -c "Resource not found" || echo "exists")

if [ "$REALM_EXISTS" = "exists" ]; then
    echo "Realm 'mytradingwiki-dev' already exists. Updating theme..."
    /opt/keycloak/bin/kcadm.sh update realms/mytradingwiki-dev \
        -s loginTheme=mytradingwiki \
        -s displayName="MyTradingWiki Development" \
        -s displayNameHtml="<b>MyTradingWiki</b> Development"
else
    echo "Creating realm 'mytradingwiki-dev' with custom theme..."
    /opt/keycloak/bin/kcadm.sh create realms \
        -s realm=mytradingwiki-dev \
        -s enabled=true \
        -s loginTheme=mytradingwiki \
        -s displayName="MyTradingWiki Development" \
        -s displayNameHtml="<b>MyTradingWiki</b> Development" \
        -s registrationAllowed=true \
        -s resetPasswordAllowed=true \
        -s rememberMe=true \
        -s verifyEmail=false \
        -s loginWithEmailAllowed=true \
        -s duplicateEmailsAllowed=false \
        -s registrationEmailAsUsername=true
fi

# Create OIDC client for the application
echo "Creating OIDC client 'mytradingwiki-app'..."

# Check if client exists by checking if query returns empty array
CLIENT_QUERY=$(/opt/keycloak/bin/kcadm.sh get clients -r mytradingwiki-dev -q clientId=mytradingwiki-app 2>&1)

if echo "$CLIENT_QUERY" | grep -q "\"clientId\" : \"mytradingwiki-app\""; then
    echo "Client 'mytradingwiki-app' already exists. Skipping creation."
else
    echo "Creating new client 'mytradingwiki-app'..."

    /opt/keycloak/bin/kcadm.sh create clients -r mytradingwiki-dev \
        -s clientId=mytradingwiki-app \
        -s enabled=true \
        -s clientAuthenticatorType=client-secret \
        -s secret=nNCnyEZhH3Von09dWdWNoSqEYV1YfHTg \
        -s publicClient=false \
        -s standardFlowEnabled=true \
        -s directAccessGrantsEnabled=true \
        -s serviceAccountsEnabled=false \
        -s 'redirectUris=["http://localhost:4321/*","http://localhost:4321/api/auth/callback","https://www.mytradingwiki.com/*","https://app.mytradingwiki.local:4321/*"]' \
        -s 'webOrigins=["http://localhost:4321","https://www.mytradingwiki.com","https://app.mytradingwiki.local:4321"]' \
        -s baseUrl=http://localhost:4321/en/dashboard

    echo "Client 'mytradingwiki-app' created successfully!"
fi

# Create test user for development
echo "Creating test user..."

# Check if test user already exists (query by email since email = username)
TEST_USER_QUERY=$(/opt/keycloak/bin/kcadm.sh get users -r mytradingwiki-dev -q email=testuser@mytradingwiki.local 2>&1)

if echo "$TEST_USER_QUERY" | grep -q "\"email\" : \"testuser@mytradingwiki.local\""; then
    echo "Test user 'testuser@mytradingwiki.local' already exists. Skipping creation."
else
    echo "Creating new test user with email as username..."

    # Create user with email as username (registrationEmailAsUsername=true)
    USER_ID=$(/opt/keycloak/bin/kcadm.sh create users -r mytradingwiki-dev \
        -s username=testuser@mytradingwiki.local \
        -s email=testuser@mytradingwiki.local \
        -s firstName=Test \
        -s lastName=User \
        -s enabled=true \
        -s emailVerified=true \
        -i)

    # Set password
    /opt/keycloak/bin/kcadm.sh set-password -r mytradingwiki-dev \
        --username testuser@mytradingwiki.local \
        --new-password password123

    echo "Test user created successfully!"
    echo "  Email/Username: testuser@mytradingwiki.local"
    echo "  Password: password123"
fi

echo ""
echo "Realm configuration complete!"
echo "Theme 'mytradingwiki' is now active for realm 'mytradingwiki-dev'"
echo ""
echo "Access Keycloak:"
echo "  Admin Console: http://localhost:8080/admin"
echo "  Account Console: http://localhost:8080/realms/mytradingwiki-dev/account"
echo ""
echo "Test credentials:"
echo "  Admin: admin / admin"
echo "  Test User: testuser / password123"
