/*param rgLocation string = resourceGroup().location
param storageNames array = [
  'contoso'
  'fabrikam'
]

resource createStorages 'Microsoft.Storage/storageAccounts@2021-06-01' = [for name in storageNames: {
  name: '${name}str${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}] */

param rgLocation string = resourceGroup().location

param storageConfig object = {
  storage1: {
    name: 'contoso'
    skuName: 'Standard_LRS'
  }
  storage2: {
    name: 'fabrikam'
    skuName: 'Premium_LRS'
  }
}

resource createStorages 'Microsoft.Storage/storageAccounts@2021-06-01' = [for config in items(storageConfig): {
  name: '${config.value.name}${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: config.value.skuName
  }
  kind: 'StorageV2'
}]

