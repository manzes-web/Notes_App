import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/note_details/pages/add_note.dart';
import 'package:notes_app/Pages/note_details/pages/note_details.dart';
import 'package:notes_app/Pages/note_details/pages/note_update.dart';
import 'package:notes_app/Pages/note_page.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/routes/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return _buildAppRouter(ref);
}

GoRouter _buildAppRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        builder: (context, state) {
          return const NotePage();
        },
      ),
      GoRoute(
        path: Routes.noteDetails.path,
        name: Routes.noteDetails.name,
        builder: (context, state) {
          Note notes = state.extra as Note;
          return NoteDetails(notes: notes);
        },
      ),
      GoRoute(
        path: Routes.noteAdd.path,
        name: Routes.noteAdd.name,
        builder: (context, state) {
          return const AddNote();
        },
      ),
      GoRoute(
        path: Routes.noteUpdate.path,
        name: Routes.noteUpdate.name,
        builder: (context, state) {
          Note notes = state.extra as Note;
          return NoteUpdate(notes: notes);
        },
      ),
    ],
  );
}
