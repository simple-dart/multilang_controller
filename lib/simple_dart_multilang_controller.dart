import 'dart:async';
import 'dart:html';

MultilangController multilangController = MultilangController();

const EN = 'English';
const ES = 'Español';
const PT = 'Português';
const RU = 'Русский';
const FR = 'Français';
const DE = 'Deutsch';
const IT = 'Italiano';
const NL = 'Nederlands';
const PL = 'Polski';
const SV = 'Svenska';
const TR = 'Türkçe';

class MultilangController {
  String _lang = '';
  String _localSettingsLang = '';
  String _defaultLang = '';
  String _langKeyPrefix = '';

  late List<String> _langList;

  // langKey => lang => translation
  final Map<String, Map<String, String>> _translations = <String, Map<String, String>>{};
  final Map<String, String> _langCodeMap = <String, String>{};

  final StreamController<String> _onLangChange = StreamController<String>.broadcast(sync: true);

  Stream<String> get onLangChange => _onLangChange.stream;

  void init(
    List<String> languages, {
    String localSettingsName = 'lang',
    String defaultLang = EN,
    String langKeyPrefix = '^',
  }) {
    _langList = languages;
    _localSettingsLang = localSettingsName;
    _defaultLang = defaultLang;
    _langKeyPrefix = langKeyPrefix;
    loadDefaultLangCodes();
    loadSettings();
  }

  void loadSettings() {
    final newLang = window.localStorage[_localSettingsLang];
    if (newLang != null) {
      lang = newLang;
    } else {
      lang = _defaultLang;
    }
  }

  String get lang => _lang;

  set lang(String language) {
    if (_lang == language) {
      return;
    }
    if (!_langList.contains(language)) {
      lang = _defaultLang;
      return;
    }
    _lang = language;
    window.localStorage[_localSettingsLang] = language;
    _onLangChange.sink.add(language);
  }

  List<String> get languages => List<String>.from(_langList);

  String get defaultLang => _defaultLang;

  String get langKeyPrefix => _langKeyPrefix;

  String translate(String text) {
    final isOneWord = !text.contains(' ');
    if (isOneWord) {
      return _translateOneWord(text);
    } else {
      return _translateSentence(text);
    }
  }

  // oneWord can contain special symbols after key for example "^Loaded:"
  String _translateOneWord(String oneWord) {
    final trimmedOneWord = trimOneWord(oneWord);
    if (trimmedOneWord.startsWith(_langKeyPrefix)) {
      final langTranslations = _translations[trimmedOneWord];
      if (langTranslations != null) {
        if (langTranslations.containsKey(_lang)) {
          final foundTranslation = langTranslations[_lang]!;
          if (trimmedOneWord.length < oneWord.length) {
            return foundTranslation + oneWord.substring(trimmedOneWord.length);
          } else {
            return foundTranslation;
          }
        } else {
          throw Exception('Unknown translation for lang:"$_lang" and key:"$oneWord"');
        }
      } else {
        throw Exception('Unknown translation for key:"$oneWord"');
      }
    } else {
      return oneWord;
    }
  }

  String _translateSentence(String text) {
    final words = text.split(' ');
    final translatedWords = <String>[];
    for (final word in words) {
      translatedWords.add(_translateOneWord(word));
    }
    return translatedWords.join(' ');
  }

  String removePrefix(String langKey) {
    if (_langKeyPrefix.isEmpty) {
      return langKey;
    }
    var langKeyWithoutPrefix = langKey;
    if (langKey.startsWith(_langKeyPrefix)) {
      langKeyWithoutPrefix = langKey.substring(_langKeyPrefix.length);
    }
    return langKeyWithoutPrefix;
  }

  String addPrefix(String langKey) {
    if (_langKeyPrefix.isEmpty) {
      return langKey;
    }
    if (langKey.startsWith(_langKeyPrefix)) {
      return langKey;
    } else {
      return _langKeyPrefix + langKey;
    }
  }

  // returns ISO 639-1 Language Code
  String getLangCode(String lang) {
    final res = _langCodeMap[lang];
    if (res == null) {
      throw Exception('Language code not found for $lang');
    }
    return res;
  }

  void loadLangCodes(Map<String, String> langCodeMap) {
    _langCodeMap.addAll(langCodeMap);
  }

  // load default ISO 639-1 Language Codes
  void loadDefaultLangCodes() {
    loadLangCodes({
      EN: 'en',
      ES: 'es',
      PT: 'pt',
      RU: 'ru',
      FR: 'fr',
      DE: 'de',
      IT: 'it',
      NL: 'nl',
      PL: 'pl',
      SV: 'sv',
      TR: 'tr',
    });
  }

  void loadTranslations(Map<String, Map<String, String>> translations) {
    _translations.addAll(translations);
  }

  void dispose() {
    _onLangChange.close();
  }
}

String trimOneWord(String oneWord) => oneWord
    .replaceAll(':', '')
    .replaceAll('%', '')
    .replaceAll('\$', '')
    .replaceAll('#', '')
    .replaceAll('@', '')
    .replaceAll('.', '')
    .replaceAll(',', '')
    .replaceAll(';', '')
    .replaceAll('?', '')
    .replaceAll('!', '')
    .replaceAll('&', '')
    .replaceAll('*', '')
    .replaceAll('(', '')
    .replaceAll(')', '')
    .replaceAll('>', '')
    .replaceAll('<', '')
    .replaceAll('[', '')
    .replaceAll(']', '')
    .replaceAll('{', '')
    .replaceAll('}', '')
    .replaceAll('|', '')
    .replaceAll('=', '')
    .trim();
