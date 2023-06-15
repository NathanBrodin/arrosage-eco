#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

const char* ssid = "SSID";
const char* password = "password";

ESP8266WebServer server(80);

String dataFromSTM32;

void setup() {
  Serial.begin(115200);
  delay(10);

  // Connexion au wifi
  Serial.println();
  Serial.println();
  Serial.print("Connexion a ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connecte");

  // Print the IP address
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/data", handleData);
  server.on("/send-data", handleReceivedData);

  server.begin();
  Serial.println("HTTP server a commence");

  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
}

void loop() {
  server.handleClient();

  static bool receiving = false;

  while (Serial.available() > 0) {
    char c = Serial.read();
    
    if (c == '{') {
      receiving = true;
      dataFromSTM32 = c;
    }
    else if (c == '}') {
      dataFromSTM32 += c; 
      receiving = false;
    }
    else if (receiving) {
      dataFromSTM32 += c; 
    }
  }
}


void handleRoot() {
  server.send(200, "text/html", "Arrosage eco, rien a voir ici");
}

void handleData() {
  if (dataFromSTM32.length() > 0) {
    server.send(200, "application/json", dataFromSTM32);
  } else {
    server.send(500, "text/plain", "Rien reçu pour le moment");
  }
}


void handleReceivedData() {
  if (server.hasArg("plain") == false) {
    server.send(200, "text/plain", "Body not received");
    return;
  }

  String message = server.arg("plain");
  Serial.println(message);
  server.send(200, "text/plain", "Body received");
}
