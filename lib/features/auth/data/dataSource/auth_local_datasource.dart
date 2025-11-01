import 'package:laghiny_chat/core/service/cache_service.dart';
import 'package:laghiny_chat/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();
  Future<void> removeCachedUser();
}

// ignore: constant_identifier_names
const String USER_CACHE_KEY = 'USER_CACHE_KEY';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService _cacheService;

  AuthLocalDataSourceImpl(this._cacheService);
  @override
  Future<void> cacheUser(User user) {
    return _cacheService.setString(USER_CACHE_KEY, user.toJson());
  }

  @override
  Future<User?> getCachedUser() async {
    final userJson = await _cacheService.getString(USER_CACHE_KEY);

    if (userJson == null) {
      return null;
    }

    return User.fromJson(userJson);
  }

  @override
  Future<void> removeCachedUser() {
    return _cacheService.remove(USER_CACHE_KEY);
  }
}