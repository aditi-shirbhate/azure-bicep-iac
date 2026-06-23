# Azure IaC with Bicep 🚀

Deploying a Storage Account and App Service on Azure using modular Bicep templates.

## Architecture

## What This Deploys

- **Storage Account** — StorageV2 with HTTPS-only, TLS 1.2, public blob access disabled
- **App Service Plan** — Linux-based, configurable SKU (F1 to P2v2)
- **App Service** — Python 3.11 runtime, HTTPS-only, connected to Storage Account via app settings

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed and logged in
- An active Azure subscription
- A resource group already created

## Usage

```bash
# Clone the repo
git clone https://github.com/aditi-shirbhate/azure-bicep-iac.git
cd azure-bicep-iac

# Login to Azure
az login

# Create a resource group
az group create --name rg-bicep-demo --location eastus

# Deploy using parameter file
az deployment group create \
  --resource-group rg-bicep-demo \
  --template-file main.bicep \
  --parameters main.bicepparam

# Or deploy with inline parameters
az deployment group create \
  --resource-group rg-bicep-demo \
  --template-file main.bicep \
  --parameters environment=dev projectName=aditidemo
```

## Parameters

| Name | Description | Allowed Values | Default |
|------|-------------|----------------|---------|
| `location` | Azure region | Any valid region | `eastus` |
| `environment` | Environment name | `dev`, `staging`, `prod` | `dev` |
| `projectName` | Project name for resource naming | Any string | `aditidemo` |

## Outputs

| Name | Description |
|------|-------------|
| `storageAccountName` | Name of the deployed Storage Account |
| `appServiceUrl` | URL of the deployed App Service |
| `appServicePlanName` | Name of the App Service Plan |

## Tech Stack

![Bicep](https://img.shields.io/badge/Bicep-0078D4?style=flat&logo=microsoftazure)
![Azure](https://img.shields.io/badge/Azure-0078D4?style=flat&logo=microsoftazure)
![AppService](https://img.shields.io/badge/App%20Service-0078D4?style=flat&logo=microsoftazure)
