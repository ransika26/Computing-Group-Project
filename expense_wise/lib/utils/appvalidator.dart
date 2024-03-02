class AppValidator {
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value.isEmpty) {
      return "Please enter a phone number";
    }
    if (value.length != 10) {
      return "Please enter a 10 digit phone number";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value.isEmpty) {
      return "Please enter a password";
    }

    return null;
  }

  String? validateUsername(value) {
    if (value == null || value.isEmpty) {
      return "Please enter a username";
    }
    return null;
  }
}
