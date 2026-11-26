class Book {
  String title;
  String author;
  int year;
  bool isAvailable;

  Book(this.title, this.author, this.year, {this.isAvailable = true});

  void showInfo() {
    String status = isAvailable ? 'Доступна' : 'Выдана';
    print('«$title» — $author ($year г.) | Статус: $status');
  }
}

Book? findBookByTitle(List<Book> catalog, String query) {
  for (var book in catalog) {
    if (book.title.toLowerCase() == query.trim().toLowerCase()) {
      return book;
    }
  }
  return null;
}

void lendBook(List<Book> catalog, String title) {
  Book? book = findBookByTitle(catalog, title);
  if (book == null) {
    print('Книга «$title» не найдена.');
    return;
  }
  if (book.isAvailable) {
    book.isAvailable = false;
    print('Вы успешно взяли книгу «${book.title}».');
  } else {
    print('Книга «${book.title}» уже выдана другому читателю.');
  }
}

void returnBook(List<Book> catalog, String title) {
  Book? book = findBookByTitle(catalog, title);
  if (book == null) {
    print('Книга «$title» не найдена.');
    return;
  }
  if (!book.isAvailable) {
    book.isAvailable = true;
    print('Вы успешно вернули книгу «${book.title}».');
  } else {
    print('Книга «${book.title}» уже находится в библиотеке.');
  }
}

void printMenu() {
  print('\n===== БИБЛИОТЕКА =====');
  print('1. Показать все книги');
  print('2. Найти книгу');
  print('3. Выдать книгу');
  print('4. Вернуть книгу');
  print('5. Выход');
  print('=====================');
  print('Выберите действие:');
}

void main() {
  List<Book> library = [
    Book('1984', 'Джордж Оруэлл', 1949),
    Book('Мастер и Маргарита', 'Михаил Булгаков', 1967),
    Book('Гарри Поттер и философский камень', 'Дж. К. Роулинг', 1997),
    Book('Преступление и наказание', 'Фёдор Достоевский', 1866),
    Book('Дюна', 'Фрэнк Герберт', 1965),
  ];

  List<String> simulatedInputs = [
    '1',
    'abc',
    '99',
    '2', 'Дюна',
    '2', 'Неизвестная',
    '3', 'Дюна',
    '3', 'Дюна',
    '4', 'Дюна',
    '4', 'Дюна',
    '5'
  ];

  int inputIndex = 0;

  String? readInput() {
    if (inputIndex < simulatedInputs.length) {
      String value = simulatedInputs[inputIndex++];
      print('> $value');
      return value;
    }
    return '5';
  }

  bool isRunning = true;

  while (isRunning) {
    printMenu();
    String? input = readInput();

    int? choice = int.tryParse(input ?? '');

    if (choice == null) {
      print('Ошибка: введите корректный номер пункта меню (число).');
      continue;
    }

    switch (choice) {
      case 1:
        print('\n--- Каталог книг ---');
        for (var book in library) {
          book.showInfo();
        }
        break;

      case 2:
        print('Введите название книги для поиска:');
        String? searchTitle = readInput();
        if (searchTitle != null && searchTitle.trim().isNotEmpty) {
          Book? found = findBookByTitle(library, searchTitle);
          if (found != null) {
            found.showInfo();
          } else {
            print('Книга не найдена.');
          }
        } else {
          print('Название не может быть пустым.');
        }
        break;

      case 3:
        print('Введите название книги для выдачи:');
        String? lendTitle = readInput();
        if (lendTitle != null && lendTitle.trim().isNotEmpty) {
          lendBook(library, lendTitle);
        } else {
          print('Название не может быть пустым.');
        }
        break;

      case 4:
        print('Введите название книги для возврата:');
        String? returnTitle = readInput();
        if (returnTitle != null && returnTitle.trim().isNotEmpty) {
          returnBook(library, returnTitle);
        } else {
          print('Название не может быть пустым.');
        }
        break;

      case 5:
        print('Выход из программы. До свидания!');
        isRunning = false;
        break;

      default:
        print('Несуществующий номер действия. Выберите пункт от 1 до 5.');
    }
  }
}
