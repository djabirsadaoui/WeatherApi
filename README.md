# WeatherApi
Ce framework permetra de récuprer la météo de 8 jours depuis le serveur OpenWeather et la sauvegarder localement sur le smartphone pour la retourner dans le cas de l'absence d'internet.
## 1. Installation: 
1. Dézippez et placez le framework au même niveau que votre application.
2. créer un podFile dans votre application: 
```
pod init
```
3. ouvre votre podFile et ajouter la ligne suivante:
```
# Pods for WeatherApplication
pod 'WeatherApi' , :path=> '../WeatherApi'
```
4. sauvegardez votre fichier, en suite installez le framework:
```
pod install
```
## 2. Diagramme de classe:

![image1](./images/class_diagram.png)

## 3. Diagramme de class métier:

![image2](./images/business_level.png)
