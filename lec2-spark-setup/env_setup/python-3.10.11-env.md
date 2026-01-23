# Creating a Python 3.10.11 Environment on Windows

## Prerequisites
- Python 3.10.11 installed on your system
- Command Prompt access

## Steps

### 1. Open Command Prompt
Press `Win + R`, type `cmd`, and press Enter.

### 2. Install virtualenv (if not already installed)
```cmd
pip install virtualenv
```

### 3. Create a new virtual environment
```cmd
python -m venv python-3.10.11-env
```

Or if you have multiple Python versions installed:
```cmd
py -3.10 -m venv python-3.10.11-env
```

### 4. Activate the virtual environment
```cmd
python-3.10.11-env\Scripts\activate
```

### 5. Verify the Python version
```cmd
python --version
```

You should see `Python 3.10.11` in the output.

### 5.1. Install PySpark and IPyKernel
```cmd
pip install pyspark ipykernel
```

### 5.2. (Optional) Register the environment as a Jupyter kernel
```cmd
python -m ipykernel install --user --name=python-3.10.11-env --display-name "Python 3.10.11 (Spark)"
```

### 6. Deactivate the environment (when done)
```cmd
deactivate
```

## Notes
- The virtual environment folder will be created in your current directory.
- Always activate the environment before installing packages to keep them isolated.