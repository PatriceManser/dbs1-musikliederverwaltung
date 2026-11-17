#!/bin/bash
# Startet Postgres + pgAdmin in Docker und oeffnet pgAdmin im Browser.
#   ./db.sh        starten
#   ./db.sh test   alle Skripte wie bei der Abgabe ausfuehren
#   ./db.sh stop   alles stoppen und entfernen
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

case "${1:-start}" in
    start)
        docker compose up -d --wait
        echo "Warte auf pgAdmin..."
        until curl -sfL -o /dev/null http://localhost:5050; do sleep 2; done
        echo "pgAdmin: http://localhost:5050  (Projektordner im Container unter /scripts)"
        open http://localhost:5050
        ;;
    test)
        docker compose exec -w /scripts postgres \
            psql -U postgres -v ON_ERROR_STOP=on -f 0_runAllScripts.sql
        ;;
    stop)
        docker compose down
        ;;
    *)
        echo "Usage: $0 [start|test|stop]" >&2
        exit 1
        ;;
esac
