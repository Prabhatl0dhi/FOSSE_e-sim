eSim 2.5 Installation Issues on Ubuntu 24.04 (Equivalent to 25.xx Environment)
1. Introduction

This report documents the issues encountered while installing eSim 2.5 on a modern Ubuntu system (24.04).
Ubuntu 25.04 was not available, so Ubuntu 24.04 LTS was used as the closest stable alternative.

The objective was to identify dependency issues, analyze their causes, and fix at least one issue.

2. Environment Setup
OS: Ubuntu 24.04 LTS (VirtualBox)
RAM: 8 GB
Python: 3.12
Tools: Git, Bash, Python
3. Installation Steps
git clone https://github.com/FOSSEE/eSim.git
cd eSim
cd scripts
./setup-esim.sh
4. Issues Encountered and Fixes
Issue 1: Incorrect Absolute Path in Script

Error:

cp: cannot stat '/3rdparty/template/sym-lib-table'

Cause:

Script used incorrect absolute path /3rdparty/...
File does not exist at root directory

Fix:
Changed to relative path.

Issue 2: Incorrect Relative Path

Error:

cp: cannot stat './3rdparty/...'

Cause:

Script executed from scripts/ directory
Relative path incorrect

Fix:
Updated path to:

../library/kicadLibrary/template/sym-lib-table
Issue 3: Outdated Repository Structure

Cause:

Script expected file in 3rdparty/
Actual file located in library/kicadLibrary/

Fix:
Updated script path accordingly.

Issue 4: Incorrect Setup Flag Handling

Problem:

Script created .esim_kicad_setup_done even when setup failed
Prevented re-execution

Fix:
Manually removed flag:

rm -f ~/.local/kicad/6.0/.esim_kicad_setup_done
Issue 5: Missing Python Dependency (setuptools)

Error:

ModuleNotFoundError: No module named 'setuptools'

Fix:

sudo apt install python3-setuptools
Issue 6: Permission Denied During Installation

Error:

Permission denied: /usr/local/lib/...

Cause:

Attempt to install in system directory without root privileges
Issue 7: Deprecated Installation Method

Problem:

setup.py install is deprecated

Insight:

Modern Python discourages setup.py install
Issue 8: Missing pip

Error:

pip3: command not found

Fix:

sudo apt install python3-pip
Issue 9: PEP 668 Restriction

Error:

externally-managed-environment

Cause:

Ubuntu 24+ blocks global pip installs
Issue 10: Missing venv Module

Error:

ensurepip is not available

Fix:

sudo apt install python3.12-venv
5. Final Fix (Key Solution)

The installation was successfully completed using a virtual environment:

python3 -m venv venv
source venv/bin/activate
pip install .
6. Results
eSim installed successfully
Multiple dependency and script issues identified
Critical issues fixed for compatibility with modern Ubuntu
7. Conclusion

The installation process revealed several compatibility issues due to:

outdated scripts
missing dependencies
modern Python restrictions

By modifying scripts and adapting to updated Python practices, successful installation was achieved.
