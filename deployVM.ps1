# Works as the main driving script which sets up the allure environment

# DECLARING PARAMETER RESOURCE NAMES
# Note that it has a dependency on azcopy.ps1 in blob storage
$resourceGroup = "Innovation-ICD-Apps-RG"
$storageAcc = "sqlvacmlqjaheddn2y"
$blob = "azcopy.ps1"
$location = "South Central US"
$container = "databasebackupcontainer"

# VM DEPLOYMENT
# Use random number to differentiate deployments
# Note that it requires the template and parameter file to be available locally 
$deploymentNum = Get-Random -Maximum 1000
$deploymentName = "SQLVMDeployment" + $deploymentNum

# Use local template and parameter file to deploy a VM
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile sqlVMtemplate.json -TemplateParameterFile paramfile.json -Name $deploymentName
$VM = (Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -Name $deploymentName).outputs.vmName.value
# $adminPass = (Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -Name $deploymentName).outputs.adminPw.value

# COPYING BACKUP FILES TO VM
# Generate SAS token
$storageAccKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAcc).Value[0]
$context = New-AzureStorageContext -StorageAccountName $storageAcc -StorageAccountKey $storageAccKey
$startTime = (Get-Date).AddMinutes(-15)
$endTime = $startTime.AddHours(1.15)
$sasToken = New-AzureStorageBlobSASToken -Container $container -Blob $blob -Permission r -StartTime $startTime -ExpiryTime $endTime -Context $context

# Run command to use AZcopy
Set-AzVMCustomScriptExtension -ResourceGroupName $resourceGroup -VMName $VM -Location $location -FileUri "https://sqlvacmlqjaheddn2y.blob.core.windows.net/databasebackupcontainer/$blob$sasToken" -Run $blob -Name "demoScriptExtension"

# Download file to launch RDP
# Get-AzRemoteDesktopFile -ResourceGroupName $resourceGroup  -Name $VM -LocalPath "C:\RDP\$VM.rdp"
