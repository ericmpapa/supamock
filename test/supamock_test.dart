import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supamock/supamock.dart';

void main() {
  late SupabaseMock supabaseMock;
  setUp(() {
    supabaseMock = SupabaseMock();
  });  
  group('A group of tests', () {
    test('test a successful signup', () async {
      final expected = AuthResponse.fromJson({
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": {"id": "1", "email": "test@test.com"}
      });

      final signupClient = supabaseMock.mockSuccessfulSignup();

      final actual = await signupClient.auth.signUp(
        password: '',
        email: '',
      );

      expect(actual.session, expected.session);
      expect(actual.user, expected.user);
    });

    test('test a unsuccessful signup', () async {
      final expected = AuthResponse.fromJson({});

      final signupClient = supabaseMock.mockUnsuccessfulSignup();

      final actual = await signupClient.auth.signUp(
        password: '',
        email: '',
      );
      
      expect(actual.session, expected.session);
      expect(actual.user, expected.user);
    });

    test('test a unsuccessful signup', () async {
      final expected = AuthResponse.fromJson({});

      final signupClient = supabaseMock.mockUnsuccessfulSignup();

      final actual = await signupClient.auth.signUp(
        password: '',
        email: '',
      );
      
      expect(actual.session, expected.session);
      expect(actual.user, expected.user);
    });

    test('test a signup with an exception', () async {
      final signupClient = supabaseMock.mockSignupWithException();
      expect(
          () => signupClient.auth.signUp(password: '',email: '',),
          throwsA(const TypeMatcher<Exception>(),
        ),
      );
    });

    test('test a successful signin', () async {
      final expected = AuthResponse.fromJson({
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": {"id": "1", "email": "test@test.com"}
      });

      final signupClient = supabaseMock.mockSuccessfulSignup();

      final actual = await signupClient.auth.signInWithPassword(
        password: '',
        email: '',
      );

      expect(actual.session, expected.session);
      expect(actual.user, expected.user);
    });

    test('test a unsuccessful signin', () async {
      final expected = AuthResponse.fromJson({});

      final signupClient = supabaseMock.mockUnsuccessfulSignup();

      final actual = await signupClient.auth.signInWithPassword(
        password: '',
        email: '',
      );
      
      expect(actual.session, expected.session);
      expect(actual.user, expected.user);
    });

    test('test a signin with an exception', () async {
      final signupClient = supabaseMock.mockSignupWithException();
      expect(
          () => signupClient.auth.signInWithPassword(password: '',email: '',),
          throwsA(const TypeMatcher<Exception>(),
        ),
      );
    });

    test('test a successful select', () async {
      final expected = [{
          "val1": "0",
          "val2": 1
        }];

      final selectClient = supabaseMock.mockSelectTable(expected);
      final actual = await selectClient.from("test_table").select();
      expect(actual, expected);
    });

    test('test a successful select', () async {
      final expected = [{
          "val1": "0",
          "val2": 1
        }];

      final selectClient = supabaseMock.mockSelectTable(expected);
      final actual = await selectClient.from("test_table").select();
      expect(actual, expected);
    });

    test('test a successful insert', () async {
      final expected = [{
          "val1": "0",
          "val2": 1
        }];

      final selectClient = supabaseMock.mockInsertTable(expected);
      final actual = await selectClient.from("test_table").select();
      expect(actual, expected);
    });


    test('test a successful update', () async {
      final expected = [{
          "val1": "0",
          "val2": 1
        }];

      final selectClient = supabaseMock.mockUpdateTable(expected);
      final actual = await selectClient.from("test_table").select();
      expect(actual, expected);
    });

  });
}
