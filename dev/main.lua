_=loadfile and loadfile("TQAE.lua"){}

--FILE:dev/Config.lua,Config;
--FILE:dev/Globals.lua,Globals;
--FILE:dev/HTTPClient.lua,HTTPClient;
--FILE:dev/i18n.lua,i18n;
--FILE:dev/Zehnder.lua,Zehnder;

--%%name="Zehnder"
--%%id=350
--%%quickVars={SubscriptionKey="",Interval=""}
--%%u1={label="labelTitle", text="Zehnder"}
--%%u2={label="labelMsg", text=""}
--%%u3={{button="btnSearch",text="Search",onReleased="searchEvent"},{button="btnRefresh",text="Refresh",onReleased="refreshEvent"}}
--%%u4={label="labeldeviceId", text="-"}
--%%u5={label="labeltimestamp", text="-"}
--%%u6={{button="btnPreset1", text="Preset 1", onReleased="setVentilationPreset"},{button="btnPreset2", text="Preset 2", onReleased="setVentilationPreset"},{button="btnPreset3", text="Preset 3", onReleased="setVentilationPreset"},{button="btnPreset4", text="Preset 4", onReleased="setVentilationPreset"}}
--%%u7={{button="btnScene1", text="Scene 1", onReleased="activateScene"},{button="btnScene2", text="Scene 2", onReleased="activateScene"},{button="btnScene3", text="Scene 3", onReleased="activateScene"},{button="btnScene4", text="Scene 4", onReleased="activateScene"},{button="btnScene5", text="Scene 5", onReleased="activateScene"}}

--%%u8={label="labelventilationPreset", text="-"}
--%%u9={label="labelmanualMode", text="-"}
--%%u10={label="labelawayEnabled", text="-"}
--%%u11={label="labelboostTimerEnabled", text="-"}
--%%u12={label="labelremainingFilterDuration", text="-"}

--%%u13={label="labelextractAirTemp", text="-"}
--%%u14={label="labelextractAirHumidity", text="-"}
--%%u15={label="labelexhaustAirTemp", text="-"}
--%%u16={label="labelexhaustAirHumidity", text="-"}
--%%u17={label="labelsystemSupplyTemp", text="-"}
--%%u18={label="labelsystemSupplyHumidity", text="-"}
--%%u19={label="labelsystemOutdoorTemp", text="-"}
--%%u20={label="labelsystemOutdoorHumidity", text="-"}

--%%u21={label="labelsupplyFanOff", text="-"}
--%%u22={label="labelsystemSupplySpeed", text="-"}
--%%u23={label="labelsystemSupplyDuty", text="-"}
--%%u24={label="labelsupplyFanAirFlow", text="-"}
--%%u25={label="labelexhaustFanOff", text="-"}
--%%u26={label="labelexhaustSpeed", text="-"}
--%%u27={label="labelexhaustDuty", text="-"}
--%%u28={label="labelexhaustFanAirFlow", text="-"}

--%%u29={label="labelcurrentVentilationPower", text="-"}
--%%u30={label="labelavoidedHeating", text="-"}
--%%u31={label="labelavoidedCooling", text="-"}

--%%u32={label="labelbypassMode", text="-"}
--%%u33={label="labelbypassDuty", text="-"}

--%%u34={label="labelheatingSeason", text="-"}
--%%u35={label="labelcoolingSeason", text="-"}
--%%u36={label="labellimitRMOTHeating", text="-"}
--%%u37={label="labellimitRMOTCooling", text="-"}
--%%u38={label="labelrunningMeanOutdoorTemparature", text="-"}

--%%u39={label="labeldeviceId", text="-"}
--%%u40={label="labeltimeSeriesType", text="-"}
--%%u41={label="labelfrostDuty", text="-"}
--%%u42={label="labelrequiredTemperature", text="-"}
--%%u43={label="labelanalogInput1", text="-"}
--%%u44={label="labelanalogInput2", text="-"}
--%%u45={label="labelanalogInput3", text="-"}
--%%u46={label="labelanalogInput4", text="-"}
--%%u47={label="labelpostSupplyAirTempAfterComfoCool", text="-"}
--%%u48={label="labelexhaustAirTempAfterComfoCool", text="-"}
--%%u49={label="labelpostHeaterPresence", text="-"}
--%%u50={label="labelhoodPresence", text="-"}
--%%u51={label="labelhoodIsOn", text="-"}
--%%u52={label="labelcomfoCoolCompressorState", text="-"}
--%%u53={label="labelcomfortTemperatureMode", text="-"}
--%%u54={label="labelpassiveTemperatureMode", text="-"}
--%%u55={label="labeltemperatureProfile", text="-"}
--%%u56={label="labelventilationMode", text="-"}
--%%u57={label="labelpostHeaterMode", text="-"}
--%%u58={label="labelwarmProfileTemp", text="-"}
--%%u59={label="labelcoolProfileTemp", text="-"}
--%%u60={label="labelnormalProfileTemp", text="-"}


--function QuickApp:copyToolbox(a,b)local c=api.get(("/quickApp/%s/files/%s"):format(a,b))assert(c,"File doesn't exists")local d=api.get(("/quickApp/%s/files/%s"):format(self.id,b))if not d then local e,f=api.post(("/quickApp/%s/files"):format(self.id),c)if f==200 then self:debug("File '",b,"' added")else self:error("Error:",f)end elseif d.content~=c.content then local e,f=api.put(("/quickApp/%s/files/%s"):format(self.id,b),c)if f==200 then self:debug("File '",b,"' updated")else self:error("Error:",f)end else self:debug("File '",b,"' up to date")end end

function QuickApp:onInit()
  self.i18n = i18n:new(api.get("/settings/info").defaultLanguage)
  self.config = Config:new(self)
  self.config.baseUrl = 'https://zehnder-prod-we-apim.azure-api.net/cloud/api/v2.1/'
  self.zehnder = Zehnder:new(self.config)

  self.title = "Zehnder Cloud Api - v2.1"
  self.presets = {"Away","Low","Medium","High"} -- Ventilation presets
  self.mode = {"Cool","Normal","Warm"}
  self.mode2 = {"Adaptive","Fixed"}
  self.mode3 = {"Off","Autoonly","On"}
  self.deviceData = {}
  self.deviceState = {}
  
  self:trace(self.title)
  self:updateView("labelTitle", "text", self.title)
  self:updateView("btnSearch", "text", self.i18n:get('search-devices'))
  if not self:varCheck() then return end
  self:pullHealth()
  self:setSceneButtons()
  self:run()
end

function QuickApp:run()
  self:updateDeviceState()
  local interval = self.config:getTimeoutInterval()
  if (interval > 0) then
    fibaro.setTimeout(interval, function() self:run() end)
  end
end

function QuickApp:varCheck()
  -- Check SubscriptionKey
  if self.config:getSubscriptionKey() == "" then
    self:updateView("labelMsg", "text", "Please supply the SubscriptionKey variable!")
    return 0
  end
--  self:debug("SubscriptionKey: ",self:getVariable("SubscriptionKey"))
  -- Passed all checks
  self:updateView("labelMsg", "text", "All variables are available!")
  return 1
end

function QuickApp:pullHealth()
  self:trace("Start pullHealth")
  local interval = self.config:getTimeoutInterval()
  local getHealthCallback = function(healthData)
    self:updateView("labelTitle", "text",  self.title .. " - " .. healthData.status )
    self:trace("End pullHealth")
  end
  self.zehnder:getHealth(getHealthCallback)
  if (interval > 0) then
    fibaro.setTimeout(interval, function() self:pullHealth() end)
  end
end

function QuickApp:setSceneButtons()
  local getScenesCallback = function(scenes)
    for __, scene in pairs(scenes) do
        self:updateView("btnScene"..tostring(scene.id), "text", scene.name)
    end
    self:debug("Scenes received and button labels updated")
  end
  self.zehnder:getScenes(getScenesCallback)
end

function QuickApp:searchEvent(callback)
  self:trace("Start searchEvent")
  self:updateView("btnSearch", "text", self.i18n:get('searching-devices'))
  local getDevicesIdsCallback = function(ids)
    if ids[1] ~= nil then
      self:updateView("labelDeviceID", "text", tostring(ids[1]))
      self:setVariable("DeviceID", tostring(ids[1]))
      self:debug("DeviceID: ", self:getVariable("DeviceID"))
      if callback ~= nil then callback() end
    end
    self:trace("End searchEvent")
    self:updateView("btnSearch", "text", self.i18n:get('search-devices'))
  end
  self.zehnder:getDevicesIds(getDevicesIdsCallback)
end

function QuickApp:refreshEvent(callback)
  self:trace("Start refreshEvent")
  self:updateView("btnRefresh", "text", self.i18n:get('refreshing'))
  if self:getVariable("DeviceID") == "" then
    local refreshEventCallback = function()
      self:refreshEvent()
    end
    self:searchEvent(refreshEventCallback)
    return
  end
  self:updateDeviceData()
  self:updateDeviceState()
  if callback ~= nil then callback() end
end

function QuickApp:updateDeviceData(callback)
  self:trace("Start updateDeviceData")
  local getDeviceCallback = function(deviceData)
--    QuickApp:debug(dump(deviceData))
    self:debug("buildingId: ", deviceData["buildingId"])
    self.deviceData = deviceData
    self:updateView("btnRefresh", "text", self.i18n:get('refresh'))
--    self:updateView("labelMsg", "text", string.format(self.i18n:get('last-update'), os.date('%Y-%m-%d %H:%M:%S')))
    if callback ~= nil then callback() end
    self:trace("End updateDeviceData")
  end
  self.zehnder:getDevice(self:getVariable("DeviceID"),getDeviceCallback)
end

function QuickApp:updateDeviceState(callback)
  self:trace("Start updateDeviceState")
  if self:getVariable("DeviceID") == "" then
    local callback = function()
      self:updateDeviceState()
    end
    self:searchEvent(callback)
    return
  end
  local getDeviceStateCallback = function(deviceState)
--    QuickApp:debug(dump(deviceState))
    self.deviceState = deviceState
    self:updateUIdeviceState(deviceState)
    self:updateView("btnRefresh", "text", self.i18n:get('refresh'))
    self:updateView("labelMsg", "text", string.format(self.i18n:get('last-update'), os.date('%Y-%m-%d %H:%M:%S')))
    if callback ~= nil then callback() end
    self:trace("End updateDeviceState")
  end
  self.zehnder:getDeviceState(self:getVariable("DeviceID"),getDeviceStateCallback)
end

function QuickApp:updateUIdeviceState(deviceState)
  self:uiUpdateLabel("deviceId",deviceState.deviceId)
  self:uiUpdateLabel("timestamp",deviceState.timestamp)

local pattern = "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)%+(%d+):(%d+)"
local runyear, runmonth, runday, runhour, runminute, runseconds = deviceState.timestamp:match(pattern)
local convertedTimestamp = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})
QuickApp:debug(convertedTimestamp)

  for k, v in pairs(deviceState.values) do
    if k == "ventilationPreset" then
      -- Update Preset Buttons to current state
      local index = tonumber(v)+1
      self:updatePresetButtons(index)
    else
      self:uiUpdateLabel(k,v)
    end
  end
end

function QuickApp:updatePresetButtons(index)
  for ip, preset in ipairs(self.presets) do
    if ip == index then
      preset = string.upper(preset)
      self:uiUpdateLabel(k,preset)
    end
    self:updateView("btnPreset"..ip, "text", preset)
  end
end

function QuickApp:uiUpdateLabel(elm,value)
  if elm == nil or value == nil then return end
  elm = tostring(elm)
  value = tostring(value)
  if elm == "exhaustAirTemp"
  or elm == "systemOutdoorTemp"
  or elm == "runningMeanOutdoorTemparature"
  or elm == "requiredTemperature"
  or elm == "postSupplyAirTempAfterComfoCool"
  or elm == "exhaustAirTempAfterComfoCool"
  or elm == "extractAirTemp"
  or elm == "limitRMOTCooling"
  or elm == "limitRMOTHeating"
  or elm == "warmProfileTemp"
  or elm == "coolProfileTemp"
  or elm == "normalProfileTemp"
  then
    value = tonumber(value)/10
  end
  -- Update Labels to corresponding language template
  self:updateView("label"..elm, "text", string.format(self.i18n:get(elm), value))
end

function QuickApp:activateScene(e)
  self:debug("Start activate scene")
  if self.deviceData.buildingId == nil then
      self:debug("activateScene: No building Id!")
      return
  end
  local buildingId = self.deviceData.buildingId
  local sceneId = string.sub(e.elementName,-1,-1)
  local activateSceneCallback = function ()
    self:debug("Scene is set")
  end
  self.zehnder:activateScene(buildingId, sceneId, callback)
end

function QuickApp:setVentilationPreset(e)
  self:debug("Start setting Ventilation Preset")
  local preset = tonumber(string.sub(e.elementName,-1,-1))
  self:updatePresetButtons(preset)
  local commands = {
    setVentilationPreset = {
      value = self.presets[preset]
    }
  }
  local setVentilationPresetCallback = function ()
    self:debug("Ventilation preset is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, setVentilationPresetCallback)
end

function QuickApp:setManualMode(enabled) -- boolean
  local commands = {
    ["setManualMode"] = {
        ["enabled"] = enabled
    }
  }
  local callback = function ()
    self:debug("Manual mode is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setAway(enabled, date) -- enabled = boolean, until = int
  local commands = {
    ["setAway"] = {
        ["enabled"] = enabled,
        ["until"] = date
    }
  }
  local callback = function ()
    self:debug("Away is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setBoostTimer(seconds) -- int optional
  local commands = {
    ["setBoostTimer"] = {}
  }
  if seconds ~= nil or seconds ~= 0 then
    commands["setBoostTimer"]["seconds"] = seconds
  end
  local callback = function ()
    self:debug("Booster is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setTemperatureProfileTemperature(mode, temperature)
  local commands = {
    ["setTemperatureProfileTemperature"] = {
        ["mode"] = mode,
        ["temperature"] = temperature
    }
  }
  local callback = function ()
    self:debug("Temperature for Temperature Profile is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setTemperatureProfile(mode)
  local commands = {
    ["setTemperatureProfile"] = {
        ["mode"] = mode
    }
  }
  local callback = function ()
    self:debug("Temperature Prolfile is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setComfortMode(mode) -- mode2
  local commands = {
    ["setComfortMode"] = {
        ["mode"] = mode
    }
  }
  local callback = function ()
    self:debug("Comfort Mode is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setPassiveTemperatureMode(mode) -- mode3
  local commands = {
    ["setPassiveTemperatureMode"] = {
        ["mode"] = mode
    }
  }
  local callback = function ()
    self:debug("Passive Temperature Mode is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setHumidityComfortMode(mode) -- mode3
  local commands = {
    ["setHumidityComfortMode"] = {
        ["mode"] = mode
    }
  }
  local callback = function ()
    self:debug("Humidity Comfort Mode is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setHumidityProtectionMode(mode) -- mode3
  local commands = {
    ["setHumidityProtectionMode"] = {
        ["mode"] = mode
    }
  }
  local callback = function ()
    self:debug("Humidity Protection Mode is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setRMOTCool(temperature) -- int
  local commands = {
    ["setRMOTCool"] = {
        ["temperature"] = temperature
    }
  }
  local callback = function ()
    self:debug("RMOT Cool is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setRMOTHeat(temperature) -- int
  local commands = {
    ["setRMOTHeat"] = {
        ["temperature"] = temperature
    }
  }
  local callback = function ()
    self:debug("RMOT Heat is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setExhaustFanOff(seconds) -- int
  local commands = {
    ["setExhaustFanOff"] = {
        ["seconds"] = seconds
    }
  }
  local callback = function ()
    self:debug("Exhaust Fan Off is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:setSupplyFanOff(seconds) -- int
  local commands = {
    ["setSupplyFanOff"] = {
        ["seconds"] = seconds
    }
  }
  local callback = function ()
    self:debug("Supply Fan Off is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end

function QuickApp:forceBypass(seconds) -- int optional
  local commands = {
    ["forceBypass"] = {}
  }
  if seconds ~= nil or seconds ~= 0 then
    commands["forceBypass"]["seconds"] = seconds
  end
  local callback = function ()
    self:debug("force Bypass is set")
    self:updateDeviceState()
  end
  self.zehnder:putComfosysCommand(self:getVariable("DeviceID"), commands, callback)
end


function SecondsToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours.." ="..mins.." ="..secs
  end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
