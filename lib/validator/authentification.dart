mixin InputAuthentification {
  bool isEmailValid(String value) => RegExp(r'\S+@\S+\.\S+').hasMatch(value);
  bool isInputLength(String value, int length) => value.length >= length;
}
