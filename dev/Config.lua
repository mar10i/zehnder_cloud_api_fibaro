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

function Config:getToken()
    return Globals:get('zehnder_atoken')
end

function Config:getSubscriptionKey()
    return self.subscriptionKey
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

--[[
This function takes variables and sets as global variables if those are not set already.
This way, adding other devices might be optional and leaves option for users, 
what they want to add into HC3 virtual devices.
]]
function Config:init()
  self.subscriptionKey = tostring(self.app:getVariable('SubscriptionKey'))
  self.deviceID = tostring(self.app:getVariable('DeviceID'))
  self.buildingId = tostring(self.app:getVariable('BuildingId'))
  self.interval = self.app:getVariable('Interval')

  -- handling interval
  if not self.interval or self.interval == "" then
    self.interval = "1"
  end
end