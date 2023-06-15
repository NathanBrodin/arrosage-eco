# Utilisation du projet

Dans le fichier `/Arduino-Arrosage-eco/web_server.ino`, changer les valeurs par vos informations wifi
```
const char* ssid = "SSID";
const char* password = "password";
```

Dans le fichier `/lib/modele/data.dart`, changer l'addresse IP par celle de la carte
```
  Future<String?> loadIp() async {
    return "192.168.73.67";
}
```