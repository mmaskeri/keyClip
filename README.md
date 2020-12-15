# keyClip 

Copyright (c) 2019 Mark A. Maskeri (see LICENSE.txt)

Provides round-trip editing between post-Keynote '09 versions and ChemDraw

Known issues (ChemDraw 18 and older): CDXML copied from Keynote via keyClip preserves the document formatting (canvas size, etc.) of the original source ChemDraw document.  This includes the scheme's original location in that document.  It is recommended to paste keyClip'd schemes into a new "receiving" document before integrating with existing ChemDraw documents.

keyClip is best used with user-set keyboard shortcuts.  **For ChemDraw 18 or earlier:** since keyClip retrieves the scheme information in form of CDXML, either the ChemDraw shortcut for pasting CDXML (shift/option/command/p) or the Service packaged with keyClip (ChemDraw_CDXML, see below) which allows the user to set that shortcut must be used. **For ChemDraw 19 or later:** paste keyClip'd structures into ChemDraw as normal with command/v.

## Setup
0. [if your Library is hidden, open Terminal and enter command "open ~/Library"; or, open Finder, and from the navigation bar choose "Go > Library"]

1. Give Accessibility privileges to Automator
    - Open System Preferences > Security & Privacy > Privacy
    - Open the "Accessibility" panel from the left list
    - Add the app `Automator` to the right list, checking the box
    ! This is necessary for the keyClip script to automate required keystrokes
    ! Additional Accessibility privileges may need to be granted to Keynote, Terminal, and ChemDraw

2. Select an OS flavor of keyClip:
### Big Sur
*Users have reported that a legacy version of keyClip, keyClip5, functions in Big Sur while the latest version (keyClip6) does not.*
*This version should work on earlier OS versions, but may be marginally slower than keyClip6.*

3. Move the keyClip5_workflow.workflow file into your /Users/YOUR_USER_NAME_HERE/Library/Services. If using, also move ChemDraw_CDXML.workflow to this directory. keyClip5 is a self-contained workflow and does not require additional script files.

4. Set up keyboard shortcuts
    - Open System Preferences > Keyboard > Shortcuts
    - Open the "Services" panel from the left list
    - Scroll down to "General"
    - Add desired shortcuts for keyClip5_workflow and, if using, ChemDraw_CDXML
       - click on `none`, then `Add Shortcut`
       - press keys of desired shortcut simultaneously
       ! recommended shortcuts:
          - keyClip5_workflow: shift option command c
          - ChemDraw_CDXML: option command v
       ! These shortcuts do not collide with existing Keynote or ChemDraw
         shortcuts, and therefore are recommended
       ! ChemDraw_CDXML is not needed for ChemDraw 19 or later (see above)

### Earlier OSX versions
3. Move these files to /Users/YOUR_USER_NAME_HERE/Library/Services:
    - ChemDraw_CDXML (required for ChemDraw 18 or earlier)
    - keyClip_workflow

4. Move keyClip6.sh to /Users/YOUR_USER_NAME_HERE/Library/Scripts
    ! If the folder "Scripts" does not exist in Library, please create it first

5. Open Terminal, type "sudo chmod +x ~/Library/Scripts/keyClip6.sh"
    - enter your password
    ! this gives the primary script permission to run on your machine

6. Set up keyboard shortcuts
    - Open System Preferences > Keyboard > Shortcuts
    - Open the "Services" panel from the left list
    - Scroll down to "General"
    - Add desired shortcuts for keyClip_workflow and ChemDraw_CDXML
       - click on `none`, then `Add Shortcut`
       - press keys of desired shortcut simultaneously
       ! recommended shortcuts:
          - keyClip_workflow: shift option command c
          - ChemDraw_CDXML: option command v
       ! These shortcuts do not collide with existing Keynote or ChemDraw
         shortcuts, and therefore are recommended


## Usage
Select the _ungrouped_ scheme desired in Keynote and use the shortcut established in step 4 above.  A Terminal window should open, run the script, and close.  If this is the first time using the script, or if there is a heavy processor load, the Terminal may prompt a close error.  Keep Terminal active in your Dock to avoid this.  If these errors persist, see below.

**For keyClip5 (Big Sur):** A small rotating gear icon will appear in the menu bar. When this icon vanishes, if no error appears, proceed to paste the keyClip'd structure into ChemDraw.

Please note that, while the scripts may be edited to allow keyClip to run in the background, these edits produce undefined behavior with regards to text symbols (e.g. degree symbol, negative sign, Greek characters, etc.).

Paste the CDXML text retrieved into ChemDraw via either the shortcut established above or through ChemDraw's built in CDXML paste capability.


## Troubleshooting
If Terminal close errors persist:

1. Edit Terminal preferences
    - Open Terminal > Preferences > Profiles > (default profile) > Shell
    - Change "When the shell exits:" to "Close if the shell exited cleanly" or "Close the window"

2. Edit keyClip_workflow
    - Navigate to /Users/YOUR_USER_NAME_HERE/Library/Services
    - Open keyClip_workflow with Automator
    - Change line 10 "delay 1" to "delay 2"
    - Save and exit
    
If keyClip does not find a CDXML object--an error will flash up on screen--verify that the Keynote object in question is ungrouped and was a ChemDraw object to begin with.

## Thanks
Thanks to DRK (testing/troubleshooting, identification of keyClip5 Big Sur functionality) and JLZ (testing)!
