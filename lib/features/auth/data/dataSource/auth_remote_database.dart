import 'package:laghiny_chat/core/service/remote_database_service.dart';
import 'package:laghiny_chat/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatabase {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}

class AuthRemoteDatabaseImpl implements AuthRemoteDatabase {
  final RemoteDatabaseService _remoteDatabaseService;

  AuthRemoteDatabaseImpl(this._remoteDatabaseService);

  @override
  Future<User> getUser(String id) {
    return _remoteDatabaseService.get("users/$id", User.fromMap);
  }

  @override
  Future<void> saveUser(User user) {
    return _remoteDatabaseService.set(
      "users/${user.id}",
      user,
      (user) => user.toMap(),
    );
  }
}