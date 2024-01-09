/*
 *    Classe Timer encarregada de crear un cronòmetre adaptable a qualsevol quantitat de temps.
      Codi extret dels recursos d'aprenentatge de l'assignatura de 
      Digitalització de continguts: PID_00216125: Manau Galtés, Oriol., & Melenchón Maldonado, J. (2014). Processing Oriol Manau Galtés; 
      [l’encàrrec i la creació d’aquest material docent han estat coordinats pel professor: Javier Melenchón Maldonado]. 
      Universitat Oberta de Catalunya.
 */

class Timer {

  boolean up;          // Variable que ens indica si haurem de sumar o restar el temps que ha passat.
  int startPoint;      // Variable a on guardarem el Temps inicial 
  int endPoint;        // Variable a on guardarem el Temps final 
  boolean counting;    // Variable a on guardarem si el cronòmetre està actualment en marxa o parat
  int currentTime;     // Variable a on guardarem el temps actual

  Timer() {            
    up = true;
    startPoint = 0;
    endPoint = 0;
    counting = false;
    currentTime = startPoint;
  }

  Timer (int sPoint, int ePoint) {
    startPoint = sPoint;
    endPoint = ePoint;

    if (startPoint <= endPoint) {
      up = true;
    } else {
      up = false;
    }

    currentTime = startPoint;
  }
  
  // Funció per deixar els valors inicials que hem definit i parar el cronòmetre
  void reset () {                                
    currentTime = startPoint;
    counting = false;
  }
  
  // Funció per definir el temps inicial i final
  void setPoints (int sPoint, int ePoint) {      
    startPoint = sPoint;
    endPoint = ePoint;

    if (startPoint <= endPoint) {
      up = true;
    } else {
      up = false;
    }

    currentTime = startPoint;
  }
  
  // Funció a on li passem els ms que han passat per actualitzar el comptador del cronòmetre (només s'actualitzarà el valor si està comptant)
  void update (int millis) {            
    if (counting) {
      if (up) {
        currentTime += millis;
      } else {
        currentTime -= millis;
      }
    }
    if (getFinish()) {
      counting = false;
    }
  }
  
  // Funció per engegar o parar el comptador
  void start (boolean onoff) {           
    counting = onoff;
  }

  int getTimeMillis () {
    return currentTime;
  }

  float getTimeSec () {
    return (currentTime / 1000.0);
  }
  
  // Funció que ens indica si hem arribat al final, per poder controlar l'estat del cronòmetre.
  boolean getFinish() {                 
    if (up) {
      if (currentTime >= endPoint) {
        return true;
      } else {
        return false;
      }
    } else {
      if (currentTime <= endPoint) {
        return true;
      } else {
        return false;
      }
    }
  }
}
