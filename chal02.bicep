// @description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure or it will be overwritten.')
// @minLength(3)
// @maxLength(24)
// param storageName string = 'challenge01huy'

var storagePrefix = 'huy'
var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

@minLength(3)
@maxLength(63)
param containerName string = 'cOmTeenar'
param globalRedundancy bool = true
var skuName = globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'

@description('Specifies the location for resources.')
param location string = resourceGroup().location
param storageAccKind string = 'StorageV2'


resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: uniqueStorageName
  location: location
  kind: storageAccKind
  sku: {
    name: skuName
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageaccount
  name: 'default'
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = {
  parent: blobService
  name: toLower(containerName)
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}


output storageAccountName string = storageaccount.name
output BlobPrimaryEndpoint string = storageaccount.properties.primaryEndpoints.blob
