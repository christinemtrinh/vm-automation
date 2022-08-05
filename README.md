# vm-automation

This is a series of Powershell scripts using JSON Azure Resource Manager template to deploy a virtual machine. 
It sets up a sandbox environment through a series of steps.

  1. Declare needed resources (i.e. resource group, storage account, helper script) and their location
  2. Assign identifying name for deployment

Achievements: 
  - Utilized Key Vault to shield password from code
  - Assigned resources of a deployment a common, randomized prefix to 
