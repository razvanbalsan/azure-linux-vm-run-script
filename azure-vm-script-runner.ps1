# Define the path to your input file
$inputFilePath = "C:\path\to\your\file.txt"

# Confirming the start of the script
Write-Host "Starting the script to process VMs from: $inputFilePath"

# Check if the input file exists
if (-Not (Test-Path $inputFilePath)) {
    Write-Host "Input file does not exist: $inputFilePath" -ForegroundColor Red
    exit
}

# Read the input file line by line
$lines = Get-Content $inputFilePath

# The encoded script
$encodedScript = <base64 code of ssh-update.sh>

# Loop through each line of the file
foreach ($line in $lines) {
    # Skip empty lines
    if ([string]::IsNullOrWhiteSpace($line)) {
        continue
    }

    # Split the line into serverName and resourceGroup
    $parts = $line -split ','
    $serverName = $parts[0].Trim()
    $resourceGroup = $parts[1].Trim()

    Write-Host "Processing VM: $serverName in Resource Group: $resourceGroup"

    # Construct and execute the Azure CLI command
    $command = "echo $encodedScript | base64 --decode > /tmp/sshd_config.sh; chmod +x /tmp/sshd_config.sh; bash /tmp/sshd_config.sh"
    try {
        az vm run-command invoke `
            --resource-group $resourceGroup `
            --name $serverName `
            --command-id RunShellScript `
            --scripts $command
        Write-Host "Successfully executed the script on VM: $serverName" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to execute the script on VM: $serverName" -ForegroundColor Red
    }
}

Write-Host "Script processing completed."
