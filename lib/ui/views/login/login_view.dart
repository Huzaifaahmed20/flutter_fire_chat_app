import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/views/login/login_viewmodel.dart';
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
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  padding: const EdgeInsets.all(20.0),
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
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    enabled: !model.isBusy,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: OutlineButton.icon(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    highlightedBorderColor: Colors.green,
                    borderSide: BorderSide(color: Colors.black),
                    onPressed: model.isBusy
                        ? null
                        : () => model.login(
                            email: _emailController.text,
                            password: _passwordController.text),
                    icon: Icon(Icons.arrow_forward),
                    label: model.isBusy
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                ),
                Text('Or'),
                FlatButton(
                  onPressed: () => model.navigateToSignUp(),
                  child: Text('Create an Account!'),
                  textColor: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
