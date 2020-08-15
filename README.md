# WeatherApi
WeatherApi is a simple framework written in swift 4.2 for building meteo applications.
With WeatherApi: 
* you can collect weather informations from OpenWeather.
* you can keep data in smartphone for offline mode.
* you can save a new city.
* you can load all cities saved

## 1. Installation: 
1. Unzip and place the framework at the same level as your application.
2. create a podFile in your application folder: 
```
pod init
```
3. open your podFile and add the following line:
```
# Pods for WeatherApplication
pod 'WeatherApi' , :path=> '../WeatherApi'
```
4. save your file and then install the framework:
```
pod install
```
## 2. Class Diagram:

![image1](./images/class_diagram.png)

## 3. Business level:

![image2](./images/business_level.png)
