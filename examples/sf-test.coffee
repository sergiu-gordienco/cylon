require('../examples/sf-client')

sfuser = process.env.SF_USERNAME,
sfpass = process.env.SF_SECURITY_TOKEN,
orgCreds = {
  clientId: process.env.SF_CLIENT_ID,
  clientSecret: process.env.SF_CLIENT_SECRET,
  redirectUri: 'http://localhost:3000/oauth/_callback'
}

sf = new Cylon.SF.SFClient(sfuser: sfuser, sfpass: sfpass, orgCredentials: orgCreds)

cc = 0
sf.authenticate((msg) ->
  simpleMessageString = "^ Sphero Name: #{msg.sobject.Sphero_Name__c}, Msg Content:#{ msg.sobject.Content__c }, SM Id:#{ msg.sobject.Id }"
  console.log("Printed from callback in client program.program")
  console.log(simpleMessageString + "\n")
)

myId = null
message = "hello"
detail = "Some Stuff for details"

setInterval(() =>
  cc++
  myId = cc
  toSend = "{ \"identifier\" :\"run3#{ myId }\", \"msg\": \"#{ message }\" }"
  sf.push(toSend)
, 1000)
