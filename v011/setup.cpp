/*
         file: /home/mikew/HICKS/setup.cpp
 date created: 06/08/25-13:34:01-MDT
date modified: 06/08/25-13:34:01-MDT
    ++version: 0-0-0-1
sulacoversion: 3-0-1
       author: mikew
  project log: GO TO THE "./readme.txt" FILE, IT CONTAINS THE PROJECT DESCRIPTION, DEBUGGING LOG AND BUGS LIST
     FILE LOG: (SEE BELOW)


    __  ___      __
   / / / (_)____/ /_______
  / /_/ / / ___/ //_/ ___/
 / __  / / /__/ ,< (__  )
/_/ /_/_/\___/_/|_/____/
	 Server	Setup &
 Jonesy Workstation Setup

readme.txt

FILE LOG:

* Entry 060825-133401
date modified: 06/08/25-13:34:01-MDT
    ++version: 0-0-0-1
sulacoversion: 3-0-1
       author: mikew
-> CPP Source file created, adding prompt for user to select (H) Setup Hicks with apt script OR (J) Setup Jonesy with dnf script


(Entry blueprint)----------------------------------------------------------------------------------------------------------------
* Entry mmddyy-hhmmss ______-______
date modified: 06/__/25-__:__:01-MDT
    ++version: 0-0-0-1
sulacoversion: 3-0-1
       author: mikew
-> (Enter brief but thorough description)
----------------------------------------------------------------------------------------------------------------------------------

(Entry blueprint-NOTE! DON'T OVERWRITE! COPY THIS SECTION WHEN NEEDED! P&TY!)----------------------------------------------------------------------------------------------------------------
* Entry mmddyy-hhmmss ______-______
date modified: 06/__/25-__:__:01-MDT
    ++version: 0-0-0-1
sulacoversion: 3-0-1
       author: mikew
->
----------------------------------------------------------------------------------------------------------------------------------




*	*	*	*	*	*	*	*	*	*	*	*	*	*
=========================================================================================================

---------------------------------------------------------------------------------------------------------
*	*	*	*	*	*	*	*	*	*	*	*	*	*
*/
#include <iostream>
#include <fstream>
#include <map>
#include <string>
#include <cstdlib>
#include <csignal>

enum class TargetSystem {
    HICKS,
    JONESY,
    UNKNOWN
};

const std::string hicksScript = "setup_hicks.sh";
const std::string jonesyScript = "setup_jonesy.sh";
const std::string hicksCheckpoint = "checkpoints_hicks.txt";
const std::string jonesyCheckpoint = "checkpoints_jonesy.txt";

TargetSystem selectedTarget = TargetSystem::UNKNOWN;
std::string checkpointFile;
std::string scriptFile;
std::map<std::string, std::string> checkpoints;

std::map<TargetSystem, std::vector<std::string>> steps = {
    { TargetSystem::HICKS, {
        "update_system", "install_base_dev_tools", "install_editors",
        "install_docs_tools", "install_languages", "install_ascii_tools",
        "install_terminal_tools", "install_networking_tools",
        "install_file_sharing", "install_web_server_tools", "install_misc_utilities"
    }},
    { TargetSystem::JONESY, {
        "update_system", "install_base_dev_tools", "install_editors",
        "install_docs_tools", "install_languages", "install_ascii_tools",
        "install_terminal_tools", "install_networking_tools",
        "install_file_sharing", "install_web_server_tools", "install_misc_utilities"
    }}
};

void signalHandler(int signum) {
    std::cerr << "\n[!] Interrupt signal received. Saving progress...\n";
    std::ofstream file(checkpointFile);
    for (const auto& [key, value] : checkpoints)
        file << key << "=" << value << "\n";
    exit(signum);
}

void loadCheckpoints() {
    std::ifstream file(checkpointFile);
    std::string line;
    while (std::getline(file, line)) {
        auto pos = line.find('=');
        if (pos != std::string::npos)
            checkpoints[line.substr(0, pos)] = line.substr(pos + 1);
    }
}

void saveCheckpoints() {
    std::ofstream file(checkpointFile);
    for (const auto& [key, value] : checkpoints)
        file << key << "=" << value << "\n";
}

void runSection(const std::string& section) {
    if (checkpoints[section] == "done") {
        std::cout << "[✓] Skipping " << section << " (already completed)\n";
        return;
    }
    std::cout << "[...] Running " << section << "...\n";
    std::string command = "bash -c 'source " + scriptFile + " && " + section + "'";
    int result = std::system(command.c_str());
    if (result == 0) {
        checkpoints[section] = "done";
        std::cout << "[✓] " << section << " completed.\n";
    } else {
        std::cerr << "[!] " << section << " failed. Aborting.\n";
        saveCheckpoints();
        exit(EXIT_FAILURE);
    }
}

void runAll() {
    for (const auto& step : steps[selectedTarget]) {
        runSection(step);
    }
    saveCheckpoints();
}

void runInteractive() {
    std::string input;
    for (const auto& step : steps[selectedTarget]) {
        std::cout << "Run step: " << step << "? [Y/n]: ";
        std::getline(std::cin, input);
        if (input.empty() || input == "y" || input == "Y") {
            runSection(step);
        } else {
            std::cout << "[!] Skipping " << step << "\n";
        }
    }
    saveCheckpoints();
}

void showStatus() {
    std::cout << "\n=== Setup Progress ===\n";
    for (const auto& step : steps[selectedTarget]) {
        std::string status = checkpoints[step];
        if (status == "done") status = "\033[1;32mdone\033[0m";
        else status = "\033[1;31mpending\033[0m";
        std::cout << step << ": " << status << "\n";
    }
    std::cout << "=======================\n\n";
}

void selectSystem() {
    std::string input;
    std::cout << R"(
==== Sulaco Setup Wizard ====

Choose target system:

(H) Hicks Server [Debian + apt]
(J) Jonesy Dev Workstation [Fedora + dnf]
(Q) Quit
)";
    std::cout << "Enter your choice [H/J/Q]: ";
    std::getline(std::cin, input);

    if (input == "H" || input == "h") {
        selectedTarget = TargetSystem::HICKS;
        scriptFile = hicksScript;
        checkpointFile = hicksCheckpoint;
    } else if (input == "J" || input == "j") {
        selectedTarget = TargetSystem::JONESY;
        scriptFile = jonesyScript;
        checkpointFile = jonesyCheckpoint;
    } else {
        std::cout << "Exiting.\n";
        exit(0);
    }
}

int main() {
    std::signal(SIGINT, signalHandler);
    std::signal(SIGTERM, signalHandler);

    selectSystem();
    loadCheckpoints();

    int choice = 0;
    while (true) {
	std::cout << "\n================ MENU OPTIONS ================\n";
        std::cout << "\n1. Run all steps automatically\n";
        std::cout << "2. Manually choose steps\n";
        std::cout << "3. Show progress\n";
        std::cout << "4. Exit\n";
        std::cout << "Enter a menu option: ";
        std::cin >> choice;
        std::cin.ignore();

        switch (choice) {
            case 1: runAll(); break;
            case 2: runInteractive(); break;
            case 3: showStatus(); break;
            case 4: std::cout << "Goodbye!\n"; return 0;
            default: std::cout << "Invalid option.\n";
        }
    }
}

