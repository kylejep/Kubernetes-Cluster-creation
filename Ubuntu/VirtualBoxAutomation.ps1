#Define Variables
$env:path="C:\Program Files\Oracle\VirtualBox;$env:path"

$vmNamePF='pfSense'
$vmName='ansible'
$vmName1='k8s-master'
$vmName2='k8s-worker1'
$vmName3='k8s-worker2'

#I did not install to the default file location on this variable 
$vmPath="C:\VirtualBox\VMs\$vmName"
$vmPath2="C:\VirtualBox\VMs\$vmNamePF"

#  Set the user name for the ubuntu instances
$userName='lab'

#  Set the password for the ubuntu instances
$password='CDWLab1!'

#  Set the location of the ISO for Ubuntu
$isoFile='C:\ISOs\ubuntu-20.04.1-desktop-amd64.iso'


# Check if the Ubuntu ISO is in the file path and if not download the ISO
Import-Module BitsTransfer
if (! (test-path $isoFile)) {
    Write-Output "ubuntu ISO file not found, downloading ISO from Ubuntu"
    Start-BitsTransfer -Source "https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-desktop-amd64.iso" -Destination "C:\ISOs"
   }


 $vmNamePF='pfSense'
$vmPath2="C:\VirtualBox\VMs\$vmNamePF"
$isoFile1='C:\ISOs\pfSense-CE-2.4.5-RELEASE-p1-amd64.iso'
$isoFile1zip='C:\ISOs\pfSense-CE-2.4.5-RELEASE-p1-amd64.iso.gz'

#Check if the pfSense ISO is present in the correct directory and if not download it
if (! (test-path $isoFile1zip)) {
    Write-Output "pfSense Firewall ISO file not found, downloading ISO from pfSense"
    Start-BitsTransfer -Source "https://nyifiles.pfsense.org/mirror/downloads/pfSense-CE-2.4.5-RELEASE-p1-amd64.iso.gz" -Destination "C:\ISOs"
     }

 # Deinfe the unzip function for GZip
 Function DeGZip-File{
    Param(
        $infile,
        $outfile = ($infile -replace '\.gz$','')
        )
    $input = New-Object System.IO.FileStream $inFile, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $output = New-Object System.IO.FileStream $outFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
    $gzipStream = New-Object System.IO.Compression.GzipStream $input, ([IO.Compression.CompressionMode]::Decompress)
    $buffer = New-Object byte[](1024)
    while($true){
        $read = $gzipstream.Read($buffer, 0, 1024)
        if ($read -le 0){break}
        $output.Write($buffer, 0, $read)
        }
    $gzipStream.Close()
    $output.Close()
    $input.Close()
}

# Unzip the ISO
DeGZip-File "C:\ISOs\pfSense-CE-2.4.5-RELEASE-p1-amd64.iso.gz" "C:\ISOs\pfSense-CE-2.4.5-RELEASE-p1-amd64.iso"

#Clean up all VMs in the environement if this script has been run before
VBoxManage controlvm $vmName poweroff
VBoxManage unregistervm $vmName --delete
Remove-Item -recurse $vmPath

VBoxManage controlvm $vmName1 poweroff
VBoxManage unregistervm $vmName1 --delete
Remove-Item -recurse $vmPath1

VBoxManage controlvm $vmName2 poweroff
VBoxManage unregistervm $vmName2 --delete
Remove-Item -recurse $vmPath2

VBoxManage controlvm $vmName3 poweroff
VBoxManage unregistervm $vmName3 --delete
Remove-Item -recurse $vmPath3

VBoxManage controlvm $vmNamePF poweroff
VBoxManage unregistervm $vmNamePF --delete
Remove-Item -recurse $vmPathPF

#Detect OS of .iso
VBoxManage.exe unattended detect --iso=$isoFile

# Create Ubuntu VM
VBoxManage createvm --name $vmName --ostype Ubuntu_64 --register

if (! (test-path $vmPath\$vmName.vbox)) {
   Write-Output "I expected a .vbox"
   return
}

#Add hard disk
VBoxManage createmedium --filename $vmPath\$vmName-hard-drive.vdi --size 10240

if (! (test-path $vmPath\$vmName-hard-drive.vdi)) {
   Write-Output "I expected a .vdi"
   return
}
#Add Sata controller
VBoxManage storagectl    $vmName --name       'SATA Controller' --add sata --controller IntelAHCI
VBoxManage storageattach $vmName --storagectl 'SATA Controller' --port 0 --device 0 --type hdd --medium $vmPath\$vmName-hard-drive.vdi

#   Create an IDE storage controller for a virtual DVD drive and
VBoxManage storagectl    $vmName --name       'IDE Controller'  --add ide

#   attach an Installation ISO medium
VBoxManage storageattach $vmName --storagectl 'IDE Controller'  --port 0 --device 0 --type dvddrive --medium $isoFile

#Enable APIC for Montherboard I/O
VBoxManage modifyvm $vmName --ioapic on

#specify boot order
VBoxManage modifyvm $vmName --boot1 dvd --boot2 disk --boot3 none --boot4 none

#specify Memory
VBoxManage modifyvm $vmName --memory 4096 --vram 128

#Enable clipboard
VBoxManage modifyvm  $vmName --clipboard-mode bidirectional

#VBox SVGA 
VBoxManage modifyvm  $vmName --graphicscontroller VMSVGA

# Set up unattended install of Ubuntu
VBoxManage unattended install $vmName      `
  --iso=$isoFile                           `
  --user=$userName                         `
  --password=$password                     `
  --hostname=ansible.localhost.localdomain `
  --full-user-name='lab'                   `
  --install-additions                      `
  --package-selection-adjustment=minimal   `
  --time-zone=PST                          `

#start the vm
VBoxManage startvm $vmName --type headless
  
#Remove Menues
VBoxManage setextradata $vmName GUI/RestrictedRuntimeMenus ALL 

#wait until the install finishes to keep going
VBoxManage guestproperty wait $vmName "/VirtualBox/GuestInfo/OS/LoggedInUsers"
 
# add user to sudoers
VBoxManage guestcontrol $vmName run /bin/sh --username root --password $password --wait-stdout --wait-stderr -- -c "usermod -aG sudo lab"

# Run apt-get update
VBoxManage guestcontrol $vmName --username=root --password=$password run --exe  /bin/apt-get /arg0 update
#upgrade all packages
VBoxManage guestcontrol $vmName --username=root --password=$password run --exe  /bin/apt-get /arg0 upgrade --wait-stdout -- -y
#Install open-ssh server
VBoxManage guestcontrol $vmName --username=root --password=$password run --exe  /bin/apt-get /arg0 install openssh-server --wait-stdout -- -y 

#Stop the Ubuntu VM
VBoxManage controlvm $vmName acpipowerbutton

Start-Sleep 60
 
# clonevm to create master and worker nodes
VBoxManage clonevm $vmName --name=$vmName1 --register --mode=all
VBoxManage clonevm $vmName --name=$vmName2 --register --mode=all
VBoxManage clonevm $vmName --name=$vmName3 --register --mode=all

#Modify Mac Addresses for Static DHCP reservations
VBoxManage modifyvm $vmName --macaddress1 00155D020221 --nic1 intnet 
VBoxManage modifyvm $vmName1 --macaddress1 00155D020222 --nic1 intnet --cpus 2 --memory 1024
VBoxManage modifyvm $vmName2 --macaddress1 00155D020223 --nic1 intnet --memory 1024
VBoxManage modifyvm $vmName3 --macaddress1 00155D020224 --nic1 intnet --memory 1024

# Create PFsense VM
$vmNamePF='pfSense'
$vmPath2="C:\VirtualBox\VMs\$vmNamePF"
$isoFile1='C:\ISOs\pfSense-CE-2.4.5-RELEASE-p1-amd64.iso'
$mypath = $MyInvocation.MyCommand.Path | Split-Path


#Variable for the creation of the Bridged Adapter
$netcon=Get-Netadapter -Physical | Where-Object status -eq 'up' | Select-Object -Property 'InterfaceDescription' | Format-Table -HideTableHeaders | Out-String -NoNewline

#Define the VM to be created
VBoxManage createvm --name $vmNamePF --ostype FreeBSD_64  --register

if (! (test-path $vmPath2\$vmNamePF.vbox)) {
   Write-Output "I expected a .vbox"
   return
}

#  Enable the USB controller
VBoxManage modifyvm $vmNamePF --usb on 

#Add hard disk
VBoxManage createmedium --filename $vmPath2\$vmNamePF-hard-drive.vdi --size 10240

if (! (test-path $vmPath2\$vmNamePF-hard-drive.vdi)) {
   Write-Output "I expected a .vdi"
   return
}

#   Create an IDE storage controller for a virtual DVD drive and HDD
VBoxManage storagectl $vmNamePF --name 'IDE' --add ide
#  Create SCSI bus controller for USB
VBoxManage storagectl $vmNamePF --name 'USB Controller' --add usb --controller USB

#   attach disk to controller
VBoxManage storageattach $vmNamePF --storagectl 'IDE' --port 0 --device 1 --type hdd --medium $vmPath2\$vmNamePF-hard-drive.vdi

#   attach an Installation ISO medium
VBoxManage storageattach $vmNamePF --storagectl 'IDE'  --port 0 --device 0 --type dvddrive --medium $isoFile1


#Set Nic1 type
VBoxManage modifyvm $vmNamePF --nic1 bridged --bridgeadapter1 $netcon.Trim()
#Set Nic2 type
VBoxManage modifyvm $vmNamePF --nic2 intnet

#Enable APIC for Montherboard I/O
VBoxManage modifyvm $vmNamePF --ioapic on

#specify Memory
VBoxManage modifyvm $vmNamePF --memory 1024 --vram 16

#VBox SVGA 
VBoxManage modifyvm  $vmNamePF --graphicscontroller VMSVGA

#  test if the ConfDisk .vmdk is already in the path If not copy over the ConfDisk
if (! (test-path $vmPath2\ConfDisk.vmdk)) {
   Copy-Item -Path $mypath\ConfDisk.vmdk -Destination $vmPath2
   return
}

#start the vm
VBoxManage startvm $vmNamePF

# Set variable to capture VM transition state from logs
$vmState=Get-Content $vmPath2\Logs\VBox.log | Select-String -Quiet "Changing the VM state from 'RUNNING' to 'RESETTING'"

#While the VM has not been reset, keep hitting enter every second
While ($vmState -ne "True")
{
    "installing pfSense with defaults"
    VBoxManage controlvm $vmNamePF keyboardputscancode 1C 9C
  start-sleep 1
  $vmState=Get-Content $vmPath2\Logs\VBox.log | Select-String -Quiet "Changing the VM state from 'RUNNING' to 'RESETTING'"
}

# unmount the ISO so the installation can finish
VBoxManage storageattach $vmNamePF --storagectl 'IDE'  --port 0 --device 0 --medium emptydrive
#  Attach the ConfDisk to the VM
VBoxManage storageattach $vmNamePF --storagectl 'USB Controller' --port 0 --device 0 --type hdd --medium $vmPath2\ConfDisk.vmdk

#wait for the reboot to finish
start-sleep 50

#  Remove the ConfDisk
VBoxManage storageattach $vmNamePF --storagectl 'USB Controller' --port 0 --device 0 --type hdd --medium none 


VBoxManage startvm $vmName --type headless
VBoxManage startvm $vmName1 --type headless
VBoxManage startvm $vmName2 --type headless
VBoxManage startvm $vmName3 --type headless


#install Ansible
VBoxManage guestcontrol $vmName --username=root --password=$password run --exe /bin/apt /arg0 install ansible --wait-stdout -- -y 
#install Git
VBoxManage guestcontrol $vmName --username=root --password=$password run --exe /bin/apt /arg0 install git --wait-stdout -- -y 

#Make new directory for git clone
VBoxManage guestcontrol $vmName run /bin/sh --username lab --password $password --verbose --wait-stdout --wait-stderr -- -c "mkdir /home/lab/k8s && cd /home/lab/k8s && git init"

