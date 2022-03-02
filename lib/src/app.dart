import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3firebase/bloc/authentication/authentication_cubit.dart';
import 'package:project3firebase/src/pages/home_page.dart';

import '../bloc/authentication/authentication_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit(AuthRepository()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomePage(),
      ),
    );
  }
}
