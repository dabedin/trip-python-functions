# trip-python-functions

A basic example of [Azure Functions in Python](https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=azurecli-linux%2Capplication-level).
* **PostTrip** class has a Function using the CosmosDBOutput in addition to the HttpResponseData, [see docs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2-output?tabs=python)
* **AnalyzeTrip** class has a Function using the CosmosDBTrigger ([see docs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2-trigger?tabs=in-process%2Cfunctionsv2&pivots=programming-language-python)) and a ServiceBusOutput ([see docs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-output?tabs=in-process%2Cextensionv5&pivots=programming-language-python))
Please note: the maxItemsPerInvocation is configured to 1 to trigger the funtion on each document, as documents are created once at a time --- please do consider potential performance impact of this choice.
Also consider that provisioned throughput and physical partition influence the scale of the Cosmos DB change feed processor used in Functions, [see docs](https://docs.microsoft.com/en-us/azure/cosmos-db/sql/change-feed-processor#components-of-the-change-feed-processor).
* **ConsumeTrip** class has a Function using the ServiceBusTrigger, [see docs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-trigger?tabs=in-process%2Cextensionv5&pivots=programming-language-python)

Test in (./test.http) is intended to be used with a non protected Function.
Test in (./test-wAA.http) is for a AAD protected Function, [see docs](https://docs.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad?toc=%2Fazure%2Fazure-functions%2Ftoc.json)

Mutuated from https://github.com/dabedin/trip-functions
