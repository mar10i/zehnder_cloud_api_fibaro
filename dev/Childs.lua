--- Child Ventilation Speed ---------------

class "ventilationPreset"(QuickAppChild)
function ventilationPreset:__init(device)
  QuickAppChild.__init(self, device)
  self:trace("ventilationPreset initiated, deviceId: ", self.id)
end
function ventilationPreset:turnOn()
    self:debug("multilevel switch turned on")
    self:setValue(99)
end
function ventilationPreset:turnOff()
    self:debug("multilevel switch turned off")
    self:setValue(0)    
end
-- Value is type of integer (0-99)
function ventilationPreset:setValue(value)
  if value == nil then value = 0 else value = math.floor(tonumber(value) / 30)*30 end
  local preset = self.parent.presets[math.floor(tonumber(value) / 30)+1]
  self:debug("Ventilation set to: ".. preset)
  self.parent:setVentilationPreset(preset)
  self:updateUI(value)
end
function ventilationPreset:updateValue()
  local value = tonumber(self.parent.deviceState.values["ventilationPreset"])
  self:debug("Preset: "..tostring(value))
  self:updateUI(value*30)
end
function ventilationPreset:updateUI(value)
  local preset = self.parent.presets[math.floor(tonumber(value) / 30)+1]
  self:updateProperty("value", value)
  self:updateProperty("log", self.parent.i18n:get(preset))
end

--- Child Remaining Filter Duration ---------------

class "remainingFilterDuration"(QuickAppChild)
function remainingFilterDuration:__init(device)
  QuickAppChild.__init(self, device)
  self:trace("remainingFilterDuration initiated, deviceId: ", self.id)
end
function remainingFilterDuration:updateValue()
  local value = tonumber(self.parent.deviceState.values["remainingFilterDuration"])
  if self.properties.value ~= value then
    if value == nil or value == '' then value = 0 end
    local w = math.floor(value / 7) --  local d = value % 7
    self:updateProperty("value",value)
    if value == 1 then
      self:updateProperty("unit", self.parent.i18n:get('unitDay'))
    else
      self:updateProperty("unit", self.parent.i18n:get('unitDays'))
    end
    if w == 0 then
      self:updateProperty("log", self.parent.i18n:get('replace-filters'))
    elseif w < 5 then
      self:updateProperty("log", self.parent.i18n:get('order-filters'))
    else
      self:updateProperty("log", string.format(self.parent.i18n:get('remaining-weeks'), w))
    end
  end
end