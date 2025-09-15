import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

void main() {
  runApp(AlumniManagementApp());
}

class AlumniManagementApp extends StatelessWidget {
  const AlumniManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profileApiService = ProfileApiService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(apiService: profileApiService),
        ),
        BlocProvider<EducationBloc>(
          create: (_) => EducationBloc(apiService: profileApiService),
        ),
        // Add other blocs here if needed
      ],
      child: MaterialApp(
        title: 'Alumni Management',
        theme: AppTheme.lightTheme(),
        home: const ProfilePageWrapper(),
      ),
    );
  }
}

/// Wrapper widget to pass userId to ProfilePage
class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual user id you want to test
    const testUserId = 'user123';

    return OwnUserProfilePage(userId: testUserId);
  }
}

const String flagsmithApiKey = 'kseSsgyYkm5ujFZhJxeHK7';
