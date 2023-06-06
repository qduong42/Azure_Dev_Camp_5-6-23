// @description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure or it will be overwritten.')
// @minLength(3)
// @maxLength(24)
// param storageName string = 'challenge01huy'

var storagePrefix = 'huy'
var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'
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


output storageAccountId string = storageaccount.id

// resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: storageName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS'
//   }
// }

// New-AzResourceGroupDeployment -ResourceGroupName challenge01group -TemplateFile ./main.biceps

//New-AzResourceGroupDeployment -ResourceGroupName challenge01group -TemplateFile ./main.biceps
