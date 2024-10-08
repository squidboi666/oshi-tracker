﻿#requires -PSEdition Core -Version 7.0

Write-Host @"


 ▄██████▄     ▄████████    ▄█    █▄     ▄█                                             
███    ███   ███    ███   ███    ███   ███                                             
███    ███   ███    █▀    ███    ███   ███▌                                            
███    ███   ███         ▄███▄▄▄▄███▄▄ ███▌                                            
███    ███ ▀███████████ ▀▀███▀▀▀▀███▀  ███▌                                            
███    ███          ███   ███    ███   ███                                             
███    ███    ▄█    ███   ███    ███   ███                                             
 ▀██████▀   ▄████████▀    ███    █▀    █▀                                              
                                                                                       
    ███        ▄████████    ▄████████  ▄████████    ▄█   ▄█▄    ▄████████    ▄████████ 
▀█████████▄   ███    ███   ███    ███ ███    ███   ███ ▄███▀   ███    ███   ███    ███ 
   ▀███▀▀██   ███    ███   ███    ███ ███    █▀    ███▐██▀     ███    █▀    ███    ███ 
    ███   ▀  ▄███▄▄▄▄██▀   ███    ███ ███         ▄█████▀     ▄███▄▄▄      ▄███▄▄▄▄██▀ 
    ███     ▀▀███▀▀▀▀▀   ▀███████████ ███        ▀▀█████▄    ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   
    ███     ▀███████████   ███    ███ ███    █▄    ███▐██▄     ███    █▄  ▀███████████ 
    ███       ███    ███   ███    ███ ███    ███   ███ ▀███▄   ███    ███   ███    ███ 
   ▄████▀     ███    ███   ███    █▀  ████████▀    ███   ▀█▀   ██████████   ███    ███ 
              ███    ███                           ▀                        ███    ███ 

               

"@


Write-Host "----------------------------------------------------------"
Write-Host "------------------------------"

# Prompt the user for the channel URLs
Write-Host "Please enter the channel urls that you would like to track. For multiple channels, please separate each URL with a comma and avoid adding any additional spaces before or after."
Write-Host "e.g., https://www.youtube.com/@ReimuHakurei,https://www.youtube.com/@Koakuma"
$oshis ="Enter the channel URL(s)"
$oshisSplit = (Read-Host $oshis).Split(',') | ForEach-Object { $_.Trim() }  # Trim spaces for each URL

# Create a list to store channel names and URLs
$oshiList = @()



# Loop through each URL
foreach ($url in $oshisSplit) {
    
    $url = $url.Trim()

    $channelName = ($url -split '@')[1]  # Extracts the part after '@' (the channel name)
    $streamUrl = "$url/streams"
    
    # Create a directory for each channel, using the channel name for the folder's name
    $oshiFolder = ".\$channelName"
    if (-not (Test-Path $oshiFolder)) {
        New-Item -Path $oshiFolder -ItemType Directory
    }

    # Add to the channel data list
    $oshiList += [PSCustomObject]@{ Name = $channelName; URL = $streamUrl }
}

# Convert the array to JSON and save it
$oshiList | ConvertTo-Json | Set-Content -Path "./oshis.json"

# Check if yt-dlp is installed and install if not
if (-not(Get-Command yt-dlp -ErrorAction SilentlyContinue)) {
    winget install --id yt-dlp.yt-dlp
    
}

# Check if BurntToast module is already installed
$module = Get-Module -ListAvailable -Name BurntToast

if ($module -and $module.Version -ge [version]'0.8.5') {
    Write-Host "..."
} else {
    Write-Host "Installing BurntToast module v.0.8.5 ..."
    Install-Module -Name BurntToast -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
}



New-BurntToastNotification -AppLogo .\burnt-toast\icon.jpg -Text "Congratulations!","Your tracker list has been updated, and you're ready to run the start_tracker.bat script." -Sound Mail

Exit 
