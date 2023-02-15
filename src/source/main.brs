import "pkg:/source/RequestExecutorV2.bs"

sub init()
  executorV2().observeField("isInitialized", "loadTest")
end sub

sub loadTest()
  executorV2().enqueuePost(createGoogleTranslateRequest())
end sub

function createGoogleTranslateRequest()
  request = CreateObject("roSGNode", "Request")
  
  return request
end function