import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/note_details/note_details.dart';
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
    ],
  );
}
