import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/views/signup/signup_viewmodel.dart';
import 'package:flutter_chat_app/ui/widgets/BusyButton.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  static const routeName = '/signup';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/splash.gif',
                height: 300,
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  enabled: !model.isBusy,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  enabled: !model.isBusy,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  enabled: !model.isBusy,
                  obscureText: model.hidePassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => model.togglePasswordValue(),
                      icon: Icon(
                          model.hidePassword ? Icons.enhanced_encryption : Icons.remove_red_eye),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              BusyButton(
                onPressed: () => model.signUp(
                  email: _emailController.text,
                  password: _passwordController.text,
                  name: _usernameController.text,
                ),
                busy: model.isBusy,
                enabled: !model.isBusy,
                title: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
