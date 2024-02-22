# azure-linux-vm-run-script
Run a script to multiple Azure Linux VMs using azure CLI in Windows' Powershell

```
az login
```
```
az account list -o table
az account set --subscription subscriptionName
```

```
#from a Linux Terminal
base64 -i ssh-update.sh # output will be set in $encodedScript variable in the powershell script
```

```
#get the list of resourceGroups from powershell
$vmNames = @("vm1", "vm2", "vm3")
$allVMs = az vm list --query "[].{Name:name, ResourceGroup:resourceGroup}" | ConvertFrom-Json
$filteredVMs = $allVMs | Where-Object { $vmNames -contains $_.Name }
$filteredVMs | Format-Table Name, ResourceGroup
```

```
#!/bin/bash

# Define an array of VM names you're interested in
vmNames=("vm1" "vm2" "vm3")

# Get the list of VMs and their resource groups using az cli and jq
allVMs=$(az vm list --query "[].{Name:name, ResourceGroup:resourceGroup}" -o json)

# Loop through the VM names and filter the list
for vmName in "${vmNames[@]}"; do
    echo "$allVMs" | jq --arg name "$vmName" '.[] | select(.Name==$name) | [.Name, .ResourceGroup] | @tsv'
done
```