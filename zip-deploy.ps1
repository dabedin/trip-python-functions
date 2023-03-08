$funcAppName = "REPLACE"
$resGroupName = "REPLACE"
$funcSlotName = "REPLACE"
$PATH = "REPLACE"

$hostName = (az functionapp show --name $funcAppName --resource-group $resGroupName --query "hostNames[0]" --output tsv)

#remember python zip structure https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=asgi%2Capplication-level#folder-structure

# Zip deployment https://docs.microsoft.com/en-us/azure/azure-functions/deployment-zip-push
az functionapp deployment source config-zip -g $resGroupName -n $funcAppName --src $PATH\deploy.zip
# alternative via API https://docs.microsoft.com/en-us/azure/azure-functions/deployment-zip-push#rest

# Run from package https://docs.microsoft.com/en-us/azure/azure-functions/run-functions-from-deployment-package#adding-the-website_run_from_package-setting
az webapp config appsettings set -n $webAppName -g $resGroupName `
    --settings "WEBSITE_RUN_FROM_PACKAGE=1"

# deploy to deployment slot
az functionapp deployment source config-zip -g $resGroupName -n $funcAppName --slot $funcSlotName --src $PATH\deploy.zip

# slot swap https://docs.microsoft.com/en-us/cli/azure/functionapp/deployment/slot?view=azure-cli-latest#az-functionapp-deployment-slot-swap
az functionapp deployment slot swap -g $resGroupName -n $funcAppName --slot $funcSlotName --target-slot production

# test
Invoke-RestMethod ($hostName + '/api/Test?name=tester')
