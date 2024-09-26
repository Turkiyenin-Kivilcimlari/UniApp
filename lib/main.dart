import 'package:flutter/material.dart';
import 'package:unipp/firebase_options.dart';
import 'package:unipp/nav.dart';
import 'package:unipp/screens/Authenticate/login_screen.dart';
import 'package:unipp/screens/Chat/calls_chat.dart';
import 'package:unipp/screens/Chat/new_message_chat.dart';
import 'package:provider/provider.dart';
import 'screens/Authenticate/welcome_screen.dart';
import 'screens/Authenticate/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'root.dart';
import 'screens/Chat/chat_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationProvider>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Authenticate.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          // ChatScreen.id: (context) => ChatScreen(),
          NewMessageChat.id: (context) => const NewMessageChat(),
          ChatHome.id: (context) => const ChatHome(),
          CallsChat.id: (context) => const CallsChat(),
          Nav.id: (context) => const Nav(),
          Register.id: (context) => const Register(),
          Welcome.id: (context) => const Welcome(),
          Authenticate.id: (context) => const Authenticate(),
        },
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  static const id = 'auth';

  const Authenticate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Nav();
    }

    return const Welcome();
  }
}
