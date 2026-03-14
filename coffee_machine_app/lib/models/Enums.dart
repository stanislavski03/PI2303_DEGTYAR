enum CoffeeType {
  espresso('Эспрессо'),
  americano('Американо'),
  cappuccino('Капучино'),
  latte('Латте');

  final String displayName;

  const CoffeeType(this.displayName);
}
