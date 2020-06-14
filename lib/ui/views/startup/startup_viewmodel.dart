import 'package:flutter_chat_app/app/locator.dart';
import 'package:flutter_chat_app/app/router.gr.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();

  Future handleStartUpLogic() async {
    bool hasLoggedInUser = await _authService.isUserLoggedIn();
    if (hasLoggedInUser) {
      _navigationService.replaceWith(Routes.dashboardViewRoute);
    } else {
      _navigationService.replaceWith(Routes.loginViewRoute);
    }
  }
}
