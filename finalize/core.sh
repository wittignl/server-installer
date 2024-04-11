#!/bin/bash

# Package Cleanup
echo "Cleaning up unused system packages..."
apt autoremove -yqqq
echo "  Successfully cleaned up unused system packages!"