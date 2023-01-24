--[[
Internationalization tool
@author masterlee
]]
class 'i18n'

function i18n:new(langCode)
    if phrases[langCode] == nill then langCode = "en" end
    self.phrases = phrases[langCode]
    return self
end

function i18n:get(key)
    if self.phrases[key] then
        return self.phrases[key]
    end
    return key
end

phrases = {
    en = {
        ['search-devices']                  = 'Search devices',
        ['searching-devices']               = 'Searching...',
        ['refresh']                         = 'Update data',
        ['refreshing']                      = 'Updating...',
        ['last-update']                     = 'Last update at %s',
        
        ['timestamp']                       = 'Last update at %s',
        
        ['deviceId']                        = 'Serial number: %s',
        ['timeSeriesType']                  = 'Time Series Type: %s',
        ['exhaustAirTemp']                  = 'Exhaust Air Temp: %s',
        ['exhaustSpeed']                    = 'Exhaust Speed: %s',
        ['exhaustDuty']                     = 'Exhaust Duty: %s',
        ['systemSupplySpeed']               = 'System Supply Speed: %s',
        ['systemSupplyDuty']                = 'System Supply Duty: %s',
        ['currentVentilationPower']         = 'Current Ventilation Power: %s',
        ['avoidedCooling']                  = 'Avoided Cooling: %s',
        ['manualMode']                      = 'Manual Mode: %s',
        ['exhaustFanOff']                   = 'Exhaust Fan Off: %s',
        ['supplyFanOff']                    = 'Supply Fan Off: %s',
        ['awayEnabled']                     = 'Away Enabled: %s',
        ['boostTimerEnabled']               = 'Boost Timer Enabled: %s',
        ['extractAirHumidity']              = 'Extract Air Humidity: %s',
        ['exhaustAirHumidity']              = 'Exhaust Air Humidity: %s',
        ['systemSupplyTemp']                = 'System Supply Temp: %s',
        ['systemSupplyHumidity']            = 'System Supply Humidity: %s',
        ['systemOutdoorTemp']               = 'System Outdoor Temp: %s',
        ['systemOutdoorHumidity']           = 'System Outdoor Humidity: %s',
        ['exhaustFanAirFlow']               = 'Exhaust Fan Air Flow: %s',
        ['supplyFanAirFlow']                = 'Supply Fan Air Flow: %s',
        ['frostDuty']                       = 'Frost Duty: %s',
        ['bypassDuty']                      = 'Bypass Duty: %s',
        ['runningMeanOutdoorTemparature']   = 'Running Mean Outdoor Temparature: %s',
        ['coolingSeason']                   = 'Cooling Season: %s',
        ['heatingSeason']                   = 'Heating Season: %s',
        ['requiredTemperature']             = 'Required Temperature: %s',
        ['analogInput1']                    = 'Analog Input 1: %s',
        ['analogInput2']                    = 'Analog Input 2: %s',
        ['analogInput3']                    = 'Analog Input 3: %s',
        ['analogInput4']                    = 'Analog Input 4: %s',
        ['avoidedHeating']                  = 'Avoided Heating: %s',
        ['postSupplyAirTempAfterComfoCool'] = 'Post Supply Air Temp After Comfo Cool: %s',
        ['exhaustAirTempAfterComfoCool']    = 'Exhaust Air Temp After Comfo Cool: %s',
        ['postHeaterPresence']              = 'Post Heater Presence: %s',
        ['hoodPresence']                    = 'Hood Presence: %s',
        ['hoodIsOn']                        = 'Hood Is On: %s',
        ['remainingFilterDuration']         = 'Filter: %s days remaining',
        ['limitRMOTCooling']                = 'Limit RMOT Cooling: %s',
        ['limitRMOTHeating']                = 'Limit RMOT Heating: %s',
        ['extractAirTemp']                  = 'Extract Air Temp: %s',
        ['ventilationPreset']               = 'Ventilation preset: %s',
        ['comfoCoolCompressorState']        = 'Comfo Cool Compressor State: %s',
        ['comfortTemperatureMode']          = 'Comfort Temperature Mode: %s',
        ['passiveTemperatureMode']          = 'Passive Temperature Mode: %s',
        ['temperatureProfile']              = 'Temperature Profile: %s',
        ['ventilationMode']                 = 'Ventilation Mode: %s',
        ['postHeaterMode']                  = 'Post Heater Mode: %s',
        ['bypassMode']                      = 'Bypass Mode: %s',
        ['warmProfileTemp']                 = 'Warm Profile Temp: %s',
        ['coolProfileTemp']                 = 'Cool Profile Temp: %s',
        ['normalProfileTemp']               = 'Normal Profile Temp: %s',
        
        ['remainingFilterDurationChildName'] = 'Filter',
        
        ['unitDay']               = ' day',
        ['unitDays']              = ' days',
        ['unitWeek']              = ' week',
        ['unitWeeks']             = ' weeks',
    
        ['replace-filters']       = 'Replace filters',
        ['order-filters']         = 'Order filters',
        ['remaining-weeks']       = '%s weeks',
    },
    nl = {
        ['search-devices'] = 'Zoek apparaten',
        ['searching-devices'] = 'Zoeken...',
        ['refresh'] = 'Update data',
        ['refreshing'] = 'Updaten...',
        ['last-update'] = 'Laatste update om %s',
        
        ['timestamp'] = 'Laatste update om %s',
        
        ['ventilationPreset']               = 'Ventilatie stand: %s',
        ['manualMode']                      = 'Manual Mode: %s',
        ['awayEnabled']                     = 'Away Enabled: %s',
        ['boostTimerEnabled']               = 'Boost Timer Enabled: %s',
        ['remainingFilterDuration']         = 'Filter: nog %s dagen resterend',
        
        ['extractAirTemp']                  = 'Extract Air Temp: %.1f°C',
        ['extractAirHumidity']              = 'Extract Air Humidity: %s%%',
        ['exhaustAirTemp']                  = 'Exhaust Air Temp: %.1f°C',
        ['exhaustAirHumidity']              = 'Exhaust Air Humidity: %s%%',
        ['systemSupplyTemp']                = 'System Supply Temp: %s',
        ['systemSupplyHumidity']            = 'System Supply Humidity: %s%%',
        ['systemOutdoorTemp']               = 'System Outdoor Temp: %.1f°C',
        ['systemOutdoorHumidity']           = 'System Outdoor Humidity: %s%%',
        
        ['supplyFanOff']                    = 'Supply Fan Off: %s',
        ['systemSupplySpeed']               = 'Toerental Toevoerventilator: %srpm',
        ['systemSupplyDuty']                = 'Last Toevoerventilator: %s%%',
        ['supplyFanAirFlow']                = 'Luchtdebiet Toevoerventilator: %sm³/h',
        ['exhaustFanOff']                   = 'Exhaust Fan Off: %s',
        ['exhaustSpeed']                    = 'Toerntal Afvoerventilator: %srpm',
        ['exhaustDuty']                     = 'Last Afvoerventilator: %s%%',
        ['exhaustFanAirFlow']               = 'Luchtdebiet Afvoerventilator: %sm³/h',
        
        ['currentVentilationPower']         = 'Huidig Ventilatie Stroomverbuik: %sW',
        ['avoidedHeating']                  = 'Actueel vermeden verwarming: %skW',
        ['avoidedCooling']                  = 'Actueel vermeden koeling: %skW',
        
        ['bypassMode']                      = 'Bypass Mode: %s',
        ['bypassDuty']                      = 'Bypass Status: %s%%',
        
        ['heatingSeason']                   = 'Stookseizoen actueel: %s',
        ['coolingSeason']                   = 'Koelseizoen actueel: %s',
        ['limitRMOTHeating']                = 'Verwarmingslimiet RMOT: %.1f°C',
        ['limitRMOTCooling']                = 'Koellimiet RMOT: %.1f°C',
        ['runningMeanOutdoorTemparature']   = 'Huidige RMOT: %.1f°C',
        
        ['deviceId']                        = 'Serienummer: %s',
        ['timeSeriesType']                  = 'Time Series Type: %s',
        ['frostDuty']                       = 'Vorstbescherming: %s%% reductie',
        ['requiredTemperature']             = 'Required Temperature: %.1f°C',
        ['analogInput1']                    = 'Analog Input 1: %s',
        ['analogInput2']                    = 'Analog Input 2: %s',
        ['analogInput3']                    = 'Analog Input 3: %s',
        ['analogInput4']                    = 'Analog Input 4: %s',
        ['postSupplyAirTempAfterComfoCool'] = 'Post Supply Air Temp After Comfo Cool: %.1f°C',
        ['exhaustAirTempAfterComfoCool']    = 'Exhaust Air Temp After Comfo Cool: %.1f°C',
        ['postHeaterPresence']              = 'Post Heater Presence: %s',
        ['hoodPresence']                    = 'Hood Presence: %s',
        ['hoodIsOn']                        = 'Hood Is On: %s',
        ['comfoCoolCompressorState']        = 'Comfo Cool Compressor State: %s',
        ['comfortTemperatureMode']          = 'Comfort Temperature Mode: %s',
        ['passiveTemperatureMode']          = 'Passive Temperature Mode: %s',
        ['temperatureProfile']              = 'Temperature Profile: %s',
        ['ventilationMode']                 = 'Ventilation Mode: %s',
        ['postHeaterMode']                  = 'Post Heater Mode: %s',
        ['warmProfileTemp']                 = 'Warm Profile Temp: %.1f°C',
        ['coolProfileTemp']                 = 'Cool Profile Temp: %.1f°C',
        ['normalProfileTemp']               = 'Normal Profile Temp: %.1f°C',
        
        ['remainingFilterDurationChildName'] = 'Filter',
        
        ['unitDay']               = ' dag',
        ['unitDays']              = ' dagen',
        ['unitWeek']              = ' week',
        ['unitWeeks']             = ' weken',
        
        ['replace-filters']       = 'Vervang filters',
        ['order-filters']         = 'Bestel filters',
        ['remaining-weeks']       = '%s weken',
    }
}