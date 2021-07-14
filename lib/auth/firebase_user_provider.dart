import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MYTaskFirebaseUser {
  MYTaskFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

MYTaskFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MYTaskFirebaseUser> mYTaskFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MYTaskFirebaseUser>((user) => currentUser = MYTaskFirebaseUser(user));
