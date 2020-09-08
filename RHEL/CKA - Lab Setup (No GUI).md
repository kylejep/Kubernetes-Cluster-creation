CKA - Lab Setup (No GUI)

Tuesday, August 11, 2020

11:31 AM

 

\# Version 0.005

\# Date: 2020-09-01

\# by Kyle Jepson with colorful commentary by Jeremey Wise

 

**Goal: Setup of lab to pass CKA certification**

 

The purpose of this lab set up guide is to give individuals looking to get hands on experience with Kubernetes, a repeatable set up process for getting a multi node cluster stood up. This is not a production grade cluster and several of the steps involved in the setup would not be used in a real world environment. This does however lower barriers of entry for those looking to understand and use Kubernetes in a local environment, without the use of cloud providers.

 

**Requirements:** Windows 10 system with account having administrator rights

 

**Step 1:** Package staging and setup Hyper-V

 

 

 

Download RHEL 7.8 iso \*\*requires RedHat account\*\*

<https://access.redhat.com/downloads>

Download - Red Hat Enterprise Linux 7.8 Binary DVD - \*should be the one listed as 4.24GB\*

Ex: RHEL 7.8 Binary DVD <https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.8/x86_64/product-software>

<img src="media/image1.png" style="width:11.1875in;height:0.85417in" />

 

 

 

\# Install HyperV

\# Navigate to windows features and enable Hyper-V

<img src="media/image2.png" style="width:2.55208in;height:0.5in" />

 

\# Use the link to Programs and Features

<img src="media/image3.png" style="width:4.67708in;height:1.54167in" />

 

\# Then to Turn Windows features on or off

<img src="media/image4.png" style="width:5.4375in;height:1.625in" />

 

\# Check the box for Hyper-V and follow the prompts which may require a restart

<img src="media/image5.png" style="width:4.27083in;height:2.71875in" />

 

\# You may need to validate service "HyperV Manager" is started

\# Launch "services" mmc

<img src="media/image6.png" style="width:1.70833in;height:0.63542in" alt="Machine generated alternative text: Services App " />

 

\# Check "Hyper-V Machine Management" is started

<img src="media/image7.png" style="width:7.41667in;height:4.29167in" alt="Machine generated alternative text: Se Nices File Action View Help Services (Local) Name Host Guardian Client Service Host Network Service HP App Helper ASA Service HP Network RSA Service HP System Info ASA Service Human Interface Device Service HV Host Service Hyper-V Data Exchange Service Hyper-V Guest Service Interface Hyper-V Guest Shutdown Service Hyper-V Heartbeat Service Hyper-V Host Compute Service Hyper-V PowerSheII Direct Service Hyper-V Remote Desktop Virtualization Service Hyper-V Time Synchronization Service Hyper-V Virtual Machine Management Description Provides abstraction of Has... Provides suppot for Windo... Activates and maintains the... Provides an interface for the... Provides a mechanism to ex... Provides an interface for the... Provides a mechanism to sh... Monitors the state of this vir... Provides support for runnin... Provides a mechanism to m... Provides a platform for com... Synchronizes the system ti... Management service fcr By... Status Running Running Running Running Running Running Running Running " />

 

 

Launch "Hyper-V manager"

<img src="media/image8.png" style="width:2.35417in;height:0.64583in" alt="Machine generated alternative text: Hyper-V Manager " />

 

\# Set Hyper-V defaults via "Hyper-V Settings" on left menu

<img src="media/image9.png" style="width:4.95833in;height:1.94792in" />

 

\# Create a folder at C:\\Hyper-V\\Virtual Disks\\ as the default folder for Virtual Disks

<img src="media/image10.png" style="width:7.05208in;height:1.05208in" />

 

\#Set the folder C:\\Hyper-V\\ as the default folder for Virtual machines

 

<img src="media/image11.png" style="width:7.16667in;height:1.16667in" />

 

\# Set up Virtual Switches -

\# Navigate to Virtual Switch manager

<img src="media/image12.png" style="width:4.875in;height:3.10417in" />

 

 

\#\#\# **Optional**: You MAY have to check your "Default Switch" to make sure it is set to "external" and bridges to the LAN / Wifi Interface you use for internet Access (with DHCP

\# EX: Below is new switch I had to make to a bridge to 1Gb RJ45 Ethernet I use (vs wifi) "External\_Bridge\_Switch"

<img src="media/image13.png" style="width:4.40625in;height:4.21875in" alt="Machine generated alternative text: Virtual Switch Manager for LT-AD070iOI Virtual Switches Nevv virtual newvork switch Default Switch Default NetA&#39;ork Private virtual snitch Intel(R) Ethernet Connection Globa I Network Settings MAC Address Range 00-15-50-3g-1c-oo to 00-15-50-3. Virtual Switch Proper bes Connection type What do pu want to connect this virtual switch to? @ External newvork: Intel(R) Ethernet Connection (6) 1219-LM Z] Allon management operating system to share this newvork adapter C) Internal newvork C) Private newvork Enable virtual LAN dentficabon for management operating system The VLAN identifier specifies the virtual LAN that the management operatng system &#39;&quot;ill use for all net&#39;,vork communications through this netnork adapter. This settng does not affect virtual machine netnorkjng. " />

 

 

\# Add new Private virtual switch

<img src="media/image14.png" style="width:7.20833in;height:2.16667in" />

 

\# Name it "LAN" and hit apply

<img src="media/image15.png" style="width:7.39583in;height:2.01042in" />

 

 

**Step 2:** Import firewall VM

Download zip package titled CKA LAB from - <https://cdw-my.sharepoint.com/:u:/p/kylejep/Eb6Qigc6sjhJkLc01z-wM84BbF1vmMMhTC-DI_jBu1boww?e=5nlwOf>

 

\# Extract the CKA LAB file to Hyper-V folder

<img src="media/image16.png" style="width:5.70833in;height:1.73958in" />

 

 

\# Import pfSense VM via "Import Virtual Machine"

<img src="media/image17.png" style="width:6.23958in;height:2.34375in" />

 

 

\# Navigate to C:\\Hyper-V\\CKA LAB\\pfSense select folder

<img src="media/image18.png" style="width:4.70833in;height:1.91667in" />

 

\# You should see "pfSense" listed as the available Virtual Machine on the next screen

<img src="media/image19.png" style="width:7.34375in;height:5.13542in" />

 

\# Choose to "copy the virtual machine" so it moves it into default Hyper-V VM folders

<img src="media/image20.png" style="width:7.32292in;height:5.5625in" />

 

\# Leave Defaults

<img src="media/image21.png" style="width:5.1875in;height:3.5625in" />

 

\# Leave Defaults

<img src="media/image22.png" style="width:5.94792in;height:4.5625in" />

 

\# Choose "Finish"

<img src="media/image23.png" style="width:6.36458in;height:4.8125in" />

 

 

**Step 4**: Deploy Bootstrap / Ansible VM

 

 

\# Launch Hyper V and create new VM "ansible\_boot"

<img src="media/image24.png" style="width:9.08333in;height:2.13542in" />

 

 

 

<img src="media/image25.png" style="width:7.32292in;height:5.5625in" alt="Machine generated alternative text: New Virtual Machine Wizard Specify Name and Location Before You Begin Specify Name and Locaton Specify Genera bon Assign Memor y Con figur e Ne Wvorking Connect Virtual Hard Disk Installa bon Options Summar y Choose a name and location for this virtual machine. The name is displayed in Hyper-V Manager. We recommend that you use a name that helps you easily identify this virtual machine, such as the name of the guest operating system or vvorkoad ansible_bootl You can create a folder or use an existng folder to store the virtual machine. If you dontselecta folder, the virtual machine is stored in the default folder configured for this server. Store the virtual machine in a different Bcabon Location: If you p&#39;an to take checkpoints of this virtual machine, selecta locaton that has enough free space. Checkpoints include virtual machine data and may require a large amount of space. &lt; Previous Next &gt; " />

 

\# Set boot to "Generation 1" so it uses more simple BIOS vs UEFI

<img src="media/image26.png" style="width:5.34375in;height:4.0625in" />

 

\# Set RAM to 2GB

<img src="media/image27.png" style="width:5.46875in;height:4.14583in" />

 

\# Set to virtual switch "LAN"

<img src="media/image28.png" style="width:5.10417in;height:3.8125in" />

 

\# Set drive to 20GB with rest as defaults

<img src="media/image29.png" style="width:7.3125in;height:5.57292in" alt="Machine generated alternative text: New Virtual Machine Wizard Connect Virtual Hard Disk Before You Begin Specify Name and Location Specify Gener a bon Assign Memor y Configure Net,Norkjng Connect Virtual Hard Disk Installa bon Options Summar y A virtual machine requires storage so that you can install an operatng system You can specify the storage non or configure it later by modifying the virtual machineß propertes. @ Create a virtual hard disk use this option to create a VHDX dynamically expanding virtual hard disk. Loca bon: ansible boot. vhdx Hard Disks\ GE (Maximum: 64 TB) C) use an existing virtual hard disk use this option to attach an existing VHDX virtual hard disk. Location: Hard Disks\ C) Attach a virtual hard disk later Use this option to skip this step and attach an existing virtual hard disk later. arovvse.. &lt; Previous Next &gt; " />

 

 

\# Select downloaded RHEL ISO file you downloaded and saved earlier

<img src="media/image30.png" style="width:6.28125in;height:4.76042in" />

 

\# Choose "Finish"

<img src="media/image31.png" style="width:4.75in;height:3.61458in" />

 

\# Edit "ansible\_boot" to set mac to 00:15:5D:**02:02:21** on NIC for pfsense to have reservation match

<img src="media/image32.png" style="width:4.14583in;height:0.77083in" alt="Machine generated alternative text: ansLie _bODt Connect-. settings. " />

 

<img src="media/image33.png" style="width:5.73958in;height:5.45833in" alt="Machine generated alternative text: Settings for ansible_ boot Ha rdwa re Add Hardware slos Soot from CD Security boot on LT-AD070S01 Key Storage Drive disabled Memory 2048 Ma c] Processor I Virtual processor IDE controller O Hard Drive ansible boot. vhdx IDE controller 1 DVD Drive None SCSI controller Ne Ork Adapter Hardware Acceleration Adv anced Features COM 1 None COM 2 None Diske tte Drive None Management ansible boot 01 In tegr a bon Services Some services offered Checkpoin ts Standard Advanced Fea tures MAC addr ess C) Dynamc @ Static 00 -15 -50 02 - 02 - 21 MAC address spoofing allovvs virtual machines to change the source MAC address in outgoing packets to one that is not assigned to them. Enable MAC address spoofing DHCP guard DHCP guard drops DHCP server messages from unauthorized virtual machines pretending to be DHCP servers. Enable DHCP guard Router guard Router guard drops router advertsement and redirection messages from unauthorized virtual machines pretending to be routers. Enable router adverbsement guard Pro tected ne Wvork Move this virtual machine to another duster node if a newvork disconnection is Z] Protected newvork Por t mirr oring Port mirroring allows the newvork traffc of a virtual machine to be monitored by copying incoming and outgoing packets and forwarding the copies to another virtual machine configured for monitoring Mirr oring mode: Apply " />

 

 

\# Start both VMs

<img src="media/image34.png" style="width:3.61458in;height:1.8125in" />

 

\# Connect to VM ansible\_boot VM console to run setup

<img src="media/image35.png" style="width:5.48958in;height:1.41667in" />

 

**Step 4**: Install RHEL basic

 

Select Install Red Hat … and hit enter

 

<img src="media/image36.png" style="width:5.95833in;height:3.13542in" />

 

 

Once loaded select English and continue

 

<img src="media/image37.png" style="width:6.07292in;height:5.02083in" />

 

 

Select Installation Destination for hard disk to accept clearing any data on disk.

<img src="media/image38.png" style="width:9.5625in;height:6.54167in" />

 

 

Leave Defaults and hit done

<img src="media/image39.png" style="width:10.07292in;height:5.15625in" />

 

 

Select Network and Host name

<img src="media/image40.png" style="width:7.58333in;height:5.08333in" />

 

 

Set the host name below as ansible.localhost.localdomain and make sure to hit apply

 

enable the eth0 link

 

If this page is set up correctly the current hostname in the bottom right hand corner should show ansible.localhost.localdomain

And the IP address of your machine should show 192.168.1.5

<img src="media/image41.png" style="width:9.57292in;height:7.02083in" />

 

Go to software selection

<img src="media/image42.png" style="width:8.14583in;height:5.02083in" />

 

Select Server with GUI hit done

 

<img src="media/image43.png" style="width:5.27083in;height:4.02083in" />

 

 

Once back to main screen hit Begin installation in lower right hand corner

 

 

Set Root password \*This can be anything as long as you remember it\*

however for all credentials we used CDWLab1! For example within the pfSense firewall

 

 

<img src="media/image44.png" style="width:8.4375in;height:1.91667in" />

 

Set the username as "lab" \*this username matters and this user must be set as an admin by checking the box\*

 

For simplicity set the user password the same as Root

Hit the done button **twice**

 

<img src="media/image45.png" style="width:7.67708in;height:7.01042in" />

 

 

Wait for the installation to finish

 

reboot

<img src="media/image46.png" style="width:7.73958in;height:1.73958in" />

 

Shut down the VM

 

<img src="media/image47.png" style="width:3.16667in;height:1.90625in" />

 

 

Export the VM to a template

 

<img src="media/image48.png" style="width:5.35417in;height:2.79167in" />

 

Create a subfolder in Hyper-Van called Templates \*the file location does matter here\* at the location shown below.

<img src="media/image49.png" style="width:5in;height:1.63542in" alt="Machine generated alternative text: Export Virtual Machine Specify where you want to save the files location C " />

 

Hit export and see the status in the Hyper-V Manager

<img src="media/image50.png" style="width:2.66667in;height:0.57292in" />

 

Change the name of the VM or the PowerShell script will rename it

<img src="media/image51.png" style="width:2.53125in;height:2.14583in" />

Ex: rename to ansible\_boot\_01

<img src="media/image52.png" style="width:2.25in;height:0.36458in" />

 

\# Open PowerShell as an administrator

 

<img src="media/image53.png" style="width:6.05208in;height:5.79167in" />

 

\# make sure the script pane is open

<img src="media/image54.png" style="width:7.04167in;height:1.09375in" alt="Machine generated alternative text: Administrator: Windows PowerSheII ISE File Edit View Tools Debug Add-ons Help " />

 

\# Open the PowerShell script file in the CKA LAB zip package that was extracted to C:\\Hyper-V

<img src="media/image55.png" style="width:4.26042in;height:1.01042in" alt="Machine generated alternative text: Administrator: Windows PowerSheII ISE File Edit View Tools Debug Add-ons Help Ctrl* N Open„. Ctrl+O " />

 

File path is C:\\Hyper-V\\CKA LAB\\CKA LAB\\K8sprovisionVMs

<img src="media/image56.png" style="width:4.47917in;height:1.625in" />

 

\# Now we will customize this deployment script as we go

 

 

 

\# Collect VM ID of that template

Ex:

<table><tbody><tr class="odd"><td><p>PS C:\Hyper-V&gt; dir 'C:\Hyper-V\Templates\ansible_boot\Virtual Machines\'</p><p> </p><p> </p><p>Directory: C:\Hyper-V\Templates\ansible_boot\Virtual Machines</p><p> </p><p> </p><p>Mode LastWriteTime Length Name</p><p>---- ------------- ------ ----</p><p>-a---- 8/17/2020 11:45 AM 45090 1994388F-C9D7-441D-A992-0F456E723F20.vmcx</p><p>-a---- 8/17/2020 11:45 AM 4194816 1994388F-C9D7-441D-A992-0F456E723F20.vmgs</p><p>-a---- 8/17/2020 11:44 AM 49152 1994388F-C9D7-441D-A992-0F456E723F20.VMRS</p><p> </p><p> </p><p> </p><p>PS C:\Hyper-V&gt;</p></td></tr></tbody></table>

 

 

\# Paste into line 18

<img src="media/image57.png" style="width:10.80208in;height:4.26042in" />

 

\# Run command to enable shell commands Ex: Run command and click "Yes to All"

set-executionpolicy remotesigned

<img src="media/image58.png" style="width:10.14583in;height:1.94792in" alt="Machine generated alternative text: Mode Execution Policy Change L astWr i teT The execution policy helps protect you from scripts that)&#39;ou do not trust. Changing the execution policy might expose you to the security ris 8/17/2020 11:45 8/17/2020 11:45 8/17/2020 11:44 Yes to All PS C: \ resources\K8sprovisionWs.psI PS set—executionpolicy remotesigned " />

 

\# Run script

<img src="media/image59.png" style="width:4.5625in;height:1.21875in" alt="Machine generated alternative text: Administrator: Windows PowerSheII ISE File Edit View Tools Debug K8sprovisionVMs.psI X Foreach (Slmport in Add-ons Help Slmport) Run Script (F5) " />

 

 

 

Watch for the VMs to be created in the Hyper-V Manager

 

Once the master and two workers are created start them along with the Ansible machine

 

<img src="media/image60.png" style="width:3.5625in;height:1.84375in" />

 

 

 

\# Download or use an SSH client to ssh into ansible controller - we will use PuTTY from putty.org

The link here is the 64bit windows installer

<https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.74-installer.msi>

Go through the installation with all the defaults

 

Find the ip address you need to ssh into.

 

<img src="media/image61.png" style="width:7.69792in;height:5.71875in" />

 

Open PuTTY

In the Session tab put the IP address of the WAN port on the pfSense firewall as shown above.

<img src="media/image62.png" style="width:4.75in;height:4.64583in" />

 

Select Yes on the prompt

<img src="media/image63.png" style="width:3.5in;height:2.19792in" />

 

\# Login to console as user "lab" created during template build

 

<img src="media/image64.png" style="width:3.16667in;height:0.88542in" />

 

\#Using PuTTY you can now copy and paste the remaining commands

 

\#\# &lt;&lt;&lt;&lt;&lt;&lt; CKA class should use RedHat resource to get a class key that feeds opporutunites to CDW and Redhat for Containers . We need a key for this lab that is 60 days&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;. Mitch has lead on this

\# Using your regular desktop browser Get the activation code from access.redhat.com website under your Redhat Account <https://access.redhat.com/management/>

<img src="media/image65.png" style="width:7.80208in;height:1.91667in" alt="Machine generated alternative text: Red Hat Customer Portal Products &amp; Services Tools Overview Security Contracts Community Subscriptions Systems Cloud Access Subscription Allocations Errata CDW Ansible Test Manage • RHSM API Tokens Activation Keys " />

 

\# Open (or create if you have not done this before. And copy ID and key=(name of key group name you created)

<img src="media/image66.png" style="width:9.90625in;height:3.42708in" alt="Machine generated alternative text: Overview Activation Key (ya.. this is stupidly nam Subscriptions Systems Cloud Access Subscription Allocations Contracts 280905 Activation Keys for Organization ID 1 org ID Activation Keys are used when registering systems to Subscription Manager. Learn More Filter by Key Name Errata Auto Attach Enabled Manage • Subscriptions Associated New Last Modified 07/21/2020 Show Name DW Ansible Tes IOO v entries Service Level d) No Preference Showing 1 to 1 of 1 entries 4 First Previous Next Last " />

\# Current org and key for class

$sudo subscription-manager register --org=(the organization ID number in the redhat.com portal) --activationkey=(the name of the activation key set up)

<img src="media/image67.png" style="width:8.47917in;height:1.35417in" alt="Machine generated alternative text: [rootßansible subscription-mnager reg ister - The system has been reg istered with ID . The registered system nam is: ansible. localhost . localdomin Instal led Product Current Status : Product Nam: Red Hat Enterprise Linux Sert.er --activationkey=&quot;CDW ansible Test&quot; • adlZ5e73-53fZ-483d-83Z7-d6aa1ff1c373 Status : [rootßansible Subscr i bed " />

 

\# Update the server with the repositories needed

sudo subscription-manager repos --enable=rhel-7-server-rpms  
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms  
sudo subscription-manager repos --enable=rhel-7-server-optional-rpms

sudo subscription-manager repos --enable=rhel-7-server-ansible-2.9-rpms

\# Update all

sudo yum -y update

\# Install Ansible and Git

sudo yum install -y ansible git

mkdir /home/lab/k8s

cd /home/lab/k8s

 

\# Initilize Git space in directory

git init

 

\# sync down CKA lab bits

git clone <https://github.com/kylejep/Kubernetes-Cluster-creation.git>

cd Kubernetes-Cluster-creation/RHEL/playbooks

vi env\_variables

 

Press "I" for insert to make changes to the file

Use the arrow keys to navigate to org\_num: and put in the RedHat key information you used to activate RHEL

 

<img src="media/image68.png" style="width:3.77083in;height:0.78125in" />

 

Press the "esc" key and "wq:" enter to save and escape the text editor

 

$ sudo vi /etc/hosts

 

Add the highlighted lines so the file has the content below

 

127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4

::1 localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.1.2 k8smaster.localhost.localdomain k8smaster

192.168.1.3 k8sworker1.localhost.localdomain k8sworker1

192.168.1.4 k8sworker2.localhost.localdomain k8sworker2

 

 

Press the "esc" key and "wq:" enter to save and escape the text editor

 

$ sudo vi /etc/ansible/hosts

 

\#Add the text below to the file

 

\[kubernetes\_master\_nodes\]

k8smaster

 

\[kubernetes\_worker\_nodes\]

k8sworker1

K8sworker2

 

Save and exit - "esc" then ":wq" then enter

 

\# Set up ssh -

$ ssh-keygen

\#hit enter 3 times

<img src="media/image69.png" style="width:7.53125in;height:5.27083in" />

 

\# copy over SSH key so passwordless login works. Using key of ansible host system

ssh-copy-id k8smaster

\# Enter yes and put in password

ssh-copy-id k8sworker1

\# Enter yes and put in password

ssh-copy-id k8sworker2

\# Enter yes and put in password

 

\# Launch

cd /home/lab/k8s/Kubernetes-Cluster-creation/RHEL

ansible-playbook settingup\_kubernetes\_cluster.yml --ask-become-pass

 

\#Enter sudo Password

 

\# Successful start output should look like this

<img src="media/image70.png" style="width:8.67708in;height:5.09375in" />

 

\# This process will take some time in different areas and could take upward of 20-30 minutes to complete. Successful deployment will look like below

<img src="media/image71.png" style="width:10.78125in;height:1.77083in" />

 

\# Once the cluster is built ssh into the k8s master and ensure the nodes are ready

 

$ ssh k8smaster

$ kubectl get nodes

<img src="media/image72.png" style="width:5.47917in;height:1.41667in" />

 

 

\# Optional: Once the cluster has built the first time the ansible controller can be shut down to save resources

 

 

**\# Kubernetes Tutorial - Tips and Steps to be efficient in using K8 Cluster**

**\# Updated Guide: 2020-09-01**

 

 

Task 1: Basics of login and command completion / help

ssh lab@k8smaster

 

\# Setup for Environment allows for quicker commands with shell command completion

\# Learn below and put into lab/test notepad so you can use as you change context

\# ls -alh /usr/bin/sh

\# echo $BASH\_VERSION

sudo yum install bash-completion -y

kubectl completion -h

\#\#\#\#\# Below are commands you need within lab/test \#\#\#\#\#\#\#\#\#\#\#

source &lt;(kubectl completion bash)

\# Write bash completion code to a file and source if from .bash\_profile

echo 'source &lt;(kubectl completion bash)' &gt;&gt;~/.bashrc

 

 

\# Connect to the k8s master and test out the new Kubernetes cluster

\# hit tab twice in commands to see available options

$ kubectl (tab twice - to bring up list of options)

<img src="media/image73.png" style="width:18.22917in;height:0.71875in" />

 

 

\# Show the available API resources along with their SHORTNAME notation for saving valuable time at the command line. Ex: horizontalpodautoscalers can be abbreviated hpa

$ kubectl api-resources

<img src="media/image74.png" style="width:8.46875in;height:1.15625in" alt="Machine generated alternative text: [lab@k8smaster bindings configmaps kubectl apl - resources sy-K)RTNMES s ubjectaccessreviews horizontal podautoscalers APIGROUP authorization. k8s. io autos cal ing NMESPACED true false true false true KIM) Binding ComponentStatus ConfigMap SubjectAccessReview Horizontal PodAutoscaIer " />

 

\# List API module help about community and options

$ kubectl explain hpa

\# This shows the available fields that can be used to reference yaml formatting. From there you can also pull out resources to explain further. Ex: Display formatted hpa.metadata.finalizers.

$ kubectl explain hpa --recursive

 

<img src="media/image75.png" style="width:4.82292in;height:4.59375in" />

 

\# Kubectl explain and explain with the --recursive option can help you get the majority of the information you need directly from the CLI

$ kubectl explain hpa.metadata.finalizers

<img src="media/image76.png" style="width:7.80208in;height:3.80208in" />

 

\# how to use tmux. Which allows within one Putty shell window to have split windows. This is NOT required, but for CKA / shell, this becomes a very helpful tool. In many cases there is a lot of information on a screen that needs to be referenced for another command or to edit a yaml file as an example. A terminal multiplexer is a great way of getting the information without the need to open multiple ssh sessions.

 

 

\# First we need to install tmux

$ sudo yum -y install tmux

\# Now start the multiplexer

$ tmux

\# From here we can split the screen into multiple windows

\# Here is a cheat sheet but I have a few useful commands listed below - <https://tmuxcheatsheet.com/>

\#Pressing the &lt;ctl + b&gt; at the same time is the bind key, the next key is the shortcut command - some are symbols that need to have shift held to access, so to show shortcuts below is the bind key (CTRL and b at the same time) Ex: ? (shift and / at the same time)

<table><thead><tr class="header"><th>Task</th><th>Key Sequence</th></tr></thead><tbody><tr class="odd"><td>Show shortcuts</td><td><img src="media/image77.png" style="width:1.96875in;height:0.4375in" alt="Machine generated alternative text: Ctrl b " /></td></tr><tr class="even"><td>Split pane vertically</td><td><img src="media/image78.png" style="width:2.03125in;height:0.5in" alt="Machine generated alternative text: Ctrl b " /></td></tr><tr class="odd"><td>Split pane horizontally</td><td><img src="media/image79.png" style="width:1.9375in;height:0.44792in" alt="Machine generated alternative text: Ctrl b " /></td></tr><tr class="even"><td>Switch to pane to the direction</td><td><img src="media/image80.png" style="width:2.16667in;height:1.6875in" alt="Machine generated alternative text: Ctrl Ctrl Ctrl Ctrl b b " /></td></tr><tr class="odd"><td>Enter copy mode and scroll one page up</td><td><img src="media/image81.png" style="width:2.3125in;height:0.5in" alt="Machine generated alternative text: Ctrl b PgUp " /></td></tr><tr class="even"><td>Close Pane</td><td># Type "exit"</td></tr></tbody></table>

 

This allows you to have much more information in a single window.

Ex: Below is sequence of:

<table><thead><tr class="header"><th>Split vertically</th><th><img src="media/image78.png" style="width:2.03125in;height:0.5in" alt="Machine generated alternative text: Ctrl b " /></th></tr></thead><tbody><tr class="odd"><td>Switch to pane to the right</td><td><img src="media/image82.png" style="width:1.98958in;height:0.40625in" /></td></tr><tr class="even"><td>Split pane horizontally</td><td><img src="media/image79.png" style="width:1.9375in;height:0.44792in" alt="Machine generated alternative text: Ctrl b " /></td></tr><tr class="odd"><td>Switch to pane to the top</td><td><img src="media/image83.png" style="width:1.90625in;height:0.4375in" alt="Machine generated alternative text: Ctrl " /></td></tr></tbody></table>

<img src="media/image84.png" style="width:14.01042in;height:7.45833in" />

**\#** Play around with tmux becomes a valuable tool to be efficient on CKA test where you need multiple windows but have limited desktop shell space

 

 

Task 2: Remove a worker node out of working cluster and return it

\# To get information or explain the use of a command type -h at the end of the command

\# Again type kubectl (tab twice to see options) lets pick cordon

$ kubectl cordon -h

<img src="media/image85.png" style="width:9.98958in;height:2.71875in" />

 

\#Lets cordon a node -

$ kubectl cordon k8sworker2

<img src="media/image86.png" style="width:4.0625in;height:0.45833in" />

 

\#Now lets use describe to get information on the status of the nodes

$ kubectl describe nodes

\#From here we can see all the information on the nodes in the cluster

Below you can see that the node was marked unschedulable but that pods are still running on the node

<img src="media/image87.png" style="width:8.54167in;height:3.32292in" />

 

\# To evict the pods we need to drain the node. This SHOULD fail as it has existing "pods" which are just cluster service pods. Ex: Flannel pod

$ kubectl drain k8sworker2

<img src="media/image88.png" style="width:11.85417in;height:1.55208in" />

 

\# From this we can see we need to pass additional arguments to the command to evict system pods

$ kubectl drain k8sworker2 --ignore-daemonsets

 

<img src="media/image89.png" style="width:10.54167in;height:0.79167in" />

 

\#With pods evicted we could now safely shutdown or perform maintenance on the node

$ ssh k8sworker2

$ systemctl status kubelet

\#From here you can see the status of the kubelet service running on the node

<img src="media/image90.png" style="width:8.8125in;height:1.58333in" />

 

\#Lets shut down the service to see what happens

$ systemctl stop kubelet

\#enter sudo password

 

<img src="media/image91.png" style="width:6.22917in;height:1.1875in" />

 

$ systemctl status kubelet

 

<img src="media/image92.png" style="width:8.84375in;height:1.375in" />

 

\#We can see the kubelet is now not running

\#Exit the ssh session back to the master

$ exit

 

$ kubectl get nodes

<img src="media/image93.png" style="width:5.86458in;height:0.92708in" />

 

\#We can see that k8worker2 is down

 

\#Lets bring it back online

 

$ ssh k8sworker2

$ systemctl start kubelet

$ systemctl status kubelet

 

$ exit

$ kubectl uncordon k8sworker2

<img src="media/image94.png" style="width:4.33333in;height:0.4375in" />

 

$ kubectl get nodes

<img src="media/image95.png" style="width:4.10417in;height:0.96875in" />

 

\#K8worker2 is now healthy again

 

 

 

Task 3: Create Resource

 

 

\# List Running PODs

\#First lets see what's running.

$ kubectl get po -A

<img src="media/image96.png" style="width:5.40625in;height:2.35417in" />

\# as we can see from the api-resources pods can be abbreviated po and -A is short for the flag --all-namespaces so that the command returns all pods running in the cluster.

 

\# Name Spaces:

\# By default kubernetes uses a namespace called "default" unless a namespace is created and specified when resources are started, pods will be placed in the "default" namespace

\# Lets create a namespace called my-namespace

We'll reference the kubernetes.io commands page to see what additional options we have and proper syntax for the command

Go to this link - <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands>

Click on create

Click on namespace

<img src="media/image97.png" style="width:8.98958in;height:2.28125in" />

 

Namespaces don't have many options so we'll go ahead and use the example on the right hand side.

<img src="media/image98.png" style="width:3.54167in;height:0.86458in" />

 

\#Now we'll create a deployment within the new namespace

$ kubectl create deploy \#stop the command and hit tab twice - output should look like this

 

<img src="media/image99.png" style="width:5.15625in;height:0.4375in" />

\#Now we can pick an image from docker hub we want to use

\#For now we'll use nginx and not specify a version so it will pull the latest

 

\# Create Deployment: (which will deploy pod and subordinate containers)

\# Let's look at creating some resources - container images used by docker can be explored on docker hub - <https://hub.docker.com/>

\# We are using docker so it by default uses hub.docker.com as image registry

$ kubectl create deployment --image=nginx nginx -n my-namespace --dry-run=client -o yaml&gt; nginx.yaml

 

\#with this command we set the deployment with image nginx, then we specified the name of the application we want to run. This can be set to anything but we chose nginx. Then we specify the namespace we want the pod to run in, my-namespace, which we just created. Rather than running this and making changes later we want to perform a dry run of the create command, this allows us to test and validate the command and the system guarantees that dry-run requests will not be persisted in storage or have any other side effects. We can then format the output with -o into yaml and send that into a file. We now have a manifest we can apply our resource from.

 

\#Let's make a change to this file first.

$ vi nginx.yaml

\# Press "I" to enter insert mode and edit the file

\# Work your way down to where it says replicas: 1 and change that to replicas 3

<img src="media/image100.png" style="width:2.55208in;height:1.05208in" />

\#Save the file and quit by hitting "esc" then type ":wq" enter

\# Lets apply the file and create the deployment

$ kubectl apply -f nginx.yaml

$ kubectl get po -n my-namespace

 

\# Validate: here we want to see the pods in the deployment and can see them being created. We used the short hand for pods with po and -n specified the namespace we wanted to see.

<img src="media/image101.png" style="width:6.34375in;height:1.38542in" />

 

<img src="media/image102.png" style="width:3.80208in;height:0.80208in" />

 

\# Now lets check the status of the status of the deployment

$ kubectl get deploy -A

\# this will show us the deployments in all namespaces and we can see our nginx deployment along with the number of replicas

 

<img src="media/image103.png" style="width:4.16667in;height:0.58333in" />

 

\# Wth a deployment kubernetes knows that you want 3 replicas running at all times. So if we shut down a pod we should see kubernetes spin up a new replica.

\# For this we need to be quick so we're going to open up a second tab and pass the --watch parameter to keep the command updating constantly

\#On tab 1

$kubectl get pods -n my-namespace

\#On tab 2

$ kubectl get deployment -n my-namespace --watch

\# Your set up should now look something like this-

<img src="media/image104.png" style="width:11.69792in;height:1.63542in" />

 

\#Now let's delete a pod

$ kubectl delete pod -n my-namespace nginx-add-one-of-your-pods-random-generated-numbers-here

 

<img src="media/image105.png" style="width:9.27083in;height:1.70833in" />

 

\#We set the replicas to 3 and kubernetes will keep 3 replicas at all times. If one pod goes down or is destroyed kubernetes will just bring a new one up to take it's place.

\# Lets delete the deployment

$ kubectl delete -f nginx.yaml

 

<img src="media/image106.png" style="width:5.19792in;height:1.23958in" />

 

 

&lt;Now you are ready for the CKA Study Class &gt;

 

 

 

 

 

 

 

 

 

 

 

\# Teachers Senerios / Materials:

 

\# Start of class baseline

1.  Validate SSH to all three nodes

2.  That they have shell environment set

3.  They have git repo to pull senerios

4.  Provide download git pull for senerios

 

\# Notes:

-   You will never know all the stuff that will be on the test.

-   Know how to get through help

-   Know how to manage time in senerio type certification

-   Make sure when you create name spaces and resources, watch to spell correctly so they can be tested

>  

 

\# Stage class

 

 

\# In the class you will be provided with scenarios to help you become proficient with cluster management and K8 environment

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Time To Complete</strong></th><th><strong>Goal (</strong>description with bullets of target states<strong>)</strong></th><th><strong>Check (</strong>script to check if they did it correctly<strong>)</strong></th></tr></thead><tbody><tr class="odd"><td>basic_1</td><td> </td><td> </td><td> </td></tr><tr class="even"><td>basic_2</td><td> </td><td><ul class="incremental"><li><blockquote><p>upgrade worker nodes to match using latest version</p></blockquote></li><li><blockquote><p>create a file in directory called /foo/ and put name of command you would need before upgrade worker</p></blockquote></li></ul></td><td> </td></tr><tr class="odd"><td>medium_1</td><td> </td><td><ul class="incremental"><li><blockquote><p>Create a deployment named 'rtro' in the 'cal' namespace.</p></blockquote></li><li><blockquote><p>Use the image busybox: 1.31.1 for the only pod container and pass the arguments sleep and 24h to the container.</p></blockquote></li><li><blockquote><p>Set the number of replicas to 2.</p></blockquote></li><li><blockquote><p>Ensure processes in the deployment pods' containers run with user ID/uid 1000 and group ID/gid 1000.</p></blockquote></li><li><blockquote><p>Also do not allow privilege escalation in the pods' containers.</p></blockquote></li></ul></td><td> </td></tr><tr class="even"><td>hard_1</td><td> </td><td> </td><td> </td></tr><tr class="odd"><td>extra_1</td><td> </td><td> </td><td> </td></tr></tbody></table>

-   When you can accomplish above in 30min .. you are at least ready to go try test :)

 

 

 

 

 

 

 

 

 

\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

**\# To Destroy the cluster -**

Turn the VMs off and delete them in the Hyper-V manager

\#Keep the pfSense and ansible controller machines intact if you want to rebuild the K8s clusters again

<img src="media/image107.png" style="width:3.53125in;height:3.42708in" />

 

Delete the folders containing VM information and virtual disks at C:\\Hyper-V\\k8svms

 

<img src="media/image108.png" style="width:2.94792in;height:1.58333in" />

 

**\#To Rebuild the cluster -**

Open PowerShell as an administrator and run the K8sprovisionVMs script again

VMs will populate in Hyper-V

Start all VMs

Connect to the ansible controller

 

\#Copy the ssh keys

 

$ ssh-copy-id k8smaster

\#Enter yes and put in password

$ ssh-copy-id k8sworker1

\#Enter yes and put in password

$ ssh-copy-id k8sworker2

Enter yes and put in password

 

\#Run the ansible playbook

 

$ cd /home/lab/k8s/Kubernetes-Cluster-creation/RHEL

$ ansible-playbook settingup\_kubernetes\_cluster.yml --ask-become-pass

 

 

 

**Reference information-**

 

pfSense Firewall -

The firewall is designed to keep the cluster isolated from the rest of the network as much as possible while still providing it the needed internet connection to download the packages required to initialize the cluster. Inside the Firewall there is also a MAC address DHCP mapping that allows the VM , assigned with a static MAC address from the PowerShell script, to be assigned the same IP address each time it is recreated for predictability with the automation.

The Firewall can be changed and updated by opening a web browser in the ansible controller VM and putting the IP address of the pfSense firewall (192.168.1.1) in the url address field. The credentials of the login page are.

Login: Admin

PW: CDWLab1!

 

The VMs do not connect directly to the computer's network connection. They connect to the LAN port of the firewall which allows for a LAN based address range and the firewall's WAN port connects to the network adaptor using a loopback and a separate IP address. The WAN port can be disconnected from the firewall in the settings of the pfSense virtual machine to provide cluster networking but isolation from internet traffic.

 

 

Ansible Automation -

The automation provides a simple way of performing all the manual tasks required to install a Kubernetes cluster. The steps can be followed along using the prompts displayed by the output of the automation. For a deeper explanation of what is taking place see the below steps.

 

Ssh Keys - all nodes in the cluster need to be DNS resolvable to their host names and have password-less authentication. This was performed through the powershell script, setting the contents of the /ect/hosts file, the static DHCP addresses set in the Firewall, and the ssh commands you ran. When the powershell script ran the script imported a VM from the template created, and set the MAC address of the VM. When the system was powered on the network adaptor was assigned an IP address from the firewall using the DHCP reservation set up before you downloaded the template for the VM. You then set a local DNS mapping in /etc/hosts so that the IP addresses would resolve with host names. The ssh-copy-id commands copy the rsa public key from /home/lab/.ssh/id\_rsa.pub to the other hosts so that when ansible reaches out to them via ssh, password authentication is not required. The host names of the OS is set as one of the first tasks in the automation.

 

--Automation steps--

 

When starting ansible the file settingup\_kubernetes\_cluster.yml is called. This file references 4 other files contained in the /playbooks subdirectory. The first to run in playbooks/initial-host-setup.yaml

 

playbooks/initial-host-setup.yaml - This is run against all hosts

-   Update hosts file in /etc/hosts - this task copies the local ansible controller /etc/hosts file from the controller to all other nodes so that host names are resolvable

-   Set variable for IP address in host file and new host name - this task looks up the newly copied host file and associates the node's IP address to the host name assigned to it and then updates the host name of the OS

-   Enable network connection on reboot - this task makes sure that the network connection will auto connect when the server is rebooted

-   Rebooting hosts - this reboots the host to ensure that the host name is set for the next steps

-   Updating subscription manager to register hosts- RHEL servers have to be subscribed to get downloads from the Red Hat package servers, this step registers the server to Red Hat by calling the environment variable set in the env\_variables file that was updated during set up

-   Updating repos to enable rpms - there are three separate steps here which are enabling the different repositories so that the required packages can be installed

-   Upgrading all packages - this is to update the servers for security reasons but this step takes quite a bit of time. Feel free to remove this step from the playbook if you are comfortable with it. That should cut the build time for the cluster down to under 10 minutes.

-   Disabling Swap on all nodes - Kubernetes installations do not support swap files so they must be disabled

-   Commenting Swap entries in /etc/fstab - This removes any existing swap files

-   Set SELinux to permissive - SELinux is an important enterprise security feature but causes problems with Kubernetes installations. It isn't worth the effort to solve for these issues for our purposes so we just disable it here.

-   Rebooting hosts - it is necessary to reboot the server after SELinux is changed

 

Playbooks/setting\_up\_nodes.yml &gt; this is the second playbook called by the main yml file - runs on all hosts

-   Creating a repository file for Kubernetes - this creates the file in the directory for approved repositories

-   Adding repository details in Kubernetes repo file - this sets all the needed information for the yum command to use the google urls as a repository

-   Installing required packages - this task references the env\_variables file and installs the packages needed for the installation. In this case we need to download and install docker, kubeadm, and kubectl

-   Starting and Enabling the required services - this task starts the services that were downloaded and needed to initialize the cluster

-   Allow Network Ports in Firewalld - firewalld is the native firewall service that runs on RHEL. We need to tell it to open the ports referenced on the env\_variables file so that kubernetes can communicate with the APIs. In this case 6443 and 10250 are required to be open.

-   Enabling Bridge Firewall Rule -

 

Playbooks/configure\_master\_node.yml &gt; next playbook in the sequence runs on just the master node

-   Pulling images required for setting up a kubernetes cluster - kubeadm config reaches out to the google repo we set up and pulls down the packages needed to initialize the cluster

-   Initializing Kubernetes cluster - this runs a command in the shell for initializing the cluster for a single master node cluster - the output of the completed cluster has instructions to follow which are done in subsequent steps. This includes the creation of a token that is used to join the worker nodes to the master. The output of this command is piped to a file called kubeadm\_logs. We will use this later.

-   Creating .kube directory - creates the directory for the kubeconfig files

-   Copying kubeconfig files - copies the files generated to the location specified in the directory with the appropriate permissions

-   Installing Network Add-on - this applies the CNI needed for the overlay network. This can be changed but in this case we are using flannel as the CNI

 

Playbooks/configure\_worker\_nodes.yml - completes the cluster set up, runs some commands against the master and some against only workers

-   Export join token as script - from here we use a grep against the kubeadm\_logs file mentioned from the initialization of the cluster and capture just the output of the file we need to join worker nodes to the cluster. We save this as joincommand.sh

-   Copy - The worker nodes then each pull a copy of the joincommand.sh file locally

-   Make it execute - the worker nodes update the permissions of the file to make it executable

-   Joining the worker nodes with kubernetes master - the worker nodes then run the script to join the cluster

 

 

 

 

 

 

 

 

 

 

 

 

 

 
