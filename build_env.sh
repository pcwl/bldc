#!/bin/bash
# VESC BLDC Firmware Build Environment Setup Script
# This script sets up the necessary environment variables for building VESC firmware

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH="${SCRIPT_DIR}/tools/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/bin:$PATH"

echo "✓ VESC Build Environment Configured"
echo "  ARM Toolchain: $(arm-none-eabi-gcc --version | head -1)"
echo ""
echo "Available build targets:"
echo "  - make fw                    # Build firmware for default target"
echo "  - make <board_name>          # Build firmware for specific board"
echo "  - make all_fw                # Build firmware for all boards"
echo "  - make 100_250               # Example: Build for VESC 100/250"
echo ""
echo "Run 'make' to see all available boards and options"
