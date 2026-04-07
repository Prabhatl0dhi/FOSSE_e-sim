#  Detailed Report: Debugging eSim 2.5 Installation on  Ubuntu

---

## 1. Introduction

The objective of this task was to analyze and debug the installation process of **eSim 2.5** on a modern Ubuntu-based system and identify dependency-related issues.

Since Ubuntu 25.04 was not publicly available, **Ubuntu 24.04 LTS** was used as a close approximation. This allowed testing compatibility with modern system libraries and Python environments.

---

## 2. Approach and Methodology

The debugging process followed a systematic approach:

1. Attempt installation using provided scripts
2. Observe and capture error outputs
3. Analyze root cause (path, dependency, or environment issue)
4. Modify scripts or install missing dependencies
5. Re-run installation to verify fix

This iterative debugging cycle was repeated until installation succeeded.

---

## 3. Initial Setup

```bash
git clone https://github.com/FOSSEE/eSim.git
cd eSim/scripts
./setup-esim.sh
```

The script execution exposed multiple issues due to outdated assumptions in the installation logic.

---

## 4. Detailed Issue Analysis

---

### Issue 1: Incorrect Absolute Path Usage

**Observation:**
The script attempted to copy files using:

```
/3rdparty/template/sym-lib-table
```

**Analysis:**

* `/3rdparty` refers to root directory
* No such directory exists
* Indicates incorrect assumption in script

**Conclusion:**
The script incorrectly used absolute paths instead of project-relative paths.

---

### Issue 2: Incorrect Relative Path Resolution

**Observation:**
After modifying the path, the script still failed.

**Analysis:**

* Script was executed from `scripts/` directory
* Relative paths depend on current working directory
* `./3rdparty/...` was still incorrect

**Conclusion:**
Understanding execution context is critical for path resolution.

---

### Issue 3: Repository Structure Mismatch

**Observation:**
The required file was not present in expected directory.

**Verification:**

```
find .. -name sym-lib-table
```

**Actual Location:**

```
../library/kicadLibrary/template/sym-lib-table
```

**Analysis:**

* Repository structure has changed
* Script not updated accordingly

**Fix Applied:**
Updated path to correct directory.

---

### Issue 4: Faulty Setup Completion Flag

**Observation:**
Even after failure, script displayed:

```
eSim libraries already set up
```

**Analysis:**

* Script creates a flag file:

```
.esim_kicad_setup_done
```

* Flag created even when setup fails

**Impact:**

* Prevents re-execution
* Leads to inconsistent installation state

**Fix Applied:**
Manually removed flag file before re-running script.

---

### Issue 5: Missing Python Dependency

**Error:**

```
ModuleNotFoundError: No module named 'setuptools'
```

**Analysis:**

* Script assumes availability of setuptools
* Not installed by default in minimal systems

---

### Issue 6: Permission Denied Error

**Error:**

```
Permission denied: /usr/local/lib/python3.12/...
```

**Analysis:**

* Installation attempted in system directory
* Requires root privileges

---

### Issue 7: Deprecated Installation Method

**Observation:**

```
setup.py install is deprecated
```

**Analysis:**

* Modern Python packaging discourages this
* Indicates outdated installation approach

---

### Issue 8: Missing pip

**Error:**

```
pip3: command not found
```

**Analysis:**

* pip not included in base installation

---

### Issue 9: PEP 668 Restriction

**Error:**

```
externally-managed-environment
```

**Analysis:**

* Ubuntu 24+ restricts pip installations
* Protects system Python environment

**Insight:**
This is a modern compatibility issue affecting legacy installers.

---

### Issue 10: Missing Virtual Environment Support

**Error:**

```
ensurepip is not available
```

**Analysis:**

* venv module not installed by default

---

## 5. Fix Implementation

The following fixes were applied:

### Script Fix

* Corrected path to:

```
../library/kicadLibrary/template/sym-lib-table
```

### Dependency Fixes

```
sudo apt install python3-setuptools python3-pip python3.12-venv
```

### Environment Fix

```
python3 -m venv venv
source venv/bin/activate
pip install .
```

---

## 6. Final Outcome

After applying the fixes:

* Installation completed successfully
* eSim 2.5 installed in isolated environment
* All major blocking issues resolved

---

## 7. Key Observations

* Installation scripts are not updated for modern systems
* Python packaging ecosystem has significantly evolved
* Absolute and relative path handling is critical
* System-level restrictions (PEP 668) impact legacy workflows

---

## 8. Conclusion

The installation of eSim 2.5 on modern Ubuntu systems revealed several compatibility issues related to outdated scripts, missing dependencies, and changes in Python package management.

By systematically analyzing errors and applying targeted fixes, the installation was successfully completed.

This process demonstrates the importance of adapting legacy software to modern development environments.

---

## 9. Author

Prabhat

