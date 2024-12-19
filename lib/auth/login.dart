import 'package:allevents_task/auth/authFunctions.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String password = '';
  bool isLogin = true;
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ============= Full Name ====================//
              isLogin
                  ? Container()
                  : TextFormField(
                      key: const ValueKey('name'),
                      decoration:
                          const InputDecoration(hintText: 'Enter Full Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Full Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        setState(() {
                          name = newValue!;
                        });
                      },
                    ),

              // ============= Email ====================//
              TextFormField(
                key: const ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter Email',prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter Valid Email';
                  } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Please Enter Valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  setState(() {
                    email = newValue!;
                  });
                },
              ),

              // ============= Password ====================//
              TextFormField(
                key: const ValueKey('password'),
                decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscured = !_obscured;
                        });
                      },
                      icon: Icon(
                        _obscured
                            ? Icons.visibility
                            : Icons.visibility_off, // Dynamic icon
                      ),
                    )),
                obscureText: _obscured,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password should Contain atleast 6 characters';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  setState(() {
                    password = newValue!;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      isLogin
                          ? AuthServices.signin(email, password, context)
                          : AuthServices.signup(email, password, name, context);
                    }
                  },
                  child: Text(isLogin ? 'Login' : 'Signup')),

              isLogin
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: const Text('Dont have an account??'))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
