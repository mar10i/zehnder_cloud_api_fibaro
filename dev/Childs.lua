--- Child Remaining Filter Duration ---------------

class "remainingFilterDuration"(QuickAppChild)
function remainingFilterDuration:__init(device)
  QuickAppChild.__init(self, device)
  self:trace("remainingFilterDuration initiated, deviceId: ", self.id)
end

function remainingFilterDuration:updateValue()
  local value = tonumber(self.parent.deviceState.values["remainingFilterDuration"])
  if value == nil or value == '' then value = 0 end
  local w = math.floor(value / 7)
--  local d = value % 7
--  self:debug("Weeks: "..w..", Days: "..d)
 
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