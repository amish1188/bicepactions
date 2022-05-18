param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location

param cosmosDBDatabaseThroughput int = 400
var cosmosDBDatabaseName = 'FlightTests'

var cosmosDBContainerName = 'FlightTests'
var cosmosDBContainerPartitionKey = '/droneId'

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2022-02-15-preview' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-02-15-preview' = {
  parent: cosmosDbAccount
  name: cosmosDBDatabaseName
  properties: {
    resource: {
      id: cosmosDBDatabaseName
    }
    options: {
      throughput:cosmosDBDatabaseThroughput
    }
  }
  resource container 'containers' = {
    name: cosmosDBContainerName
    properties:{
      resource: {
        id: cosmosDBContainerName
        partitionKey:{
          kind: 'Hash'
          paths: [
            cosmosDBContainerPartitionKey
          ]
        }
      }
      options: {}
    }
  }
}


