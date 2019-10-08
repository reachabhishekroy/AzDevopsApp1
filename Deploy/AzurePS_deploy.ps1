# Login to Azure subscription using Powershell extension in Visual studio code
$User = "Your_Azure_subscription_email_id@xyz.com"
$PWord = ConvertTo-SecureString -String "*********" -AsPlainText -Force
$tenant = "xxxxxxxxxxx-Your directory ID in Azure"
$subscription = "xxxxxxx- subscription ID under subscription App in Azure"
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User,$PWord
Connect-AzAccount -Credential $Credential -Tenant $tenant -Subscription $subscription

# Deploy resources from templates in Azure subscription using Powershell
# debug option is really useful in troubleshooting ARM template
# This will also validate the JSON template and report if any synatx error
# You can deploy one resources after another in sequence in order to troubleshoot

New-AzResourceGroupDeployment -ResourceGroupName YOUR_RG_NAME -TemplateParameterFile .\Parameter.json -TemplateFile .\Template.json -debug -Force -Verbose

