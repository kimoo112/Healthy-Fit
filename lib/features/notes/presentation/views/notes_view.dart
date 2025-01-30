import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../cubit/notes_cubit.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Notes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (state is NotesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.dark,
                ),
              );
            } else if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return const Center(
                  child: Text(
                    "No notes found. Add your first note!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.dark,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 2,
                              color: AppColors.grey.withOpacity(.3))
                        ]),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(00.0),
                      child: ListTile(
                        title: Text(
                          state.notes[index],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditNoteDialog(
                                    context, index, state.notes[index]);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<NotesCubit>().deleteNote(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is NotesFailure) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "No notes found.",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.dark,
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 60.0.h),
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.dark,
            onPressed: () {
              _showAddNoteDialog(context);
            },
            icon: Icon(Icons.add, color: AppColors.white),
            label: Text("Add Note", style: TextStyle(color: AppColors.white)),
          ),
        ),
      ),
    );
  }

  // Method to show a dialog for adding a new note
  void _showAddNoteDialog(BuildContext context) {
    final TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Add Note",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: noteController,
          decoration: InputDecoration(
            hintText: "Enter your note",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.dark),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              final noteText = noteController.text.trim();
              if (noteText.isNotEmpty) {
                context.read<NotesCubit>().addNote(noteText);
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: CustomTextStyles.poppins400Style12
                  .copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show a dialog for editing an existing note
  void _showEditNoteDialog(
      BuildContext context, int index, String currentNote) {
    final TextEditingController noteController = TextEditingController();
    noteController.text = currentNote;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Edit Note",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: noteController,
          decoration: InputDecoration(
            hintText: "Edit your note",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.dark),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              final updatedNote = noteController.text.trim();
              if (updatedNote.isNotEmpty) {
                context.read<NotesCubit>().editNote(index, updatedNote);
                Navigator.pop(context);
              }
            },
            child: Text(
              "Save",
              style: CustomTextStyles.poppins400Style12
                  .copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
