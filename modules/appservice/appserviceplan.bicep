@description('Name of the App Service Plan')
param appServicePlanName string

@description('Azure region')
param location string = resourceGroup().location

@description('App Service Plan SKU')
@allowed([
  'F1'
  'B1'
  'B2'
  'S1'
  'S2'
  'P1v2'
  'P2v2'
])
param skuName string = 'B1'

@description('Environment tag')
param environment string = 'dev'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
  tags: {
    Environment: environment
    ManagedBy: 'Bicep'
  }
}

output appServicePlanId string = appServicePlan.id
output appServicePlanName string = appServicePlan.name
