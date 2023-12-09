import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCurrentUser();
    });
  }

    Future<void> checkCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? userId ="1234xx";
      final String? username = user.displayName;
      final String? email = user.email;
      final String? profilepicture = user.photoURL;
      print(">>>>>>>>>>>>>>>>>>>>User IDx: $userId");
      print("User is logged in already");
      print("Username: $username");
      print("Email: $email");
      print("Profile Picture: $profilepicture");
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: {
            'username': username ?? '',
            'email': email ?? '',
            'profilepicture': profilepicture ?? '',
          },
        );
      }
    }
  }


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool circular = false;

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFFFD746C), Color(0xFFFF9068), Color(0xFFFD746C)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // logo image here
              Image(
                  image: AssetImage("assets/icon/logo.png"),
                  width: 200,
                  height: 200),
              const SizedBox(height: 20),
              buttonItem("assets/google.svg", "Continue with Google", 25, () {
                handleGoogleSignIn();
              }),
              const SizedBox(height: 15),
              buttonItem("assets/phone.svg", "Continue with Phone", 30, () {}),
              const SizedBox(height: 10),
              const Text("Or",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              const SizedBox(height: 10),
              textItem("Email", _emailController, false),
              const SizedBox(height: 15),
              textItem("Password", _passwordController, true),
              const SizedBox(height: 15),
              colorButton("Login"),
              const SizedBox(height: 15),
              const SizedBox(height: 10),
              const Text(
                "Forgot Password ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleGoogleSignIn() async {
    User? user = await signInWithGoogle();
    if (user != null) {
      final String? userId = user.uid;
      final String? username = user.displayName;
      final String? email = user.email;
      final String? profilepicture = user.photoURL;
      print(">>>>>>>>>>>>>>>>>>>>User IDs: $userId");
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: {
            'username': username ?? '',
            'email': email ?? '',
            'profilepicture': profilepicture ?? '',
          },
        );
      }
    }
  }

  Future<User?> signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    print("xxxx user: ");
    print(user);
    return user;
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          elevation: 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              const SizedBox(width: 15),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String name, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name) {
    return InkWell(
      onTap: () async {
        // Your login logic here
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: buttonGradient,
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : Text(name,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}

class FirebaseFirestore {
}
