# Deletes resources provisioned by "deployVM.ps1" using the naming prefixes as an argument
# Is dependent on the current naming convention applied in sqlVMtemplate.json

# Initialize resource names 
$prefix = $args[0]
$resourceGroup = "Innovation-ICD-Apps-RG"

# Delete resources
Remove-AzResource -ResourceGroupName $resourceGroup -ResourceName $prefix'VM' -ResourceType Microsoft.Compute/virtualMachines -Force
Remove-AzResource -ResourceGroupName $resourceGroup -ResourceName $prefix'_DataDisk_0' -ResourceType Microsoft.Compute/disks -Force
Remove-AzResource -ResourceGroupName $resourceGroup -ResourceName $prefix'_DataDisk_1' -ResourceType Microsoft.Compute/disks -Force
Remove-AzResource -ResourceGroupName $resourceGroup -ResourceName $prefix'nsg' -ResourceType Microsoft.Network/networkSecurityGroups -Force
