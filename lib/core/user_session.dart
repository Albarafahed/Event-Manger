import 'dart:typed_data';
import '../models/user.dart';

class UserSession {
  static User? currentUser;
  static Uint8List? profileImageBytes;

  static void logout() {
    currentUser = null;
    profileImageBytes = null;
  }
}
