@echo off
REM ============================================================
REM Script: setup-python-env.bat
REM Description: Creates a Python 3.10.11 virtual environment
REM              with PySpark and IPyKernel installed
REM ============================================================

setlocal enabledelayedexpansion

REM Configuration
set ENV_NAME=python310env
set DISPLAY_NAME=Python 3.10.11 (Spark)

echo ============================================================
echo  Python 3.10.11 Environment Setup Script
echo ============================================================
echo.

REM Step 1: Check if Python 3.10 is available
echo [Step 1] Checking for Python 3.10...
py -3.10 --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python 3.10 is not installed or not found.
    echo Please install Python 3.10.11 from https://www.python.org/downloads/
    exit /b 1
)
py -3.10 --version
echo.

REM Step 2: Install virtualenv (if not already installed)
echo [Step 2] Ensuring virtualenv is installed...
pip install virtualenv >nul 2>&1
echo Done.
echo.

REM Step 3: Create the virtual environment
echo [Step 3] Creating virtual environment '%ENV_NAME%'...
if exist %ENV_NAME% (
    echo WARNING: Environment '%ENV_NAME%' already exists.
    set /p OVERWRITE="Do you want to overwrite it? (y/n): "
    if /i "!OVERWRITE!"=="y" (
        echo Removing existing environment...
        rmdir /s /q %ENV_NAME%
    ) else (
        echo Skipping environment creation.
        goto activate
    )
)
py -3.10 -m venv %ENV_NAME%
if %errorlevel% neq 0 (
    echo ERROR: Failed to create virtual environment.
    exit /b 1
)
echo Virtual environment created successfully.
echo.

:activate
REM Step 4: Activate the virtual environment
echo [Step 4] Activating virtual environment...
call %ENV_NAME%\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo ERROR: Failed to activate virtual environment.
    exit /b 1
)
echo Virtual environment activated.
echo.

REM Step 5: Verify Python version
echo [Step 5] Verifying Python version...
python --version
echo.

REM Step 5.1: Install Required packages for spark and Jupyter
echo [Step 5.1] Installing required packages...
pip install pyspark pyarrow ipykernel pandas matplotlib seaborn grpcio grpcio-status zstandard request nbformat
if %errorlevel% neq 0 (
    echo ERROR: Failed to install packages.
    exit /b 1
)
echo Packages installed successfully.
echo.

REM Step 5.2: Register as Jupyter kernel
echo [Step 5.2] Registering environment as Jupyter kernel...
python -m ipykernel install --user --name=%ENV_NAME% --display-name "%DISPLAY_NAME%"
if %errorlevel% neq 0 (
    echo WARNING: Failed to register Jupyter kernel.
) else (
    echo Jupyter kernel registered successfully.
)
echo.

REM Complete
echo ============================================================
echo  Setup Complete!
echo ============================================================
echo.
echo Virtual environment: %ENV_NAME%
echo Jupyter kernel: %DISPLAY_NAME%
echo.
echo To activate this environment later, run:
echo   %ENV_NAME%\Scripts\activate
echo.
echo To deactivate, run:
echo   deactivate
echo.

endlocal
