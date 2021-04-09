# MS SQL HA
In a nutshell Microsoft SQL offers HA in an Active/Passive format using a stack of technologies. With the migration of MS SQL Server to Azure they have modified a number of these technologies to work in a cloud environment. Here are my ramblings, documentation, and scripts from of what I learned making MS SQL run on Azure VMs.

# Core technologies
## Windows Server Failover Cluster (WSFC)
* Windows Server Level
* Contains resources with attributes like IP addresses, quorum witness, virtual network name (VNN), distributed network name (DNN)
* Azure documentation occasionally refers to WSFC as "SQL virtual machine group"
* Computer Account Object in AD
## Always On Availability Group (AG)
* MS SQL Level
* Contains details like What databases are synced where/how, SQL specific details about virtual network name (VNN)
* Child object of WSFC Cluster AD object
### Listener
*  Virtual IP (VIP) endpoint used to connect to the MS SQL

# How fail-over works
Traditional on-prem AGs use gratuitous arp (GARP) to broadcast a change in ownership of the listener (VIP) from one server another. Since there generally aren't broadcast domains in The Cloud this traditional approach does not work.

In Azure the listener (VIP) is held by the load balancer. Health probes configured on the load balancer to check for a specific port to be open on a server that identify it is primary in the cluster. The Cluster Probe Port attribute is configured at the WSFC level via Powershell.
