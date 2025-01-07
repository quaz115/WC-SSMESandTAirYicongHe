

#include <stdio.h>

#include "calc.h"

int main(){
  int xxx = 1;
  
  calc(&xxx);

  fprintf(stdout,"xxx = %i\n",xxx);

}


