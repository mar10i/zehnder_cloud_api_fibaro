--[[
Zehnder MSAL
]]
class 'MSAL'

function MSAL:new(config)
  self.config = config
  self.client_id = config:getClientID()
  self.user = config:getUsername()
  self.pass = config:getPassword()
  self.access_token = config:getAccessToken()
  self.token = config:getAccessToken()
  self.http = HTTPClient:new({
    baseUrl = config:getBaseUrl()
  })
  --AUTHENTICATION
  self.cookies = ''
  self.cookieSso = ''
  self.cookieCsrf = ''
  self.cookieCache = ''
  self.cookieTrans = ''   
  self.csrf = ''
  self.transId = ''
  self.refresh_token = ''
  return self
end

function MSAL:getAuthCode(callback)
  QuickApp:trace("Get Authentication Code")
  local success = function(response)
    QuickApp:trace("Successfully started Authentication")
    MSAL:setCookies(response.headers)
    self.csrf = string.match(response.data,'"csrf":"(.-)"')
    self.transId = string.match(response.data,'"transId":"(.-)"')
    local data = {
      ["request_type"] = 'RESPONSE',
      ["email"] = self.user,
      ["password"] = self.pass,
    }
    local success = function(response)
      QuickApp:trace("Successfully send login credentials")
      MSAL:setCookies(response.headers)
      local success = function(response)
--        QuickApp:debug("Success confirm: "..response.status)
--        QuickApp:debug(response.headers["location"])
        local code = string.match(response.headers["location"],'code=(.*)')
--        QuickApp:debug(code)
        QuickApp:trace("Succesfully retreived Authentication Code")
        MSAL:getAccessToken(code, callback)
      end
      local fail = function(response)
        QuickApp:debug("Confirm Auth Failed: "..response)
      end
      local headers = {
        ["Cookie"] = self.cookies,
      }
      local url = 'api/CombinedSigninAndSignup/confirmed?rememberMe=false&csrf_token='..self.csrf..'&tx='..self.transId..'&p=B2C_1_signin_signup_enduser'
      self.http:getRedirect(url, success, fail, headers)
    end
    local fail = function(response)
      QuickApp:debug("Send Login Failed: "..response)
    end
    local headers = {
      ["X-CSRF-TOKEN"] = self.csrf,
      ["X-Requested-With"] = "XMLHttpRequest",
      ["Cookie"] = self.cookies,
    }
    url = 'SelfAsserted?tx='..self.transId..'&p=B2C_1_signin_signup_enduser'
    self.http:postForm(url, data, success, fail, headers)
  end
  local fail = function(response)
    QuickApp:debug("Start Auth Failed: "..response)
  end
  local headers = {}
  if self.cookies ~= '' then headers["Cookie"] = self.cookies end
  local url = 'oauth2/v2.0/authorize?client_id='..self.client_id..'&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A5000&scope='..self.client_id..'%20openid&response_mode=fragment&code_challenge=ThisIsntRandomButItNeedsToBe43CharactersLong'
  self.http:get(url, success, fail, headers)
end

function MSAL:getAccessToken(code, callback)
--  QuickApp:debug(code)
  QuickApp:trace("Get Access Token")
  local data = {
    ["client_id"] = self.client_id,
    ["grant_type"] = 'authorization_code',
    ["scope"] = self.client_id .. '%20offline_access',
    ["code"] = code,
    ["redirect_uri"] = 'http%3A%2F%2Flocalhost%3A5000',
    ["code_verifier"] = 'ThisIsntRandomButItNeedsToBe43CharactersLong',
  }
  local fail = function(response)
    QuickApp:error('Unable to get token')
    if self.access_token == self.token then
      QuickApp:error('Removing configured AccessToken')
      self.config:setAccessToken('')
    end
    MSAL:setToken('')
  end
  local success = function(response)
    if response.status > 299 then
      fail(response)
      return
    end
    local data = json.decode(response.data)
    MSAL:setToken(data.access_token)
    self.refresh_token = data.refresh_token
    fibaro.setTimeout(tonumber(data.expires_in)*1000, function() MSAL:refreshToken() end)
    QuickApp:trace('Successfully retreived token')
    if callback ~= nil then
      callback(data)
    end
  end
  self.http:postForm('oauth2/v2.0/token', data, success, fail)
end

function MSAL:refreshToken()
  QuickApp:trace("Refresh Access Token")
  local data = {
    ["grant_type"] = 'refresh_token',
    ["client_id"] = self.client_id,
    ["refresh_token"] = self.refresh_token,
    ["redirect_uri"] = "http%3A%2F%2Flocalhost%3A5000",
    ["scope"] = self.client_id .. '%20offline_access',
  }
  local fail = function(response)
    QuickApp:error('Unable to refresh token')
    if self.access_token == self.token then
      QuickApp:error('Removing configured AccessToken')
      self.config:setAccessToken('')
    end
    MSAL:setToken('')
    MSAL:getAuthCode()
  end
  local success = function(response)
    if response.status > 299 then
      fail(response)
      return
    end
    local data = json.decode(response.data)
    MSAL:setToken(data.access_token)
    self.refresh_token = data.refresh_token
    fibaro.setTimeout(tonumber(data.expires_in)*1000, function () MSAL:refreshToken() end)
    QuickApp:trace('Successfully refreshed token')
  end
  self.http:postForm('oauth2/v2.0/token', data, success, fail)
end

function MSAL:setCookies(headers)
  for k, v in pairs(headers) do
    if k == "set-cookie" then
      local cookieSso = string.match(headers["set-cookie"],'x%-ms%-cpim%-sso.-;')
      local cookieCsrf = string.match(headers["set-cookie"],'x%-ms%-cpim%-csrf.-;')
      local cookieCache = string.match(headers["set-cookie"],'x%-ms%-cpim%-cache.-;')
      local cookieTrans = string.match(headers["set-cookie"],'x%-ms%-cpim%-trans.-;')
      if cookieSso ~= nil and cookieSso ~= "" then self.cookieSso = cookieSso end
      if cookieCsrf ~= nil and cookieCsrf ~= "" then self.cookieCsrf = cookieCsrf end
      if cookieCache ~= nil and cookieCache ~= "" then self.cookieCache = cookieCache end
      if cookieTrans ~= nil and cookieTrans ~= "" then self.cookieTrans = cookieTrans end
    end
  end
  self.cookies = self.cookieSso.." "..self.cookieCsrf.." "..self.cookieCache.." "..self.cookieTrans
end

function MSAL:setToken(token)
  self.token = token
  Globals:set('zehnder_atoken', token)
end

function MSAL:getToken()
  if not self.token and self.access_token ~= nil then
    self.token = self.access_token
  end
  if string.len(self.token) > 10 then
    return self.token
  elseif string.len(Globals:get('zehnder_atoken', '')) > 10 then
    return Globals:get('zehnder_atoken', '')
  end
  return ""
end