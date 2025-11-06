# CheckerApp
My final exam project for the Swift course
#  PhishChecker

![Screenshot](https://github.com/HattoriHanzo1412/CheckerApp/tree/main/03-11-abschlussprojekt-HattoriHanzo1412#phishchecker)

**Schütze dich vor Phishing mit nur einem Klick.**

PhishChecker ist eine iOS-App, die verdächtige Links erkennt, bevor sie gefährlich werden.
Gib eine URL oder E-Mail ein – die App prüft mit einer externen API, ob es sich um einen Phishing-Versuch handelt.

Die App richtet sich an sicherheitsbewusste Nutzer:innen, die sich im Internet besser schützen möchten.
Anders als viele andere Apps zeigt PhishChecker transparente Ergebnisse, speichert deine Anfragen lokal (offline), und lernt mit.
Für wen ist sie geeignet? Welches Problem löst sie? Was macht deine App anders/besser als andere Apps?
Vermeide es, hier allzusehr in technische Details zu gehen.


## Design

<p>
  <img src="./img/download-2.png" width="200">
  <img src="./img/download-1.png" width="200">
  <img src="./img/download.png" width="200">
</p>


## Features
 1 Eingabe von URL zur Prüfung

 2 API-Anfrage an Google Safe Browsing API

 3 Ergebnisanzeige (sicher, verdächtig, gefährlich)

 4 Speicherung der Anfragen in SwiftData

 5 Verlauf mit Datum/Uhrzeit und Ergebnis

 
 

## Technischer Aufbau
PhishChecker
 Models           → Datenstrukturen wie URLCheck, PhishResult
 Views            → SwiftUI Views (Eingabe, Ergebnisse, Verlauf)
 ViewModels       → MVVM-Logik pro Bildschirm
 Services         → APIClient, FirebaseManager
 Resources        → Assets, Localizations

 
#### Projektaufbau
Architektur
MVVM – Model View ViewModel

Services (für API, SwiftData)

EnvironmentObject für globale AppStates

#### Datenspeicherung
Komponente      	Dienst	         Zweck

Verlauf	          SwiftData	       Speicherung der Suchanfragen
Ergebnisse   	    temporär	       Zwischenspeicher im Speicher
Benutzerprefs   	UserDefaults	   Dark Mode, erste Nutzung usw.



#### API Calls

Primär:  Google Safe Browsing API,
Erkennt gefährliche Seiten (Phishing, Malware)
Prüft, ob URL in bekannter Phishing-Datenbank ist




#### 3rd-Party Frameworks

 Google Safe Browsing API
 
 SwiftData

 Swift Package: URLImage  

 Swift Regex für String Matching


## Ausblick
geplante Features

1 Integration mit Safari/Google (Share Extension)

2 Erklärungstexte zur Aufklärung über Phishing

3 Extra UX/UI Design features möglich

4 Dark Mode

