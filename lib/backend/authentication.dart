import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authentication {
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithApple() async {
    final appleIdCredential =
                    await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                  webAuthenticationOptions: WebAuthenticationOptions(
                    clientId: 'dev.nordify.wayawarelogin',
                    redirectUri: Uri.parse(
                      'https://wayaware-app.firebaseapp.com/__/auth/handler',
                    ),
                  ),
                );

                // get an OAuthCredential
                final credential = OAuthProvider('apple.com').credential(
                  idToken: appleIdCredential.identityToken,
                  accessToken: appleIdCredential.authorizationCode,
                );

                // use the credential to sign in to firebase
               return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}


