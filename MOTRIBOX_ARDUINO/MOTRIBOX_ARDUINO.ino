/* ------------------------------------------------------------------------------------------
  TFG - Arduino | MOTRIBOX | Sistema tangible, interactiu i educatiu
  Grau de Tècniques d'Interacció Digital i Multimèdia, UOC

  ALEIX MARTÍN CUADRAS - 2023/24
  --------------------------------------------------------------------------------------------*/

/* *******************************************************************************************
 ***  IMPORTACIÓ DE LLIBRERIES  **************************************************************
 *********************************************************************************************/

// Llibreria Wire que permet la comunicació I2C entre l'Arduino i el sensor MPR121.
#include <Wire.h>

// Importació de la llibreria Adafruit_MPR121.h necessària per controlar el sensor tàctil capacitiu MPR121.
#include "Adafruit_MPR121.h"

/* *******************************************************************************************
 ***  DECLARACIÓ DE VARIABLES GLOBALS  *******************************************************
 *********************************************************************************************/

// Definició de la macro _BV que es fa servir en la llibreria del sensor capacitatiu MPR121.
#ifndef _BV
#define _BV(bit) (1 << (bit))
#endif

// Es crea un objecte anomenat "cap" de classe Adafruit_MPR121 per tal de cridar les funcions de la llibreria.
Adafruit_MPR121 cap = Adafruit_MPR121();

// Es declaren unes variables enteres de mida fixa de 16 bits:
uint16_t lasttouched;       // Estat dels pins tocats en el cicle anterior
uint16_t currtouched;       // Estat dels pins tocats en el cicle actual

// Es declara un conjunt de constants enteres per assignar a cada pin digital un nom, així serà més fàcil identificar-los en el codi, que no pas usant un número.
/* LEDS DE COLORS. S'utilitzen els pins 6,9,10 i 11, ja que proporcionen una sortida PWM (modulació de l'amplada de pols) que permet simular
   una sortida analògica, per tal de poder regular el voltatge de sortida i així canviar la intensitat lumínica de cada led.*/
const int pinLED_R = 10;      // LED Vermell connectat al pin digital 10
const int pinLED_G = 11;      // LED Verd connectat al pin digital 11
const int pinLED_B = 6;       // LED Blau connectat al pin digital 6
const int pinLED_Y = 9;       // LED Groc connectat al pin digital 9

// SENSOR ULTRASONS
const int s0pinTrigger = 3;   // Sensor Ultrasons 0 - Disparador (Trigger)
const int s0pinEcho = 2;      // Sensor Ultrasons 0 - Ressò (Echo)
const int s1pinTrigger = 5;   // Sensor Ultrasons 1 - Disparador (Trigger)
const int s1pinEcho = 4;      // Sensor Ultrasons 1 - Ressò (Echo)
const int s2pinTrigger = 8;   // Sensor Ultrasons 2 - Disparador (Trigger)
const int s2pinEcho = 7;      // Sensor Ultrasons 2 - Ressò (Echo)
const int s3pinTrigger = 13;  // Sensor Ultrasons 3 - Disparador (Trigger)
const int s3pinEcho = 12;     // Sensor Ultrasons 3 - Ressò (Echo)

// Variables enteres que guardaran la distància (valor de distàncies convertits en valors d'intensitat entre 255 i 0) que detecten els tres sensors d'ultrasons
int sensor0;   // Sensor Ultrasons Esquerra que proporciona un valor d'intensitat pel LED Vermell.
int sensor1;   // Sensor Ultrasons Superior que proporciona un valor d'intensitat pel LED Verd.
int sensor2;   // Sensor Ultrasons Dret que proporciona un valor d'intensitat pel LED Blau.
int sensor3;   // Sensor Ultrasons Inferior que proporciona un valor d'intensitat pel LED Groc.

// Variable booleana per indicar la seqüència inicial d'encesa del dispositiu.
boolean inici;

// Variable per guardar un valor de caràcter rebut del port en sèrie des de Processing a Arduino
char val;

/* *******************************************************************************************
 ***  FUNCIÓ SETUP   *************************************************************************
 *********************************************************************************************/
// Funció utilitzada per inicialitzar variables, objectes i descriure elements generals del programa.
void setup() {

  // S'obre una connexió en sèrie amb l'ordinador, per tal de veure valors que li passem.
  Serial.begin(9600);

  // S'inicialitza a 0 (0 = pin no tocat) l'estat dels pins tocats en el cicle anterior
  lasttouched = 0;
  // S'inicialitza a 0 (0 = pin no tocat) l'estat dels pins tocats en el cicle actual
  currtouched = 0;

  // S'inicialitza el sensor capacitatiu MPR121 amb l'adreça predeterminada del sensor a 0x5A i es comprova que està connectat correctament.
  if (!cap.begin(0x5A)) {
    // S'indica pel port sèrie que el sensor no s'ha trobat.
    Serial.println("MPR121 no s'ha trobat, comprovar el cablejat!");
    // En cas que la comunicació no s'ha establert, el programa queda en un bucle infinit, és a dir que el programa quedarà aturat en aquest punt del codi i no passarà a les línies inferiors.
    while (1);
  }

  // Es configuren els pins digitals dels leds perquè es comportin com a SORTIDA
  pinMode(pinLED_R, OUTPUT);
  pinMode(pinLED_G, OUTPUT);
  pinMode(pinLED_B, OUTPUT);
  pinMode(pinLED_Y, OUTPUT);

  // Es configuren els pins digitals a on tenim connectat el Trigger i Echo perquè es comportin com a:
  pinMode(s0pinTrigger, OUTPUT);  // Trigger --> SORTIDA
  pinMode(s0pinEcho, INPUT);      // Echo    --> ENTRADA
  pinMode(s1pinTrigger, OUTPUT);  // Trigger --> SORTIDA
  pinMode(s1pinEcho, INPUT);      // Echo    --> ENTRADA
  pinMode(s2pinTrigger, OUTPUT);  // Trigger --> SORTIDA
  pinMode(s2pinEcho, INPUT);      // Echo    --> ENTRADA
  pinMode(s3pinTrigger, OUTPUT);  // Trigger --> SORTIDA
  pinMode(s3pinEcho, INPUT);      // Echo    --> ENTRADA

  // Inicialitzem en true el valor d'inici, per tal d'indicar que es vol iniciar la seqüència de parpelleig inicial.
  inici = true;
}

/* *******************************************************************************************
 ***  FUNCIÓ LOOP   *************************************************************************
 *********************************************************************************************/
// Funció mitjançant la qual, mentre la placa Arduino estigui encesa, s'executarà contínuament el codi que conté.
void loop() {

  // SEQÜÈNCIA D'INICI: parpelleig dels leds de colors.
  // Si la variable inici és true (sempre que arrenqui el present programa), aleshores:
  if (inici) {
    // Es repeteix 3 cops l'encesa i apagada dels leds:
    for (int i = 0; i < 3; i++) {    // Variable local entera "i" per comptar el nombre de cops que portem, el valor de "i" s'incrementa des de 0 fins a 2 (3 cops).
      digitalWrite(pinLED_R, HIGH);  // LED Vermell encès amb la màxima intensitat
      digitalWrite(pinLED_G, HIGH);  // LED Verd encès amb la màxima intensitat
      digitalWrite(pinLED_B, HIGH);  // LED Blau encès amb la màxima intensitat
      digitalWrite(pinLED_Y, HIGH);  // LED Groc encès amb la màxima intensitat
      delay(400);                    // Detenció del programa uns ms
      digitalWrite(pinLED_R, LOW);   // LED Vermell apagat
      digitalWrite(pinLED_G, LOW);   // LED Verd apagat
      digitalWrite(pinLED_B, LOW);   // LED Blau apagat
      digitalWrite(pinLED_Y, LOW);   // LED Groc apagat
      delay(400);                    // Detenció del programa uns ms
    }
    // Es canvia el valor de la variable inici a false, per tal que la seqüència d'inici ja no es torni a executar més.
    inici = false;
  }

  // Es crida la funció ultrasons() 4 cops, un per cada sensor i s'assigna el valor que retorna a cadascuna de les següents variables:
  sensor0 = ultrasons(s0pinTrigger, s0pinEcho);   // Sensor Ultrasons Esquerra
  sensor1 = ultrasons(s1pinTrigger, s1pinEcho);   // Sensor Ultrasons Superior
  sensor2 = ultrasons(s2pinTrigger, s2pinEcho);   // Sensor Ultrasons Dret
  sensor3 = ultrasons(s3pinTrigger, s3pinEcho);   // Sensor Ultrasons Inferior

  /* S'encenen amb més o menys intensitat els leds en funció del valor de distància de cada sensor
     (es pot utilitzar analogWrite() perquè tenim els leds connectats en pins PWM, que són capaços de produir uns senyals analògics modulats)*/
  analogWrite(pinLED_R, sensor0);      // LED VERMELL
  analogWrite(pinLED_G, sensor1);      // LED VERD
  analogWrite(pinLED_B, sensor2);      // LED BLAU
  analogWrite(pinLED_Y, sensor3);      // LED Groc

  // S'envien un seguit de dades al port sèrie com a text.
  // Cada dada la separem amb una coma, per tal que el codi de Processing les pugui diferenciar a través d'un array [].
  Serial.print(sensor0);        // [0] --> Valor del Sensor Ultrasons Esquerra
  Serial.print(",");
  Serial.print(sensor1);        // [1] --> Valor del Sensor Ultrasons Superior
  Serial.print(",");
  Serial.print(sensor2);        // [2] --> Valor del Sensor Ultrasons Dret
  Serial.print(",");
  Serial.print(sensor3);        // [3] --> Valor del Sensor Ultrasons Inferior
  Serial.print(",");

  // S'obtenen els pads que actualment s'estan tocant
  currtouched = cap.touched();

  // Es comprova quins pads estan sent tocats:
  // PAD 1:  [4] --> Valor 0 o 1 per indicar si el pad 1 no està tocant-se o si
  if ((currtouched & _BV(1))  ) {           // En cas que el pad 1 sigui tocat, aleshores:
    Serial.print(1);                            // S'escriu pel port sèrie el valor 1
    Serial.print(",");                          // També s'escriu una coma per delimitar el final de l'element de l'array.
  } else if (!(currtouched & _BV(1)) )  {   // En cas contrari (no tocat), aleshores:
    Serial.print(0);                            // S'escriu pel port sèrie el valor 0
    Serial.print(",");                          // També s'escriu una coma per delimitar el final de l'element de l'array.
  }

  // PAD 2: [5]
  if ((currtouched & _BV(2))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(2)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 3: [6]
  if ((currtouched & _BV(3))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(3)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 4: [7]
  if ((currtouched & _BV(4))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(4)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 5: [8]
  if ((currtouched & _BV(5))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(5)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 6: [9]
  if ((currtouched & _BV(6))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(6)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 7: [10]
  if ((currtouched & _BV(7))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(7)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 8: [11]
  if ((currtouched & _BV(8))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(8)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 9: [12]
  if ((currtouched & _BV(9))  ) {
    Serial.print(1);
    Serial.print(",");
  } else if (!(currtouched & _BV(9)) )  {
    Serial.print(0);
    Serial.print(",");
  }

  // PAD 10: [13]
  if ((currtouched & _BV(10))  ) {
    Serial.print(1);
    Serial.println(",");
  } else if (!(currtouched & _BV(10)) )  {
    Serial.print(0);
    Serial.println(",");
  }

  // S'actualitza l'estat anterior dels pads del sensor MPR121 que han estat tocats
  lasttouched = currtouched;

  // Llegim les dades enviades des de Processing pel port en sèrie per tal d'activar o no els leds corresponents.
  if (Serial.available()) {       // Si tenim dades disponibles per llegir, aleshores:
    val = Serial.read();          // Es llegeixen i es guarden a la variable val

    // En funció del valor de val, s'activarà un led o un altre.
    switch (val) {
      // Si s'ha rebut una R, aleshores:
      case 'R':
        digitalWrite(pinLED_R, HIGH);         // LED Vermell encès amb la màxima intensitat
        break;
      // Si s'ha rebut una G, aleshores:
      case 'G':
        digitalWrite(pinLED_G, HIGH);         // LED Verd encès amb la màxima intensitat
        break;
      // Si s'ha rebut una B, aleshores:
      case 'B':
        digitalWrite(pinLED_B, HIGH);         // LED Blau encès amb la màxima intensitat
        break;
      // Si s'ha rebut una Y, aleshores:
      case 'Y':
        digitalWrite(pinLED_Y, HIGH);         // LED Groc encès amb la màxima intensitat
        break;
    }
  }
  delay(5);    // Esperem uns ms per no col·lapsar d'informació a Processing.
}
