## WhiteDuck: KISS Evil USB Blocker (AutoIt Script)

**WhiteDuck** is a lightweight AutoIt script that helps detect and mitigate basic USB/Rubber Ducky attacks. It monitors for the insertion of HID keyboards while your computer is running and takes the following actions:

*   **Locks the computer:** When a new HID keyboard is detected, WhiteDuck locks your computer screen to prevent unauthorized access.
*   **Blocks typing (temporary):** After locking the screen, WhiteDuck blocks keyboard input for a random amount of time to further deter unauthorized activity.

**Disclaimer:**

*   WhiteDuck is a **basic security measure** and should not be considered a foolproof defense.
*   It may not be effective against delayed attacks or more sophisticated techniques.
*   It is recommended to combine WhiteDuck with other security practices like strong passwords and antivirus software.

**Running WhiteDuck:**

1.  Download the `WhiteDuck.au3` script file to use with AutoIt or the WhiteDuck.exe/WhiteDuck64.exe that are ready for use 
2.  Double-click the exe to run it.
3.  WhiteDuck will run silently in the background.
4.  A tray icon will appear in the system tray (usually bottom right of your screen) to indicate it's running.

**Stopping WhiteDuck:**

WhiteDuck is designed to run continuously in the background. **The only way to stop the script is to terminate the process through the Windows Task Manager.**

1.  Press `Ctrl + Shift + Esc` to open the Task Manager.
2.  Go to the "Processes" or "Details" tab (depending on your Windows version).
3.  Locate the `WhiteDuck(64).exe` process that is running the WhiteDuck script (it might be helpful to sort by name to find it easily).
4.  Select the process and click "End Task."

**Please Note:**

*   WhiteDuck utilizes AutoIt scripting language. Familiarity with AutoIt is recommended for advanced users who wish to modify the script.
*   The script uses a random time delay for blocking typing. This can be adjusted within the script if desired (not recommended for beginners).
*   **The lack of a tray icon exit option is intentional, providing an additional layer of protection against casual tampering.**

**This script is provided "as is" without warranty of any kind.**

**KISS philosophy:** WhiteDuck is designed with the "Keep It Simple, Stupid" (KISS) principle in mind, offering a basic layer of protection with minimal complexity.