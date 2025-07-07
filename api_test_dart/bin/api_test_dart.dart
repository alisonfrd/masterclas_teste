void main(List<String> args) {
  double peso = 80; // Peso em quilogramas
  double altura = 1.75; // Altura em metros

  if (imcCalc(altura, peso) == 26.122448979591837) {
    print('OK: Deve calcular o IMC corretamente');
  } else {
    print('Error: Deve calcular o IMC corretamente');
  }

  try {
    imcCalc(0, peso);
    print('Error: Deve lançar uma exceção se a altura for zero');
  } catch (e) {
    print('OK: Deve lançar uma exceção se a altura for zero');
  }

  try {
    imcCalc(altura, 0);
    print('Error: Deve lançar uma exceção se o peso for zero');
  } catch (e) {
    print('OK: Deve lançar uma exceção se o peso for zero');
  }
}

double imcCalc(double altura, double peso) {
  if (altura <= 0) {
    throw ArgumentError("A altura deve ser maior que zero.");
  }
  if (peso <= 0) {
    throw ArgumentError("O peso deve ser maior que zero.");
  }
  return peso / (altura * altura);
}
