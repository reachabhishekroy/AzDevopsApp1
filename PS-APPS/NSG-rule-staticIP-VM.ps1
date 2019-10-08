# Azure Powershell
# It can create new Network Security Group
# Add Inbound rules to newly created NSG
# Add static IP to VM's NIC
# Add NSG to subnet
# By Abhishek Roy created 08.10.2019

$RGname="Your-Resource-Group-Name"
$port1=3389
$rulename1="allowAppPort$port1"
$nsgname="Your-New-NSG-Name"
$location="westeurope"
$NetworkInterface1="Your-VM1-NIC"
$NetworkInterface2="Your-VM2-NIC"
$VNETname="Your-VNET-Name"
$Subnetname1="Your-subnet-name-1"

# Create NSG in resource group

New-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname  -Location  $location

# Get the NSG resource
$resource = Get-AzResource | Where {$_.ResourceGroupName –eq $RGname -and $_.ResourceType -eq "Microsoft.Network/networkSecurityGroups"} 
$nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname

# Add the inbound security rule.
$nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename1 -Description "Allow RDP port" -Access Allow -Protocol * -Direction Inbound -Priority 3891 -SourceAddressPrefix "*" -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange $port1

# Update the NSG.
$nsg | Set-AzNetworkSecurityGroup

# static IP to VM1 and VM2


$Nic1 = Get-AzNetworkInterface -ResourceGroupName $RGname -Name $NetworkInterface1
$Nic1.IpConfigurations[0].PrivateIpAddress = "10.x.x.x"
$Nic1.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
$Nic1.Tag = @{Name = "Name"; Value = "Value"}
Set-AzNetworkInterface -NetworkInterface $Nic1

$Nic2 = Get-AzNetworkInterface -ResourceGroupName $RGname -Name $NetworkInterface2
$Nic2.IpConfigurations[0].PrivateIpAddress = "10.x.x.x"
$Nic2.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
$Nic2.Tag = @{Name = "Name"; Value = "Value"}
Set-AzNetworkInterface -NetworkInterface $Nic2

#Attach NSG to subnet
Set-AzContext -SubscriptionName "Your-subscription-name"
Set-AzureNetworkSecurityGroupToSubnet -Name $nsgname -VirtualNetworkName $VNETname -SubnetName $Subnetname1
