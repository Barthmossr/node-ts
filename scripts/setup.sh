#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[INFO]${NC} Setting up Node.js TypeScript project..."
echo ""

if ! command -v node &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Node.js is not installed. Please install Node.js v24.11.1"
    exit 1
fi

REQUIRED_NODE_VERSION="24.11.1"
CURRENT_NODE_VERSION=$(node -v | sed 's/v//')

if [ "$CURRENT_NODE_VERSION" != "$REQUIRED_NODE_VERSION" ]; then
    echo -e "${YELLOW}[WARN]${NC} Node.js version mismatch"
    echo "       Required: v$REQUIRED_NODE_VERSION"
    echo "       Current:  v$CURRENT_NODE_VERSION"
    echo ""
    echo "       Run 'nvm use' to switch to the correct version"
    echo ""
fi

echo -e -n "${BLUE}[INFO]${NC} Installing dependencies... "
if npm install --silent 2>&1 | tee /tmp/npm_install.log > /dev/null; then
    echo -e "${GREEN}done${NC}"
else
    echo -e "${RED}failed${NC}"
    echo -e "${RED}[ERROR]${NC} Failed to install dependencies:"
    cat /tmp/npm_install.log
    exit 1
fi

echo -e -n "${BLUE}[INFO]${NC} Setting up git hooks... "
if npm run prepare --silent 2>&1 | tee /tmp/npm_prepare.log > /dev/null; then
    echo -e "${GREEN}done${NC}"
else
    echo -e "${RED}failed${NC}"
    echo -e "${RED}[ERROR]${NC} Failed to set up git hooks:"
    cat /tmp/npm_prepare.log
    exit 1
fi

echo -e -n "${BLUE}[INFO]${NC} Verifying setup... "
if npm run validate --silent 2>&1 | tee /tmp/npm_validate.log > /dev/null; then
    echo -e "${GREEN}done${NC}"
else
    echo -e "${RED}failed${NC}"
    echo -e "${RED}[ERROR]${NC} Validation failed:"
    cat /tmp/npm_validate.log
    exit 1
fi

rm -f /tmp/npm_install.log /tmp/npm_prepare.log /tmp/npm_validate.log

echo ""
echo -e "${GREEN}[SUCCESS]${NC} Setup complete"
echo ""
echo "Available commands:"
echo "  npm run dev        - Run in development mode"
echo "  npm run dev:watch  - Run with hot reload"
echo "  npm run build      - Build for production"
echo "  npm test           - Run tests"
echo "  npm run validate   - Run all quality checks"
echo ""
