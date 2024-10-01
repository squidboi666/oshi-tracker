#requires -PSEdition Core -Version 7.0
# Import the notification module
Import-Module BurntToast

# Show notification
New-BurntToastNotification -Text "Oshi Tracker", "The Oshi Tracker script is now running." -Sound Mail

# Load oshis from the JSON file
$oshi = Get-Content -Path ./oshis.json | ConvertFrom-Json

# Infinite loop to run every 5 minutes
while ($true) {
    $oshi | ForEach-Object -Parallel {
        $channelName = $_.Name
        $channelUrl = $_.URL
    
        # Folder path for this channel (relative to the script location)
        $channelFolder = ".\$channelName"
    
        # Ensure the folder exists
        if (-not (Test-Path -Path $channelFolder)) {
            New-Item -ItemType Directory -Path $channelFolder
        }
    
        # Run yt-dlp and save the video to the respective channel folder
        yt-dlp.exe $channelUrl --match-filter "!was_live" --live-from-start --no-wait-for-video -o "$channelFolder/%(title)s.%(ext)s"
    } -ThrottleLimit 5  
            # The ThrottleLimit parameter limits the number of script blocks running in parallel at a given time, 
            # so if you have a powerful CPU feel free to increase this value. 5 is the default value.
    # Wait for 5 minutes before running again
    Start-Sleep -Seconds 300
}

