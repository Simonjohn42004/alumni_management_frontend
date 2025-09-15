import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/bloc/profile/profile_events.dart';
import 'package:profile/src/bloc/profile/profile_state.dart';
import 'package:profile/src/screens/create_education_page.dart';
import 'package:profile/src/screens/edit_education_page.dart';
import 'package:profile/src/screens/profile_skeleton.dart';

class EditProfilePage extends StatefulWidget {
  final String userId;

  const EditProfilePage({super.key, required this.userId});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController fullNameController;
  late final TextEditingController currentPositionController;
  late final TextEditingController skillSetController;

  List<String> skillSets = [];
  List<Education> educations = [];

  late ProfileBloc profileBloc;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>();

    fullNameController = TextEditingController();
    currentPositionController = TextEditingController();
    skillSetController = TextEditingController();

    profileBloc.add(LoadProfileById(widget.userId));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    currentPositionController.dispose();
    skillSetController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToEditEducation(Education education) async {
    final updatedEducation = await Navigator.of(context).push<Education>(
      MaterialPageRoute(
        builder: (context) => EditEducationPage(education: education),
      ),
    );
    if (updatedEducation != null) {
      setState(() {
        int index = educations.indexWhere((e) => e.id == updatedEducation.id);
        if (index != -1) {
          educations[index] = updatedEducation;
        }
      });
    }
  }

  void _addSkill() {
    final skill = skillSetController.text.trim();
    if (skill.isNotEmpty && !skillSets.contains(skill)) {
      setState(() {
        skillSets.add(skill);
      });
      skillSetController.clear();
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      skillSets.remove(skill);
    });
  }

  void _saveProfile() {
    final updateData = {
      'fullName': fullNameController.text.trim(),
      'currentPosition': currentPositionController.text.trim(),
      'skillSets': skillSets,
      // 'educations': educations.map((e) => e.toJson()).toList(),
    };

    profileBloc.add(UpdateProfile(widget.userId, updateData));
    Navigator.pop(context);
  }

  String _roleName(int roleId) {
    switch (roleId) {
      case 1:
        return 'Student';
      case 2:
        return 'Alumni';
      case 3:
        return 'Faculty';
      case 4:
        return 'Admin';
      default:
        return 'Unknown';
    }
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: TextEditingController(text: value),
            enabled: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).disabledColor),
              ),
            ),
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          fullNameController.text = state.user.fullName;
          currentPositionController.text = state.user.currentPosition ?? '';
          skillSets = List<String>.from(state.user.skillSets);
          educations = List<Education>.from(state.user.educations ?? []);
          setState(() {});
          _animationController.forward();
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ProfileOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile saved successfully')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return ProfileSkeleton();
            }
            if (state is ProfileLoaded ||
                state is ProfileOperationSuccess ||
                state is ProfileFailure) {
              final roleId = state is ProfileLoaded ? state.user.roleId : 0;
              final graduationYear = state is ProfileLoaded
                  ? state.user.graduationYear
                  : 0;
              final departmentName = state is ProfileLoaded
                  ? state.user.department.displayName
                  : '';
              educations = state is ProfileLoaded
                  ? state.user.educations ?? []
                  : [];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: FadeTransition(
                  opacity: _animationController,
                  child: ListView(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: _buildReadOnlyField('Role', _roleName(roleId)),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: _buildReadOnlyField(
                          'Graduation Year',
                          graduationYear.toString(),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        child: _buildReadOnlyField(
                          'Department',
                          departmentName,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: _buildReadOnlyField(
                          'Created At',
                          state is ProfileLoaded
                              ? state.user.createdAt.toLocal().toString()
                              : '',
                        ),
                      ),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: AnimatedOutlinedTextField(
                          labelText: 'Full Name',
                          controller: fullNameController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        child: AnimatedOutlinedTextField(
                          labelText: 'Current Position',
                          controller: currentPositionController,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Skill Sets',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 900),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: skillSets
                              .map(
                                (skill) => Chip(
                                  label: Text(skill),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColorLight,
                                  onDeleted: () => _removeSkill(skill),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedOutlinedTextField(
                              labelText: 'Add Skill',
                              controller: skillSetController,
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedElevatedGlowButton(
                            onPressed: _addSkill,
                            width: 52,
                            height: 52,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 900),
                            child: Text(
                              'Educations',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          OutlinedElevatedGlowButton(
                            onPressed: () async {
                              final newEducation = await Navigator.of(context)
                                  .push<Education>(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlocProvider<EducationBloc>.value(
                                            value: context
                                                .read<EducationBloc>(),
                                            child: CreateEducationPage(
                                              userId: widget.userId,
                                            ),
                                          ),
                                    ),
                                  );
                              if (newEducation != null) {
                                setState(() {
                                  educations.add(newEducation);
                                });
                              }
                            },
                            width: 52,
                            height: 52,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        child: Column(
                          children: educations
                              .map(
                                (education) => Card(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  child: ListTile(
                                    title: Text(education.degree),
                                    subtitle: Text(
                                      education.fieldOfStudy ?? '',
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _navigateToEditEducation(education),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 50),
                      OutlinedElevatedGlowButton(
                        onPressed: _saveProfile,
                        width: double.infinity,
                        height: 56,
                        child: const Text('Save Profile'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
