import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './SignupScreen.dart';

import '../providers/AuthProvider.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
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
                    onPressed: auth.isLoading
                        ? null
                        : () {
                            auth.login(
                                _emailController.text,
                                _passwordController.text,
                                _phoneController.text);
                            // Navigator.of(context).pushNamed(HomeScreen.routeName);
                          },
                    icon: Icon(Icons.arrow_forward),
                    label: auth.isLoading
                        ? CircularProgressIndicator()
                        : Text('Login')),
              ),
              Text('Or'),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignupScreen.routeName);
                },
                child: Text('Create an Account!'),
                textColor: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
