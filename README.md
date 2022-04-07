# Relazione progetto LAM: myWorkout

A cura di: Pezzulli Francesco, 0000800883

Corso: Laboratorio di Applicazioni Mobili, A.A. 2018/
Piattaforma: iOS

Linguaggio di sviluppo: Swift
Ambiente di sviluppo: Xcode

Data relazione: 2 Settembre 2019


## RIEPILOGO APPLICAZIONE

### Descrizione generale

Applicazione che permette la gestione completa degli allenamenti in palestra

### Struttura

myWorkout è strutturata da 5 diverse schermate, ognuna con una propria funzione:

1. Schede (schermata principale): visualizzazione ed eliminazione delle schede di allenamento
2. Esercizi: visualizzazione degli esercizi
3. Crea: creazione di una scheda personalizzata
4. Progressi: visualizzazione tramite grafici dei progressi ottenuti nell’arco del tempo
5. Profilo: creazione del proprio profilo e visualizzazione BMI

### Funzionalità

L’utente tramite myWorkout è in grado di semplificarsi la gestione degli allenamenti a causa di tutti quei
parametri che in palestra andrebbero segnati con carta e penna.

L’applicazione dunque offre tante funzionalità, tra cui:

- Visualizzazione e creazione di schede personalizzate
- Avviare un allenamento dalla scheda scelta
- Registrare il carico utilizzato durante un certo esercizio
- Avvisare l’utente tramite vibrazione e notifica che il timer per il recupero è scaduto
- Mostrare una descrizione dettagliata sull’esecuzione di ogni esercizio
- Mostrare grafici dell’andamento dei carichi utilizzati durante gli allenamenti e dei parametri corporei
- Registrare i parametri corporei

### Caratteristiche e requisiti

L’applicazione è stata sviluppata nel linguaggio Swift nella versione iOS 12.2 ed ottimizzata per un iPhone XR


## FUNZIONAMENTO E DESCRIZIONE

### Schermata di caricamento

La prima cosa che notiamo appena lanciamo in esecuzione l’applicazione sul nostro Device è sicuramente la
schermata di caricamento. Molto semplice ma serve a non presentare una schermata totalmente bianca
nell’attesa che tutte le componenti siano caricate.


### Schermata Schede

Questa è la schermata principale, essa ci mostra tutte le schede ora presenti che possiamo utilizzare. Notiamo
subito che oltre al nome dell’allenamento ci viene fornita una stima della durata di quest’ultimo, calcolando i

tempi di recupero e quelli di esecuzione di un normale individuo. Oltre a vedere quanti e quali allenamenti
abbiamo a disposizione possiamo selezionarne uno fra questi e vedere quali esercizi comporta e il numero di

ripetizioni, serie e recupero che ci spettano, con anche un’immagine esplicativa. Per esempio selezionando
“Petto” ci vengono mostrati tutti gli esercizi che la scheda comporta, mantenendo l’ordine in cui l’abbiamo

precedentemente creata.
Possiamo ovviamente tornare indietro se non ci aggrada l’idea di questo allenamento oppure proseguire con il

pulsante “Avvia Allenamento” che ci porterà ad un’altra schermata.


### Schermata Live Workout

Questa è la schermata dell’allenamento vero e proprio. Possiamo notare come ci venga fornito il nome
dell’esercizio corrente e un’immagine che rappresenta il movimento da compiere. Sotto la foto vengono fornite
le serie che abbiamo compiuto e quelle ancora da fare, il numero di ripetizioni e il peso da noi utilizzato nelle
sessioni precedenti. In questo caso abbiamo 14 Kg, ciò significa che in una sessione di allenamento abbiamo
già utilizzato questo carico. Oggi siamo particolarmente in forma e riusciamo a sollevare 16 Kg quindi
possiamo andare su “Registra peso” e registrarlo.


Ricordiamoci anche che una volta finita la serie dobbiamo premere sul pulsante “Fatto” in modo da far partire il
cronometro. Il numero delle serie svolte viene incrementato, il timer parte ed il pulsante pausa non sarà più

disabilitato e potremo fermare il tempo ogni volta che vorremo per poi riprenderlo. Possiamo anticipare il
cronometro se non vogliamo aspettare troppo per il riposo e possiamo premere su “Fatto” anche se il timer

non è ancora scaduto, l’applicazione lo resetterà e incrementerà le serie svolte.
Anche lasciando in background l’applicazione il cronometro continuerà ad andare e se non saremo

effettivamente sull’applicazione manderà una notifica per dirci che il timer è scaduto. Premendo sulla notifica
saremo portati alla schermata dell’allenamento.


Una volta finite le serie la pagina viene aggiornata con i dati dell’esercizio successivo (nella figura viene
mostrato l’ultimo esercizio per semplicità). Finito l’allenamento ci viene mostrato un alert che ci informa che

l’allenamento è terminato e premendo su “Fine” verremo riportati alla pagina iniziale delle schede.


### Schermata Esercizi

La schermata si presenta mostrando gli esercizi tramite il loro nome e il muscolo coinvolto. Se vogliamo
saperne di più riguardo ad un singolo possiamo premere su questo e verremo portati sulla schermata di
descrizione dell’esercizio. Qui viene illustrata dettagliatamente l’esecuzione e mostrata l’immagine relativa.


### Schermata Crea

Qui vengono create le schede degli allenamenti, a cui possiamo dare un nome e una lista di esercizi
personalizzati. Premendo il pulsante aggiungi andremo ad aggiungere un esercizio alla nostra scheda tramite
una schermata in Pop Up presente di:

- Nome dell’esercizio
- Numero di serie allenanti
- Numero di ripetizioni
- Tempo di recupero

Una volta impostati tutti i parametri dell’esercizio possiamo premere avanti per aggiungerlo effettivamente alla
scheda


Se ci riteniamo soddisfatti dopo aver aggiunto i nostri esercizi possiamo concludere la creazione con il
pulsante di “Fine” e se tutto è corretto la scheda verrà aggiunta. Ovviamente dopo averla creata, la schermata
di creazione si imposta allo stato iniziale in modo che se volessimo aggiungere un’altra scheda lo riusciremmo
a fare.

Una scheda senza nome o senza esercizi non verrà considerata valida e verrà mostrato a video un alert che ci
avviserà che la scheda è incorretta.


### Schermata Progressi

Questa è la schermata dedicata alla visualizzazione tramite grafici dell’andamento dei carichi/peso corporeo
durante il corso del tempo. Molto semplice ed intuitiva, di fatto ci basta scegliere se vogliamo vedere un certo
esercizio o il nostro peso corporeo e il grafico verrà caricato all’istante. Possiamo inoltre vedere più
informazioni riguardanti i punti nel grafico, se vengono cliccati mostrano il peso associato e la data di
misurazione in cui è stato registrato tale peso.


### Schermata Profilo

Ultima ma non meno importante schermata è quella relativa al profilo dell’utente, inizialmente con campi vuoti,
che una volta salvati, verranno caricati sempre dall’applicazione.

I dati richiesti dall’applicazione sono:

- Dati anagrafici
- Altezza
- Peso
- Obiettivo peso


Premendo sul pulsante “Salva” salviamo tutti i dati, se corretti, sul dispositivo. Possiamo sempre aggiornare
anche solo il nostro peso, così facendo potremo vedere i progressi nel tempo, l’applicazione terrà comunque
traccia delle vecchie misurazioni.

Premendo invece sul tasto “BMI” verrà mostrato un Pop Up che ci informerà su cosa è realmente ill Body
Mass Index, come viene calcolato e il risultato della stima.


## PROGETTAZIONE

### Classi

Per questo progetto ho utilizzato 16 classi (.swift) senza contare le classi AppDelegate e ViewController che
sono di default per un progetto creato su Xcode.

Vediamo una descrizione di ogni singola classe:

**1.** _ScheduleCell:_ figlia di UITableViewCell, cella specifica per _ScheduleListScreen_
**_2._** _WorkoutCell:_ figlia di UITableViewCell, cella specifica per _ScheduleScreen_
**_3._** _ExerciseCell:_ figlia di UITableViewCell, cella specifica per _ExerciseListScreen_
**_4._** _NewScheduleCell:_ figlia di UITableViewCell, cella specifica per _NewScheduleScreen_
**_5._** _ScheduleScreen:_ figlia di UIViewController, mostra gli esercizi della scheda selezionata
**_6._** _ExerciseScreen:_ figlia di UIViewController, mostra le informazioni dell’esercizio selezionato
**_7._** _ScheduleListScreen:_ figlia di UIViewController, mostra le schede della schermata Schede (principale)
**_8._** _ExerciseListScreen:_ figlia di UIViewController, mostra gli esercizi della schermata Esercizi
**_9._** _LiveWorkoutScreen:_ figlia di UIViewController, mostra l’allenamento della schermata Live Workout
**_10._** _NewScheduleScreen:_ figlia di UIViewController, mostra la schermata Crea
**_11._** _ProgressListScreen:_ figlia di UIViewController, mostra la schermata Progressi
**_12._** _PopUpAddExercise:_ figlia di UIViewController, mostra il Pop Up di creazione dell’esercizio personalizzato
**_13._** _PopUpBMI:_ figlia di UIViewController, mostra il Pop Up del BMI
**_14._** _ProfileScreen:_ figlia di UIViewController, mostra la schermata Profilo
**_15._** _Schedule:_ definisce la struttura di una scheda
**_16._** _Exercise:_ definisce la struttura di un esercizio

In più sono presenti le classi Main e LaunchScreen (.storyboard) per la definizione del layout dell’applicazione.


### Gestione dei dati e problemi relativi

I dati nell’applicazione vengono gestiti in locale; Swift mette a disposizione un proprio database (molto
semplificato anche se molto ostico) denominato CoreData. Il suo funzionamento è diretto dalle entities che
sono le nostre tabelle immaginare. Al loro interno possiamo definire gli attributi tipizzati (se si tratta di classi
complesse o definite da noi verranno etichettati come “Transformable”).

La parte più complessa del progetto a mio parere è stata la gestione simultanea dei dati in locale salvati e
quelli a runtime nell’applicazione, avendo a volte strutture dati differenti e quindi una difficile coordinazione tra
questi. Infatti durante lo sviluppo sono venuto a conoscenza che molte delle mie strutture dati che avevo
creato (come quella proposta nella classe Schedule) non potevo implementarle nel database di CoreData, o
magari si può ma non sono riuscito a trovare soluzioni. Quindi ho dovuto creare un database più “dispendioso”
a livello di risorse ma pur sempre funzionante, poiché invece di creare più entità per rappresentare una scheda
(come ad es. creare un’entità Scheda e un’altra EsercizioCustom) ho dovuto rappresentare tutto tramite
un’unica entità.

Infatti ogni record dell’entità “ _Workouts_ ” ha questi attributi:

- Exercise: nome dell’esercizio
- Pos: posizione nella scheda
- Reps: numero di ripetizioni
- Sets: numero di serie
- Rest: tempo di recupero
- Title: nome della scheda

Fortunatamente le altre due entità sono riuscito a rappresentarle più naturalmente, la prima “ _Exercises_ ”:

- Name: nome dell’esercizio
- Weight: pesi usati nell’esercizio (array)
- Date: date delle registrazioni dei pesi (array)

La seconda “ _Profile_ ”:

- Sex, Name, Surname, Age: dati anagrafici
- Height: altezza
- Weight: pesi corporei (array)
- Date: date delle misurazioni dei pesi (array)
- Goalweight: peso obiettivo


### Conclusioni e commenti finali

Questa esperienza di progetto per applicazioni mobili mi è piaciuta molto, mi sono divertito a sviluppare tutta
l’applicazione da zero, scoprire un nuovo linguaggio di programmazione, un nuovo IDE. Nonostante tutti i
problemi che sono sorti durante la fase di sviluppo è sempre bello vedere il prodotto ultimato. Certo lo vedo
più come un punto di partenza perché ci sarebbe ancora tanto da migliorare e ampliare. Magari un giorno
potrò pensare di metterla sull’AppStore, ma prima di ciò mi piacerebbe ancora spenderci altro tempo sopra.

Di sicuro è stato uno dei corsi che ha stimolato di più la mia creatività e passione per la programmazione.
