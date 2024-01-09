/* ------------------------------------------------------------------------------------------
 TFG - Arduino | MOTRIBOX | Sistema tangible, interactiu i educatiu
 Grau de Tècniques d'Interacció Digital i Multimèdia, UOC
 
 ALEIX MARTÍN CUADRAS - 2023/24
 --------------------------------------------------------------------------------------------*/

/* *******************************************************************************************
 ***  IMPORTACIÓ DE LLIBRERIES  **************************************************************
 *********************************************************************************************/

// Llibreria per la comunicació del port en sèrie.
import processing.serial.*;

// Llibreria Minim per l'àudio.
import ddf.minim.*;

// Llibreria Ani per fer animacions i transicions.
import de.looksgood.ani.*;

/* *******************************************************************************************
 ***  DECLARACIÓ DE VARIABLES GLOBALS  *******************************************************
 *********************************************************************************************/

// Variable del tipus Serial per establir una connexió en sèrie entre Processing i Arduino  
Serial myPort;

// Variable de tipus cadena de caràcters utilitzada per guardar les dades rebudes del port sèrie.
String dada;

// Declaració i inicialització d'un Array de 14 posicions per guardar els 14 valors del port sèrie.
int valors[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

// Diverses variables de punt flotant per guardar els valors de cada sensor d'ultrasons. 
int s0;     // Sensor 0 - Sensor Ultrasons Esquerra
int s1;     // Sensor 1 - Sensor Ultrasons Superior
int s2;     // Sensor 2 - Sensor Ultrasons Dret
int s3;     // Sensor 3 - Sensor Ultrasons Inferior

// Diverses variables enteres per guardar el valor de cada sensor tàctil.  
int pad0, pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9;

// Variable utilitzada per saber l'estat en què ens trobem: Tindrem 9 estats principals: 0:INTRO, 1:MENU, 2:CONFIG, 3:ACTIV1, 4:ACTIV2, 5:FIACTIV, 6:INFO, 7:SORTIR i 8: RETORN.
int mainState;  
// Variable utilitzada per guardar l'estat anterior al que ens trobem:
int mainStateAnterior;               

// Diverses constants enteres, una per cada estat:
final int INTRO = 0;         // Constant per l'estat 0: INTRO
final int MENU = 1;          // Constant per l'estat 1: MENU
final int CONFIG = 2;        // Constant per l'estat 2: CONFIG
final int ACTIV1 = 3;        // Constant per l'estat 3: ACTIVITAT 1
final int ACTIV2 = 4;        // Constant per l'estat 4: ACTIVITAT 2
final int FIACTIV = 5;       // Constant per l'estat 5: FIACTIV
final int INFO = 6;          // Constant per l'estat 6: INFO
final int SORTIR = 7;        // Constant per l'estat 7: SORTIR
final int RETORN = 8;        // Constant per l'estat 8: RETORN

// Variables del tipus PFont per emmagatzemar una tipografia.
PFont font1;  

// IMATGES
// Variables del tipus PImage, per carregar i dibuixar imatges del MENU, CONFIGURACIÓ O ESTAT INFO:
PImage  fonsIntro, logo, fonsCel, instruccions, panellConfig, panellInfo, panellFiActiv;
PImage botoActivitat1S, botoActivitat1NoS, botoActivitat2S, botoActivitat2NoS, botoInformesS, botoInformesNoS, botoConfS, botoConfNoS, botoExitS, botoExitNoS, hover1, hover2, hover3, hover4; 
PImage imgNuvol1, imgNuvol2, imgNuvol3, imgNuvol4, imgNuvol5;
PImage botoMusicaS, botoMusicaNoS, botoMusicaOFFS, botoMusicaOFFNoS, notes, notesNo ;

// Variables generals de l'estat 0: INTRO
float escalaLogo;    //  Variable per guardar el valor de l'escala del logo

// Variable myMinim del tipus Minim que ens permet utilitzar la llibreria Minim per l'àudio.
Minim myMinim;      

// Diferents variables del tipus AudioPlayer que ens permet carregar i executar un arxiu de so concret.
// MENU, CONFIGURACIO i FI ACTIVITAT
AudioPlayer musica, musica1, musica2, musica3, audiMotribox, pop, select, retorn, instrucMenu, missatge_GameOver;

// ACTIVITAT 1
AudioPlayer activ1_0, activ1_1, activ1_2, activ1_3, instrucEndevant, massaDits1, massaDits2; 
AudioPlayer hitOk, hitNo, agafat, fiu;
AudioPlayer obj1, obj2, obj3;

// ACTIVITAT 2
AudioPlayer activ2_0, activ2_1, activ2_2, electra, formaOk, rebot, estrella, explosio, tocOk;

// Variable clock del tipus Clock per controlar el temps que passa entre dues execucions de la funció draw().
Clock clock;

// Variables timer del tipus Timer per controlar el temps que ha passat en diferents estats o parts del codi.
Timer timer0_7segons, timer2segons, timer5segons, timer6segons, timer10segons, timerACTIV1, timerACTIV2;


// Declarem diversos objectes de tipus Boto, un per cada botó del programa
Boto boto1, boto2, boto3, boto4, boto5, boto1C, boto2C, boto3C, boto4C, boto1Cok, boto2Cok, boto3Cok, boto4Cok;           

// Variables enteres per conèixer el botó que tenim actiu actualment o seleccionat en diferents estats:
int botoActiuMENU;
int botoActiuCONFIG;
int botoSeleccionatCONFIG;

// Declarem diversos objectes de tipus Nuvols, un per cada núvol que apareixerà.
Nuvols nuvol1, nuvol2, nuvol3, nuvol4, nuvol5;

// Diverses constants enteres per guardar el valor en x i y de cada cercle que representa un sensor tàctil, en el cas de l'activitat 1: per on surten els talps, en le cas de l'activitat 2: uns cercles de color groc.
final int furat1X = 332;
final int furat2X = 450;
final int furat3X = 615;
final int furat4X = 783;
final int furat5X = 862;
final int furat6X = 1055;
final int furat7X = 1134;
final int furat8X = 1302;
final int furat9X = 1467;
final int furat10X = 1585;
final int furat1Y = 618;
final int furat2Y = 476;
final int furat3Y = 430;
final int furat4Y = 476;
final int furat5Y = 706;
final int furat6Y = 706;
final int furat7Y = 476;
final int furat8Y = 430;
final int furat9Y = 476;
final int furat10Y = 618;

// Array de 10 variables per poder relacionar el sensor objectiu amb cada posició en x a on tenim els furats/cercles.
int[] furatX = {furat1X, furat2X, furat3X, furat4X, furat5X, furat6X, furat7X, furat8X, furat9X, furat10X};

/* ***************************************************************************************************************
 ***** ACTIVITAT 1 *****
 *****************************************************************************************************************/
// Variables del tipus PImage, per carregar i dibuixar imatges:
PImage  fonsACTIV1Muntanyes, pedra, fonsFlors, talpSurt, talpTocat, talpElectric;

// Diverses variables enteres per controlar aspectes de l'activitat 1:
int nivell;                         // Nivell de joc
int talpObjectiu1;                  // Talp objectiu 1 (sensor tàctil objectiu)
int talpObjectiu2;                  // Talp objectiu 2 (sensor tàctil objectiu)
int objectiuUltrasons;              // Sensor d'ultrasons objectiu
int objectiu;                       // Objectius de distància per fer els moviments correctes en el nivell 3
int talpObjectiu1PosX;              // Posició en x del talp objectiu 1
int talpObjectiu2PosX;              // Posició en x del talp objectiu 2
int talpObjectiu1anterior;          // Talp objectiu 1 que s'ha tocat anteriorment
int talpObjectiu2anterior;          // Talp objectiu 1 que s'ha tocat anteriorment
int objectiuUltrasonsAnterior;      // Sensor d'ultrasons que s'ha activat anteriorment
int count;                          // Nombre de tocs dels sensors tàctils bons
int numTapsSimultanis;              // Nombre de sensors tàctils que s'estan activant simultàniament
int talpsBenTocats;                 // Nombre de talps ben tocats o nombre d'objectius aconseguits, necessaris per passar de nivell.
int moviments;                      // Nombre de moviments que s'han de realitzar per electritzar correctament el talp objectiu en el nivell 3
int movRestants;                    // Nombre de moviments restants a realitzar per complir amb l'objectiu d'electritzar el talp objectiu en el nivell 3
int anaritornar;                    // Comptabilitza els moviments per saber si s'han realitzat tots els demanats
int ultimFuratTocat;                // Conté l'últim sensor tàctil tocat

// Diveres variables booleanes:
boolean padsTotsTocats;             // Serà true quan s'hagin tocat tots els sensors tàctils
boolean talpObjectiu1Assolit;       // Serà true quan s'hagin tocat el talp de l'objectiu 1
boolean talpObjectiu2Assolit;       // Serà true quan s'hagin tocat el talp de l'objectiu 2
boolean errorFurat;                 // Serà true quan s'hagi deixat de tocat un furat no objectiu.

// Declarem un array de talp de classe Talps amb 2 talps. 
Talps[] talp =  new Talps[2];     

// VARIABLES PER CONTROLAR LES FLETXES DE COLORS:
// Variables enteres per les posicions en x i y dels triangles que formen la forma de les fletxes.
int posX1Triang, posY1Triang, posX2Triang, posY2Triang, posX3Triang, posY3Triang;
// Variables de colors, per indicar el color de cada fletxa.
color colorFletxE, colorFletxS, colorFletxD, colorFletxI;
// Declarem diversos objectes de tipus Fletxa, un per cada fletxa indicativa.
Fletxa fletxaEsquerra, fletxaSuperior, fletxaDreta, fletxaInferiro;

// Conté el temps que ha transcorregut en l'activitat 1.
int tempsACTIV1;       
// Guarda el temps més baix de totes les partides fetes en una mateixa cessió de joc de l'activitat 1.
int toptempsACTIV1;                
// Puntuació de l'activitat 1.
int puntuacioACTIV1;
// Màxima puntuació de l'activitat 1.
int maxPuntuacioACTIV1;
// Declaració de diverses variables de coma flotant:
float encertsActiv1;       // Nombre d'encerts de l'activitat 1
float erradesActiv1;       // Nombre d'errades de l'activitat 1
int puntuacioACTIV1temp;   // Útil per mantenir a l'estat INFO l'última puntuació obtinguda.
float erradesActiv1temp;   // Útil per mantenir a l'estat INFO les ultimes errades obtingudes.

/* ***************************************************************************************************************
 ***** ACTIVITAT 2 *****
 *****************************************************************************************************************/
// *** Variables FONS ESTRELLES *** 
// Nombre d'estrelles que es mostraran en el fons de l'activitat 2.
int numEstrelles;
// Array d'objectes de classe Estrella. 
Estrella[] estrelles;    

// *** Variables INFORMACIÓ VISUAL *** 
// Imatges de la icona de tornar al menú, les estrelles per indicar el nivell i del panell de l'activitat 2. 
PImage tornarMenu, estrellaBuida, estrellaPlena, panellActiv2;
// Imatges dels trios d'objectius encara no aconseguits.
PImage tresCercles, tresPentagons, tresQuadrats, tresTriangles;
// Array d'objectes de classe PImage utilitzades per guardar les imatges anteriors.
PImage[] triosGeometrics;

// *** Variables FORMES GEOMÈTRIQUES ***
// Imatges dels cercles de 4 colors. 
PImage cercleVermell, cercleVerd, cercleBlau, cercleGroc;
// Imatges dels triangles de 4 colors. 
PImage triangleVermell, triangleVerd, triangleBlau, triangleGroc;
// Imatges dels quadrats de 4 colors. 
PImage quadratVermell, quadratVerd, quadratBlau, quadratGroc;
// Imatges dels pentagons de 4 colors. 
PImage pentagonVermell, pentagonVerd, pentagonBlau, pentagonGroc;
// Array d'objectes de classe PImage utilitzades per guardar: 
PImage[] cercles;                      // Imatges dels cercles de 4 colors. 
PImage[] triangles;                    // Imatges dels triangles de 4 colors. 
PImage[] quadrats;                     // Imatges dels quadrats de 4 colors. 
PImage[] pentagons;                    // Imatges dels pentagons de 4 colors. 
PImage[][] formesGeometriques;         // Matriu bidimensional d'objectes de la classe PImage, per guardar les FORMES en una dimensió i el COLOR en l'altre.
PImage[] formesGeometriquesTotes;      // Totes les imatges de les formes geomètriques.
// Variables enteres: 
int maxFormes;                         // Nombre màxim de formes geomètriques.
int numFormes;                         // Nombre de formes actual.
int formaObjectiuFILA;                 // Valor de l'índex per les FILES de la matriu bidimensional. Determina la FORMA geomètrica: 0: Cercle, 1: Triangle, 2: Quadrat, 3: Pentàgon. 
int formaObjectiuCOLUMNA;              // Valor de l'índex per les COLUMNES de la matriu bidimensional. Determina el COLOR de la forma geomètrica: 0: Vermell, 1: Verd, 2: Blau, 3: Groc. 
// Array d'objectes enters utilitzades per guardar: 
int[] objectiusHistoricFILA;           // L'històric de les FORMES geomètriques.
int[] objectiusHistoricCOLUMNA;        // L'històric dels COLORS de les formes geomètriques.
// Variables enteres: 
int indexFILA;                         // Valor de l'índex per les FILES/FORMA de l'array objectiusHistoricFILA
int indexCOLUMNA;                      // Valor de l'índex per les COLUMNES/COLORS de l'array objectiusHistoricFILA.
// Declaració i inicialització d'arrays enters:
int[] formesAtzar = {0, 1, 2, 3};      // Amb 3 valors que representen: 0: Cercle, 1: Triangle, 2: Quadrat, 3: Pentàgon.  
int[] colorsAtzar = {0, 1, 2, 3};      // Amb 3 valors que representen: 0: Vermell, 1: Verd, 2: Blau, 3: Groc. 
int indexFormes;                       // Index que indica la FORMA geomètrica objectiu de l'array formesAtzar.
int indexColors;                       // Index que indica el COLOR de la forma geomètrica objectiu de l'array colorsAtzar.
// Array d'objectes de classe FormesGeometriques. 
FormesGeometriques[] formes;
// Array d'enters per guardar els objectius aconseguits.
int[] objectius;
// Index per l'array objectius.
int indexObjectiu;
// Varaible entera per guardar l'objecte forma tocat.
int formaTocada;  

// *** Variables NAU ***
PImage nau;                     // Imatge de la nau
float nauX, nauY, alturaNau;    // Variables de coma flotant per guardar el valor de la posició en x, y i l'altura de la nau.
float velXnau, velYnau;         // Velocitat en x i y de la nau.
int numParticles;               // Variable entera per guardar el valor del nombre de partícules (efecte de propulsió de la nau).
ParticulaNau[] particules;      // Array d'objectes de classe ParticulaNau. 

// *** ALTRES ***
// Declaració de diverses variables booleanes:
boolean formaAgafada;                                 // Per indicar si s'ha aconseguit agafar o no, la forma geomètrica objectiu.
boolean sensorTactilPolsat = false;                   // Per indicar si s'ha polsat o no, el sensor tàctil objectiu corresponent.
boolean barraFull = false;                            // Per indicar si s'ha omplert completament la barra d'ajuda (que elimina les formes gemètriques de la finestra gràfica que no són iguals que l'objectiu).
// Declaració de diverses variables enteres:
int numAgafats;                                       // Nombre d'objectes objectius agafats.
int triosAconseguits;                                 // Nombre de trios d'objectes aconseguits.
int barra;                                            // Valor d'omplerta de la barra.
int diamExplo;                                        // Diàmetre d'un cercle que imita una explosió.
int puntuacioACTIV2;                                  // Puntuació de l'activitat 2.
int maxPuntuacioACTIV2;                               // Màxima puntuació de l'activitat 2.
int furatObjectiu;                                    // Variable entera per guardar el valor del furat/sensor objectiu.
int furatObjectiuAnterior;                            // Variable entera per guardar el valor anterior del furat/sensor objectiu.
int tempsACTIV2;                                      // Conté el temps que ha transcorregut de l'activitat 2.
int toptempsACTIV2;                                   // Guarda el temps més baix de totes les partides fetes en una mateixa cessió de joc de l'activitat 2.
int puntuacioACTIV2temp;                              // Útil per mantenir a l'estat INFO l'última puntuació obtinguda.

// Declaració de diverses variables de coma flotant:
float encertsActiv2;                                  // Nombre d'encerts de l'activitat 2
float erradesActiv2;                                  // Nombre d'errades de l'activitat 2 
float erradesActiv2temp;                              // Útil per mantenir a l'estat INFO les últimes errades.

// FI ACTIVITAT 2

/* ***************************************************************************************************************
 ***** INFORMACIÓ ACTIVITATS *****
 *****************************************************************************************************************/

// Variable booleana usada per indicar si ja s'ha fet o no un registra de dades a l'arxiu .CSV
boolean registre;
// Diverses variables de tipus string per guardar el text que s'escriurà a l'arxiu .csv  
String data;
String hora;
String activitat;
String temps;
String recordTemps;
String puntuacio;
String recordPuntuacio;
String errades;
// Variable de classe PrintWriter que permet escriure dades a un arxiu de text
PrintWriter writer;
// Variable per emmagatzemar el nom de l'arxiu CSV
String nomFitxer;
// FI INFO

/* *******************************************************************************************
 ***  FUNCIÓ SETUP   *************************************************************************
 *********************************************************************************************/
// Funció utilitzada per inicialitzar variables, arrays i descriure elements generals del programa.
void setup() {
  //size(1920, 1080);        // Mida de la finestra gràfica (instrucció usada per programar)
  fullScreen();              // Pantalla completa
  frameRate(30);             // Nombre de fotogrames que es mostraran cada segon: 30
  noStroke();                // Sense traç
  textAlign(CENTER, CENTER); // Alineació horitzontal i vertical del text al centre.

  // S'inicialitzen les variables PFont amb la funció createFont, que carrega l'arxiu tipogràfic en cada variable
  font1= createFont("Gluten-Medium.ttf", 100);
  // Es defineix la tipografia del text de la variable font1 com la predefinida per tot el programa.
  textFont(font1);   

  // S'estableix la connexió entre Processing i Arduino, tot indicant que volem que es connecti pel tercer port sèrie de la llista a una velocitat de transmissió de 9600 bps.
  myPort = new Serial(this, Serial.list()[2], 9600);     //  [2] --> COM6

  // S'inicialitza l'objecte de la classe Minim amb el seu constructor.
  myMinim = new Minim(this);

  // S'inicialitza la biblioteca Ani.
  Ani.init(this);

  // S'inicialitza la variable clock sense cap paràmetre.
  clock = new Clock();              

  timer0_7segons = new Timer(0, 700);   // S'inicialitza la variable timer0_7segons amb dos paràmetres. És un cronòmetre que anirà des del valor 0 fins a 700 ms (0,7 segons).
  timer0_7segons.start (false);         // No es posa el cronòmetre en marxa.

  timer2segons = new Timer(0, 2000);    // Cronòmetre de 2 segons.
  timer2segons.start (false);           // No es posa el cronòmetre en marxa.

  timer5segons = new Timer(0, 5000);    // Cronòmetre de 5 segons.
  timer5segons.start (false);            // Es posa el cronòmetre en marxa perquè comenci a comptar.

  timer6segons = new Timer(0, 6000);    // Cronòmetre de 6 segons.
  timer6segons.start (true);            // Es posa el cronòmetre en marxa perquè comenci a comptar.

  timer10segons = new Timer(0, 10000);  // Cronòmetre de 10 segon.  
  timer10segons.start (false);          // No es posa el cronòmetre en marxa.

  timerACTIV1 = new Timer();            // Cronòmetre infinit per l'activitat 1 que començarà a comptar automàticament desde 0.
  timerACTIV1.start (false);            // No es posa el cronòmetre en marxa.

  timerACTIV2 = new Timer();            // Cronòmetre infinit per l'activitat 2 que començarà a comptar automàticament desde 0.
  timerACTIV2.start (false);            // No es posa el cronòmetre en marxa.

  // ES CARREGUEN IMATGES GENERALS 
  fonsIntro = loadImage ("fonsIntro.png");
  logo = loadImage ("logo.png");  
  fonsCel = loadImage ("fonsCel.png");
  instruccions = loadImage ("instruccions.png");
  imgNuvol1 = loadImage ("imgNuvol1.png");
  imgNuvol2 = loadImage ("imgNuvol2.png");
  imgNuvol3 = loadImage ("imgNuvol3.png");
  imgNuvol4 = loadImage ("imgNuvol4.png");
  imgNuvol5 = loadImage ("imgNuvol5.png");

  // ES CARREGUEN AUDIOS GENERALS 
  audiMotribox =  myMinim.loadFile("audiMotribox.mp3");
  pop = myMinim.loadFile("pop.mp3");
  select = myMinim.loadFile("select.mp3");
  retorn = myMinim.loadFile("retorn.mp3");
  instrucMenu = myMinim.loadFile("instrucMenu.mp3");
  musica1 = myMinim.loadFile("musica1.mp3");
  musica2 = myMinim.loadFile("musica2.mp3"); 
  musica3 = myMinim.loadFile("musica3.mp3"); 
  musica = musica1;     // La música que soni serà la que estigui a la variable musica
  musica.loop();        // Reproduïm en loop la cançó ubicada en música

  // MENU
  botoActivitat1S = loadImage ("botoActivitat1S.png");
  botoActivitat1NoS = loadImage ("botoActivitat1NoS.png");
  botoActivitat2S = loadImage ("botoActivitat2S.png");
  botoActivitat2NoS = loadImage ("botoActivitat2NoS.png");
  botoConfS = loadImage ("botoConfS.png");
  botoConfNoS = loadImage ("botoConfNoS.png");
  botoInformesS = loadImage ("botoInformesS.png");
  botoInformesNoS = loadImage ("botoInformesNoS.png");
  botoExitS = loadImage ("botoExitS.png");
  botoExitNoS = loadImage ("botoExitNoS.png");
  hover1 =  loadImage ("hover1.png");
  hover2 =  loadImage ("hover2.png");
  hover3 =  loadImage ("hover3.png");
  hover4 =  loadImage ("hover4.png");

  // CONFIGURACIÓ
  panellConfig = loadImage ("panellConfig.png");
  botoMusicaS = loadImage ("botoMusicaS.png");
  botoMusicaNoS = loadImage ("botoMusicaNoS.png");  
  botoMusicaOFFS = loadImage ("botoMusicaOFFS.png");
  botoMusicaOFFNoS = loadImage ("botoMusicaOFFNoS.png");
  notes = loadImage ("notes.png");
  notesNo = loadImage ("notesNo.png");

  // Construcció de diversos objectes de classe Boto
  //BOTONS MENÚ
  boto1 = new Boto(95, 380, botoActivitat1S, botoActivitat1NoS, true, 500);
  boto2 = new Boto(605, 380, botoActivitat2S, botoActivitat2NoS, false, 500);
  boto3 = new Boto(1115, 380, botoInformesS, botoInformesNoS, false, 500);  
  boto4 = new Boto(1625, 380, botoConfS, botoConfNoS, false, 240);
  boto5 = new Boto(1625, 630, botoExitS, botoExitNoS, false, 240);

  // S'inicialitza a 0 un conjunt de variables:
  botoActiuMENU = 0;
  botoActiuCONFIG = 0;
  botoSeleccionatCONFIG = 0;

  // Construcció de diversos objectes de classe Nuvols
  nuvol1 = new Nuvols(100, 80, imgNuvol1, 1);
  nuvol2 = new Nuvols(1500, 150, imgNuvol2, 0.5);
  nuvol3 = new Nuvols(300, 850, imgNuvol3, 1);
  nuvol4 = new Nuvols(960, 600, imgNuvol4, 0.5);
  nuvol5 = new Nuvols(1500, 900, imgNuvol5, 1);

  // BOTONS CONFIGURACIÓ
  boto1C = new Boto(280, 320, botoMusicaS, botoMusicaNoS, true, 390);
  boto2C = new Boto(680, 320, botoMusicaS, botoMusicaNoS, false, 390);
  boto3C = new Boto(1080, 320, botoMusicaS, botoMusicaNoS, false, 390);
  boto4C = new Boto(1500, 380, botoMusicaOFFS, botoMusicaOFFNoS, false, 150);
  boto1Cok = new Boto(370, 600, notes, notes, false, 0);
  boto2Cok = new Boto(770, 600, notes, notes, false, 0);
  boto3Cok = new Boto(1170, 600, notes, notes, false, 0);
  boto4Cok = new Boto(1530, 600, notes, notesNo, false, 0);

  // INFO
  panellInfo = loadImage ("panellInfo.png");

  // FI ACTIVITAT
  panellFiActiv = loadImage ("panellFiActiv.png");
  missatge_GameOver =  myMinim.loadFile("missatge_GameOver.mp3");

  // Factor de l'escala del logo
  escalaLogo = 0.8;      

  // S'inicialitza mainState per indicar que el primer estat que volem que aparegui sigui l'estat 0: INTRO, també s'inicialitza mainStateAnterior en l'estat 0. 
  mainState =  0;      
  mainStateAnterior = 0;

  /* ***************************************************************************************************************
   ***** ACTIVITAT 1 *****
   *****************************************************************************************************************/
  // ES CARREGUEN LES IMATGES
  fonsACTIV1Muntanyes = loadImage ("fonsACTIV1Muntanyes.png");
  pedra = loadImage ("pedra.png");
  fonsFlors = loadImage ("fonsFlors.png");
  talpSurt = loadImage ("talpSurt.png");
  talpTocat = loadImage ("talpTocat.png");
  talpElectric = loadImage ("talpElectric.png");

  // ES CARREGUEN ELS SONS
  activ1_0 = myMinim.loadFile("activ1_0.mp3");
  activ1_1 = myMinim.loadFile("activ1_1.mp3"); 
  activ1_2 = myMinim.loadFile("activ1_2.mp3"); 
  activ1_3 = myMinim.loadFile("activ1_3.mp3"); 
  instrucEndevant = myMinim.loadFile("instrucEndevant.mp3");
  massaDits1 = myMinim.loadFile("massaDits1.mp3");
  massaDits2 =  myMinim.loadFile("massaDits2.mp3");  
  hitOk = myMinim.loadFile("hitOk.mp3");   
  hitNo = myMinim.loadFile("hitNo.mp3"); 
  fiu = myMinim.loadFile("fiu.mp3");  
  agafat  = myMinim.loadFile("agafat.mp3"); 
  obj1 =  myMinim.loadFile("obj1.mp3");
  obj2 =  myMinim.loadFile("obj2.mp3");
  obj3 =  myMinim.loadFile("obj3.mp3");


  nivell = 0;

  // Canvi aleatori dels talps objectius 1 i 2 per tal que no coincideixin.
  do {     
    talpObjectiu1 = int(random(furatX.length));  
    talpObjectiu2 = int(random(furatX.length));
  } while (talpObjectiu1 == talpObjectiu2); 

  talpObjectiu1anterior = talpObjectiu1;
  talpObjectiu2anterior = talpObjectiu2;  


  objectiuUltrasons = int(random(1, 4));
  objectiuUltrasonsAnterior = objectiuUltrasons;
  objectiu = 0;
  talpObjectiu1PosX= furatX[talpObjectiu1]; 
  talpObjectiu2PosX = furatX[talpObjectiu2]; 

  // Construcció del primer i segon element de l'array d'objecte de classe Talps amb un seguit de paràmetres   
  talp[0] = new Talps(talpObjectiu1PosX, talpSurt);
  talp[1] = new Talps(talpObjectiu2PosX, talpSurt);

  count = 0; 

  numTapsSimultanis = 0; 
  talpsBenTocats = 0;
  moviments = 0;
  anaritornar = 0; 
  movRestants = moviments - anaritornar;  
  ultimFuratTocat = 0;  

  padsTotsTocats = false;    
  talpObjectiu1Assolit = false;
  talpObjectiu2Assolit = false;  
  errorFurat = false;

  // DEFINICIÓ DELS COLORS DE FARCIMENT DE LES FLETXES
  colorFletxE = color(255, 91, 77);
  colorFletxS = color(125, 200, 80);
  colorFletxD = color(95, 160, 220);
  colorFletxI = color(250, 250, 77);

  // CONSTRUCCIÓ DELS QUATRE OBJECTES de classe Fletxa 
  fletxaEsquerra = new Fletxa(25, height/2-225, 25, height/2+225, 125, height/2, colorFletxE);  
  fletxaSuperior = new Fletxa(width/2-225, 25, width/2+225, 25, width/2, 125, colorFletxS);
  fletxaDreta = new Fletxa(width-25, height/2-225, width-25, height/2+225, width-125, height/2, colorFletxD);
  fletxaInferiro = new Fletxa(width/2-225, height-25, width/2+225, height-25, width/2, height-125, colorFletxI);

  // DADES DE JOC 
  tempsACTIV1 = 0;  
  toptempsACTIV1 = 0;
  puntuacioACTIV1 = 0;
  maxPuntuacioACTIV1 = 0;
  puntuacioACTIV1temp = 0; 
  erradesActiv1temp = 0.0; 
  // FI ACTIVITAT 1

  /* ***************************************************************************************************************
   ***** ACTIVITAT 2 *****
   *****************************************************************************************************************/
  // *** INICIALITZACIÓ FONS ESTRELLES ***  
  numEstrelles = 200;                            // El nombre inicial d'estrelles serà de 200.  
  estrelles = new Estrella[numEstrelles];        // Inicialització d'un un array que tindrà tants elements com valgui el valor de numEstrelles.
  for (int i = 0; i < numEstrelles; i++) {
    estrelles[i] = new Estrella();               // Inicialització dels 200 objectes estrelles.
  }

  // *** INICIALITZACIÓ INFORMACIÓ VISUAL *** 
  // Inicialització de les imatges. Amb la funció loadImage es carreguen els diferents arxius d'imatge a la variable corresponent.
  tornarMenu = loadImage ("tornarMenu.png");
  estrellaBuida= loadImage ("estrellaBuida.png");
  estrellaPlena= loadImage ("estrellaPlena.png");
  panellActiv2= loadImage ("panellActiv2.png");
  tresCercles = loadImage ("tresCercles.png");
  tresPentagons = loadImage ("tresPentagons.png");
  tresQuadrats = loadImage ("tresQuadrats.png");
  tresTriangles = loadImage ("tresTriangles.png");
  // Inicialització d'un array d'imatges:
  triosGeometrics = new PImage[] {tresCercles, tresTriangles, tresQuadrats, tresPentagons};

  // *** INICIALITZACIÓ FORMES GEOMÈTRIQUES ***
  // Inicialització de les imatges. Amb la funció loadImage es carreguen els diferents arxius d'imatge a la variable corresponent. 
  cercleVermell = loadImage ("0,0.png");
  cercleVerd = loadImage ("0,1.png");
  cercleBlau = loadImage ("0,2.png");
  cercleGroc = loadImage ("0,3.png");
  triangleVermell = loadImage ("1,0.png");
  triangleVerd = loadImage ("1,1.png");
  triangleBlau = loadImage ("1,2.png");
  triangleGroc = loadImage ("1,3.png");
  quadratVermell = loadImage ("2,0.png");
  quadratVerd = loadImage ("2,1.png");
  quadratBlau = loadImage ("2,2.png");
  quadratGroc = loadImage ("2,3.png");
  pentagonVermell = loadImage ("3,0.png");
  pentagonVerd = loadImage ("3,1.png");
  pentagonBlau = loadImage ("3,2.png");
  pentagonGroc = loadImage ("3,3.png");

  // Inicialització dels array d'imatges:
  cercles = new PImage[] {cercleVermell, cercleVerd, cercleBlau, cercleGroc}; 
  triangles= new PImage[] {triangleVermell, triangleVerd, triangleBlau, triangleGroc}; 
  quadrats= new PImage[] {quadratVermell, quadratVerd, quadratBlau, quadratGroc}; 
  pentagons= new PImage[] {pentagonVermell, pentagonVerd, pentagonBlau, pentagonGroc};
  formesGeometriques = new PImage[][] {cercles, triangles, quadrats, pentagons};
  formesGeometriquesTotes = new PImage[] {cercleVermell, cercleVerd, cercleBlau, cercleGroc, triangleVermell, triangleVerd, triangleBlau, triangleGroc, quadratVermell, quadratVerd, quadratBlau, quadratGroc, pentagonVermell, pentagonVerd, pentagonBlau, pentagonGroc};
  maxFormes = 15;      // El nombre màxim d'objectes formes serà de 12.
  numFormes = 3;       // El nombre inicial d'objectes formes serà de 3.  

  // Inicialització d'un un array que tindrà tants elements com valgui el valor de maxFormes.
  formes = new FormesGeometriques[maxFormes];    
  for (int i = 0; i < numFormes; i++) {   
    // Inicialització dels 3 objectes formes.
    formes[i] = new FormesGeometriques();
  }

  // Elecció a l'atzar de les FORMES GEOMÈTRIQUES objectiu i guardat en un array. No es repetiran.
  for (int i = 0; i < formesAtzar.length - 1; i++) {    // Iteració pels 4 elements de l'array formesAtzar. 
    int index = int(random(i, formesAtzar.length));     // Generació d'un nombre enter, el 0, 1, 2 o 3. 0: Cercle, 1: Triangle, 2: Quadrat, 3: Pentàgon. 
    int temp = formesAtzar[i];                          // Es guarada temporalment l'element actual. 
    formesAtzar[i] = formesAtzar[index];                // Permutació d'elements.
    formesAtzar[index] = temp;                          // Restauració del valor inicial de formesAtzar[i].
  }

  // Elecció a l'atzar del COLORS de les formes geomètriques objectiu i guardat en un array. No es repetiran.
  for (int i = 0; i < colorsAtzar.length - 1; i++) {    // Iteració pels 4 elements de l'array colorsAtzar. 
    int index = int(random(i, colorsAtzar.length));     // Generació d'un nombre enter, el 0, 1, 2 o 3. 0: Vermell, 1: Verd, 2: Blau, 3: Groc. 
    int temp = colorsAtzar[i];                          // Es guarada temporalment l'element actual. 
    colorsAtzar[i] = colorsAtzar[index];                // Permutació d'elements.
    colorsAtzar[index] = temp;                          // Restauració del valor inicial de colorsAtzar[i].
  }

  indexFormes = 0;    // Index que indica la FORMA geomètrica objectiu, d'inici la primera de l'array formesAtzar.
  indexColors = 0;    // Index que indica el COLOR de la forma geomètrica objectiu, d'inici la 0 que serà la primera de l'array colorsAtzar.

  // La FORMA objectiu d'inici serà el valor indexFormes (la primera opció que s'ha permutat abans, per tant diferent a 0 o diferent a un cercle).
  formaObjectiuFILA = formesAtzar[indexFormes];
  // El COLOR objectiu d'inici serà el valor indexColors (la primera opció que s'ha permutat abans, per tant diferent a 0 o diferent al color vermell).
  formaObjectiuCOLUMNA = colorsAtzar[indexColors];

  // Variables OBJECTIUS   
  // array de 12 posicions, una per guadar cada objectiu
  objectiusHistoricFILA= new int[12];        // Inicialització d'un un array que tindrà 12 elements (3 objectius * 4 formes geomètriques).
  objectiusHistoricCOLUMNA= new int[12];     // Inicialització d'un un array que tindrà 12 elements (3 objectius * 4 colors). 
  indexFILA = 0;                             // Inicialització de l'index a 0, per indicar la posició 0.
  indexCOLUMNA = 0;                          // Inicialització de l'index a 0, per indicar la posició 0.

  objectius = new int[12];                        // Inicialització d'un un array que tindrà 12 elements, una per guadar cada objectiu aconseguits
  for (int i = 0; i < objectius.length; i++) {
    objectius[i] = 99;                            // Inicialització del valor inicial de cada element a 99.
  }

  indexObjectiu = 0;                              // Inicialització de l'index a 0, per indicar la posició 0.
  formaTocada = 0;                                // Inicialització de l'objecte que s'ha tocat a 0.

  // *** INICIALITZACIÓ NAU ***   
  nau = loadImage ("nau.png");                    // Inicialització de la imatge de la nau. Amb la funció loadImage es carrega l'arxiu d'imatge a la variable corresponent.
  nauX = width/2 ;                                // Posició inicial de la nau en x al centre.
  nauY = height-270;                              // Posició inicial de la nau en y quasi al centre.
  velXnau = 0.05;                                 // Velocitat de la nau en x de 0.04.
  velYnau = 0.05;                                 // Velocitat de la nau en y de 0.04.
  numParticles = 255;                             // El nombre inicial de partícules serà de 255. 
  particules = new ParticulaNau[numParticles];    // Inicialització d'un un array que tindrà tants elements com valgui el valor de numParticles.
  for (int i = 0; i < particules.length; i++) {        
    particules[i] = new ParticulaNau();           // Inicialització dels 255 objectes particules de classe ParticulaNau.
  }

  // Inicialització d'unes varibles boleanes:  
  formaAgafada = false;                           // Forma geomètrica objectiu NO agafada.
  sensorTactilPolsat = false;                     // Sensor tàctil objectiu NO polsat.
  barraFull = false;                              // Barra d'ajuda NO està completa.

  // Inicialització d'unes varibles enteres:
  numAgafats = 0;                                 // 0 objectius agafats.
  triosAconseguits= 0;                            // 0 trios d'objectius aconseguits.
  barra = 0;                                      // Barra sense omplir.
  diamExplo = 100;                                // Diametre de 100 px.

  // Inicialització de la variable furatObjectiu amb un valor aleatori, per indicar l'index de l'array furatX que serà objectiu.
  furatObjectiu = int(random(furatX.length));

  // Variable entera per guardar el valor anterior del furat/sensor objectiu. 
  furatObjectiuAnterior = furatObjectiu;

  // S'inicialitza l'objecte de la classe Minim amb el seu constructor
  myMinim = new Minim(this); 

  // Amb la funció loadFile es carreguen els diferents arxius d'àudio a la variable corresponent.
  activ2_0 = myMinim.loadFile("activ2_0.mp3");
  activ2_1 = myMinim.loadFile("activ2_1.mp3"); 
  activ2_2 = myMinim.loadFile("activ2_2.mp3"); 
  electra =  myMinim.loadFile("electra.mp3");
  formaOk =  myMinim.loadFile("formaOk.mp3");
  rebot =  myMinim.loadFile("rebot.mp3");
  estrella =  myMinim.loadFile("estrella.mp3");
  explosio =  myMinim.loadFile("explosio.mp3");
  tocOk = myMinim.loadFile("tocOk.mp3");

  // DADES DE JOC
  tempsACTIV2 = 0;  
  toptempsACTIV2 = 0;
  puntuacioACTIV2 = 0;   
  maxPuntuacioACTIV2 = 0;
  puntuacioACTIV2temp = 0; 
  erradesActiv2temp = 0; 
  encertsActiv2 = 0.0;                           
  erradesActiv2 = 0.0;      
  // FI ACTIVITAT 2

  /* ***************************************************************************************************************
   ***** INFORMACIÓ ACTIVITATS *****
   *****************************************************************************************************************/
  // Inicialitzem a false el valor de registre 
  registre = false;

  // Inicialització de les dades tipus string
  data = "";
  hora = "";
  activitat = "";
  temps= "";
  recordTemps= "";
  puntuacio= "";
  recordPuntuacio= "";
  errades= "";
  // FI INFORMACIÓ ACTIVITATS
}

/* *******************************************************************************************
 ***  FUNCIÓ DRAW   *************************************************************************
 *********************************************************************************************/
// Funció que actua com el motor del programa. Durant el temps que el programa estigui encès s'executarà contínuament el codi que conté
void draw() {

  // S'executa la funció update de clock, per tal d'anar calculant el temps que passa.
  clock.update();        

  // Estructura switch que serveix per identificar l'estat actual i cridar la funció que executa el codi associat a cada estat.  
  switch (mainState) {    // Si la variable mainState és igual a un dels següents estats, aleshores s'executarà una funció concreta.
  case INTRO:                 // Estat 0
    intro();                  // Funció per l'estat 0
    break;
  case MENU:                  // Estat 1
    menu();                   // Funció per l'estat 1
    break;
  case CONFIG:                // Estat 2
    config();                 // Funció per l'estat 2
    break;
  case ACTIV1:                // Estat 3
    activ1();                 // Funció per l'estat 3
    break;
  case ACTIV2:                // Estat 4
    activ2();                 // Funció per l'estat 4
    break;
  case FIACTIV:               // Estat 5
    fiActiv();                // Funció per l'estat 5
    break;
  case INFO:                  // Estat 6
    info();                   // Funció per l'estat 6
    break;
  case SORTIR:                // Estat 7
    sortir();                 // Funció per l'estat 7
    break;
  case RETORN:                // Estat 8
    retorn();                 // Funció per l'estat 8
    break;
  }

  // Controlem les dades d'ARDUINO
  if ( myPort.available() > 0) {            // Si hi han dades disponibles al port sèrie, aleshores:
    dada = myPort.readStringUntil('\n');    // S'assigna a la variable data la cadena de text del buffer del port sèrie, fins al salt de línia.
  } 

  if (dada != null) {                       // Si hi ha dades a la variable dada, aleshores:
    valors = int(split(dada, ','));         // Es converteix la cadena de caràcters que conté valors separats per comes en una matriu d'enters i es guarda a l'array valors.
  }

  // S'assignen les dades dels sensors guardades a l'array valors a diverses variables. 
  s0 = valors[0];      // ESQUERRA
  s1 = valors[1];      // SUPERIOR
  s2 =  valors[2];     // DRETA
  s3 =  valors[3];     // INFERIOR
  pad0 = valors[4];    // Dit 1
  pad1 = valors[5];    // Dit 2
  pad2 = valors[6];    // Dit 3
  pad3 = valors[7];    // Dit 4
  pad4 = valors[8];    // Dit 5
  pad5 = valors[9];    // Dit 6
  pad6 = valors[10];   // Dit 7
  pad7 = valors[11];   // Dit 8
  pad8 = valors[12];   // Dit 9
  pad9 = valors[13];   // Dit 10

  // Passem per consola una sèrie de variables per tal de monitorar el programa  
  println ("********************************************");
  println ("ESTAT: " + mainState);
  println ("ESTAT ANTERIOR: " + mainStateAnterior);
  // Si la variable mainState és igual a un dels següents estats, aleshores es mostra per consola el temps transcorregut si escau.
  switch (mainState) {    
  case INTRO:  // Estat 0
    println ("Temps: " + timer6segons.getTimeSec() + " segons");    // Temps transcorregut des de l'inici
    break;
  case ACTIV1: // Estat 3
    println ("Temps: " + timerACTIV1.getTimeSec() + " segons");    // Temps transcorregut des de l'inici
    break;
  case ACTIV2: // Estat 4
    println ("Temps: " + timerACTIV2.getTimeSec() + " segons");    // Temps transcorregut des de l'inici
    break;
  case SORTIR: // Estat 7
    println ("Temps: " + timer6segons.getTimeSec() + " segons");   // Temps transcorregut des de l'inici
    break;
  }
  println("botoActiuMENU: " + botoActiuMENU);
  print ("S0: " + valors[0]);
  print ("\t\tS1: " + valors[1]);
  println ("\t\tS2: " + valors[2]);
  println ("");
  println ("\t\tS3: " + valors[3]); 
  println ("PAD 1 : " + valors[4] + "\t \t \t PAD 6 : " + valors[9]);
  println ("PAD 2 : " + valors[5] + "\t \t \t PAD 7 : " + valors[10]);
  println ("PAD 3 : " + valors[6] + "\t \t \t PAD 8 : " + valors[11]);
  println ("PAD 4 : " + valors[7] + "\t \t \t PAD 9 : " + valors[12]);
  println ("PAD 5 : " + valors[8] + "\t \t \t PAD 10: " + valors[13]);  

  // INFO ACTIVITAT 1
  if (mainState == ACTIV1 || mainStateAnterior == ACTIV1 ) {
    println("**************** ACTIVITAT 1 ****************");  
    println("Nivell: " + nivell);
    println("Talps ben tocats: " + talpsBenTocats);
    println("padsTotsTocats: " + padsTotsTocats);
    println("Taps simultanis: " + numTapsSimultanis);
    println("ultimFuratTocat: " + ultimFuratTocat);
    println("Objectiu tàctil 1 : " + talpObjectiu1);
    println("Objectiu tàctil 2 : " + talpObjectiu2);
    println("Objectiu tàctil 1 anterior: " + talpObjectiu1anterior);
    println("Objectiu tàctil 2 anterior: " + talpObjectiu2anterior);
    println("Objectiu Ultrasons " + objectiuUltrasons);
    println("Objectiu Ultrasons anterior " + objectiuUltrasonsAnterior);
    println("Moviments: " + moviments);
    println("movRestants: " + movRestants);
    println("anaritornar: " + anaritornar);
    println("Objectiu distància: " + objectiu);  
    println("Temps Partida: " + tempsACTIV1);
    println("Top Temps: " + toptempsACTIV1); 
    println("botoActiuMENU: " + botoActiuMENU); 
    println("encertsActiv1: " + encertsActiv1); 
    println("erradesActiv1: " + erradesActiv1);     
    println ("*******************************************");
  }

  // INFO ACTIVITAT 2
  if (mainState == ACTIV2 || mainStateAnterior == ACTIV2 ) {
    println("**************** ACTIVITAT 2 ******************");
    println("numFormes: " + numFormes);  
    print("FORMA/FILA: " + "\t");
    for (int i = 0; i < 12; i++) {     

      print(objectiusHistoricFILA[i] + " ");
    }
    println("");
    print("COLOR/COLUMNA: " + "\t");
    for (int i = 0; i < 12; i++) {

      print(objectiusHistoricCOLUMNA[i]+ " ");
    }
    println(""); 
    print("OBJECTIU -> ");
    switch (formaObjectiuFILA) {    
    case 0:                   
      print ("CERCLE "); 
      break;
    case 1:
      print ("TRIANGLE "); 
      break;
    case 2:
      print ("QUADRAT "); 
      break;
    case 3:
      print ("PENTAGON "); 
      break;
    }
    switch (formaObjectiuCOLUMNA) {    
    case 0:                   
      print ("VERMELL"); 
      break;
    case 1:
      print ("VERD"); 
      break;
    case 2:
      print ("BLAU"); 
      break;
    case 3:
      print ("GROC"); 
      break;
    }
    println("");
    println("formaObjectiuFILA: " + "\t" + formaObjectiuFILA);
    println("formaObjectiuCOLUMNA: " + "\t" + formaObjectiuCOLUMNA);    
    println("furatObjectiuAnterior: " + furatObjectiuAnterior);
    println("furatObjectiu: " + furatObjectiu); 
    println("numAgafats:" + numAgafats);
    println("triosAconseguits: " + triosAconseguits);
    println("encertsActiv2: " + encertsActiv2);
    println("erradesActiv2: " + erradesActiv2);  
    println("puntuacioACTIV2: " + puntuacioACTIV2);
    println("maxPuntuacioACTIV2: " + maxPuntuacioACTIV2);  
    println("*****************************************");
  }
}
