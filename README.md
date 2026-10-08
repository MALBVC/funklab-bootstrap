# funklab-bootstrap

Public, secret-free entry point for rebuilding a personal workstation. It installs git and the GitHub CLI, signs in to GitHub, and clones the private repo that holds the real rebuild scripts.

Run in an elevated PowerShell:

    irm https://raw.githubusercontent.com/MALBVC/funklab-bootstrap/main/00_bootstrap.ps1 | iex
