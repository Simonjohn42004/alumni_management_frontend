import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/src/bloc/education/education_bloc.dart';
import 'package:profile/src/bloc/education/education_event.dart';
import 'package:profile/src/bloc/education/education_state.dart';

class CreateEducationPage extends StatefulWidget {
  final String userId;

  const CreateEducationPage({super.key, required this.userId});

  @override
  CreateEducationPageState createState() => CreateEducationPageState();
}

class CreateEducationPageState extends State<CreateEducationPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController schoolNameController;
  late TextEditingController degreeController;
  late TextEditingController fieldOfStudyController;
  late TextEditingController cgpaController;
  late TextEditingController descriptionController;

  late DateTime startDate;
  late DateTime endDate;

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late EducationBloc educationBloc;

  @override
  void initState() {
    super.initState();
    schoolNameController = TextEditingController();
    degreeController = TextEditingController();
    fieldOfStudyController = TextEditingController();
    cgpaController = TextEditingController();
    descriptionController = TextEditingController();

    final now = DateTime.now();
    startDate = DateTime(now.year - 4, now.month, now.day);
    endDate = now;

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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newEducation = Education(
      userId: widget.userId,
      schoolName: schoolNameController.text.trim(),
      degree: degreeController.text.trim(),
      fieldOfStudy: fieldOfStudyController.text.trim().isEmpty
          ? null
          : fieldOfStudyController.text.trim(),
      startDate: startDate,
      endDate: endDate,
      cgpa: cgpaController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
    );

    educationBloc.add(CreateEducation(newEducation));
  }

  String? _nonEmptyValidator(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _cgpaValidator(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'CGPA is required';
    }
    final cgpa = double.tryParse(val.trim());
    if (cgpa == null || cgpa < 0 || cgpa > 10) {
      return 'Enter valid CGPA (0-10)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationBloc, EducationState>(
      listener: (context, state) {
        if (state is EducationLoaded) {
          Navigator.of(context).pop(state.education);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Education added successfully')),
          );
        } else if (state is EducationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add education: ${state.message}'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Education')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                AnimatedOutlinedTextField(
                  labelText: 'School Name',
                  controller: schoolNameController,
                  validator: _nonEmptyValidator,
                ),
                const SizedBox(height: 16),
                AnimatedOutlinedTextField(
                  labelText: 'Degree',
                  controller: degreeController,
                  validator: _nonEmptyValidator,
                ),
                const SizedBox(height: 16),
                AnimatedOutlinedTextField(
                  labelText: 'Field Of Study (Optional)',
                  controller: fieldOfStudyController,
                ),
                const SizedBox(height: 16),
                AnimatedOutlinedTextField(
                  labelText: 'CGPA',
                  controller: cgpaController,
                  keyboardType: TextInputType.number,
                  validator: _cgpaValidator,
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
                  labelText: 'Description (Optional)',
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 32),
                OutlinedElevatedGlowButton(
                  onPressed: _submit,
                  width: double.infinity,
                  height: 54,
                  child: const Text('Add Education'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
