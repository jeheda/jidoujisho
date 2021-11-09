import 'dart:async';

import 'package:chisa/media/media_history_items/media_history_item.dart';
import 'package:chisa/media/media_sources/player_media_source.dart';
import 'package:chisa/media/media_type.dart';
import 'package:chisa/media/media_types/media_launch_params.dart';
import 'package:chisa/models/app_model.dart';
import 'package:chisa/pages/player_page.dart';
import 'package:chisa/util/bottom_sheet_dialog.dart';
import 'package:chisa/util/media_source_action_button.dart';
import 'package:chisa/util/subtitle_utils.dart';
import 'package:chisa/util/youtube_subtitles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subtitle/subtitle.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;

enum YouTubeVideoQuality {
  sd_144,
  sd_240,
  sd_360,
  sd_480,
  sd_720,
  hd_1080,
  hd_1440,
  uhd_2160,
}

class PlayerYouTubeSource extends PlayerMediaSource {
  PlayerYouTubeSource()
      : super(
          sourceName: "YouTube",
          icon: Icons.smart_display,
        );

  static YoutubeExplode yt = YoutubeExplode();

  Map<String, Video> videoStore = {};
  Map<String, StreamManifest> manifestStore = {};
  Map<String, SearchList> searchListStore = {};
  SharedPreferences? sharedPreferences;

  @override
  PlayerLaunchParams getLaunchParams(AppModel appModel, MediaHistoryItem item) {
    return PlayerLaunchParams.network(
      appModel: appModel,
      networkPath: item.key,
      mediaSource: this,
      mediaHistoryItem: item,
      saveHistoryItem: true,
    );
  }

  MediaHistoryItem getItemFromUrl(Video video) {
    return MediaHistoryItem(
      key: video.url,
      title: video.title,
      author: video.author,
      sourceName: sourceName,
      mediaTypePrefs: mediaType.prefsDirectory(),
      currentProgress: 0,
      completeProgress: video.duration?.inSeconds ?? 0,
      extra: {"thumbnail": video.thumbnails.mediumResUrl},
    );
  }

  @override
  @override
  Widget? buildSourceButton(BuildContext context, PlayerPageState page) {
    AppModel appModel = Provider.of<AppModel>(context, listen: false);

    return IconButton(
      color: appModel.getIsDarkMode() ? Colors.white : Colors.black,
      icon: const Icon(Icons.video_settings),
      onPressed: () async {
        String url = page.widget.params.mediaHistoryItem.key;
        StreamManifest manifest = await getManifestFromUrl(url);
        YouTubeVideoQuality preferredQuality = await getPreferredQuality();

        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          builder: (context) => BottomSheetDialog(
            options: getQualityOptions(
              page,
              manifest,
              preferredQuality,
              context,
              appModel,
            ),
          ),
        );
      },
    );
  }

  List<BottomSheetDialogOption> getQualityOptions(
      PlayerPageState page,
      StreamManifest manifest,
      YouTubeVideoQuality preferredQuality,
      BuildContext context,
      AppModel appModel) {
    List<BottomSheetDialogOption> options = [];

    List<YouTubeVideoQuality> qualities = getQualitiesFromManifest(manifest);

    for (YouTubeVideoQuality quality in qualities) {
      BottomSheetDialogOption option = BottomSheetDialogOption(
          label: labelFromQuality(quality)!,
          icon: iconFromQuality(quality)!,
          active: quality == preferredQuality,
          action: () async {
            await setPreferredQuality(quality);

            PlayerLaunchParams params =
                getLaunchParams(appModel, page.widget.params.mediaHistoryItem);
            await launchMediaPage(
              context,
              params,
              pushReplacement: true,
            );
            Future.delayed(const Duration(seconds: 3), () async {
              await SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.immersiveSticky);
            });
          });

      options.add(option);
    }

    return options;
  }

  @override
  FutureOr<String> getNetworkStreamUrl(PlayerLaunchParams params) async {
    String url = params.mediaHistoryItem.key;
    StreamManifest manifest = await getManifestFromUrl(url);
    List<YouTubeVideoQuality> qualities = getQualitiesFromManifest(manifest);
    YouTubeVideoQuality preferredQuality = await getPreferredQuality();

    while (!qualities.contains(preferredQuality)) {
      if (preferredQuality.index == 0) {
        preferredQuality = qualities.first;
      } else {
        preferredQuality =
            YouTubeVideoQuality.values.elementAt(preferredQuality.index - 1);
      }
    }

    return getVideoFromManifest(manifest, preferredQuality);
  }

  Future<StreamManifest> getManifestFromUrl(String url) async {
    String videoId = VideoId.fromString(url).toString();
    StreamManifest? manifest = manifestStore[url];
    if (manifest == null) {
      manifest = await yt.videos.streamsClient.getManifest(videoId);
      manifestStore[url] = manifest;
    }

    return manifest;
  }

  @override
  FutureOr<String?> getAudioStreamUrl(PlayerLaunchParams params) async {
    String url = params.mediaHistoryItem.key;
    StreamManifest manifest = await getManifestFromUrl(url);

    AudioStreamInfo streamAudioInfo = manifest.audioOnly.withHighestBitrate();
    return streamAudioInfo.url.toString();
  }

  String getVideoFromManifest(
      StreamManifest manifest, YouTubeVideoQuality preferredQuality) {
    for (VideoStreamInfo streamInfo in manifest.video) {
      if (!streamInfo.videoCodec.contains("avc1")) {
        continue;
      }

      YouTubeVideoQuality? quality =
          qualityFromLabel(streamInfo.videoQualityLabel);

      if (quality == preferredQuality) {
        return streamInfo.url.toString();
      }
    }

    throw Exception("Preferred quality not found");
  }

  @override
  String getHistoryCaption(MediaHistoryItem item) {
    return item.title;
  }

  @override
  String getHistorySubcaption(MediaHistoryItem item) {
    return item.author;
  }

  @override
  Future<ImageProvider<Object>> getHistoryThumbnail(
      MediaHistoryItem item) async {
    String thumbnailUrl = item.extra["thumbnail"]!;
    return NetworkImage(thumbnailUrl);
  }

  @override
  FutureOr<List<MediaHistoryItem>>? getSearchMediaHistoryItems(
      String searchTerm) async {
    SearchList? searchResults;
    SearchList? searchListCached = searchListStore[searchTerm];

    if (searchListCached != null) {
      searchResults = searchListCached;
    } else {
      searchResults = await yt.search.getVideos(searchTerm);
    }

    searchListStore[searchTerm] = searchResults;

    List<MediaHistoryItem> items = [];
    List<Video> videos = [];

    for (Video video in searchResults) {
      if (video.duration == null || video.duration == Duration.zero) {
        continue;
      }

      videos.add(video);
      videoStore[video.url] = video;
      items.add(getItemFromUrl(video));
    }

    return items;
  }

  @override
  List<MediaSourceActionButton> getSearchBarActions(
      BuildContext context, Function() refreshCallback) {
    return [];
  }

  @override
  Future<List<String>> generateSearchSuggestions(String searchTerm) {
    return yt.search.getQuerySuggestions(searchTerm);
  }

  @override
  int get getSearchDebounceDelay => 1500;

  @override
  FutureOr<List<SubtitleItem>> provideSubtitles(
      PlayerLaunchParams params) async {
    String videoId = VideoId.fromString(params.mediaHistoryItem.key).toString();
    ClosedCaptionManifest manifest = await yt.videos.closedCaptions
        .getManifest(videoId, formats: [ClosedCaptionFormat.ttml]);

    List<String> languageCodes = [];
    List<Future<String>> futures = [];

    for (ClosedCaptionTrackInfo trackInfo in manifest.tracks) {
      String languageCode = trackInfo.language.code;
      languageCodes.add(languageCode);
    }

    languageCodes = languageCodes.toSet().toList();

    for (int i = 0; i < languageCodes.length; i++) {
      String languageCode = languageCodes[i];
      futures.add(http.read(Uri.parse(
          "https://www.youtube.com/api/timedtext?lang=$languageCode&v=$videoId")));
    }

    List<SubtitleItem> items = [];
    List<String> xmls = await Future.wait(futures);
    for (int i = 0; i < languageCodes.length; i++) {
      String languageCode = languageCodes[i];

      try {
        String srt = timedTextToSRT(xmls[i]);
        String sanitizedSrt = sanitizeSubtitleArtifacts(srt);
        items.add(
          SubtitleItem(
            controller: SubtitleController(
              provider: SubtitleProvider.fromString(
                data: sanitizedSrt,
                type: SubtitleType.srt,
              ),
            ),
            metadata: "YouTube - [$languageCode]",
            type: SubtitleItemType.webSubtitle,
          ),
        );
      } catch (e) {
        debugPrint(
            "$languageCode failed to convert from xml to srt for $videoId");
      }
    }

    SubtitleItem priorityItem;
    int priorityIndex = languageCodes
        .indexOf(params.appModel.getCurrentLanguage().languageCode);

    if (priorityIndex != -1) {
      priorityItem = items[priorityIndex];
      items.remove(priorityItem);
      List<SubtitleItem> newItems = [];
      newItems.add(priorityItem);
      newItems.addAll(items);
      items = newItems;
    }

    return items;
  }

  @override
  Widget getHistoryExtraMetadata(BuildContext context, MediaHistoryItem item) {
    AppModel appModel = Provider.of<AppModel>(context, listen: false);

    String url = item.key;
    return FutureBuilder<bool>(
      future: hasSubtitles(url),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Row(
            children: [
              Icon(
                Icons.closed_caption,
                color: Theme.of(context).unselectedWidgetColor,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                appModel.translate("closed_captions_query"),
                style: TextStyle(
                  color: Theme.of(context).unselectedWidgetColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              SizedBox(
                width: 12,
                height: 12,
                child: JumpingDotsProgressIndicator(
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              )
            ],
          );
        }

        bool hasSubtitles = snapshot.data!;

        return Row(
          children: [
            Icon(
              hasSubtitles
                  ? Icons.closed_caption
                  : Icons.closed_caption_disabled,
              color: hasSubtitles
                  ? appModel.getIsDarkMode()
                      ? Colors.green[200]
                      : Colors.green[600]
                  : appModel.getIsDarkMode()
                      ? Colors.red[200]
                      : Colors.red[600],
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              hasSubtitles
                  ? appModel.translate("closed_captions_available")
                  : appModel.translate("closed_captions_unavailable"),
              style: TextStyle(
                color: hasSubtitles
                    ? appModel.getIsDarkMode()
                        ? Colors.green[200]
                        : Colors.green[600]
                    : appModel.getIsDarkMode()
                        ? Colors.red[200]
                        : Colors.red[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        );
      },
    );
  }

  List<YouTubeVideoQuality> getQualitiesFromManifest(StreamManifest manifest) {
    List<YouTubeVideoQuality> qualities = [];

    for (VideoStreamInfo streamInfo in manifest.video) {
      if (!streamInfo.videoCodec.contains("avc1")) {
        continue;
      }

      YouTubeVideoQuality? quality =
          qualityFromLabel(streamInfo.videoQualityLabel);
      if (quality != null) {
        qualities.add(quality);
      }
    }

    qualities = qualities.toSet().toList();
    qualities.sort((a, b) => a.index.compareTo(b.index));
    return qualities;
  }

  YouTubeVideoQuality? qualityFromLabel(String label) {
    switch (label) {
      case "144p":
        return YouTubeVideoQuality.sd_144;
      case "240p":
        return YouTubeVideoQuality.sd_240;
      case "360p":
        return YouTubeVideoQuality.sd_360;
      case "480p":
        return YouTubeVideoQuality.sd_360;
      case "720p":
      case "720p60":
        return YouTubeVideoQuality.sd_720;
      case "1080p":
      case "1080p60":
        return YouTubeVideoQuality.hd_1080;
      case "1440p":
      case "1440p60":
        return YouTubeVideoQuality.hd_1440;
      case "2160p":
      case "2160p60":
        return YouTubeVideoQuality.uhd_2160;
      default:
        return null;
    }
  }

  IconData? iconFromQuality(YouTubeVideoQuality quality) {
    switch (quality) {
      case YouTubeVideoQuality.sd_144:
      case YouTubeVideoQuality.sd_240:
      case YouTubeVideoQuality.sd_360:
      case YouTubeVideoQuality.sd_480:
      case YouTubeVideoQuality.sd_720:
        return Icons.sd;
      case YouTubeVideoQuality.hd_1080:
      case YouTubeVideoQuality.hd_1440:
        return Icons.hd;
      case YouTubeVideoQuality.uhd_2160:
        return Icons.four_k;
      default:
        return null;
    }
  }

  String? labelFromQuality(YouTubeVideoQuality quality) {
    switch (quality) {
      case YouTubeVideoQuality.sd_144:
        return "144p";
      case YouTubeVideoQuality.sd_240:
        return "240p";
      case YouTubeVideoQuality.sd_360:
        return "360p";
      case YouTubeVideoQuality.sd_480:
        return "480p";
      case YouTubeVideoQuality.sd_720:
        return "720p";
      case YouTubeVideoQuality.hd_1080:
        return "1080p";
      case YouTubeVideoQuality.hd_1440:
        return "1440p";
      case YouTubeVideoQuality.uhd_2160:
        return "2160p";
      default:
        return null;
    }
  }

  Future<bool> hasSubtitles(String url) async {
    String videoId = VideoId.fromString(url).toString();

    sharedPreferences ??= await SharedPreferences.getInstance();
    bool? hasSubtitlesPrefs =
        sharedPreferences!.getBool(getSubtitlesPrefsKey(videoId));
    if (hasSubtitlesPrefs != null) {
      return hasSubtitlesPrefs;
    }

    ClosedCaptionManifest manifest = await yt.videos.closedCaptions
        .getManifest(videoId, formats: [ClosedCaptionFormat.ttml]);

    List<String> languageCodes = [];

    for (ClosedCaptionTrackInfo trackInfo in manifest.tracks) {
      String languageCode = trackInfo.language.code;
      languageCodes.add(languageCode);
    }

    languageCodes = languageCodes.toSet().toList();

    bool hasSubtitles = languageCodes.isNotEmpty;
    sharedPreferences!.setBool(getSubtitlesPrefsKey(videoId), hasSubtitles);

    return hasSubtitles;
  }

  Future<YouTubeVideoQuality> getPreferredQuality() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return YouTubeVideoQuality.values.elementAt(
        sharedPreferences!.getInt(getQualityPrefsKey()) ??
            YouTubeVideoQuality.sd_480.index);
  }

  Future<void> setPreferredQuality(YouTubeVideoQuality quality) async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    await sharedPreferences!.setInt(getQualityPrefsKey(), quality.index);
  }

  String getSubtitlesPrefsKey(String videoId) {
    return "${getIdentifier()}://subtitles/$videoId";
  }

  String getQualityPrefsKey() {
    return "${getIdentifier()}://quality/";
  }
}
