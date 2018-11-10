#include <stdio.h>

// implementado
float my_exp(float a, int b){
  float result = 1;

  while(b--){
    result*=a;
  }
  return result;
}


int main() {

  float entradaX;
  float arctan;
  float arccotg;
  float resultadoTemp = 0;
  float fatorCorrecaoCotg = 3.141592653589/2;
  float resultadoFinal = 0;
  int contadorSinal = 1;

  printf("Entre com o valor de X\n");
  scanf("%f", &entradaX);

  if (entradaX >= 0 && entradaX < 1){
    for ( int contadorIndice = 1; contadorIndice < 23; contadorIndice += 2) {
      if (contadorSinal == 1) {
          resultadoTemp = my_exp(entradaX,contadorIndice);
          resultadoFinal = resultadoTemp/contadorIndice;
          arctan = arctan + resultadoFinal;
          contadorSinal --;
      } else {
          resultadoTemp = my_exp(entradaX,contadorIndice);
          resultadoFinal = resultadoTemp/contadorIndice;
          arctan = arctan - resultadoFinal;
          contadorSinal ++;
      }
    }
    arccotg = (3.141592653589/2)-arctan;
    printf("O valor do arco cotangente é :\n");
    printf("%f", arccotg);
    printf("\n");
  }

  else if (entradaX >= 1) {
    for (int contadorIndice = 1; contadorIndice < 23; contadorIndice+=2){
      if(contadorSinal == 1){
        resultadoTemp = contadorIndice*(my_exp(entradaX,contadorIndice));
        resultadoFinal = 1/resultadoTemp;
        arctan = arctan - resultadoFinal;
        contadorSinal --;
      } else {
        resultadoTemp = contadorIndice*(my_exp(entradaX,contadorIndice));
        resultadoFinal = 1/resultadoTemp;
        arctan = arctan + resultadoFinal;
        contadorSinal ++;
      }
    }
    arccotg = fatorCorrecaoCotg - (fatorCorrecaoCotg + arctan);
    printf("O valor do arco cotangente é :\n");
    printf("%f", arccotg);
    printf("\n");
  }

  else{
    printf("Entrada Inválida");
  }


  return 0;
}
