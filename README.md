# Roku Request Executor
Callback based singleton HTTP client for Roku written in BrighterScript

## Requirements

- Handles a queue of multiple simultaneous requests
- Safe to call from render thread
- Singleton, accessible globally
- Invokes a callback declared at call site with data from request
  - e.g.
  ```
    executorV2()@.enqueuePost(createPostRequest())

function createPostRequest()
  request = createObject("roSGNode", "Request")
  request.headers = { "Content-Type": "application/json" }
  request.body = { randomNumber: StrI(Rnd(55) * 100) }
  request.callBack = {
    componentReference: m.componentReference
    functionName: "printResponse"
  }
  return request
end function
```

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

### Gif demo
[https://i.imgur.com/Rwge8PP.gif](https://i.imgur.com/Rwge8PP.gif)
![gif of load test executing](https://i.imgur.com/Rwge8PP.gif)

### To-do
 - migrate to roPM
    - maybe--not sure how hard this will be
 -  review documentation to make sure it's still correct
 - support other http Methods
   - maybe--we don't have an internal usecase so it's lower priority for me
 - write unit tests
   - I'm unfamiliar with unit testing in bs/brs, but this feels valuable to me
