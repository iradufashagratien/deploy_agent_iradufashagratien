#!/bin/bash
echo "                                               "
echo "========================== WELCOME TO STUDENT TRACKER SYSTEM =========================="
echo "                                                                            "
echo "Let's get you started"
echo "          "

read -p "Write the name of the project: " user_input

# Ensure user input isn't blank
if [ -z "$user_input" ]; then
    echo "Error: Project name cannot be empty."
    exit 1
fi

#Creating portable location for source files and location


script_location="$(cd "$(dirname "$0")" && pwd)"

created_project_dir="attendance_tracker_${user_input}"

# Carefully exiting the program and archive the progress

interupt_handler() {

    echo "    "

    echo "Interupt Detected!!"

    echo "Archiving in Progress..."

    if [ -d "$created_project_dir" ]; then

    tar -czf "${created_project_dir}_archive.tar.gz" "$created_project_dir"

    echo "Archived project created: ${created_project_dir}_archive.tar.gz. Pay attention to the zip method used!!"

    rm -rf "$created_project_dir"

    echo "The unfinished project is discarded and deleted successfully!!"

    else
    
    echo "No project directory dound to archive. Please create a project!"

    fi

    echo "Exiting..."

    exit 1
}

trap interupt_handler SIGINT

#Creatinng the required directory structure

mkdir -p "$created_project_dir/Helpers"

mkdir -p "$created_project_dir/reports"

files_source="$script_location/source_files"

cp "$files_source/attendance_checker.py" "$created_project_dir/attendance_checker.py"
cp "$files_source/assets.csv" "$created_project_dir/Helpers/assets.csv"
cp "$files_source/config.json" "$created_project_dir/Helpers/config.json"
cp "$files_source/reports.log" "$created_project_dir/reports/reports.log"

echo "You have successfully created project $created_project_dir"

echo " "

#Dynamic configuration on updating the tresholds

echo "========================= UPDATING TRESHOLDS ========================================="
echo "   "
read -p "Do you want to update the tresholds (Yes/No) : " user_choice

if [ "$user_choice" = "Yes" ]; then

    read -p "Please enter warning treshold: " warning_value
    read -p "Please enter failure treshold: " failure_value

    if [ -z "$warning_value" ]; then

    warning_value=75

    fi

    if [ -z "$failure_value" ]; then

    failure_value=50

    fi

    sed -i "s/\"warning\": [0-9]*/\"warning\": $warning_value/" "$created_project_dir/Helpers/config.json"

    sed -i "s/\"failure\": [0-9]*/\"failure\": $failure_value/" "$created_project_dir/Helpers/config.json"

    echo "Updating accordingly..."
    echo " "

    echo "Tresholds updated as you required by values: Warning Value=$warning_value %, Failure value=$failure_value %"

else

    echo "Keeping the defalut values to Warning:75% and Failure=50%"

    echo "Done..."

fi    

echo " "

#health Check---

echo "============================ HEALTH CHECK REPORT ====================================="
echo " "

echo "Running health check..."

if python3 --version > /dev/null 2>&1; then

echo "Python is found and version is: $(python3 --version)"

else

echo "Warning: No Python found!!"

fi

if [ -f "$created_project_dir/attendance_checker.py" ] && [ -d "$created_project_dir/Helpers" ] && [ -d "$created_project_dir/reports" ]; then

echo "Conglatulations!!! The project Looks Complete"

else

echo "The Project Looks Incomplete, please review!"

fi

echo " "
echo "=============================== THE END ==============================================="
#Finalement
echo " "
echo "Project $created_project_dir created successfully!!"
echo " "
