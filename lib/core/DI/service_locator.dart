import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:laghiny_chat/core/service/cache_service.dart';
import 'package:laghiny_chat/core/service/remote_auth_service.dart';
import 'package:laghiny_chat/core/service/remote_database_service.dart';
import 'package:laghiny_chat/features/auth/data/dataSource/auth_local_datasource.dart';
import 'package:laghiny_chat/features/auth/data/dataSource/auth_remote_database.dart';
import 'package:laghiny_chat/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:laghiny_chat/features/auth/data/repo/auth_repo_impl.dart';
import 'package:laghiny_chat/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:laghiny_chat/features/auth/presentation/repo/auth_repo.dart';

final sl = GetIt.instance;

void initServiceLocator(){
    sl.registerFactory(() => AuthCubit(sl()));


     sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
        authLocalDataSource: sl(),
        authRemoteDataSource: sl(),
        authRemoteDatabase: sl(),
      ));



  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDatabase>(
      () => AuthRemoteDatabaseImpl(sl()));



  sl.registerLazySingleton<RemoteAuthService>(
      () => RemoteAuthServiceImpl(FirebaseAuth.instance));
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl());
  sl.registerLazySingleton<RemoteDatabaseService>(
      () => RemoteDatabaseServiceImpl(FirebaseFirestore.instance));
}