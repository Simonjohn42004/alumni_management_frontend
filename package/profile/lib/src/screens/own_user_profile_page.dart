import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/bloc/profile/profile_events.dart';
import 'package:profile/src/bloc/profile/profile_state.dart';
import 'package:profile/src/screens/edit_profile_page.dart';
import 'package:profile/src/screens/profile_skeleton.dart';
import 'package:profile/src/widgets/education_list.dart';
import 'package:profile/src/widgets/profile_header.dart';
import 'package:profile/src/widgets/profile_info_field.dart';
import 'package:profile/src/widgets/skills_section.dart';

class OwnUserProfilePage extends StatelessWidget {
  final String userId;

  const OwnUserProfilePage({super.key, required this.userId});
  void _onEditPressed(BuildContext context, String userId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider<EducationBloc>.value(
          value: context.read<EducationBloc>(),
          child: EditProfilePage(userId: userId),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProfileBloc>().add(LoadProfileById(userId));
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Optional: let Bloc process
  }

  @override
  Widget build(BuildContext context) {
    // Load own user profile from bloc
    context.read<ProfileBloc>().add(LoadProfileById(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onEditPressed(context, userId),
        tooltip: 'Edit Profile',
        child: const Icon(Icons.edit),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const ProfileSkeleton();
          } else if (state is ProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ListView(
                  children: [
                    ProfileHeader(
                      fullName: user.fullName,
                      profilePictureUrl:
                          "https://randomuser.me/api/portraits/women/72.jpg",
                      roleName: roleNames[user.roleId] ?? 'Unknown',
                    ),
                    const SizedBox(height: 16),
                    ProfileInfoField(
                      title: 'Graduation Year',
                      content: user.graduationYear.toString(),
                      isEditable: false,
                    ),
                    ProfileInfoField(
                      title: 'Current Position',
                      content: user.currentPosition ?? 'N/A',
                      isEditable: false,
                    ),
                    ProfileInfoField(
                      title: 'Department',
                      content: user.department.displayName,
                      isEditable: false,
                    ),
                    ProfileInfoField(
                      title: 'Created At',
                      content: user.createdAt.toLocal().toString(),
                      isEditable: false,
                    ),
                    SkillsSection(skillSets: user.skillSets),
                    const SizedBox(height: 20),
                    EducationList(educations: user.educations ?? []),

                    // Placeholder for additional sections/features
                    // Add more children widgets here as needed for other profile features
                  ],
                ),
              ),
            );
          } else if (state is ProfileFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No profile found'));
        },
      ),
    );
  }
}
