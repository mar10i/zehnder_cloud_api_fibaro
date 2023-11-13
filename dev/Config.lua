--[[
Configuration handler
@author ikubicki
]]
class 'Config'

function Config:new(app)
    self.app = app
    self:init()
    return self
end

function Config:getBaseUrl()
    return self.baseUrl
end

--function Config:getToken()
--    return Globals:get('zehnder_atoken')
--end

function Config:getSubscriptionKey()
    return self.subscriptionKey
end

function Config:getApiKeyName()
    return self.apiKeyName
end

function Config:getApiKeySecret()
    return self.apiKeySecret
end

function Config:getDeviceID()
    return self.deviceID
end

function Config:getBuildingId()
    return self.buildingId
end

function Config:getTimeoutInterval()
    return tonumber(self.interval) * 60000
end

function Config:init()
  self.baseUrl = ''
  self.subscriptionKey = tostring(self.app:getVariable('SubscriptionKey'))
  self.apiKeyName = tostring(self.app:getVariable('ApiKeyName'))
  self.apiKeySecret = tostring(self.app:getVariable('ApiKeySecret'))
  self.deviceID = tostring(self.app:getVariable('DeviceID'))
  self.buildingId = tostring(self.app:getVariable('BuildingId'))
  self.interval = self.app:getVariable('Interval')

  if not self.subscriptionKey or self.subscriptionKey == '' then
    self.app:setVariable('SubscriptionKey','')
    self.subscriptionKey = ''
  end
  if not self.apiKeyName or self.apiKeyName == '' then
    self.app:setVariable('ApiKeyName','')
    self.apiKeyName = ''
  end
  if not self.apiKeySecret or self.apiKeySecret == '' then
    self.app:setVariable('ApiKeySecret','')
    self.apiKeySecret = ''
  end
  if not self.deviceID or self.deviceID == '' then
    self.app:setVariable('DeviceID','')
    self.deviceID = ''
  end
  if not self.buildingId or self.buildingId == '' then
    self.app:setVariable('BuildingId','')
    self.buildingId = ''
  end
  if not self.interval or self.interval == '' then
    self.app:setVariable('Interval','5')
    self.interval = '5'
  end
end
