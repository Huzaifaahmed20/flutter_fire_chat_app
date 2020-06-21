import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/views/login/login_viewmodel.dart';
import 'package:flutter_chat_app/ui/widgets/BusyButton.dart';
import 'package:stacked/stacked.dart';
// import './SignupScreen.dart';
// import '../providers/AuthProvider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Login',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/splash.gif',
                height: 300,
                width: 300,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: TextField(
              //     keyboardType: TextInputType.phone,
              //     controller: _phoneController,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       prefixIcon: Icon(
              //         Icons.phone,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
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
                  obscureText: model.hidePassword,
                  enabled: !model.isBusy,
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
                onPressed: () => model.login(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
                busy: model.isBusy,
                enabled: !model.isBusy,
                title: 'Log in',
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Or'),
              )),
              FlatButton(
                onPressed: () => model.navigateToSignUp(),
                child: Text('Create an Account!'),
                textColor: Colors.blue,
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
