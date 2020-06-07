import 'package:flutter/material.dart';
import 'package:flutter_chat_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  highlightedBorderColor: Colors.green,
                  borderSide: BorderSide(color: Colors.black),
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          await auth.register(
                            _emailController.text,
                            _passwordController.text,
                            _usernameController.text,
                          );
                          Navigator.of(context).pop();
                        },
                  icon: Icon(Icons.arrow_forward),
                  label: auth.isLoading
                      ? CircularProgressIndicator()
                      : Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
