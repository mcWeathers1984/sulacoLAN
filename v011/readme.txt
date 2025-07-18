         file: /home/mikew/HICKS/readme.txt
 date created: 06/08/25-13:34:01-MDT
date modified: 06/08/25-13:34:01-MDT
    ++version: 0-0-0-1
sulacoversion: 3-0-1
       author: mikew
  project log: (see below the program description)



    __  ___      __
   / / / (_)____/ /_______
  / /_/ / / ___/ //_/ ___/
 / __  / / /__/ ,< (__  )
/_/ /_/_/\___/_/|_/____/
	 Server	Setup &
 Jonesy Workstation Setup

readme.txt




Contents

*	Build Instructions
*	Program Description
	*	Development Tools, compilers, Vim and Nano, etc...
	*	Ascii and Terminal
	*	Networking
	*	Configuring, bashrc, mail setup, git setup, etc...

*	Project Log Entries

*	Bug(s)



*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*
=================================================================================================================================

---------------------------------------------------------------------------------------------------------------------------------

Build Instructions:

To build and run; enter the following commands in the bash terminal in the hicks-setup directory:

chmod 755 setup_hicks.sh setup_jonesy.sh
g++ -std=c++17 -o setup_wizard setup_wizard.cpp
./setup_wizard




Program Description:

 The program runs a 'Setup and Installation Wizard' and installs all programs and tools I like to use for software development. It
prompts the user with a text-based menu interface and after a few questions it runs the installation script. It has checkpoints so
if the program is interupted or has to stop, it can continue from where it left off.

The programs, tools and utilities it installs are as follows:

* C, C++, Rust, Java, Bash, Web Dev'mt, Python, Lua languages support

* Text Editors language support and setup: nano and vim and neovim - syntax highlighting, tabset, whitespace to tab, autocomplete? yes

* Dev tools, build tools
-	Make, Git
-	GNU C Tools and libraries
-	Compilers gcc and g++, clang, tools like chocolate, valgrind, objdump
-	Networking tools- tcpdump, netcat, netstat, wireshark, telnet, openssh, apache, samba(cifs-utils), nfs? (for redundancy? unsecure), nginX
 
* Ascii and terminal tools-figlet, toilet, boxes, poppler-utils(pdftotext, pdftohtml...etc), 

*  Current projects in progress- server(hicks) and development workstation setup and installation wizard with c++ text menu interface and script, system hardening (my network setup - set acl's, set up firewall, set up keygen ssh connection, setup 
 Other interesting tools: Caligula-Disk Burnner
Caligula, Pastel-Colors -hex codes, Astroterm

*  Setup a series of "blueprint" documents. These will be the 'templates' for documents, source files, header files, libraries, et cetera with
preferred formatting, documentation, references, licenses. Then archive all our blueprint files in an immuteable folder so we can easily make copies
when needed and don't have to spend 20 minutes whenever we make a new file or project.

* Blueprint Examples to be implemented:

Doc files - documentation, debugging, tracking and logs
Source files-Source file bp's for c, c++, rust, java, html, css.
Header files-Header file bp's for c, c++, java, et cetera
Shared libraries and object
API and ABI's
New Project Blueprints- A project and a set of blueprint folders for new coding projects like New C++ Project, New C Project, New Rust Project,
New Project from BP
New Installation Wizard BP

*	*	*	*	*	*	*	*	*	*	*	*	*	*
=========================================================================================================

---------------------------------------------------------------------------------------------------------
*	*	*	*	*	*	*	*	*	*	*	*	*	*

Project Log (for every entry please include the date/time/author/version pre-appended to the entry:

*	060825-133401-MDT-mikew-v0.001: Started Log and main file. Updating the cpp file so program begins by prompting
the user to select whether setting up server(hicks-debian cli) or workstation(jonesy-fedora ws-gnome) platform. Hope-
fully next will add support for the rest of setup including network and system hardening, et cetera...


*	06__25-____01-MDT-mikew-v0.0.0.2: (blueprint-type entry here______)


NOTE!!! Copy the last blueprint! lol DO NOT OVERWRITE. Please and Thank You!----------------------------------

*	06__25-____01-MDT-mikew-v0.0.0.3: (blueprint-type entry here)
-------------------------------------------------------------------------------------------------------------


*	*	*	*	*	*	*	*	*	*	*	*	*	*
=========================================================================================================

---------------------------------------------------------------------------------------------------------
*	*	*	*	*	*	*	*	*	*	*	*	*	*

Bugs Report:

Lot's of errors!!!!!! Heres the plan. 

Start by CLEARLY defining the goals of the project and EXACTLY what the program is supposed to do,
THEN we will work on important bugs and errors. List them here as a kind of TODO List and use the
Project Log to track the progress of this project.



*	*	*	*	*	*	*	*	*	*	*	*	*	*
=========================================================================================================

---------------------------------------------------------------------------------------------------------
*	*	*	*	*	*	*	*	*	*	*	*	*	*
