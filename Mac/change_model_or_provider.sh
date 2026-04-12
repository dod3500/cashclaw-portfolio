#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  Portable AI USB - Change Model/Provider (Linux)
# ═══════════════════════════════════════════════════════════

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'
DIM='\033[90m'; BOLD='\033[1m'; RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DATA_DIR="$ROOT_DIR/data"
ENV_FILE="$DATA_DIR/ai_settings.env"

echo ""
echo -e "${CYAN}=========================================================${RESET}"
echo -e "  ${BOLD}Portable AI USB - Reconfiguration Tool${RESET}"
echo -e "${CYAN}=========================================================${RESET}"
echo ""
echo "  This will clear your current API Key and Model choices"
echo "  and restart the setup menu so you can pick new ones."
echo ""

# Show current config
if [ -f "$ENV_FILE" ]; then
    echo -e "  ${BOLD}Current Configuration:${RESET}"
    echo -e "  ${CYAN}-------------------------------------------------${RESET}"
    while IFS='=' read -r key value; do
        [[ "$key" =~ ^#.* ]] && continue
        [ -z "$key" ] && continue
        # Mask API keys
        case "$key" in
            *API_KEY*) [ ${#value} -gt 10 ] && value="${value:0:6}****${value: -4}" ;;
        esac
        echo -e "  ${DIM}${key}${RESET} = ${GREEN}${value}${RESET}"
    done < "$ENV_FILE"
    echo -e "  ${CYAN}-------------------------------------------------${RESET}"
    echo ""
fi

read -p "  Reset configuration? (Y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "  ${DIM}Cancelled. No changes made.${RESET}"
    exit 0
fi

if [ -f "$ENV_FILE" ]; then
    rm "$ENV_FILE"
    echo ""
    echo -e "  ${GREEN}[OK] Previous configuration cleared!${RESET}"
    echo ""
else
    echo ""
    echo -e "  ${DIM}[INFO] No previous configuration found.${RESET}"
    echo ""
fi

echo -e "  ${CYAN}[~] Launching setup...${RESET}"
echo ""
exec bash "$SCRIPT_DIR/start_ai.sh"
