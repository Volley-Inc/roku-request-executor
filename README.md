# roku-request-executor
Callback based HTTP client for Roku written in BrighterScript

### Lifecycle Sequence Diagram
```mermaid
sequenceDiagram
	note over Request: RequestNode w type, body, and callback
	RequestPort->>RequestPort: receiveEvents()
	note over RequestPort: for singleton's lifespan
	Request->>RequestPort: requestExecutorV2()@.enqueuePost(request)
	RequestPort->>RequestQueue: request
	alt there is an available TransferObject	
		RequestQueue->>TransferObjectPool: get TransferObject
		TransferObject->>TransferObject: sendRequest
		TransferObject->>RequestPort: processResponse
		note over RequestPort: request.invokeCallback (if present)
		TransferObject->>TransferObjectPool: return to pool
	else no TransferObjects available
		note over RequestQueue: no-op
	end
  ```
