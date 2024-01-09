/*
 *    Classe Clock encarregada de calcular el temps que passa. Codi extret dels recursos d'aprenentatge de l'assignatura de 
      Digitalització de continguts: PID_00216125: Manau Galtés, Oriol., & Melenchón Maldonado, J. (2014). Processing Oriol Manau Galtés; 
      [l’encàrrec i la creació d’aquest material docent han estat coordinats pel professor: Javier Melenchón Maldonado]. 
      Universitat Oberta de Catalunya.
 */

class Clock {

  int time_now;
  int time_old;
  int time_delta_millis;
  float time_delta_sec;

  Clock() {
    time_now = 0;
    time_old = 0;
    time_delta_millis = 0;
  }

  void update() {
    time_now = millis();
    time_delta_millis = time_now - time_old;
    time_old = time_now;

    time_delta_sec = time_delta_millis / 1000.0;
  }

  int getDeltaMillis() {
    return time_delta_millis;
  }

  float getDeltaSec() {
    return time_delta_sec;
  }
}
