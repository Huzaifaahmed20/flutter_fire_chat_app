import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/views/signup/signup_viewmodel.dart';
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
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                    obscureText: true,
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
                        : () => model.signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _usernameController.text,
                            ),
                    icon: Icon(Icons.arrow_forward),
                    label: model.isBusy
                        ? CircularProgressIndicator()
                        : Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
