/*
  setup-wizard.cpp
  SulacoLAN: Setup Wizard for Hicks, Jonesy, etc.
*/

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>

void runScript(const std::string& script) {
    std::cout << "[*] Running: " << script << "\n";
    int result = system(script.c_str());
    if (result != 0)
        std::cerr << "[!] Script exited with code: " << result << "\n";
}

void generateVimrc() {
    std::ofstream vimrc(getenv("HOME") + std::string("/.vimrc"));
    vimrc << R"(
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set wildmenu
set showmatch
set showcmd
set clipboard=unnamed
set completeopt=menuone,noinsert,noselect
set updatetime=300
set shortmess+=c
set signcolumn=yes
)";
    vimrc.close();
    std::cout << "[✓] .vimrc created\n";
}

void generateNanorc() {
    std::ofstream nanorc(getenv("HOME") + std::string("/.nanorc"));
    nanorc << R"(
set linenumbers
set tabsize 4
set softwrap
set tabstospaces
set autoindent
set smooth
set mouse
include /usr/share/nano/*.nanorc
)";
    nanorc.close();
    std::cout << "[✓] .nanorc created\n";
}

int main() {
    std::string choice;
    std::cout << "Welcome to the Sulaco Setup Wizard\n";
    std::cout << "[H] Hicks (Debian)\n";
    std::cout << "[J] Jonesy (Fedora)\n";
    std::cout << "Select system to configure: ";
    std::cin >> choice;

    if (choice == "H" || choice == "h")
        runScript("./setup-hicks-v2.sh");
    else if (choice == "J" || choice == "j")
        runScript("./setup-jonesy-v2.sh");
    else {
        std::cerr << "[!] Unknown choice\n";
        return 1;
    }

    generateVimrc();
    generateNanorc();

    std::cout << "[✓] Setup complete!\n";
    return 0;
}
