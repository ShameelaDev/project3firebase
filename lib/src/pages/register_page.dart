import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/authentication/authentication_cubit.dart';
import 'home_page.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool obscuretext = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    validator: (val) {
                      String data = val ?? '';
                      if (data.trim().isEmpty) {
                        return 'please give your name';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: "Enter your name",
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
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
                        labelText: "Enter your email",
                        hintText: "email@gmail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      String data = val ?? '';
                      if (data.isEmpty) {
                        return 'please give your Phone no';
                      } else if (data.length < 10) {
                        return "Phone no should be of 10 digits";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.phone),
                        labelText: "Enter your mobile no",
                        hintText: "+91 0000000000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    validator: (val) {
                      String data = val ?? "";
                      if (data.isEmpty) {
                        return "please re-enter password";
                      } else if (passwordController.text !=
                          confirmpasswordController.text) {
                        return "password not match please re-enter";
                      } else {
                        return null;
                      }
                    },
                    controller: confirmpasswordController,
                    obscureText: obscuretext,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: "Confirm password",
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
                  width: 200,
                  height: 50,
                ),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                  if (state is AuthenticationSucess) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomePage()));
                  } else if (state is AuthenticationError) {
                    Fluttertoast.showToast(msg: "Registration failed");
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
                            .registerWithEmailPassword(email, password);
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
