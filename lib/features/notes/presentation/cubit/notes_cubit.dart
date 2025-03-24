import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  // Box to store notes in Hive
  late Box<String> notesBox;

  // Fetch the notes from Hive
  Future<void> fetchNotes() async {
    emit(NotesLoading());
    try {
      notesBox = await Hive.openBox<String>('notesBox');
      final List<String> storedNotes = notesBox.values.toList();
      emit(NotesLoaded(notes: storedNotes));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  // Add a new note and save it in Hive
  Future<void> addNote(String note) async {
    try {
      await notesBox.add(note);
      emit(NotesLoaded(notes: notesBox.values.toList()));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteNote(int index) async {
    try {
      await notesBox.deleteAt(index);
      emit(NotesLoaded(notes: notesBox.values.toList()));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  void editNote(int index, String updatedNote) {
    if (state is NotesLoaded) {
      final notes = List<String>.from((state as NotesLoaded).notes);
      notes[index] = updatedNote; // Update the note at the specified index
      emit(NotesLoaded(notes: notes)); // Emit the updated state
    }
  }
}
