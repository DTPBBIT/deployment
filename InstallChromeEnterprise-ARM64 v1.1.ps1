# Define the correct URL for the latest Google Chrome Enterprise for Windows 11 ARM MSI download
$chromeEnterpriseArmDownloadUrl = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B15EB1FA3-3EEB-36E2-41A5-0043FAD6B259%7D%26lang%3Den%26browser%3D5%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Darm64-stable-statsdef_0%26brand%3DGCEA/dl/chrome/install/GoogleChromeStandaloneEnterprise_Arm64.msi"

# Define the path to check if Chrome is already installed
$chromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"

# Check if Chrome is already installed
if (Test-Path $chromePath) {
    Write-Host "Chrome is already installed."
    Start-Sleep -Seconds 5
    Exit
}

# Define the output path where the MSI will be saved
$outputPath = "$env:TEMP\GoogleChromeEnterpriseARM.msi"

# Download the latest Google Chrome Enterprise ARM MSI
Write-Host "Downloading Google Chrome Enterprise for Windows 11 ARM..."
Invoke-WebRequest -Uri $chromeEnterpriseArmDownloadUrl -OutFile $outputPath

# Check if the download was successful
if (Test-Path $outputPath) {
    Write-Host "Download successful. Installing Google Chrome Enterprise for Windows 11 ARM silently..."

    # Install the MSI silently
    $arguments = "/i `"$outputPath`" /quiet /norestart"
    Start-Process msiexec.exe -ArgumentList $arguments -NoNewWindow -Wait

    # Verify installation by checking if the Chrome executable exists
    if (Test-Path $chromePath) {
        Write-Host "Google Chrome Enterprise for Windows 11 ARM installed successfully."
    } else {
        Write-Host "Installation failed."
    }

    # Optionally, delete the MSI after installation
    Remove-Item $outputPath -Force
} else {
    Write-Host "Download failed. Please check your internet connection or the URL."
}
