import 'package:flutter/material.dart';
import 'package:restaurant_app/common/custom_widget/form_login.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80.0),
                Text(
                  'Jelajah Kuliner',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 80.0),
                const FormLogin(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
