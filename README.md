# Simple Dart Multilang Controller

Multilingual support for Simple Web Ui framework.

Read in other languages: [English](README.md), [Русский](README.ru.md).

### Superficial description:

The library provides a basic interface for building multilingual applications.
Exports the multilangController global variable - a MultilangController instance.
Stream<String> onLangChange - Allows to listen language changes.

### An example of using the library:

    multilangController.init(['English', 'Español', 'Português', 'Русский', 'Français', 'Deutsch', 'Italiano']);
    multilangController.loadTranslations({
        'Language': {
            'English': 'Language',
            'Español': 'Idioma',
            'Português': 'Idioma',
            'Русский': 'Язык',
            'Français': 'Langue',
            'Deutsch': 'Sprache',
            'Italiano': 'Lingua'
        },
        'Some Word': {
            'English': 'Some Word',
            'Español': 'Alguna Palabra',
            'Português': 'Alguma Palavra',
            'Русский': 'Некоторое Слово',
            'Français': 'Quelque Mot',
            'Deutsch': 'Einige Wort',
            'Italiano': 'Qualche Parola'
        },
        'Another Word': {
            'English': 'Another Word',
            'Español': 'Otra Palabra',
            'Português': 'Outra Palavra',
            'Русский': 'Другое Слово',
            'Français': 'Autre Mot',
            'Deutsch': 'Ein Anderes Wort',
            'Italiano': 'Un Altra Parola'
        },
    });
    multilangController.lang = 'Español';
    print(multilangController.translate('Some Word')); // Alguna Palabra
    multilangController.lang = 'Français';
    print(multilangController.translate('Some Word')); // Quelque Mot

