#Automate vm configuration

Set-AzVMExtension -ResourceGroupName "TestingResourceGroupName"`
    -ExtensionName "IIS" `
    -VMName "TestVM" `
    -Location "EastUS" `
    -Publisher Microsoft.Compute `
    -ExtensionType CustomScriptExtension `
    -TypeHandlerVersion 1.8 `
    -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'


#TEST THE WEBSITE USING THE IP ADDRESS
Get-AzPublicIpAddress `
-ResourceGroupName "TestingResourceGroupName" `
-Name "TestPublicIpAddress"` | Select-Object IpAddress 

#Cleaning up resources
#Delete the VM

