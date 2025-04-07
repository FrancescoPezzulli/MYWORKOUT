# myWorkout

Relazione di progetto per il corso di **Laboratorio di Applicazioni Mobili** (A.A. 2018)  
_A cura di Francesco Pezzulli_  
Piattaforma: **iOS**  
Linguaggio: **Swift**  
Ambiente di sviluppo: **Xcode**  

---

## 📱 Panoramica dell'applicazione

**myWorkout** è un'app iOS pensata per la gestione completa degli allenamenti in palestra.  
Semplifica la pianificazione e il tracciamento degli esercizi, dei progressi e dei parametri corporei.

### 🔧 Struttura

L’app è composta da 5 schermate principali:

1. **Schede** – Visualizzazione e gestione delle schede di allenamento
2. **Esercizi** – Elenco degli esercizi disponibili
3. **Crea** – Creazione di schede personalizzate
4. **Progressi** – Grafici e statistiche sui miglioramenti
5. **Profilo** – Gestione dei dati utente e calcolo del BMI

### ✨ Funzionalità principali

- Visualizzazione e creazione di schede di allenamento personalizzate
- Avvio e tracciamento degli allenamenti
- Registrazione dei carichi per ogni esercizio
- Timer con notifiche push e vibrazione per la gestione dei tempi di recupero
- Descrizione dettagliata degli esercizi
- Grafici per monitorare l’andamento di carichi e peso corporeo
- Gestione del profilo utente e calcolo del BMI

### 📲 Requisiti

- Sviluppata in Swift per **iOS 12.2**
- Ottimizzata per **iPhone XR**

---

## ⚙️ Funzionamento dell'app

### Schermata di Caricamento

Schermata iniziale semplice, utilizzata per evitare un avvio su sfondo bianco durante il caricamento dei componenti.

### Schede

- Mostra tutte le schede disponibili con stima della durata dell’allenamento
- Selezionando una scheda si visualizzano gli esercizi, con dettagli su serie, ripetizioni, recupero e immagine esplicativa
- Possibilità di avviare l’allenamento direttamente da qui

### Live Workout

- Visualizzazione in tempo reale dell’esercizio corrente
- Tracciamento del peso usato, numero di serie e ripetizioni
- Funzionalità “Registra peso”
- Timer di recupero con possibilità di pausa, skip, e notifica anche in background
- Al termine dell’esercizio si passa automaticamente al successivo

### Esercizi

- Elenco degli esercizi disponibili
- Possibilità di cliccare per visualizzare descrizione ed esecuzione

### Crea

- Creazione di nuove schede personalizzate
- Pop-up per aggiungere esercizi con nome, serie, ripetizioni, recupero
- Validazione dei dati inseriti e feedback in caso di errori

### Progressi

- Grafici interattivi per peso corporeo e carichi
- Interazione con i punti del grafico per visualizzare dati e date

### Profilo

- Inserimento e salvataggio dei dati utente
- Tracciamento del peso nel tempo
- Calcolo BMI tramite pop-up informativo

---

## 🧠 Architettura e Progettazione

### Classi principali (16)

| Classe               | Descrizione                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `ScheduleCell`       | Cella per la lista delle schede                                             |
| `WorkoutCell`        | Cella per la visualizzazione degli esercizi di una scheda                   |
| `ExerciseCell`       | Cella per l’elenco esercizi                                                 |
| `NewScheduleCell`    | Cella per la creazione di una nuova scheda                                  |
| `ScheduleScreen`     | Visualizza gli esercizi di una scheda                                       |
| `ExerciseScreen`     | Mostra i dettagli di un esercizio                                           |
| `ScheduleListScreen` | Schermata principale con elenco schede                                      |
| `ExerciseListScreen` | Schermata elenco esercizi                                                   |
| `LiveWorkoutScreen`  | Schermata di allenamento live                                               |
| `NewScheduleScreen`  | Schermata di creazione schede                                               |
| `ProgressListScreen` | Schermata con i grafici di progresso                                        |
| `PopUpAddExercise`   | Pop-up per aggiungere un esercizio                                          |
| `PopUpBMI`           | Pop-up informativo sul BMI                                                  |
| `ProfileScreen`      | Schermata del profilo utente                                                |
| `Schedule`           | Modello dati per una scheda                                                 |
| `Exercise`           | Modello dati per un esercizio                                               |

> Presenti anche `Main.storyboard` e `LaunchScreen.storyboard` per la definizione UI.

---

## 💾 Gestione dei dati

Utilizzo di **CoreData** per la persistenza locale dei dati.  
Sono state create tre entità principali:

### Workouts

| Attributo | Descrizione                   |
|----------|-------------------------------|
| Title    | Nome della scheda             |
| Exercise | Nome dell’esercizio           |
| Pos      | Posizione dell’esercizio      |
| Reps     | Numero di ripetizioni         |
| Sets     | Numero di serie               |
| Rest     | Tempo di recupero             |

### Exercises

| Attributo | Descrizione                           |
|----------|---------------------------------------|
| Name     | Nome dell’esercizio                   |
| Weight   | Array di pesi registrati              |
| Date     | Array di date relative ai pesi        |

### Profile

| Attributo  | Descrizione                          |
|------------|--------------------------------------|
| Sex, Name, Surname, Age | Dati anagrafici         |
| Height     | Altezza dell’utente                  |
| Weight     | Array pesi corporei registrati       |
| Date       | Array date delle misurazioni         |
| Goalweight | Obiettivo peso corporeo              |
