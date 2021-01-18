#Start the VM
Start-AzVM `
-ResourceGroupName "TestingResourceGroupName" `
-Name "TestVM"




#Create and manage data disks 
#configure disk
$diskConfig = New-AzDiskConfig `
 -Location "EastUS" `
 -CreateOption Empty `
 -DiskSizeGB 128

 #create data disk
$dataDisk = New-AzDisk `
-ResourceGroupName "TestingResourceGroupName" `
-DiskName "TestDataDisk" `
-Disk $diskConfig

#get the vm to attache the disk to
 $vm = Get-AzVM `
-ResourceGroupName "TestingResourceGroupName" `
-Name "TestVM"

#Add the Data disk to the VM
Add-AzVMDataDisk `
-VM $vm `
-Name "TestDataDisk" `
-CreateOption Attach `
-ManagedDiskId $dataDisk.Id `
-Lun 1 

#update the vm
Update-AzVM `
-ResourceGroupName "TestingResourceGroupName"`
-VM $vm

#configure OS to use data disk
Get-Disk | Where-Object partitionstyle -eq 'raw' |
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -AssignDriveLetter -UseMaximumSize |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "TestDataDisk" -Confirm:$false

#verify that data disk is attached
$vm.StorageProfile.DataDisks