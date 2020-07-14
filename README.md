# Kubernetes-Cluster-creation

set up requires the following
 -access to RHEL 7 and 8 subscriptions
 -access to Ansible Tower license file
 -VM template with RHEL 7.x
 
 
Instructions
 -Import the virtual machines 
  -rename machines
   - at least 1 k8master
   - at least 2 k8worker(1, 2, etc.)
  -add memory and cpu to master
  Bring network connections online for each host
   nmcli con up eth0 
   -DHCP to assign IP addresses
   (if needed) import ansible tower VM
   (if needed) set ssh key
   
   - Update /etc/hosts on ansible controller
    - build IP address and host names list to place into /etc/hosts
   - Update /env_variables files
      - K8 master host IP
      - Org_num (RedHat org ID for licenses)
      - Act_key (activation key name in subscriptions)
