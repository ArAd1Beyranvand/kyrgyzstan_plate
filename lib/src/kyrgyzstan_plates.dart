import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'kyrgyzstan_colors.dart';
import 'kyrgyzstan_country.dart';

/// Where the ink sits, in plate units. Measured off `Plak_shakhsi-KG` (1000 px
/// across the frame, normalised to the article's 520 × 110 mm; the brief's
/// flat is cropped to the serial and was not used) and, for the eco stripe,
/// `Green-Eco-License-Plate-Kyrgyzstan-2024`.
///
/// - frame 4.3; divider x 128.7–132.9 (centre 130.8, 4.2 thick).
/// - `01`: ink x 33–107 in two glyphs (centres 47, 88), y 13–56.
/// - flag x 19–64, y 71.6–98.4; `KG` ink x 72–107, y 75–97.
/// - serial digits: x 183.7–228, 235.4–280, 288.8–333 (pitch 52.5), ink y
///   17–92; letters x 355.6–394.5, 400.4–439.4, 445.3–484.2 (pitch 45), ink
///   y 32–92.
/// - eco: divider x 148–150.5 (3 thick), green strip x 156–171.
///
/// Ink is not box: a slot's ink is about 55% of its box height. The serial
/// digits' 75 would need a 136 box on a 110 plate, so they get the full height
/// and land near 60 (80% of reference); the letters' 60 gets 96 and lands
/// near 53; `01` (ink 43) gets 68 for about 37.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double dividerCx = 130.8, dividerThickness = 4.2;
  static const double ecoDividerCx = 149.2, ecoDividerThickness = 3;
  static const double ecoStripStart = 156, ecoStripEnd = 171;

  static const List<double> regionCx = <double>[47, 88];
  static const double regionWidth = 40, regionTop = 0, regionBox = 68;

  static const List<double> digitCx = <double>[205.9, 258.4, 310.9];
  static const double digitWidth = 52, digitTop = 0, digitBox = 110;

  static const List<double> letterCx = <double>[375, 420, 465];
  static const double letterWidth = 45, letterTop = 14, letterBox = 96;

  static const double flagLeft = 19, flagTop = 71.6;
  static const double flagWidth = 45, flagHeight = 26.8;
  static const double sunDiameter = 14;

  static const double kgLeft = 70, kgTop = 66, kgWidth = 40, kgHeight = 40;
  static const double kgGlyph = 40;
}

/// The Kyrgyz plates since 2015: `01 123ABC`, a two-digit region code over
/// the flag and `KG`, an edge-to-edge divider, then three digits and two or
/// three letters.
///
/// [private] is black on white; [eco] adds the green strip of the electric
/// plate after the divider and prints in grey.
///
/// Not implemented, for want of a measured reference: the square two-row
/// plate, the diplomatic and consular series with their mission codes, and
/// the 1980 and 1994 formats. The eco plate reuses the private plate's region
/// placement, which the artwork shifts by about 10 units.
abstract final class KyrgyzstanPlates {
  static final PlateSpec private = _spec(id: 'kg.private', eco: false);

  static final PlateSpec eco = _spec(id: 'kg.eco', eco: true);

  static List<PlateSpec> get all => <PlateSpec>[private, eco];

  static List<PlateSlot> _slots(
    List<double> centres,
    double width,
    double top,
    double box,
    PlateAlphabet alphabet,
  ) => <PlateSlot>[
    for (final double cx in centres)
      PlateSlot(
        alphabet: alphabet,
        box: PlateBox(cx - width / 2, top, width, box),
      ),
  ];

  static PlateSpec _spec({required String id, required bool eco}) {
    final PlateSection background = eco
        ? const PlateSection.columns(<PlatePart>[
            PlatePart(
              PlateSection.plain,
              end: _Layout.ecoDividerCx,
              divider: _Layout.ecoDividerThickness,
            ),
            PlatePart(PlateSection.plain, end: _Layout.ecoStripStart),
            PlatePart(
              PlateSection.fill(PlateFill.color(KyrgyzstanColors.ecoGreen)),
              end: _Layout.ecoStripEnd,
            ),
            PlatePart(PlateSection.plain),
          ])
        : const PlateSection.columns(<PlatePart>[
            PlatePart(
              PlateSection.plain,
              end: _Layout.dividerCx,
              divider: _Layout.dividerThickness,
            ),
            PlatePart(PlateSection.plain),
          ]);
    return PlateSpec(
      id: id,
      country: KyrgyzstanCountry.kyrgyzstan,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: const PlatePanel(
        box: PlateBox(0, 0, 0, 0),
        padding: EdgeInsets.zero,
      ),
      noPanel: true,
      background: background,
      slots: <PlateSlot>[
        ..._slots(
          _Layout.regionCx,
          _Layout.regionWidth,
          _Layout.regionTop,
          _Layout.regionBox,
          KyrgyzstanAlphabets.digits,
        ),
        ..._slots(
          _Layout.digitCx,
          _Layout.digitWidth,
          _Layout.digitTop,
          _Layout.digitBox,
          KyrgyzstanAlphabets.digits,
        ),
        ..._slots(
          _Layout.letterCx,
          _Layout.letterWidth,
          _Layout.letterTop,
          _Layout.letterBox,
          KyrgyzstanAlphabets.letters,
        ),
      ],
      bands: const <PlateBand>[
        PlateBand(
          box: PlateBox(
            _Layout.flagLeft,
            _Layout.flagTop,
            _Layout.flagWidth,
            _Layout.flagHeight,
          ),
          color: KyrgyzstanColors.flagRed,
        ),
        PlateBand(
          box: PlateBox(
            _Layout.flagLeft + (_Layout.flagWidth - _Layout.sunDiameter) / 2,
            _Layout.flagTop + (_Layout.flagHeight - _Layout.sunDiameter) / 2,
            _Layout.sunDiameter,
            _Layout.sunDiameter,
          ),
          color: KyrgyzstanColors.flagSun,
          topCornerRadius: _Layout.sunDiameter / 2,
          bottomCornerRadius: _Layout.sunDiameter / 2,
        ),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'KG',
          box: PlateBox(
            _Layout.kgLeft,
            _Layout.kgTop,
            _Layout.kgWidth,
            _Layout.kgHeight,
          ),
          glyphHeight: _Layout.kgGlyph,
        ),
      ],
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0, 1], key: 'region'),
        PlateTextGroup(<int>[2, 3, 4], key: 'number'),
        PlateTextGroup(<int>[5, 6, 7], key: 'letters'),
      ],
    );
  }
}
