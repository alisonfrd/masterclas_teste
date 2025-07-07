void main(List<String> args) {
  int altura = 2; // Altura em metros
  int peso = 80; // Peso em quilogramas

  double imc = imcCalc(altura, peso);
  print("O IMC é: $imc");
}

double imcCalc(int altura, int peso) {
  return peso / (altura * altura);
}
