part of 'notes_cubit.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<String> notes;
  NotesLoaded({required this.notes});
}

class NotesFailure extends NotesState {
  final String errorMessage;
  NotesFailure({required this.errorMessage});
}
