var storageaccount = 'huyd33v6gykhb4jw'
param blobContainerNames array
var cleanedContainerNames = [for x in blobContainerNames: toLower(x)]

resource existingstorage 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageaccount
}

// resource storaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: 'test'
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Standard_LRS'
//   }
// }

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: existingstorage
  name: 'default'
}

resource existingStoragedepends 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [for containerName in cleanedContainerNames: {
  parent: blobService
  name: containerName
}]
