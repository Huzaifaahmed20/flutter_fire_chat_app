import 'package:flutter_chat_app/app/locator.dart';
import 'package:flutter_chat_app/app/router.gr.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  void navigateToSignUp() =>
      _navigationService.navigateTo(Routes.signupViewRoute);

  Future login({String email, String password}) async {
    setBusy(true);

    var result = await _authService.loginWithEmail(
      email: email,
      password: password,
    );

    if (result is bool) {
      if (result) {
        setBusy(false);
        _navigationService.replaceWith(Routes.dashboardViewRoute);
      } else {
        setBusy(false);
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      setBusy(false);
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }
}
