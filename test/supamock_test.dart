import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supamock/supamock.dart';

void main() {
  late SupaMock supabaseMock;
  setUp(() {
    supabaseMock = SupaMock();
  });  
  group('A group of tests', () {
    test('test a successful signup', () async {
      final expected = AuthResponse.fromJson({
        "access_token": "0",
        "expire_in": 0,
        "refresh_token": "0",
        "token_type": "string",
        "user": {"id": "0", "email": "test@test.com"}
      });

      final signupClient = supabaseMock.mockSignup();

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
        "user": {"id": "0", "email": "test@test.com"}
      });

      final signupClient = supabaseMock.mockSignup();

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

      final selectClient = supabaseMock.mockSelectTable(response: expected);
      final actual = await selectClient.from("test_table").select();
      expect(actual, expected);
    });

    test('test a successful insert', () async {
      final expected = [{
          "val1": "0",
          "val2": 1
        }];

      final selectClient = supabaseMock.mockInsertSelectTable(reponse: expected);
      final actual = await selectClient.from("test_table").insert(expected).select();
      expect(actual, expected);
    });
  });
}

