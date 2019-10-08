#######################################################################
##   Add the Virtual Service endpoint Id as a rule,                  ##
##   into Azure SQL Database ACLs for connectivity using private IP  ##
##   Created by Abhishek Roy Date 02.09.2019                         ##
#######################################################################

$ResourceGroupName="Your-Resource-Group-Name"
$ResourceGroupNameVnet="Your-VNET-Resource-Group-Name"
$VNetName="Your-VNET-Name"
$SubnetName="Your-Subnet-Name"
$SqlDbServerName="Azure-SQL-DB-server-name"
$VNetRuleName="Name-of-service-endpoint"

Write-Host "Get the subnet object.";

$vnet = Get-AzVirtualNetwork `
  -ResourceGroupName $ResourceGroupNameVnet `
  -Name              $VNetName;

$subnet = Get-AzVirtualNetworkSubnetConfig `
  -Name           $SubnetName `
  -VirtualNetwork $vnet;

Write-Host "Add the subnet .Id as a rule, into the ACLs for your Azure SQL Database server.";

$vnetRuleObject1 = New-AzSqlServerVirtualNetworkRule `
  -ResourceGroupName      $ResourceGroupName `
  -ServerName             $SqlDbServerName `
  -VirtualNetworkRuleName $VNetRuleName `
  -IgnoreMissingVnetServiceEndpoint `
  -VirtualNetworkSubnetId $subnet.Id;

$vnetRuleObject1;
