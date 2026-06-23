@description('Name of the App Service')
param appServiceName string

@description('Azure region')
param location string = resourceGroup().location

@description('App Service Plan ID')
param appServicePlanId string

@description('Runtime stack')
@allowed([
  'PYTHON|3.11'
  'NODE|18-lts'
  'JAVA|17-java17'
  'DOTNETCORE|7.0'
])
param linuxFxVersion string = 'PYTHON|3.11'

@description('Storage account name for app settings')
param storageAccountName string

@description('Storage account primary endpoint')
param storageEndpoint string

@description('Environment tag')
param environment string = 'dev'

resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      appSettings: [
        {
          name: 'STORAGE_ACCOUNT_NAME'
          value: storageAccountName
        }
        {
          name: 'STORAGE_BLOB_ENDPOINT'
          value: storageEndpoint
        }
        {
          name: 'ENVIRONMENT'
          value: environment
        }
      ]
    }
    httpsOnly: true
  }
  tags: {
    Environment: environment
    ManagedBy: 'Bicep'
  }
}

output appServiceUrl string = 'https://${appService.properties.defaultHostName}'
output appServiceId string = appService.id
