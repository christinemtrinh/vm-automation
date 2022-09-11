# vm-automation

This is a series of Powershell scripts using JSON Azure Resource Manager template to deploy a virtual machine. 
It sets up a sandbox environment through a series of steps.

  1. Declare needed resources (i.e. resource group, storage account, helper script) and their location
  2. Assign identifying name for deployment
  
Missing from the files is an additional script which configured security settings on the VM, copied over back up files from blob storage, and runs a SQL query to attach the database to make a usable instance. 

Achievements: 
  - Utilized Key Vault to shield password from code
  - Assigned resources of a deployment a common, randomized prefix to differentiate
  - Generated tokens for secure access to cloud resources
  - Configured network to only allow connections from corporate VPN
