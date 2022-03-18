# Space-run
A variation on the Tunnel Rush game with some extra features. For detailed explanation of the game, look into [Game_specifications.pdf](https://github.com/AdilovicUna/Space-run/blob/master/Documentation/Game_specifications.pdf).

## Installation

**Requirements:**

  - [Godot Engine](https://godotengine.org)(version v3.2.3.stable)
  - [Inno Setup Compiler](https://jrsoftware.org/isdl.php) (version 6.2.0)
  - [installationScript.iss](https://github.com/AdilovicUna/Space-run/blob/master/Setup/installationScript.iss)
  
**How to install?**

  1. Clone this repository
  2.  Open the Godot Engine
        - Click the import button
        - Navigate to the "./Space-run/Game" and import “project.godot”.
        - Open the project
        - Go to Project -> Export
        - From Add... choose your operating system and Export project
        - Save the executable in "./Space-run/Setup/"
  3.  Open the Inno Setup Compiler
        - From here open the script
        - Change "OutputDir" variable to where you want the installer to be added
        - Click Build -> Compile (this will create "Space-run SetUp.exe" in "OutputDir")
        - Navigate to that file and open it
        - Follow the instructions of the installer
  4. Have fun playing!
