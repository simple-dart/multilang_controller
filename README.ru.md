# Simle Dart Multilang Controller

Библиотека для создания мультиязычных web-приложений на dart.

Читать на других языках: [English](README.md), [Русский](README.ru.md).

### Поверхностное описание:

Библиотека предоставляет базовый интерфейс для создания многоязычных приложений.
Экспортирует глобальную переменную multilangController - инстанс MultilangController.
Stream<String> onLangChange - Позволяет отслеживать изменения языка.

### Параметры:

- languages - список языков, которые будут доступны в приложении
- localSettingsName (по-умолчанию 'lang') - имя параметра в localStorage, в котором хранится текущий язык
- defaultLang (по-умолчанию 'English') - язык по умолчанию
- langKeySuffix (по-умолчанию '^') - суффикс, который отличает в ключи от слов не требующих перевода.

### Пример использования библиотеки:

    multilangController.init(['English', 'Español', 'Português', 'Русский', 'Français', 'Deutsch', 'Italiano']);
    multilangController.loadTranslations({
        '^Language': {
            'English': 'Language',
            'Español': 'Idioma',
            'Português': 'Idioma',
            'Русский': 'Язык',
            'Français': 'Langue',
            'Deutsch': 'Sprache',
            'Italiano': 'Lingua'
        },
        '^Some_Word': {
            'English': 'Some Word',
            'Español': 'Alguna Palabra',
            'Português': 'Alguma Palavra',
            'Русский': 'Некоторое Слово',
            'Français': 'Quelque Mot',
            'Deutsch': 'Einige Wort',
            'Italiano': 'Qualche Parola'
        },
    });
    multilangController.lang = 'Español';
    print(multilangController.translate('^Some_Word 1')); // Alguna Palabra 1
    multilangController.lang = 'Português';
    print(multilangController.translate('^Some_Word 2')); // Alguma Palavra 2
    print(multilangController.translate('^Unknown_Word 3')); // Exception: Unknown translation for key: "^Unknown_Word"

