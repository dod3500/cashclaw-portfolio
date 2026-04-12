#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  Portable AI USB - Uninstall (Linux)
# ═══════════════════════════════════════════════════════════

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'
DIM='\033[90m'; BOLD='\033[1m'; RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"
DATA_DIR="$ROOT_DIR/data"

echo ""
echo -e "${CYAN}=========================================================${RESET}"
echo -e "  ${BOLD}Portable AI USB - Uninstall${RESET}"
echo -e "${CYAN}=========================================================${RESET}"
echo ""
echo "  This tool will remove installed components."
echo ""

HAS_BIN=0; HAS_DATA=0
[ -d "$BIN_DIR" ] && HAS_BIN=1
[ -d "$DATA_DIR" ] && HAS_DATA=1

if [ $HAS_BIN -eq 0 ] && [ $HAS_DATA -eq 0 ]; then
    echo -e "  ${DIM}Nothing to uninstall. Already clean.${RESET}"
    exit 0
fi

# Calculate sizes
BIN_SIZE="0"; DATA_SIZE="0"
[ $HAS_BIN -eq 1 ] && BIN_SIZE=$(du -shm "$BIN_DIR" 2>/dev/null | awk '{print $1}')
[ $HAS_DATA -eq 1 ] && DATA_SIZE=$(du -shm "$DATA_DIR" 2>/dev/null | awk '{print $1}')

echo -e "  ${BOLD}What would you like to remove?${RESET}"
echo ""
[ $HAS_BIN -eq 1 ] && echo -e "  ${CYAN}1)${RESET} Engine only ${DIM}(bin folder - ${BIN_SIZE} MB)${RESET}"
[ $HAS_BIN -eq 1 ] && [ $HAS_DATA -eq 1 ] && echo -e "  ${CYAN}2)${RESET} Everything  ${DIM}(bin + data folders)${RESET}"
echo -e "  ${CYAN}3)${RESET} Cancel"
echo ""

read -p "  Select option: " CHOICE

case "$CHOICE" in
    1)
        if [ $HAS_BIN -eq 1 ]; then
            echo ""
            echo -e "  ${RED}${BOLD}WARNING: This will delete the bin folder!${RESET}"
            echo -e "  ${DIM}You will need to run setup_first_time.sh again.${RESET}"
            echo ""
            read -p "  Are you sure? (Y/N): " CONFIRM
            if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                echo ""
                echo -e "  ${YELLOW}[~] Removing engine files...${RESET}"
                rm -rf "$BIN_DIR"
                echo -e "  ${GREEN}[OK] Engine removed! Freed ~${BIN_SIZE} MB${RESET}"
            else
                echo -e "  ${DIM}Cancelled.${RESET}"
            fi
        fi ;;
    2)
        if [ $HAS_BIN -eq 1 ] && [ $HAS_DATA -eq 1 ]; then
            echo ""
            echo -e "  ${RED}${BOLD}WARNING: This will delete ALL data including:${RESET}"
            echo -e "  ${RED}  - AI Engine (bin folder)${RESET}"
            echo -e "  ${RED}  - API keys and settings${RESET}"
            echo -e "  ${RED}  - Chat history and logs${RESET}"
            echo ""
            read -p "  Type 'DELETE' to confirm: " CONFIRM
            if [ "$CONFIRM" = "DELETE" ]; then
                echo ""
                echo -e "  ${YELLOW}[~] Removing all files...${RESET}"
                rm -rf "$BIN_DIR" "$DATA_DIR"
                TOTAL=$((BIN_SIZE + DATA_SIZE))
                echo -e "  ${GREEN}[OK] Everything removed! Freed ~${TOTAL} MB${RESET}"
            else
                echo -e "  ${DIM}Cancelled. You must type DELETE exactly.${RESET}"
            fi
        fi ;;
    3|*)
        echo ""
        echo -e "  ${DIM}Cancelled. Nothing was removed.${RESET}" ;;
esac
echo ""
