import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/AuthProvider.dart';
import './providers/ChatProvider.dart';

import './screens/HomeScreen.dart';
import './screens/SignupScreen.dart';
import './screens/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FireChat',
        home: MainApp(),
        routes: {
          SignupScreen.routeName: (_) => SignupScreen(),
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<FirebaseUser>(
        stream: auth.isAuth,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Splash screen will be here
          } else {
            if (snapshot.hasData) {
              return HomeScreen(snapshot.data);
            }
            return LoginScreen();
          }
        });
  }
}
