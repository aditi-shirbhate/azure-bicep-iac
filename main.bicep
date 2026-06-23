@description('Azure region for all resources')
param location string = resourceGroup().location

@description('Environment name')
@allowed([
  'dev'
  'staging'
  'prod'
])
param environment string = 'dev'

@description('Project name used to generate resource names')
param projectName string = 'aditidemo'

// Storage Account Module
module storage './modules/storage/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: '${projectName}${environment}sa'
    location: location
    skuName: 'Standard_LRS'
    environment: environment
  }
}

// App Service Plan Module
module appServicePlan './modules/appservice/appserviceplan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: '${projectName}-${environment}-asp'
    location: location
    skuName: 'B1'
    environment: environment
  }
}

// App Service Module
module appService './modules/appservice/appservice.bicep' = {
  name: 'appServiceDeployment'
  params: {
    appServiceName: '${projectName}-${environment}-app'
    location: location
    appServicePlanId: appServicePlan.outputs.appServicePlanId
    linuxFxVersion: 'PYTHON|3.11'
    storageAccountName: storage.outputs.storageAccountName
    storageEndpoint: storage.outputs.primaryEndpoint
    environment: environment
  }
}

output storageAccountName string = storage.outputs.storageAccountName
output appServiceUrl string = appService.outputs.appServiceUrl
output appServicePlanName string = appServicePlan.outputs.appServicePlanName
