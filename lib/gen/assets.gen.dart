/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/icons
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();

  /// Directory path: assets/images/logo
  $AssetsImagesLogoGen get logo => const $AssetsImagesLogoGen();

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  /// File path: assets/images/icons/add.svg
  String get add => 'assets/images/icons/add.svg';

  /// File path: assets/images/icons/app_logo.svg
  String get appLogo => 'assets/images/icons/app_logo.svg';

  /// File path: assets/images/icons/app_setting.svg
  String get appSetting => 'assets/images/icons/app_setting.svg';

  /// File path: assets/images/icons/check.svg
  String get check => 'assets/images/icons/check.svg';

  /// File path: assets/images/icons/menu.svg
  String get menu => 'assets/images/icons/menu.svg';

  /// File path: assets/images/icons/right_arrow.svg
  String get rightArrow => 'assets/images/icons/right_arrow.svg';

  /// File path: assets/images/icons/search.svg
  String get search => 'assets/images/icons/search.svg';

  /// File path: assets/images/icons/setting.svg
  String get setting => 'assets/images/icons/setting.svg';

  /// List of all assets
  List<String> get values =>
      [add, appLogo, appSetting, check, menu, rightArrow, search, setting];
}

class $AssetsImagesLogoGen {
  const $AssetsImagesLogoGen();

  /// File path: assets/images/logo/App Icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/logo/App Icon.png');

  /// File path: assets/images/logo/logo_fonst.png
  AssetGenImage get logoFonst =>
      const AssetGenImage('assets/images/logo/logo_fonst.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon, logoFonst];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/appbar_logo.png
  AssetGenImage get appbarLogo =>
      const AssetGenImage('assets/images/png/appbar_logo.png');

  /// File path: assets/images/png/bottom_logo_splash.png
  AssetGenImage get bottomLogoSplash =>
      const AssetGenImage('assets/images/png/bottom_logo_splash.png');

  /// File path: assets/images/png/calcuator_logo.png
  AssetGenImage get calcuatorLogo =>
      const AssetGenImage('assets/images/png/calcuator_logo.png');

  /// File path: assets/images/png/card.png
  AssetGenImage get card => const AssetGenImage('assets/images/png/card.png');

  /// File path: assets/images/png/new_splash.png
  AssetGenImage get newSplash =>
      const AssetGenImage('assets/images/png/new_splash.png');

  /// File path: assets/images/png/new_splash_shadow.png
  AssetGenImage get newSplashShadow =>
      const AssetGenImage('assets/images/png/new_splash_shadow.png');

  /// File path: assets/images/png/splash_image.png
  AssetGenImage get splashImage =>
      const AssetGenImage('assets/images/png/splash_image.png');

  /// File path: assets/images/png/splash_logo.png
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/png/splash_logo.png');

  /// File path: assets/images/png/splash_shadow.png
  AssetGenImage get splashShadow =>
      const AssetGenImage('assets/images/png/splash_shadow.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        appbarLogo,
        bottomLogoSplash,
        calcuatorLogo,
        card,
        newSplash,
        newSplashShadow,
        splashImage,
        splashLogo,
        splashShadow
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
