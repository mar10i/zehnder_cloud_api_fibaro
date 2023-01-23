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
        ['init']         = 'Initialized Quickapp',
        ['start']        = 'Start',
        ['no_client_id'] = 'Please supply the global variable zehnder_client_id',
        ['no_username']  = 'Please supply the global variable zehnder_username',
        ['no_password']  = 'Please supply the global variable zehnder_password',
        ['running']      = 'Busy updating access token',
    },
    nl = {
        ['init']         = 'Quickapp is gestart',
        ['start']        = 'Start',
        ['no_client_id'] = 'Vul de globale variabele zehnder_client_id in',
        ['no_username']  = 'Vul de globale variabele zehnder_username in',
        ['no_password']  = 'Vul de globale variabele zehnder_password in',
        ['running']      = 'Bezig met vernieuwen van access token',
    }
}