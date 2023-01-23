class 'Config'

function Config:new(app)
    self.app = app
    self:init()
    return self
end

function Config:getBaseUrl()
    return self.baseUrl
end

function Config:getClientID()
    return self.clientID
end

function Config:getUsername()
    return self.username
end

function Config:getPassword()
    return self.password
end

function Config:getAccessToken()
  self.token = Globals:get('zehnder_atoken')
  return self.token
end

function Config:setAccessToken(token)
  Globals:set('zehnder_atoken', token)
  self.token = token
end

function Config:init()
  if Globals:get('zehnder_client_id') == nil then Globals:set('zehnder_client_id', '') end
  if Globals:get('zehnder_username') == nil then Globals:set('zehnder_username', '') end
  if Globals:get('zehnder_password') == nil then Globals:set('zehnder_password', '') end
  if Globals:get('zehnder_atoken') == nil then Globals:set('zehnder_atoken', '') end
  self.clientID = Globals:get('zehnder_client_id')
  self.username = Globals:get('zehnder_username')
  self.password = Globals:get('zehnder_password')
  self.token = Globals:get('zehnder_atoken')
end