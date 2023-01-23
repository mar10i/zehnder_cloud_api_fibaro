_=loadfile and loadfile("TQAE.lua"){}

--FILE:test/Config.lua,Config;
--FILE:test/Globals.lua,Globals;
--FILE:test/HTTPClient.lua,HTTPClient;
--FILE:test/i18n.lua,i18n;
--FILE:test/MSAL.lua,MSAL;

--%%name="Zehnder"
--%%u1={label="labelTitle", text="Zehnder"}
--%%u2={label="labelMsg", text=""}
--%%u3={{button="btnStart",text="Start",onReleased="run"}}

function QuickApp:onInit()
  self.title = "Zehnder Authorization"
  self.i18n = i18n:new(api.get("/settings/info").defaultLanguage)
  self.config = Config:new(self)
  self.config.baseUrl = 'https://zehndergroupauth.b2clogin.com/zehndergroupauth.onmicrosoft.com/b2c_1_signin_signup_enduser/'
  self.msal = MSAL:new(self.config)
  
  self:trace(self.title)
  self:updateView("labelTitle", "text", self.title)
  self:updateView("btnStart", "text", self.i18n:get('start'))
  self:updateView("labelMsg", "text", self.i18n:get('init'))
  self:run()
end

function QuickApp:run()
  if Globals:get('zehnder_client_id') == '' then
    self:updateView("labelMsg", "text", self.i18n:get('no_client_id'))
    return
  end
  if Globals:get('zehnder_username') == '' then
    self:updateView("labelMsg", "text", self.i18n:get('no_username'))
    return
  end
  if Globals:get('zehnder_password') == '' then
    self:updateView("labelMsg", "text", self.i18n:get('no_password'))
    return
  end
  MSAL:getAuthCode()
  self:updateView("labelMsg", "text", self.i18n:get('running'))
end