#!/bin/bash
# Keycloak Development Helper Script
#
# Usage:
#   ./scripts/keycloak-dev.sh start         # Start Keycloak
#   ./scripts/keycloak-dev.sh stop          # Stop Keycloak
#   ./scripts/keycloak-dev.sh restart       # Restart Keycloak
#   ./scripts/keycloak-dev.sh --reset       # Reset database and restart
#   ./scripts/keycloak-dev.sh logs          # Show logs

set -e

COMPOSE_FILE="docker-compose.keycloak.yml"
VOLUME_NAME="solutions-dreamlab-trademind_postgres_keycloak_data"

case "$1" in
    start)
        echo "Starting Keycloak services..."
        docker compose -f "$COMPOSE_FILE" up -d
        echo "✅ Keycloak started"
        echo "   Admin Console: http://localhost:8080/admin (admin/admin)"
        echo "   Account Console: http://localhost:8080/realms/mytradingwiki-dev/account"
        echo "   Test User: testuser / password123"
        ;;

    stop)
        echo "Stopping Keycloak services..."
        docker compose -f "$COMPOSE_FILE" down
        echo "✅ Keycloak stopped"
        ;;

    restart)
        echo "Restarting Keycloak services..."
        docker compose -f "$COMPOSE_FILE" restart
        echo "✅ Keycloak restarted"
        ;;

    --reset)
        echo "🔄 Resetting Keycloak environment..."
        echo ""
        echo "This will:"
        echo "  - Stop all Keycloak containers"
        echo "  - Remove PostgreSQL data volume"
        echo "  - Recreate realm and test user"
        echo "  - Reapply custom theme"
        echo ""
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Stopping containers..."
            docker compose -f "$COMPOSE_FILE" down

            echo "Removing PostgreSQL volume..."
            docker volume rm "$VOLUME_NAME" 2>/dev/null || echo "Volume not found or already removed"

            echo "Starting fresh Keycloak environment..."
            docker compose -f "$COMPOSE_FILE" up -d

            echo ""
            echo "✅ Keycloak environment reset complete!"
            echo ""
            echo "Waiting for initialization (this may take 30-60 seconds)..."
            echo "Follow logs with: ./scripts/keycloak-dev.sh logs"
            echo ""
            echo "Once ready, login with:"
            echo "  Admin: admin / admin"
            echo "  Test User: testuser / password123"
        else
            echo "Reset cancelled."
        fi
        ;;

    logs)
        echo "Following Keycloak logs (Ctrl+C to exit)..."
        docker compose -f "$COMPOSE_FILE" logs -f
        ;;

    --help|help|-h)
        echo "Keycloak Development Helper"
        echo ""
        echo "Usage:"
        echo "  ./scripts/keycloak-dev.sh start      Start Keycloak services"
        echo "  ./scripts/keycloak-dev.sh stop       Stop Keycloak services"
        echo "  ./scripts/keycloak-dev.sh restart    Restart Keycloak services"
        echo "  ./scripts/keycloak-dev.sh --reset    Reset database and recreate environment"
        echo "  ./scripts/keycloak-dev.sh logs       Show and follow logs"
        echo "  ./scripts/keycloak-dev.sh help       Show this help"
        ;;

    *)
        echo "❌ Unknown command: $1"
        echo "Run './scripts/keycloak-dev.sh help' for usage"
        exit 1
        ;;
esac
