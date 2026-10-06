import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'kyrgyzstan_colors.dart';

/// One ink on a white field with a frame of the same ink.
///
/// Frame 4.3 of 110 is 0.039; the corner radius ratio is read off the artwork
/// by eye.
abstract final class KyrgyzstanThemes {
  /// Black on white.
  static final PlateTheme private = _theme(KyrgyzstanColors.black);

  /// Dark grey on white, for the green-striped electric plate.
  static final PlateTheme eco = _theme(KyrgyzstanColors.ecoInk);
}

PlateTheme _theme(Color ink) => PlateTheme.monochrome(
  field: KyrgyzstanColors.white,
  ink: ink,
  inactive: KyrgyzstanColors.inactive,
  borderWidthRatio: 0.039,
  plateRadiusRatio: 0.08,
);
