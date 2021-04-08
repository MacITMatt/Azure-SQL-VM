$AGName = "sql01ag" #Name of Availability Group
$ILBIP = "10.10.10.250" #Address of Load balancer Front-end IP
[int]$ProbePort = 59999 #port number for health probe

#Given and derivative variables
$ClusterNetworkName = "Cluster Network 1" #Default WSFC Cluster Network name
$IPResourceName = $AGName+ "_" +$ILBIP

Import-Module FailoverClusters
Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}
