import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/src/bloc/education/education_bloc.dart';
import 'package:profile/src/bloc/education/education_event.dart';
import 'package:profile/src/bloc/education/education_state.dart';

class EditEducationPage extends StatefulWidget {
  final Education education;

  const EditEducationPage({super.key, required this.education});

  @override
  EditEducationPageState createState() => EditEducationPageState();
}

class EditEducationPageState extends State<EditEducationPage> {
  late TextEditingController schoolNameController;
  late TextEditingController degreeController;
  late TextEditingController fieldOfStudyController;
  late TextEditingController cgpaController;
  late TextEditingController descriptionController;
  late DateTime startDate;
  late DateTime endDate;

  final dateFormat = DateFormat('yyyy-MM-dd');
  late EducationBloc educationBloc;

  @override
  void initState() {
    super.initState();
    final e = widget.education;
    schoolNameController = TextEditingController(text: e.schoolName);
    degreeController = TextEditingController(text: e.degree);
    fieldOfStudyController = TextEditingController(text: e.fieldOfStudy ?? '');
    cgpaController = TextEditingController(text: e.cgpa);
    descriptionController = TextEditingController(text: e.description ?? '');
    startDate = e.startDate;
    endDate = e.endDate;

    educationBloc = context.read<EducationBloc>();
  }

  @override
  void dispose() {
    schoolNameController.dispose();
    degreeController.dispose();
    fieldOfStudyController.dispose();
    cgpaController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initialDate = isStart ? startDate : endDate;
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (newDate != null) {
      setState(() {
        if (isStart) {
          startDate = newDate;
          if (endDate.isBefore(startDate)) {
            endDate = startDate;
          }
        } else {
          endDate = newDate;
          if (endDate.isBefore(startDate)) {
            startDate = endDate;
          }
        }
      });
    }
  }

  void _saveEducation() {
    final updated = widget.education.copyWith(
      schoolName: schoolNameController.text.trim(),
      degree: degreeController.text.trim(),
      fieldOfStudy: fieldOfStudyController.text.trim().isEmpty
          ? null
          : fieldOfStudyController.text.trim(),
      cgpa: cgpaController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      startDate: startDate,
      endDate: endDate,
    );

    educationBloc.add(UpdateEducation(updated.id!, updated.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationBloc, EducationState>(
      listener: (context, state) {
        if (state is EducationLoaded) {
          Navigator.of(context).pop(state.education);
        } else if (state is EducationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save education: ${state.message}'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Education')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              AnimatedOutlinedTextField(
                labelText: 'School Name',
                controller: schoolNameController,
              ),
              const SizedBox(height: 16),
              AnimatedOutlinedTextField(
                labelText: 'Degree',
                controller: degreeController,
              ),
              const SizedBox(height: 16),
              AnimatedOutlinedTextField(
                labelText: 'Field Of Study',
                controller: fieldOfStudyController,
              ),
              const SizedBox(height: 16),
              AnimatedOutlinedTextField(
                labelText: 'CGPA',
                controller: cgpaController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedElevatedGlowButton(
                      onPressed: () => _pickDate(context, true),
                      child: Text(
                        'Start Date: ${dateFormat.format(startDate)}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedElevatedGlowButton(
                      onPressed: () => _pickDate(context, false),
                      child: Text('End Date: ${dateFormat.format(endDate)}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AnimatedOutlinedTextField(
                labelText: 'Description',
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 32),
              OutlinedElevatedGlowButton(
                onPressed: _saveEducation,
                width: double.infinity,
                height: 54,
                child: const Text('Save Education'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
