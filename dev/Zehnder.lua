--[[
Zehnder SDK
@author ikubicki
]]
class 'Zehnder'

function Zehnder:new(config)
  self.config = config
  self.subscription_key = config:getSubscriptionKey()
  self.device_id = config:getDeviceID()
  self.http = HTTPClient:new({
    baseUrl = config:getBaseUrl()
  })
  return self
end

function Zehnder:addAuthHeaders(headers)
  if headers == nil then headers = {} end
  headers["Authorization"] = "Bearer " .. self.config:getToken()
  headers["x-api-key"] = self.subscription_key
  return headers
end

function Zehnder:getData(url, errorMsg, callback)
  local fail = function(response) QuickApp:error(errorMsg) end
  local success = function(response)
    if response.status ~= 200 then fail(response) return end
    local data = json.decode(response.data)
    if callback ~= nil then callback(data) end
  end
  self.http:get(url, success, fail, self:addAuthHeaders())
end

function Zehnder:getHealth(callback)
  local url = 'health'
  local errorMsg = 'Unable to get health of API'
  self:getData(url, errorMsg, callback)
end

function Zehnder:getDevicesIds(callback)
  local url = 'devices/ids'
  local errorMsg = 'Unable to get device ids'
  self:getData(url, errorMsg, callback)
end

function Zehnder:getDevice(deviceId, callback)
  local url = 'devices/byid/'..deviceId..'/details'
  local errorMsg = 'Unable to get device'
  self:getData(url, errorMsg, callback)
end

function Zehnder:getDeviceState(deviceId, callback)
  local url = 'devices/'..deviceId..'/state'
  local errorMsg = 'Unable to get device state'
  self:getData(url, errorMsg, callback)
end

function Zehnder:getScenes(callback)
  local url = 'scenes'
  local errorMsg = 'Unable to get the supported scenes'
  self:getData(url, errorMsg, callback)
end

function Zehnder:putComfosysCommand(deviceId, commands, callback)
  local url = 'devices/'..deviceId..'/comfosys/settings'
  local errorMsg = 'Unable to put the command'
  local fail = function(response) QuickApp:error(errorMsg) end
  local success = function(response)
    --QuickApp:debug("Put Command status: "..response.status)
    if response.status ~= 200 then fail(response) return end
    --local data = json.decode(response.data)
    if callback ~= nil then callback() end
  end
  local headers = {}
  headers["Content-Type"] = "application/json"
  headers["Cache-Control"] = "no-cache"
  local data = json.encode(commands)
  QuickApp:debug(data)
  self.http:put(url, data, success, fail, self:addAuthHeaders(headers))
end

function Zehnder:activateScene(buildingId, sceneId, callback)
  local url = 'scenes/'..buildingId..'/activate/'..sceneId
  local errorMsg = 'Unable to activate the scene'
  local fail = function(response) QuickApp:error(errorMsg) end
  local success = function(response)
    --QuickApp:debug("Activate scene status: "..response.status)
    if response.status ~= 200 then fail(response) return end
    --local data = json.decode(response.data)
    if callback ~= nil then callback() end
  end
  local data = {}
  self.http:put(url, data, success, fail, self:addAuthHeaders())
end
