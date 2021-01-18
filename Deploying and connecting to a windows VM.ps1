#Deploying and connecting to a windows VM

#Creating a resource group
New-AzResourceGroup `
-ResourceGroupName "TestingResourceGroupName" `
-Location "EastUS"

#creating a virtual maching
#first set username and password for vm

$cred = Get-Credential

#vm
New-AzVM `
-ResourceGroupName "TestingResourceGroupName" `
-Name "TestVM" `
-Location "EastUS" `
-VirtualNetworkName "TestVnet" `
-SubnetName "TestSubnet" `
-SecurityGroupName "TestSucurityGroup" `
-PublicIpAddressName "TestPublicIpAddress" `
-Credential $cred 

#Connecting to vm

Get-AzPublicIpAddress `
   -ResourceGroupName "TestingResourceGroupName"  | Select-Object IpAddress

mstsc /v:<52.224.10.226>

Get-AzVMImagePublisher -Location "EastUS"

Stop-AzVM `
   -ResourceGroupName "TestingResourceGroupName" `
   -Name "TestVM" -Force


Remove-AzResourceGroup `
-Name "TestingResourceGroupName"



   