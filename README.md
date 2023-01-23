# Zehnder Cloud Api Fibaro
Fibaro HC3 Quickapp development for Zehnder ComfoAirQ control via cloud api
- Inspired by https://github.com/ikubicki/fibaro-netatmo-weather-provider
- Developped using https://github.com/jangabrielsson/TQAE with manual: https://forum.fibaro.com/topic/55045-tiny-quickapp-emulator-tqae/
- Zehnder Cloud API: https://portal.zehnder.cloudapi.ch/

To control you ComfoAirQ with this app a registration to The IoT Cloud is required. Register via: https://www.zehnder.nl/iot-cloud

Development steps:
- Download TQAE
- Replace modules/net.lua with net.lua file in order to catch redirect url
- Download this repository to replace dev and test folders.
  - The test folder contains the MSAL authentication storing the access token globally on the HC3
  - The dev folder contains the Zehnder control app
- See the TQAE documentation how to install and use the simulator

When project is ready the Quickapp file will be created and can be uploaded into the Fibaro HC3
