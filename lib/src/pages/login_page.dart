import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/authentication/authentication_cubit.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 200),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(val)) {
                        return 'please enter a valid Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.email),
                        labelText: "Enter your Email",
                        hintText: "Email@gmail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    validator: (val) {
                      String data = val ?? '';
                      if (data.isEmpty) {
                        return 'please give a password';
                      } else if (data.length < 5) {
                        return 'password length should not be less than 5 character';
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscuretext,
                    decoration: InputDecoration(
                        labelText: "password",
                        prefixIcon: const Icon(Icons.lock),
                        suffix: obscuretext
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscuretext = false;
                                  });
                                },
                                icon: const Icon(Icons.visibility))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscuretext = true;
                                  });
                                },
                                icon: const Icon(Icons.visibility_off)),
                        contentPadding: const EdgeInsets.all(4),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                    onPressed: () {}, child: const Text("forgot password?")),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                  if (state is AuthenticationSucess) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomePage()));
                  } else if (state is AuthenticationError) {
                    Fluttertoast.showToast(msg: "Login failed");
                  }
                }, builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        BlocProvider.of<AuthenticationCubit>(context)
                            .loginWithEmailPassword(email, password);
                      },
                      child: const Text('login'),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
