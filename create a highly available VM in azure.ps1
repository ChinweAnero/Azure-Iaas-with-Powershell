#create a highly available VM in azure

#first create a resource group
New-AzResourceGroup `
-Name "Test2ResourceGroup" `
-Location EastUS

#create an availability domain
New-AzAvailabilitySet `
-Location "EastUS" `
-Name "AvailabilitySet" `
-ResourceGroupName "Test2ResourceGroup" `
-Sku aligned `
-PlatformUpdateDomainCount 2 `
-PlatformFaultDomainCount 2 

#set the credentials for the vm
$cred = Get-Credential

#create two vms inside the availablity set
for ($i=1; $i -le 2; $i++)
{
    New-AzVM `
    -ResourceGroupName "Test2ResourceGroup" `
    -Name "Test2VM$i" `
    -Location 'East US' `
    -VirtualNetworkName "TestVnetwork2" `
    -SubnetName "TestSubnet2" `
    -SecurityGroupName "TestSecurityGroup2" `
    -PublicIpAddressName "TestPublicIpAdress$i" `
    -AvailabilitySetName "AvailabilitySet" `
    -Credential $cred
}

#check for available vm sizes for the scale set
Get-AzVMSize `
-AvailabilitySetName "AvailabilitySet" 


