import 'package:clean_architecture_template/core/helper/regexes.dart';

abstract class EmailValidator {
  static bool isValid(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.isNotEmpty &&
        Regexes.isEmail.hasMatch(trimmed) &&
        trimmed.length <= 255;
  }
}

abstract class PasswordValidator {
  static bool isValid(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.length >= 8 && trimmed.length <= 255;
  }
}

abstract class OtpValidator {
  static bool isValid(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.length == 4 && Regexes.onlyNumber.hasMatch(trimmed);
  }
}

abstract class PhoneValidator {
  static bool isValid(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.length > 6 &&
        Regexes.onlyNumberAndPlusSign.hasMatch(trimmed);
  }
}

abstract class NameValidator {
  static bool isValid(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.length > 2 &&
        trimmed.length <= 255 &&
        Regexes.isName.hasMatch(trimmed) &&
        Regexes.containsLetters.hasMatch(trimmed);
  }

  static String? validate(String? value) {
    final isValueValid = isValid(value);
    if (!isValueValid) {
      if ((value?.length ?? 0) <= 2) {
        return 'Повинно бути більше 2 символів';
      } else {
        return 'В імені можуть бути тільки літери ';
      }
    }
    return null;
  }
}

abstract class PasswordConfirmValidator {
  static bool isValid(String? value, String passwordValue) {
    final trimmed = value?.trim() ?? "";
    final trimmedPassword = passwordValue.trim() ?? "";
    return trimmed == trimmedPassword;
  }
}
