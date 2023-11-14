CURRENTLY THE CODE IS MADE READY FOR THE NEW API IN COOPERATION WITH ZEHNDER

# Zehnder Cloud Api Fibaro
Fibaro HC3 Quickapp development for Zehnder ComfoAirQ control via cloud api
- Inspired by https://github.com/ikubicki/fibaro-netatmo-weather-provider
- Developped using https://github.com/jangabrielsson/TQAE with manual: https://forum.fibaro.com/topic/55045-tiny-quickapp-emulator-tqae/
- Zehnder ComfoControl App:
  - Android Play Store: https://play.google.com/store/apps/details?id=com.zehndergroup.comfocontrol
  - Apple App Store: https://apps.apple.com/nl/app/comfocontrol/id1104291808
- Zehnder Dashboard: https://mydevices.beta.zehnder.cloud
- Zehnder Cloud API: https://developer.beta.zehnder.cloud

To control you ComfoAirQ with this app a registration to The IoT Cloud is required. Register via: https://www.zehnder.nl/iot-cloud
Follow the instructions to enable the beta app and create connection to the cloud. When the connection is made a api key-name combination can be requested. Together with the subscription key of the developer cloud the Quickapp can make connection to your Zehneder device.

Development steps:
- Download TQAE
- Download this repository to replace dev or test folders.
  - The dev folder contains the Zehnder control app
- See the TQAE documentation how to install and use the simulator

When project is ready the Quickapp file will be created and can be uploaded into the Fibaro HC3
