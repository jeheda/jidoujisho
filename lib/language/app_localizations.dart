class AppLocalizations {
  AppLocalizations();

  static const _languageCodes = <String, String>{
    'English': 'en',
    'Tagalog': 'tl'
  };

  static const _localizedValues = <String, Map<String, String>>{
    'English': {
      'app_title': 'jidoujisho',
      'target_language': 'Target language',
      'app_language': 'App language',
      'player_media_type': 'Player',
      'reader_media_type': 'Reader',
      'viewer_media_type': 'Viewer',
      'dictionary_media_type': 'Dictionary',
      'card_creator': 'Card Creator',
      'export_card': 'Export Card',
      'options_theme_light': 'Use light theme',
      'options_theme_dark': 'Use dark theme',
      'options_incognito_on': 'Turn on incognito mode',
      'options_incognito_off': 'Turn off incognito mode',
      'options_dictionaries': 'Manage dictionaries',
      'options_enhancements': 'User enhancements',
      'options_sources': 'Media sources',
      'options_language': 'Language settings',
      'options_github': 'View repository on GitHub',
      'options_licenses': 'Licenses and attribution',
      'dialog_close': 'CLOSE',
      'dialog_context': 'CONTEXT',
      'dialog_import': 'IMPORT',
      'dialog_remove': 'REMOVE',
      'dialog_yes': 'YES',
      'dialog_no': 'NO',
      'dialog_select': 'SELECT',
      'dialog_return': 'RETURN',
      'dialog_hide': 'HIDE',
      'dialog_show': 'SHOW',
      'dialog_creator': 'CREATOR',
      'dialog_channel': 'CHANNEL',
      'dialog_play': 'PLAY',
      'dialog_read': 'READ',
      'dialog_set_remember': 'SET AND REMEMBER',
      'dialog_set': 'SET',
      'dialog_exit_player': 'Exit Player?',
      'dialog_exit_reader': 'Exit Reader?',
      'dialog_exit_viewer': 'Exit Viewer?',
      'dictionary_searching_before': 'Searching for',
      'dictionary_searching_after': '',
      'dictionary_nomatch_before': 'No matches for',
      'dictionary_nomatch_after': 'could be found.',
      'creator_options_menu': 'Creator menu addons',
      'creator_options_auto': 'Creator auto addons',
      'closed_captions_query': 'Querying for captions',
      'closed_captions_target': 'Target language captions',
      'closed_captions_app': 'App language captions',
      'closed_captions_other': 'Other language captions',
      'closed_captions_unavailable': 'No captions',
      'closed_captions_error': 'Error while querying captions',
      'widget_options': 'Dictionary widget addons',
      'creator_options_confirm': 'Are you sure you want to leave changes '
          'unsaved?',
      'preparing_card_creator': 'Preparing card creator',
      'remove_dictionary_confirmation':
          'This dictionary and its searched entries will be removed. Are you '
              'sure you want to remove this?',
      'player_pick_video': 'Pick Video File',
      'player_option_shadowing': 'Shadowing Mode',
      'player_option_definition_focus': 'Definition Focus Mode',
      'player_option_listening_comprehension': 'Listening Comprehension Mode',
      'player_option_drag_to_select': 'Use Drag to Select Subtitle Selection',
      'player_option_tap_to_select': 'Use Tap to Select Subtitle Selection',
      'player_option_dictionary_menu': 'Select Active Dictionary Source',
      'player_option_cast_video': 'Cast to Display Device',
      'player_option_share_subtitle': 'Share Current Subtitle',
      'player_option_export': 'Create Card from Context',
      'player_option_audio': 'Audio',
      'player_option_subtitle': 'Subtitle',
      'player_option_subtitle_external': 'External',
      'player_option_subtitle_none': 'None',
      'player_option_select_subtitle': 'Select Subtitle Track',
      'player_option_select_audio': 'Select Audio Track',
      'player_option_text_filter': 'Use Regular Expression Filter',
      'player_option_blur_preferences': 'Blur Widget Preferences',
      'player_option_blur_use': 'Use Blur Widget',
      'player_option_blur_radius': 'Blur Radius',
      'player_option_blur_options': 'Set Blur Widget Color and Bluriness',
      'player_option_blur_reset': 'Reset Blur Widget Size and Position',
      'player_align_subtitle_transcript': 'Align Subtitle with Transcript',
      'player_option_subtitle_appearance': 'Subtitle Timing and Appearance',
      'player_option_load_subtitles': 'Load External Subtitles',
      'player_option_subtitle_delay': 'Subtitle Delay',
      'player_option_audio_allowance': 'Audio Allowance',
      'player_option_font_size': 'Font Size',
      'player_option_regex_filter': 'Regular Expression Filter',
      'player_subtitles_transcript_empty': 'Transcript is empty.',
      'player_prepare_export': 'Preparing card...',
      'player_change_player_orientation': 'Change Player Orientation',
      'instant_search_label_before': 'Showing ',
      'instant_search_label_after': ' search results found for',
      'search_label_before': 'Search result ',
      'search_label_middle': 'out of ',
      'search_label_from': 'from ',
      'search_label_after': 'found for',
      'deck_label_before': 'Card exported to',
      'deck_label_after': '.',
      'image_label_before': 'Selecting image ',
      'image_label_middle': 'out of ',
      'image_label_after': '',
      'field_label_sentence': 'Sentence',
      'field_label_word': 'Word',
      'field_label_reading': 'Reading',
      'field_label_meaning': 'Meaning',
      'field_label_extra': 'Extra',
      'field_label_image': 'Image',
      'field_label_audio': 'Audio',
      'field_hint_context': 'Sentence or written context',
      'field_hint_word': 'The headword of the card',
      'field_hint_reading': 'Reading or pronunciation',
      'field_hint_meaning': 'Meaning or dictionary definition',
      'field_hint_extra': 'Any extra information here',
      'field_hint_image': 'Enter image search term',
      'field_hint_audio': 'Enter audio search term',
      'import_format': 'Import format',
      'import_in_progress': 'Import in progress...',
      'start_reading': 'Start Reading',
      'search': 'Search',
      'search_dictionary_before': 'Search ',
      'search_dictionary_after': '...',
      'enter_a_search_term': 'Enter a search term',
      'import_dictionaries_for_use': 'Import dictionaries to be used',
      'no_more_available_enhancements':
          'No more available enhancements for this field',
      'history_empty': 'History is empty',
      'source_list_empty': 'No sources listed',
      'ankidroid_api': 'AnkiDroid API',
      'ankidroid_api_message':
          'The Card Creator requires the AnkiDroid API to be active in the background. Launch AnkiDroid in order to continue.',
      'dialog_launch_ankidroid': 'LAUNCH ANKIDROID',
      'youtube_trending': 'YouTube Trending',
      'localisation_warning': 'Community addons and enhancements are managed '
          'by their respective developers, and these may appear in their '
          'original language.',
      'license_screen_legalese': "A mobile video player, reader assistant, "
          "image mining workflow and card creation toolkit tailored for "
          "language learners.\n\nBuilt for the language learning community "
          "by Leo Rafael Orpilla. Logo by Aaron Marbella.\n\nChisa is "
          "free and open source software. Liking the application? Help out "
          "by providing feedback, making a donation, reporting issues or "
          "collaborating for further improvements on GitHub.",
    },
    'Tagalog': {
      'app_title': 'jidoujisho',
      'target_language': 'Wikang pakay',
      'app_language': 'Wika ng aplikasyon',
      'player_media_type': 'Video',
      'reader_media_type': 'Libro',
      'viewer_media_type': 'Komiks',
      'dictionary_media_type': 'Diksyunaryo',
      'card_creator': 'Pagawaan ng Card',
      'export_card': 'Idagdag ang Card',
      'options_theme_light': 'Magaan na tema',
      'options_theme_dark': 'Madilim na tema',
      'options_incognito_on': 'Ilihim ang kasaysayan',
      'options_incognito_off': 'Huwag ilihim ang kasaysayan',
      'options_dictionaries': 'Mga diksyunaryo',
      'options_enhancements': 'Karagdagang kagamitan',
      'options_sources': 'Mga pagkukunan',
      'options_language': 'Pagpipiliang wika',
      'options_github': 'Makibahagi sa GitHub',
      'options_licenses': 'Mga pagpapatungkol',
      'dialog_close': 'ISARA',
      'dialog_context': 'KONTEKSTO',
      'dialog_import': 'MAGDAGDAG',
      'dialog_remove': 'ITANGGAL',
      'dialog_select': 'PILIIN',
      'dialog_return': 'BUMALIK',
      'dialog_yes': 'OO',
      'dialog_no': 'HINDI',
      'dialog_hide': 'ITAGO',
      'dialog_show': 'IPAKITA',
      'dialog_creator': 'PAGAWAAN',
      'dialog_channel': 'CHANNEL',
      'dialog_play': 'IPALABAS',
      'dialog_read': 'BASAHIN',
      'dialog_set_remember': 'ISAAYOS AT IALALA',
      'dialog_set': 'ISAAYOS',
      'dialog_exit_player': 'Isarado ang Video?',
      'dialog_exit_reader': 'Isarado ang Libro?',
      'dialog_exit_viewer': 'Isarado ang Komiks?',
      'dictionary_searching_before': 'Naghahanap para sa',
      'dictionary_searching_after': '',
      'dictionary_nomatch_before': 'Walang resultang nahanap para sa',
      'dictionary_nomatch_after': '',
      'creator_options_menu': 'Mga menu mod ng Pagawaan',
      'creator_options_auto': 'Mga auto mod ng Pagawaan',
      'closed_captions_query': 'Naghahanap ng mga caption',
      'closed_captions_target': 'May caption ang wikang pakay',
      'closed_captions_app': 'May caption ang wika ng app',
      'closed_captions_other': 'May caption ang ibang wika',
      'closed_captions_unavailable': 'Walang caption',
      'closed_captions_error': 'Nagkaproblema sa pagkuha ng caption',
      'widget_options': 'Mga widget ng diksunaryo',
      'creator_options_confirm':
          'Walang magbabagong kagamitan. Sigurado ka ba sa pagbalik?',
      'preparing_card_creator': 'Hinahanda ang card...',
      'remove_dictionary_confirmation':
          'Ang diksyunaryo na ito ay mawawala, kasama ang mga resulta na galing '
              'dito. Sigurado ka ba sa pagtanggal nito?',
      'player_pick_video': 'Pumili ng Video',
      'player_option_shadowing': 'Ulitin ang Pangkasalukuyang Subtitle',
      'player_option_definition_focus': 'Huminto kapag Naghanap ng Salita',
      'player_option_listening_comprehension': 'Itago ang Subtitle at Makinig',
      'player_option_drag_to_select':
          'Humila ng Subtitle para Maghanap ng Salita',
      'player_option_tap_to_select':
          'Pindutin ang Subtitle para Maghanap ng Salita',
      'player_option_dictionary_menu': 'Pumili ng Ibang Diksunaryo',
      'player_foption_cast_video': 'Ipalabas sa Ibang Kagamitan',
      'player_option_share_subtitle': 'Ibahagi ang Pangkasalukuyang Subtitle',
      'player_option_export': 'Gumawa ng Card Mula sa Konteksto',
      'player_option_audio': 'Audio',
      'player_option_subtitle': 'Subtitle',
      'player_option_subtitle_external': 'External',
      'player_option_subtitle_none': 'Wala',
      'player_option_select_subtitle': 'Pumili ng Subtitle Track',
      'player_option_select_audio': 'Pumili ng Audio Track',
      'player_option_text_filter': 'Gamitin ang Regular Expression Filter',
      'player_option_blur_preferences': 'Opsyon ng Blur Widget',
      'player_option_blur_use': 'Gamitin ang Blur Widget',
      'player_option_blur_radius': 'Pagkalabo',
      'player_option_blur_options':
          'Isaayos ang Kulay at Pagkalabo ng Blur Widget',
      'player_option_blur_reset':
          'Ibalik ang Blur Widget sa Orihinal na Estado',
      'player_align_subtitle_transcript':
          'Isakto ang Simula ng Subtitle Gamit ang Iskrip',
      'player_option_subtitle_appearance':
          'Isaayos ang Oras at Itsura ng Subtitle',
      'player_option_load_subtitles': 'Pumili ng Ibang Subtitle',
      'player_option_subtitle_delay': 'Ipatagal ang Subtitle',
      'player_option_audio_allowance': 'Ipahaba ang Sakop ng Kukuning Audio',
      'player_option_font_size': 'Laki ng Salita',
      'player_option_regex_filter': 'Regular Expression Filter',
      'player_subtitles_transcript_empty': 'Walang laman ang iskrip.',
      'player_prepare_export': 'Hindahanda ang card...',
      'player_change_player_orientation': 'Ipatagilid ang Video',
      'instant_search_label_before': 'Pinapakita ang ',
      'instant_search_label_after': ' na resultang nahanap para sa',
      'search_label_before': 'Resulto ',
      'search_label_middle': 'sa ',
      'search_label_from': 'galing sa ',
      'search_label_after': 'mula sa',
      'deck_label_before': 'Dinagdag ang card sa',
      'deck_label_after': '.',
      'image_label_before': 'Pinipili ang ika-',
      'image_label_middle': 'na imahe mula sa ',
      'image_label_after': '',
      'field_label_sentence': 'Pangungusap',
      'field_label_word': 'Salita',
      'field_label_reading': 'Bigkas',
      'field_label_meaning': 'Kahulugan',
      'field_label_extra': 'Karagdagan',
      'field_label_image': 'Imahe',
      'field_label_audio': 'Audio',
      'field_hint_context': 'Pangungusap o konteksto',
      'field_hint_word': 'Salitang tinutukoy',
      'field_hint_reading': 'Pagbigkas ng salita',
      'field_hint_meaning': 'Kahulugan ng salita',
      'field_hint_extra': 'Karagdagang impormasyon',
      'field_hint_image': 'Imaheng hahanapin',
      'field_hint_audio': 'Tunog na hahanapin',
      'search': 'Maghanap',
      'search_dictionary_before': 'Hanapin sa ',
      'search_dictionary_after': '...',
      'enter_a_search_term': 'Maglagay ng salitang hahanapin',
      'import_format': 'Klase ng idadagdag na diksyunaryo',
      'import_in_progress': 'Nagdadagdag ng diksyunaryo...',
      'start_reading': 'Magsimulang Magbasa',
      'no_more_available_enhancements':
          'Wala nang karagdagang kagamitan para dito',
      'import_dictionaries_for_use': 'Magdagdag ng diksyunaryo na gagamitin',
      'history_empty': 'Wala pang kasaysayan',
      'source_list_emmpty': 'Walang mga pagkukunan',
      'ankidroid_api': 'AnkiDroid API',
      'ankidroid_api_message':
          'Kailangan na buhay ang AnkiDroid API upang gamitin anYouTubeg Pagawaan ng Card. Buksan ang AnkiDroid upang magpatuloy.',
      'dialog_launch_ankidroid': 'BUKSAN ANG ANKIDROID',
      'youtube_trending': 'Trending sa YouTube',
      'localisation_warning': 'Ang mga mod na gawa ng komunidad ay maaring '
          'hindi naisalin at magpakita sa orihinal na wikang '
          'pinanggalingan.',
      'license_screen_legalese': "Kagamitang nakakatulong sa pagnood ng video, "
          "pagbasa ng libro at komiks at pagkabisado ng mga salita ng mga "
          "wikang banyaga.\n\nGawa ni Leo Rafael Orpilla para sa magaaral ng "
          "iba't ibang wika. Tatak ng aplikasyon, gawa ni Aaron Marbella.\n\n"
          "Ang aplikasyon na ito ay libre na gamitin at ipagbuti para sa "
          "lahat. Nagustuhan mo ba? Maari kang makatulong sa pamamagitan ng "
          "donasyon o kontribusyon o ng puna, at sa pagbahagi at pagbatid ng "
          "apliksayon na ito sa kapwa.",
    },
  };

  static List<String> localizations() => _localizedValues.keys.toList();

  static String getLocalizedValue(String localization, String key) {
    return _localizedValues[localization]![key]!;
  }

  static String getLanguageCode(String languageName) {
    return _languageCodes[languageName]!;
  }
}
