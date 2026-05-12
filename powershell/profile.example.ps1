# =========================================================
# Public-safe PowerShell 7 profile example
# =========================================================
# This file contains example shell configuration only.
# No credentials, tokens, private hostnames, or sensitive
# machine-specific information are included.
# =========================================================

# ---------------------------------------------------------
# AWS CLI autocomplete
# ---------------------------------------------------------
if (Get-Command aws_completer.exe -ErrorAction SilentlyContinue) {

    Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {

        param($commandName, $wordToComplete, $cursorPosition)

        $env:COMP_LINE = $wordToComplete

        if ($env:COMP_LINE.Length -lt $cursorPosition) {
            $env:COMP_LINE = $env:COMP_LINE + " "
        }

        $env:COMP_POINT = $cursorPosition

        aws_completer.exe | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(
                $_,
                $_,
                'ParameterValue',
                $_
            )
        }

        Remove-Item Env:\COMP_LINE -ErrorAction SilentlyContinue
        Remove-Item Env:\COMP_POINT -ErrorAction SilentlyContinue
    }
}

# ---------------------------------------------------------
# UTF-8 terminal configuration
# ---------------------------------------------------------
chcp 65001 > $null

$OutputEncoding = [System.Text.UTF8Encoding]::new()

[Console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# ---------------------------------------------------------
# Useful aliases
# ---------------------------------------------------------
Set-Alias ll Get-ChildItem
Set-Alias grep Select-String

# ---------------------------------------------------------
# Terraform helper
# ---------------------------------------------------------
function tfinit {
    terraform init
}

# ---------------------------------------------------------
# Docker helper
# ---------------------------------------------------------
function dps {
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# ---------------------------------------------------------
# Git helper
# ---------------------------------------------------------
function gs {
    git status
}

# ---------------------------------------------------------
# Prompt indicator
# ---------------------------------------------------------
Write-Host "PowerShell 7 profile loaded." -ForegroundColor DarkGray