import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String text = "";
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Masukan Username';
              }
              text = value;
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: isShown ? false : true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShown = !isShown;
                  });
                },
                icon: Icon(isShown ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukan Password';
              }
              return null;
            },
          ),
          const SizedBox(height: 48.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Halo, $text'),
                      // backgroundColor: Colors.blue.shade900,
                      action: SnackBarAction(
                        textColor: Colors.white,
                        label: 'Tutup',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                  Navigator.pushNamed(context, HomePage.routeName);
                }
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 13.0,
                  bottom: 13.0,
                ),
                child: Text(
                  'Masuk',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          const Text("atau masuk dengan"),
          const SizedBox(height: 32.0),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(
                        side:
                            BorderSide(color: Colors.blue.shade600, width: 2.0),
                      ),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/icon/google.png'),
                      color: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Login dengan Google'),
                            // backgroundColor: Colors.blue.shade900,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Tutup',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(
                        side:
                            BorderSide(color: Colors.blue.shade600, width: 2.0),
                      ),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/icon/x.png'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Login dengan X'),
                            // backgroundColor: Colors.blue.shade900,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Tutup',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(
                        side:
                            BorderSide(color: Colors.blue.shade600, width: 2.0),
                      ),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/icon/facebook.png'),
                      color: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Login dengan Facebook'),
                            // backgroundColor: Colors.blue.shade900,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Tutup',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
