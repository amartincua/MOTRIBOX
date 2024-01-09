/* *******************************************************************************************
 ***  Funció ULTRASONS  **********************************************************************
 *********************************************************************************************/

// Funció utilitzada per controlar els sensors i obtenir la distància en què es troba un objecte davant seu.
int ultrasons(int pinTrigger, int pinEcho) {    // Dos paràmetres d'entrada
  // Declaració de variables locals per calcular la distància amb el sensor d'ultrasons
  long temps;     // Variable llarga per guardar el temps en què triga a viatjar una ona sonora des del sensor fins a rebotar contra l'objecte que tingui davant
  int distancia;  // Variable per calcular la distància a través del temps anterior i la velocitat del so.

  // Es genera un pols net, cada cop que el bucle del codi torna a començar:
  digitalWrite(pinTrigger, LOW);   // Deixem d'enviar ultrasons
  delayMicroseconds(4);            // Esperem uns microsegons

  // Es genera un tret d'ultrasons, tot deixant 10 microsegons abans de tornar a apagar el disparador
  digitalWrite(pinTrigger, HIGH);    // Disparem ultrasons
  delayMicroseconds(10);             // Esperem uns microsegons
  digitalWrite(pinTrigger, LOW);     // Deixem d'enviar ultrasons

  // Lectura del pinEcho a través de la funció pulseIn() que ens retorna el temps que ha trigat l'ona sonora en microsegons en anar i tornar al sensor.
  temps = pulseIn(pinEcho, HIGH);   // Guardem el valor a la variable temps

  // Càlcul de la distància, sabent que el TEMPS = DISTÀNCIA / VELOCITAT --> DISTÀNCIA = TEMPS * VELOCITAT
  /*  La velocitat serà la velocitat del so (340 m/s), ja que el sensor envia ultrasons. Per tal d'obtenir
      la distància en cm i poder operar amb el temps en us (microsegons) fem un canvi d'unitat --> 340 m/s = 0.034 cm/us
      Dividim entre 2 el temps, ja que es tracta del temps que els ultrasons han trigat a anar i tornar, i només
      necessitem el temps necessari fins que les ones xoquen contra un objecte. */
  distancia = (temps / 2) * 0.034;

  /* S'estableixen uns valors màxims i mínims pels sensors, ja que no ens interessa que mesuri més d'uns 25 cm (distància màxima
    en què un usuari en principi hauria d'interactuar amb el dispositiu).
    La distància mínima també es configura, ja que el sensor HC-SR04 segons el fabricant té un rang efectiu entre 2 i 500 cm i si s'està a menys de 2 cm
    obtenim problemes de lectura, per tant, s'ha posat 3 cm per anar segurs, a part la mà no es plana i en apropar-la al sensor de forma natural queda un espai buit .*/
  if (distancia > 25) {
    distancia = 25;
  } else if (distancia < 3) {
    distancia = 3;
  }

  /* Es converteixen les dades de distància recollides que oscil·len entre 3 i 25 cm amb unes noves dades que oscil·laran entre 255 i 0,
    així es pot controlar la intensitat lumínica de cada led, ja que els tenim connectats a pins que proporcionen una sortida PWM */
  distancia = map(distancia, 3, 25, 255, 0);

  return distancia;     // La funció ultrasons() ens retorna la distància de l'objecte que està davant del sensor d'ultrasons amb uns valors mapejats de 255 a 0.
}
