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

class SupabaseMock {
  final authSuccessResponse = '''
      {
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": {"id": "1", "email": "test@test.com"}
      }
    ''';
  final authErrorResponse = "{}";

  final authRequest = '[{"email":"test@test.com"}]';

  SupabaseMock() {
    registerFallbackValue(_MockUri());
    registerFallbackValue(_MockBaseRequest());
    registerFallbackValue(<String, String>{});
    registerFallbackValue(<String, dynamic>{});
  }

  SupabaseClient mockSuccessfulSignup() {
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

  SupabaseClient mockUnsuccessfulSignup() {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(authErrorResponse, 200));
    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSignupWithException() {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenThrow(Exception());

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient signinMock() {
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

  SupabaseClient mockFailedSignin() {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(authErrorResponse, 200));
    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSigninWithException() {
    final mockHttpClient = _MockHttpClient();

    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: "headers"),
        body: any(named: 'body'),
      ),
    ).thenThrow(Exception());

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockSelectTable(expected) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any())).thenAnswer((_) async =>
        http.StreamedResponse(
            Stream<List<int>>.value(utf8.encode(jsonEncode(expected))), 200,
            request: http.Request("GET", _MockUri()
        )
      )
    );

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }

  SupabaseClient mockInsertTable(expected) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any())).thenAnswer((_) async =>
        http.StreamedResponse(
            Stream<List<int>>.value(utf8.encode(jsonEncode(expected))), 200,
            request: http.Request("GET", _MockUri()
        )
      )
    );

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }


  SupabaseClient mockUpdateTable(expected) {
    final mockHttpClient = _MockHttpClient();

    when(() => mockHttpClient.send(any())).thenAnswer((_) async =>
        http.StreamedResponse(
            Stream<List<int>>.value(utf8.encode(jsonEncode(expected))), 200,
            request: http.Request("GET", _MockUri()
        )
      )
    );

    return SupabaseClient(
      "",
      "",
      authOptions: AuthClientOptions(pkceAsyncStorage: _AsyncStorage()),
      httpClient: mockHttpClient,
    );
  }
}
