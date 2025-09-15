import 'package:flutter/material.dart';
import 'package:profile/src/bloc/profile/profile_bloc.dart';
import 'package:profile/src/bloc/profile/profile_events.dart';
import 'package:profile/src/bloc/profile/profile_state.dart';
import 'package:core/core.dart';
import 'package:profile/src/screens/profile_skeleton.dart';
import 'package:profile/src/widgets/education_list.dart';
import 'package:profile/src/widgets/profile_header.dart';
import 'package:profile/src/widgets/profile_info_field.dart';
import 'package:profile/src/widgets/skills_section.dart';

const Map<int, String> roleNames = {
  1: 'Student',
  2: 'Alumni',
  3: 'Faculty',
  4: 'Admin',
};

class OtherUserProfilePage extends StatelessWidget {
  final String userId;

  const OtherUserProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfileById(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const ProfileSkeleton();
          } else if (state is ProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(16),
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
                ],
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
