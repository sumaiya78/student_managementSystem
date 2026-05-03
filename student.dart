import 'dart:io';

const String fileName = "students.txt";

// Read all students
List<List<String>> readStudents() {
  File file = File(fileName);

  if (!file.existsSync()) {
    file.createSync();
  }

  List<String> lines = file.readAsLinesSync();
  List<List<String>> students = [];

  for (var line in lines) {
    students.add(line.split(", "));
  }

  return students;
}

// Save all students
void saveStudents(List<List<String>> students) {
  File file = File(fileName);
  List<String> lines = [];

  for (var s in students) {
    lines.add(s.join(", "));
  }

  file.writeAsStringSync(lines.join("\n"));
}

// Add student
void addStudent() {
  stdout.write("Enter ID: ");
  String id = stdin.readLineSync()!;

  stdout.write("Enter Name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter CGPA: ");
  String cgpa = stdin.readLineSync()!;

  File file = File(fileName);
  file.writeAsStringSync("$id, $name, $cgpa\n", mode: FileMode.append);

  print("Student added successfully!\n");
}

// List students
void listStudents() {
  var students = readStudents();

  if (students.isEmpty) {
    print("No students found.\n");
    return;
  }

  print("\n--- Student List ---");
  for (var s in students) {
    print("ID: ${s[0]}, Name: ${s[1]}, CGPA: ${s[2]}");
  }
  print("");
}

// Edit student
void editStudent() {
  var students = readStudents();

  stdout.write("Enter ID to edit: ");
  String id = stdin.readLineSync()!;

  bool found = false;

  for (var s in students) {
    if (s[0] == id) {
      stdout.write("New Name: ");
      s[1] = stdin.readLineSync()!;

      stdout.write("New CGPA: ");
      s[2] = stdin.readLineSync()!;

      found = true;
      break;
    }
  }

  if (found) {
    saveStudents(students);
    print("Student updated!\n");
  } else {
    print("Student not found!\n");
  }
}

// Delete student
void deleteStudent() {
  var students = readStudents();

  stdout.write("Enter ID to delete: ");
  String id = stdin.readLineSync()!;

  students.removeWhere((s) => s[0] == id);

  saveStudents(students);

  print("Student deleted (if existed).\n");
}

// Main menu
void main() {
  while (true) {
    print("===== Student Management System =====");
    print("1. Add Student");
    print("2. Edit Student");
    print("3. Delete Student");
    print("4. List Students");
    print("5. Exit");
    stdout.write("Choose option: ");

    String choice = stdin.readLineSync()!;

    switch (choice) {
      case '1':
        addStudent();
        break;
      case '2':
        editStudent();
        break;
      case '3':
        deleteStudent();
        break;
      case '4':
        listStudents();
        break;
      case '5':
        print("Exiting...");
        exit(0);
      default:
        print("Invalid option!\n");
    }
  }
}