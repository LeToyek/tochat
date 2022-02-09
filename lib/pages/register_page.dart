import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tochat/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obsecureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Hero(
                    tag: 'ToChat',
                    child: Text(
                      'ToChat',
                      style: Theme.of(context).textTheme.headline5,
                    )),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
                controller: _passwordController,
                obscureText: _obsecureText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () => setState(() {
                              _obsecureText = !_obsecureText;
                            }),
                        icon: Icon(_obsecureText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    hintText: 'password')),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pop(context);
                } catch (e) {
                  final snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: Text('Register'),
              color: Colors.blue,
              textTheme: ButtonTextTheme.primary,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, LoginPage.id),
                child: Text('Already have account ? login here'))
          ],
        ),
      ),
    );
  }
}
