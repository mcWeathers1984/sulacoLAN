/* setup-sulaco.cpp
-This program is a setup-wizard for the SulacoLAN model. The deployment steps are (1) Install and configure Debian 12 on the Server,
(2) Install and configure Fedora WS on the DevWorkStation1 (3) Install Tools and Utilities on the Server (4) Install Tools and Utilities on the Workstation,
(5) Test (0) Exit Setup-Wizard

compile using c++17 or c++20

*/
#include <iostream>
#include <fstream>
#include <string>
#include <unistd.h>
#include <stdint>
#include <vector>
#include <utility>
#include <chrono>
enum class inputOption
{


};
int main()
{
	inputOption INPUT_OPTION{-1};
	while(INPUT_OPTION != 0)
	{
		INPUT_OPTION = GET_OPTION();
		INSTALL_SECTION(INPUT_OPTION);
	}


	return 0;
}
