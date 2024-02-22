#!/bin/bash

# Define the path to your input file
inputFilePath="/path/to/your/file.txt"

# Confirming the start of the script
echo "Starting the script to process VMs from: $inputFilePath"

# Check if the input file exists
if [ ! -f "$inputFilePath" ]; then
    echo "Input file does not exist: $inputFilePath" >&2
    exit 1
fi

# The encoded script
encodedScript="<base64 code of ssh-update.sh>"

# Read the input file line by line
while IFS=, read -r serverName resourceGroup; do
    # Skip empty lines
    if [[ -z "$serverName" || -z "$resourceGroup" ]]; then
        continue
    fi

    echo "Processing VM: $serverName in Resource Group: $resourceGroup"

    # Construct and execute the Azure CLI command
    command="echo $encodedScript | base64 --decode > /tmp/sshd_config.sh; chmod +x /tmp/sshd_config.sh; bash /tmp/sshd_config.sh"
    if az vm run-command invoke \
        --resource-group "$resourceGroup" \
        --name "$serverName" \
        --command-id RunShellScript \
        --scripts "$command"; then
        echo "Successfully executed the script on VM: $serverName"
    else
        echo "Failed to execute the script on VM: $serverName" >&2
    fi
done < "$inputFilePath"

echo "Script processing completed."
