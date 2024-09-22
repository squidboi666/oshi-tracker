# Oshi-Tracker

This is a multi-channel, livestream only implementation of YT-DLP. 

The setup script will create a .json file, where it will store the channel URLS that you provided at it's prompting. It will also create a folder for each of those channels, and name it after the channel. This setup script will also check if `yt-dlp` is properly set up in your system/user environment variables. If it isn't detected, it will use `winget` to install a full-featured `yt-dlp` package and add it to your user environment variables.


The main script, `Oshi_Tracker.ps1`, will check each channel for new live streams every 5 minutes and download any new livestreams. It will **ONLY** download livestreams -- using the `--live-from-start` argument -- and will ignore any waiting rooms, VODs, shorts, or regular uploads. Livestreams will be downloaded to the folder that corresponds to the channel that they are being downloaded from.

---

## Requirements

- **Windows 10 or Windows 11**
- **PowerShell 7**

You can install PowerShell 7 via Windows' native package manager, `winget`:

```bash
winget install --id Microsoft.PowerShell --source winget
```

Or via the official Microsoft Software Installer:

[PowerShell-7.4.5-win-x64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.msi)

If you're unclear on the difference between Windows PowerShell and PowerShell, I recommend [this article](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/differences-from-windows-powershell?view=powershell-7.4#powershell-executable-changes).

---

## Step 1:

Download the [latest release](https://github.com/squidboi666/oshi-tracker/releases/download/v1.0.0/oshi-tracker.7z) to your %USER% folder. 

Once downloaded, extract it.

---

## Step 2:

The `setup-script.ps1` needs to be run in an Administrator PowerShell terminal.

Since we'll be using PowerShell instead of Windows PowerShell, the easiest way to do this is as follows:

1. Launch the Run dialog by using the following shortcut:
    - <kbd>Windows</kbd> + <kbd>R</kbd>

2. Type the following:
    ```bash
    pwsh.exe
    ```

3. Instead of hitting Enter, use this shortcut to launch the PowerShell terminal with elevated privileges:
    - <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd>

4. If you downloaded and extracted this repo to the proper location, you should be able to navigate there via the command line like so:
5. 
    ```bash
    Set-Location "$env:USERPROFILE\oshi-tracker"
    ```

6. Now to run our setup script, simply type:
   
    ```bash
    ./setup-script.ps1
    ```

You'll be prompted to enter the YouTube URLs for each of your Oshi's channels. After doing so, you'll be greeted with a notification confirming your success. 

You'll also notice that there are new folders in the project directory corresponding to each channel URL you added. **Do not rename them**, as new live streams will be saved in these folders.

You can run this script again at any time in the future to update the list of channels to track. Just be aware that it will overwrite the current list rather than append new entries. This is intentional.

---

## Step 3

Now, you can execute the `tracker_launcher.bat` script, which will run the PowerShell script (`Oshi_Tracker.ps1`) and keep it running in the background.

The script is designed to avoid flashing and launching a terminal window, as I find that to be annoying and extremely un-leet, so I added a notification with a custom image.

If you don't want to manually execute the `tracker_launcher.bat` script each time, you can schedule it to run whenever you log onto your computer using Task Scheduler.


