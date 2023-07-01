// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shoping/app/providers/user_provider.dart';
// import 'package:shoping/app/screens/Auth_screen.dart';
// import 'package:shoping/app/screens/admin_screen.dart';
// import 'package:shoping/app/services/Auth_servics.dart';
// import 'package:shoping/components/decortion.dart';
// import 'package:shoping/router.dart';
// import 'app/widgets/custem_butten_bar.dart';
//
// void main() async {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => UserProvider(),
//         )
//       ],
//       child: const spalsh(),
//     ),
//   );
// }
//
// // ignore: camel_case_types
// class spalsh extends StatefulWidget {
//   const spalsh({Key? key}) : super(key: key);
//   @override
//   State<spalsh> createState() => _spalshState();
// }
//
// // ignore: camel_case_types
// class _spalshState extends State<spalsh> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     final Authservics authservics = Authservics();
//     authservics.getUserdata(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       title: 'eazeet',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Decortion.backgruondColor,
//         colorScheme: const ColorScheme.light(
//           primary: Decortion.secondergray,
//         ),
//         appBarTheme: const AppBarTheme(elevation: 0),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       onGenerateRoute: (settings) => generatRoute(settings),
//       home: Provider.of<UserProvider>(context).user.token.isNotEmpty
//           ? Provider.of<UserProvider>(context).user.name=='user'
//           ? const BottomBar()
//           :const AdminScreen()
//           : const AuthScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/dart_screen.dart';
import 'package:shoping/app/services/Auth_servics.dart';
import 'package:shoping/components/decortion.dart';
import 'package:shoping/router.dart';
import 'app/widgets/animait_add_abar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authservics authService = Authservics();
  @override
  void initState() {
    super.initState();
    authService.getUserdata(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon clone',
      theme: ThemeData(
          scaffoldBackgroundColor: Decortion.backgruondColor,
          colorScheme: const ColorScheme.light(
            primary: Decortion.secondergray,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                  color: Color(0xff3B3B3B)))),
      onGenerateRoute: (settings) => generatRoute(settings),
      home: Builder(builder: (context) {
        return FutureBuilder(
          future: authService.getUserdata(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? const BottomNavBar()
                  : const DartScreen();
            }
            return  Container(
              color: Colors.white,
              child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 12,
                    backgroundColor: Colors.indigoAccent,
                  )),
            );
          },
        );
      }),
    );
  }
}
// home: Builder(builder: (context) {
// return FutureBuilder(
// future: authService.getUserData(context),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.done) {
// return Provider.of<UserProvider>(context).user.token.isNotEmpty
// ? const BottomBar()
//     : const AuthScreen();
// }
// return const Center(child: CircularProgressIndicator());
// },
// );
// }),

