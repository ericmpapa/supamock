import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class _AsyncStorage extends GotrueAsyncStorage {
  var cache = {};
  @override
  Future<String?> getItem({required String key}) async {
    return cache[key];
  }

  @override
  Future<void> removeItem({required String key}) async {
    cache.remove(key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    cache[key] = value;
  }
}

class _MockHttpClient extends Mock implements http.Client {}

class _MockUri extends Mock implements Uri {}

class _MockBaseRequest extends Mock implements http.BaseRequest {}

class SupaMock {
  final authErrorResponse = "{}";
  final authRequest = '[{"email":"test@test.com"}]';

  SupaMock() {
    registerFallbackValue(_MockUri());
    registerFallbackValue(_MockBaseRequest());
    registerFallbackValue(<String, String>{});
    registerFallbackValue(<String, dynamic>{});
  }

  SupabaseClient mockSignup(
      {Map<String, String> connectedUser = const {
        "id": "0",
        "email": "test@test.com",
      }}) {
    final authSuccessResponse = '''
      {
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": ${jsonEncode(connectedUser)}
      }
    ''';

    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(authSuccessResponse, 200));

    when(
      () => mockHttpClient.send(any()),
    ).thenAnswer(
      (_) async => http.StreamedResponse(
        Stream<List<int>>.value(utf8.encode(authRequest)),
        200,
        request: http.Request("GET", _MockUri()),
      ),
    );
    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSignupWithException({
    Exception exception = const AuthException(""),
  }) {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenThrow(exception);

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSignin(
      {Map<String, dynamic> connectedUser = const {
        "id": "0",
        "email": "test@test.com",
      }}) {
    final authSuccessResponse = '''
      {
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": ${jsonEncode(connectedUser)}
      }
    ''';

    final mockHttpClient = _MockHttpClient();
    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(authSuccessResponse, 200));

    when(
      () => mockHttpClient.send(any()),
    ).thenAnswer((_) async => http.StreamedResponse(
          Stream<List<int>>.value(utf8.encode(authRequest)),
          200,
          request: http.Request("GET", _MockUri()),
        ));

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSigninWithException({
    Exception exception = const AuthException(""),
  }) {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenThrow(exception);

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSelectTable({
    List<Map<String, dynamic>> response = const [],
  }) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any())).thenAnswer(
      (_) async => http.StreamedResponse(
        Stream<List<int>>.value(utf8.encode(jsonEncode(response))),
        200,
        request: http.Request("GET", _MockUri()),
      ),
    );

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockInsertSelectTable({
    List<Map<String, dynamic>> reponse = const [],
  }) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any()))
        .thenAnswer((_) async => http.StreamedResponse(
              Stream<List<int>>.value(utf8.encode(jsonEncode(reponse))),
              200,
              request: http.Request("GET", _MockUri()),
            ));

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  /*SupabaseClient mockUpdateSelectTable({
    List<Map<String, dynamic>> response = const [],
  }) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any())).thenAnswer((_) async =>
        http.StreamedResponse(
            Stream<List<int>>.value(utf8.encode(jsonEncode(response))),
            200,
            request: http.Request("GET", _MockUri())));

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }*/
}

