///Password Validation
String? validatePassword(String? value) {
  String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (!regex.hasMatch(value)) {
    return 'Password must be at least 8 characters,\ninclude uppercase letter,number,and special character.';
  }
  return null;
}