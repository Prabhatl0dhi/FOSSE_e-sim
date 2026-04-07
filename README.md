#  eSim 2.5 Installation Debugging on Modern Ubuntu (24.04+)

##  Overview

This project documents the **systematic debugging and installation of eSim 2.5** on a modern Ubuntu environment.

The objective was to:

* Identify **dependency and compatibility issues**
* Analyze failures in installation scripts
* Fix at least one issue (multiple were fixed)
* Successfully install eSim using modern best practices

> ⚠️ Ubuntu 25.04 was not available at the time, so **Ubuntu 24.04 LTS** was used as the closest equivalent.

---

##  Key Highlights

*  Successfully installed eSim 2.5
*  Identified **10+ real issues**
*  Fixed critical script and compatibility bugs
*  Adapted installation to **modern Python (PEP 668)**
*  Fully documented debugging process

---

##  Environment

| Component | Details                   |
| --------- | ------------------------- |
| OS        | Ubuntu 24.04 (VirtualBox) |
| Python    | 3.12                      |
| RAM       | 8 GB                      |
| Tools     | Git, Bash, Python         |

---

##  Installation Workflow

```bash
git clone https://github.com/FOSSEE/eSim.git
cd eSim/scripts
./setup-esim.sh
```

Followed by:

```bash
python3 -m venv venv
source venv/bin/activate
pip install .
```

---

##  Issues Identified

### 1.  Incorrect Absolute Path

* Script used `/3rdparty/...`
* File not found

---

### 2.  Incorrect Relative Path

* Script assumed wrong working directory

---

### 3.  Outdated Repository Structure

* File moved from `3rdparty/` → `library/kicadLibrary/`

---

### 4.  Faulty Setup Flag Logic

* `.esim_kicad_setup_done` created even on failure

---

### 5.  Missing Python Dependency

```bash
ModuleNotFoundError: No module named 'setuptools'
```

---

### 6.  Permission Denied (System Install)

* Attempted install in `/usr/local/lib/...`

---

### 7.  Deprecated Installation Method

* `setup.py install` is outdated

---

### 8.  Missing pip

```bash
pip3: command not found
```

---

### 9.  PEP 668 Restriction

```bash
externally-managed-environment
```

---

### 10.  Missing venv Module

```bash
ensurepip is not available
```

---

##  Key Fixes Implemented

### ✔ Fix 1: Corrected Script Path

```bash
../library/kicadLibrary/template/sym-lib-table
```

---

### ✔ Fix 2: Removed Faulty Setup Flag

```bash
rm -f ~/.local/kicad/6.0/.esim_kicad_setup_done
```

---

### ✔ Fix 3: Installed Missing Dependencies

```bash
sudo apt install python3-setuptools python3-pip python3.12-venv
```

---

### ✔ Fix 4: Modern Python Installation

Used virtual environment to bypass PEP 668:

```bash
python3 -m venv venv
source venv/bin/activate
pip install .
```

---

##  Final Result

* eSim 2.5 installed successfully
* Installation adapted to modern Ubuntu + Python ecosystem
* Multiple critical issues identified and resolved

---

##  Repository Structure

```
.
├── README.md
├── report.md
├── fixes/
│   └── setup-esim.sh
├── screenshots/
└── steps.txt
```

---

##  Documentation

Detailed report available in:
 `report.md`

Includes:

* All errors
* Root causes
* Fixes
* Step-by-step debugging

---

##  Key Learnings

* Legacy scripts often break on modern systems
* Python packaging has significantly evolved (PEP 668)
* Debugging requires:

  * reading scripts
  * verifying paths
  * understanding environment constraints

---

##  Conclusion

The installation process exposed several **real-world compatibility issues**.
By systematically debugging and adapting to modern standards, a successful installation was achieved.

---

##  Submission

* GitHub Repository: *(https://github.com/Prabhatl0dhi/FOSSE_e-sim)*
* Report: Included in repo
* Submission sent via email as per guidelines

---

##  Author

**Prabhat**

---

>  *This project demonstrates practical debugging, system-level thinking, and adaptation to evolving software ecosystems.*
