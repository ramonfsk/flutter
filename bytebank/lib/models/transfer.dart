class Transfer {
  final double value;
  final int numBalance;

  Transfer(this.value, this.numBalance);

  @override
  String toString() {
    return 'Transfer{value: $value, numBalance: $numBalance}';
  }
}