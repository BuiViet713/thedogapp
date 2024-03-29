import 'package:thedogapi/Cofig/Messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/core/navigation/routes.dart';
import 'package:thedogapi/pages/login.dart';
import 'package:thedogapi/pages/navbar_roots.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final auth = FirebaseAuth.instance;


  void loginWithEmail() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
      successMessage('Login Success');
      // Get.offAll(NavBarRoots());
      appRouter.pushNamedAndRemoveUntil(AppRoute.navBarRoots, (route) => false);
    } catch (ex) {
      print(ex);
      errorMessage("Error ! Try Agin");
    }
    isLoading.value = false;
  }

  void signout() async {
    await auth.signOut();
    successMessage('Logout');
    // Get.offAll(LoginPage());
    appRouter.pushNamedAndRemoveUntil(AppRoute.loginView, (route) => false);
  }

  void loginWithEmailPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      successMessage('Login Success');
      appRouter.pushNamedAndRemoveUntil(AppRoute.navBarRoots, (route) => false);
      // Get.offAll(NavBarRoots());
    } catch (e) {
      print(e);
      errorMessage("Error ! Try Again");
    } finally {
      isLoading.value = false;
    }
  }

  void signUpWithEmailPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      successMessage('Sign Up Success');
      appRouter.pushNamedAndRemoveUntil(AppRoute.navBarRoots, (route) => false);
      // Get.offAll(NavBarRoots());
    } catch (e) {
      print(e);
      errorMessage("Error ! Try Again");
    } finally {
      isLoading.value = false;
    }
  }

}
