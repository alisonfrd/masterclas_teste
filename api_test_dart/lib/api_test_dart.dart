double imcCalc(double altura, double peso) {
  if (altura <= 0) {
    throw Exception("A altura deve ser maior que zero.");
  }
  if (peso <= 0) {
    throw Exception("O peso deve ser maior que zero.");
  }
  return peso / (altura * altura);
}
