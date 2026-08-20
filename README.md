# deploy_agent_iradufashagratien
Automated Project Bootstrapping &amp; Process Management

# Student Attendance Tracker

A shell script that automates the setup of a Student Attendance Tracker project: 
creates the folder structure, copies source files, lets the user configure attendance 
thresholds, and safely handles interruptions (Ctrl+C) by archiving progress.

## What This Script Does

1. Prompts for a project name and creates `attendance_tracker_<name>/` with:
   - `attendance_checker.py`
   - `Helpers/` containing `assets.csv` and `config.json`
   - `reports/` containing `reports.log`
2. Optionally lets the user update the Warning (default 75%) and Failure (default 50%) 
   attendance thresholds, writing the new values into `config.json` using `sed` and `i` for updating accordingly.
3. Runs a health check to confirm `python3` is installed. It uses command `python3 --version` and gives the message showing that the python file is shown and even the version of the file present.
   If no python file found it will give a Warning message telling the user that no python found in the system.
5. Catches `Ctrl+C` mid-run, archives whatever progress exists into a `.tar.gz` file, the project `attendance_tracker_<name>/_archive` 
   and deletes the incomplete folder to keep the workspace clean.

## Requirements

- Bash (Linux/macOS, or Windows)
- `python3` installed (for the health check to pass)
- `tar` and `sed` (included by default on most Unix-like systems)
- Installed `tree` command for successful project architecture validation

## Project Structure (this repository)

## How to Run

1. Clone this repository:
```bash
   git clone https://github.com/iradufashagratien/deploy_agent_iradufashagratien
   cd deploy_agent_iradufashagratien
```

2. Make the script executable (optional, only needed if running with `./`):
```bash
   chmod +x setup_project.sh
```

3. Run it:
```bash
   ./setup_project.sh
```
   or
```bash
   bash setup_project.sh
```
 or
```sh
   bash setup_project.sh
```

4. Follow the prompts:
   - Enter a project name (this becomes `attendance_tracker_<name>`)
   - Choose whether to update the Warning/Failure thresholds (Yes/No)
     - If Yes, enter new values, or press Enter to keep the defaults (75/50)
   - The script will finish by running a health check and confirming the 
     structure was created successfully

> **Note:** The script can be run from any directory as it automatically locates 
>  to its own `source_files/` folder regardless of where you run it from.

## How to Trigger the Archive Feature

While the script is running (at any point after the project folder has started 
being created), press `Ctrl+C`.

This will:
- Print an interrupt message
- Kepp whatever exists so far into `attendance_tracker_<name>_archive.tar.gz`
- Delete the incomplete `attendance_tracker_<name>/` directory
  
This is the link to the walkthrough video: https://www.loom.com/share/a890aeae618249ac84da1ee63a55a48a
  

