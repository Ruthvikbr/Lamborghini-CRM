import 'package:lamborghini/services/validators.dart';

enum SignInFormType { login, register }

class AccountRequest with MobileAndPasswordValidators {
  AccountRequest({
    this.mobile = "",
    this.password = "",
    this.signInFormType = SignInFormType.login,
    this.loading = false,
    this.submitted = false,
  });

  final String mobile;
  final String password;
  final SignInFormType signInFormType;
  final bool loading;
  final bool submitted;

  AccountRequest copyWith({
    String? mobile,
    String? password,
    SignInFormType? signInFormType,
    bool? loading,
    bool? submitted,
  }) {
    return AccountRequest(
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      signInFormType: signInFormType ?? this.signInFormType,
      loading: loading ?? this.loading,
      submitted: submitted ?? this.submitted,
    );
  }

  bool get canSubmit {
    return mobileValidator.isValid(mobile) &&
        passwordValidator.isValid(password) &&
        !loading;
  }

  String? get passwordErrorText {
    return submitted && !passwordValidator.isValid(password)
        ? "Enter a valid password"
        : null;
  }

  String? get mobileErrorText {
    return submitted && !mobileValidator.isValid(mobile)
        ? "Enter a valid mobile number"
        : null;
  }
}
