Tanuki Lifelike Defense Script for DCS
This is a lightweight Lua script for DCS World that makes AI aircraft behave in a more realistic and human-like way during combat. Developed by Tanuki Infosec in collaboration with Nemesis Simulations, the goal is to improve immersion without making AI invincible or overly passive.

Features
Realistic, human-like defensive behavior for AI aircraft

Enables evasion of heatseeking and radar-guided missiles

AI returns fire only when attacked (Return Fire ROE)

Smooth, non-aggressive maneuvering

Automatically applies settings to all relevant AI groups shortly after mission start

How It Works
The script:

Scans all RED and BLUE coalition aircraft groups

Filters groups by a specific name prefix (default: AI_PLANE_)

Applies the following settings:

Passive reaction to threats

Evasion for gunfire, heatseekers, and radar-guided missiles

Return Fire only (no preemptive engagement)

Non-aggressive maneuvering behavior

Configuration
lua
local AI_GROUP_PREFIX = "AI_PLANE_"
To control which groups are affected, change the AI_GROUP_PREFIX to match the naming convention of your AI aircraft in the mission editor.

Installation
Place the script file in your DCS mission directory.

In the mission editor or scripting tool (e.g. MOOSE/MIST), run the script by adding:

lua
dofile("Tanuki_lifelike_defense 0.01.lua")
Ensure AI aircraft groups you want affected have names beginning with AI_PLANE_ or the prefix you've configured.

Script Behavior
lua
ApplyLifelikeDefenseToAll()
Runs automatically 5 seconds after the mission starts. No manual triggering is required.

Tested With
DCS World 2.9

Multiplayer and single-player missions

Aircraft from both RED and BLUE coalitions

Credits
Tanuki AKA altshift2638/Muska – Script Author

Nemesis Simulations – Concept and Testing

License
This script is free to use. See the LICENSE file for details.

Let me know if you'd like a matching CHANGELOG.md, mission example, or instructions for integration with mission templates.
