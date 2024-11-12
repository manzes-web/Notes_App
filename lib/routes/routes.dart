/// approutes for the app which are name and path
enum Routes {
  noteDetails('/note-details', 'note-details'),
  home('/home', 'home'),
  noteUpdate('/note-update', 'note-update');

  final String path;
  final String name;

  const Routes(this.path, this.name);
}
