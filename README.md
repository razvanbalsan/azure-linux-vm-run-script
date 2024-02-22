# Azure Linux VM Run Script

This repository contains scripts and tools for efficiently managing and executing scripts on Azure Linux Virtual Machines (VMs). It leverages Azure CLI and Bash scripting to automate the process of running custom scripts on one or more VMs in Azure, making it easier to deploy changes, updates, or configurations across your cloud infrastructure.

## Prerequisites

Before you begin, ensure you have the following prerequisites met:

- Azure CLI installed on your machine. For installation instructions, see [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- An Azure account with an active subscription. If you don't have one, you can create [a free account](https://azure.microsoft.com/en-us/free/).
- `jq` installed for processing JSON. Most Linux distributions include `jq` in their package repositories.

## Getting Started

1. **Clone the Repository**

    Start by cloning this repository to your local machine:

    ```bash
    git clone https://github.com/razvanbalsan/azure-linux-vm-run-script.git
    cd azure-linux-vm-run-script
    ```

2. **Login to Azure CLI**

    Make sure you are logged in to your Azure account via CLI:

    ```bash
    az login
    ```

3. **Set Execution Permissions**

    Depending on the script, you might need to set the appropriate execution permissions:

    ```bash
    chmod +x script_name.sh
    ```

4. **Run the Script**

    Execute the script with necessary arguments as per the script's usage instructions:

    ```bash
    ./script_name.sh
    ```

## Usage

The primary script in this repository, `run-on-vm.sh`, is designed to execute a specified script on a list of Azure VMs. Here's a basic usage example:

```bash
./run-on-vm.sh -f vm_list.txt -s script_to_run.sh
```

- `-f vm_list.txt`: Specifies the file containing a list of VM names and their respective resource groups.
- `-s script_to_run.sh`: Specifies the script to be executed on the VMs listed in vm_list.txt.

## vm_list.txt Format
The VM list file should contain lines in the format `vmName,resourceGroupName`, one VM per line. Example:

```bash
myVm1,myResourceGroup1
myVm2,myResourceGroup2
```

## Custom Script Requirements
Your custom script (script_to_run.sh) should be able to run on the target VM's environment. Ensure it has the correct shebang line at the top and appropriate execution permissions.

## Contributing
Contributions are welcome! Please feel free to submit a pull request or create an issue for any bugs, features, or improvements.