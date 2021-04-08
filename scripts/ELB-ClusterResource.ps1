$AGName = "sql01ag" #Availability Group Name
$ELBIP = "12.69.13.37" #Public IP address of Load balancer Front-end IP
[int]$ProbePortELB = 59998 #port number for health probe ELB

#Given and derivative variables
$ClusterNetworkName = "Cluster Network 1" #Default WSFC Cluster Network name 
$IPResourceName = $AGName+ "_" +$ELBIP

Import-Module FailoverClusters
Add-ClusterResource -Name $IPResourceName -ResourceType "IP Address" -Group $AGName
Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ELBIP";"ProbePort"=$ProbePortELB;”SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"OverrideAddressMatch"=1;"EnableDhcp"=0}
