# deploy_agent_iradufashagratien
Automated Project Bootstrapping &amp; Process Management

# Attendance Tracker — Project Factory

A shell script that automates the setup of a Student Attendance Tracker workspace: 
creates the folder structure, copies source files, lets the user configure attendance 
thresholds, and safely handles interruptions (Ctrl+C) by archiving progress.

## What This Script Does

1. Prompts for a project name and creates `attendance_tracker_<name>/` with:
   - `attendance_checker.py`
   - `Helpers/` containing `assets.csv` and `config.json`
   - `reports/` containing `reports.log`
2. Optionally lets you update the Warning (default 75%) and Failure (default 50%) 
   attendance thresholds, writing the new values into `config.json` using `sed`.
3. Runs a health check to confirm `python3` is installed.
4. Catches `Ctrl+C` mid-run, archives whatever progress exists into a `.tar.gz`, 
   and deletes the incomplete folder to keep the workspace clean.

## Requirements

- Bash (Linux/macOS, or WSL on Windows)
- `python3` installed (for the health check to pass)
- `tar` and `sed` (included by default on most Unix-like systems)

## Project Structure (this repo)

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

4. Follow the prompts:
   - Enter a project name (this becomes `attendance_tracker_<name>`)
   - Choose whether to update the Warning/Failure thresholds (Yes/No)
     - If Yes, enter new values, or press Enter to keep the defaults (75/50)
   - The script will finish by running a health check and confirming the 
     structure was created successfully

> **Note:** The script can be run from any directory — it automatically locates 
> its own `source_files/` folder regardless of where you invoke it from.

## How to Trigger the Archive Feature

While the script is running (at any point after the project folder has started 
being created), press `Ctrl+C`.

This will:
- Print an interrupt message
- Bundle whatever exists so far into `attendance_tracker_<name>_archive.tar.gz`
- Delete the incomplete `attendance_tracker_<name>/` folder

Example:
```bash
$ bash setup_project.sh
Write the name of the project: demo
...
Do you want to update the tresholds (Yes/No) : ^C
Interupt Detected!!
Archiving in Progress...
Archived project created: attendance_tracker_demo_archive.tar.gz
The unfinished project is discarded and deleted successfully!!
```

You can inspect the archive's contents without extracting it:
```bash
tar -tzf attendance_tracker_demo_archive.tar.gz
```

## Example: Successful Run

```bash
$ bash setup_project.sh
Write the name of the project: demo
You have successfully created project attendance_tracker_demo
Do you want to update the tresholds (Yes/No) : Yes
Please enter warning treshold: 80
Please enter failure treshold: 60
Tresholds updated as you required by values: Warning Value=80 %, Failure value=60 %
Running health check...
Python is found and version is: Python 3.x.x
Conglatulations!!! The project Looks Complete
```
## Notes

- If `python3` is not found, the health check will print a warning but the 
  script will still complete the rest of the setup.
- Leaving a threshold input blank when prompted (after choosing "Yes") will 
  fall back to the default value for that field.