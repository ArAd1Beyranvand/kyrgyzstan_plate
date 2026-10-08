import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'kyrgyzstan_colors.dart';
import 'kyrgyzstan_country.dart';

/// Where the ink sits, in plate units.
///
/// Every figure was measured off `.plateref/kg` (the originals of the Persian
/// Wikipedia-derived artwork on the article, cropped to the frame and scaled to
/// the canvas): connected-component boxes of the ink for glyph columns and
/// rows, full-height ink columns for dividers, and the red field for the flag.
/// The article gives 520 × 110 mm only; the square and motorcycle canvases
/// (320 × 160, 276 × 200) keep the artwork's aspect and the same ~4.2 frame,
/// which makes their glyph strokes agree with the long plate.
///
/// A slot's ink is about 55% of its box height (`glyphStyle` is 0.72 of the
/// box, a bold cap 0.75 of that), so [_cells] boxes each register at
/// ink / 0.55 centred on the measured ink, and shrinks it where it would leave
/// the canvas. The digits' 73 of ink would need a 132 box on 110 and land near
/// 60; the long plate's letters (61) near 53.
abstract final class _Layout {
  static const double width = 520, height = 110;

  // Dividers: x 128.7–132.9 on private, foreign; 148.2–151 on eco; 451.3–455.8
  // before the diplomatic date box, whose month/year rule is y 51–55.5.
  static const double dividerCx = 130.8, dividerThickness = 4.3;
  static const double ecoDividerCx = 149.6, ecoDividerThickness = 2.8;
  static const double ecoStripStart = 156.75, ecoStripEnd = 171.5;
  static const double dateDividerCx = 453.55, dateDividerThickness = 4.5;
  static const double dateRuleCy = 53.25, dateRuleThickness = 4.5;

  // Private and government (Plak_shakhsi-KG, Plak_dolati-KG). Region ink
  // 13.7–59.9, digits 17.4–91.1, letters 31.1–92.1.
  static const _Run region = _Run(47.3, 33.05, 13.7, 59.9);
  static const _Run digits = _Run(205.5, 52.7, 17.4, 91.1);
  static const _Run governmentDigits = _Run(212.75, 52.85, 17.4, 91.1);
  static const _Run letters = _Run(375.05, 44.85, 31.1, 92.1);
  static const _Run governmentLetters = _Run(386.25, 44.85, 31.1, 92.1);
  // The flag (red field x 18.7–64.1, y 71.6–98.4) and `KG` (ink x 72.6–107.3,
  // y 71.6–97.4, so cap height 25.8 and centre 84.5).
  static const PlateBox flag = PlateBox(18.7, 71.6, 45.4, 26.8);
  static const PlateBox kg = PlateBox(70, 61, 40, 47);
  static const double kgGlyph = 47;

  // Eco (Green-Eco-License-Plate-Kyrgyzstan-2024).
  static const _Run ecoRegion = _Run(62.35, 33.75, 17.2, 62.2);
  static const _Run ecoDigits = _Run(208.1, 52.6, 22.2, 94.2);
  static const _Run ecoLetters = _Run(370.1, 44.8, 34.8, 93.8);
  static const PlateBox ecoFlag = PlateBox(34.2, 71.5, 41.3, 23.3);
  static const PlateBox ecoKg = PlateBox(80.8, 61.25, 40, 41);
  static const double ecoKgGlyph = 41;

  // President (Plak_President-KG): flag block at the left, `01` and `KG` ink
  // x 358.2–441.5, y 30.8–91.5 (a 61 cap height, so the full-height glyph).
  static const PlateBox presidentFlag = PlateBox(8.5, 10, 154.7, 90.8);
  static const _Run presidentRegion = _Run(254.1, 53.8, 19.8, 92.5);
  static const PlateBox presidentKg = PlateBox(359.85, 12.8, 80, 97.2);
  static const double presidentKgGlyph = 111;

  // Foreign (Plak_mohajer/resane/varedat/sherkat_khareji-KG): the four
  // photographs agree to within 4 units; these are the means. No flag.
  static const _Run foreignRegion = _Run(52.9, 34.2, 12.5, 58.8);
  static const _Run foreignDigits = _Run(201.4, 52.3, 16.2, 89.2);
  static const _Run foreignLetter = _Run(432.1, 39.2, 29, 89.25);
  static const PlateBox foreignKg = PlateBox(47.25, 61.6, 40, 46);
  static const double foreignKgGlyph = 46;

  // White-on-colour series (Plak_diplomatic-KG and the ONU/eftekhari/safir
  // flats): glyph ink 17.3–90 (in each run below), month 13–43.5 and year 64.8–95.2 in the date box.
  static const _Run diplomaticClass = _Run(68.6, 46.8, 17.3, 90);
  static const _Run diplomaticMission = _Run(154, 53.2, 17.3, 90);
  static const _Run diplomaticNumber = _Run(288.9, 52.7, 17.3, 90);
  static const _Run honoraryClass = _Run(80.75, 53.65, 17.3, 90);
  static const _Run honoraryNumber = _Run(234.5, 52.2, 17.3, 90);
  static const _Run missionClass = _Run(103.4, 53.2, 16.8, 89.5);
  static const _Run missionNumber = _Run(310.5, 52.6, 16.8, 89.5);
  static const _Run month = _Run(473.8, 22.1, 13, 43.75);
  static const _Run year = _Run(473.8, 22.1, 64.8, 95.2);

  // Square two-row plate (Plak_shakhsi2-KG / Plak_dolati2-KG), 320 × 160.
  static const double squareWidth = 320, squareHeight = 160;
  static const double squareDividerCx = 110.8, squareDividerThickness = 4.2;
  static const _Run squareRegion = _Run(41.2, 33.5, 18.9, 66.8);
  static const _Run squareDigits = _Run(171.6, 42, 17.9, 79.5);
  static const _Run squareLetters = _Run(177.75, 36.1, 94.2, 145.3);
  static const _Run squareGovernmentLetters = _Run(198.35, 36.1, 94.2, 145.3);
  static const PlateBox squareFlag = PlateBox(33.5, 84.2, 43.8, 26.9);
  static const PlateBox squareKg = PlateBox(34.85, 112, 40, 47);

  // Motorcycle plate (Plak_motor-KG), 276 × 200: a second rule splits the
  // left cell at y 101–105.
  static const double motoWidth = 276, motoHeight = 200;
  static const double motoDividerCx = 114.1, motoDividerThickness = 4.2;
  static const double motoRuleCy = 103, motoRuleThickness = 4.2;
  static const _Run motoRegion = _Run(48.3, 34.5, 20.7, 69.1);
  static const _Run motoDigits = _Run(149.65, 43.25, 26.6, 88.8);
  static const _Run motoLetters = _Run(168.25, 37.7, 119.7, 171.3);
  static const PlateBox motoFlag = PlateBox(35, 118.1, 45.1, 27.1);
  static const PlateBox motoKg = PlateBox(37.05, 146.2, 40, 47.5);
}

/// One register's cells: the first at [firstCx], each [pitch] wide and apart,
/// with the ink spanning [inkTop]–[inkBottom].
final class _Run {
  const _Run(this.firstCx, this.pitch, this.inkTop, this.inkBottom);
  final double firstCx, pitch, inkTop, inkBottom;
}

/// A named register, so the text groups come out of the order it is listed in.
final class _Register {
  _Register(
    this.key,
    PlateAlphabet alphabet,
    _Run run,
    int count,
    double canvasHeight,
  ) : slots = _cells(alphabet, run, count, canvasHeight);
  final String key;
  final List<PlateSlot> slots;
}

List<PlateSlot> _cells(
  PlateAlphabet alphabet,
  _Run run,
  int count,
  double canvasHeight,
) {
  final double centre = (run.inkTop + run.inkBottom) / 2;
  final double fit =
      2 * (centre < canvasHeight - centre ? centre : canvasHeight - centre);
  final double wanted = (run.inkBottom - run.inkTop) / 0.55;
  final double height = wanted < fit ? wanted : fit;
  return plateRegister(
    alphabet: alphabet,
    count: count,
    left: run.firstCx - run.pitch / 2,
    top: centre - height / 2,
    width: run.pitch,
    height: height,
  );
}

PlateSection _split(double end, double thickness, [PlateSection? right]) =>
    PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: end, divider: thickness),
      PlatePart(right ?? PlateSection.plain),
    ]);

const AssetImage _flagImage = AssetImage(
  // Commons: File:Flag_of_Kyrgyzstan.svg, red recoloured to the plates'
  // E8112D; assets/icons/kyrgyzstan_flag.svg is the vector.
  'assets/icons/kyrgyzstan_flag.png',
  package: 'kyrgyzstan_plate',
);

PlateSpec _spec({
  required String id,
  required List<_Register> registers,
  double width = _Layout.width,
  double height = _Layout.height,
  PlateSection background = PlateSection.plain,
  List<PlateLabel> labels = const <PlateLabel>[],
  List<PlateBox> flags = const <PlateBox>[],
}) {
  final List<PlateSlot> slots = <PlateSlot>[];
  final List<PlateTextGroup> groups = <PlateTextGroup>[];
  for (final _Register r in registers) {
    groups.add(
      PlateTextGroup(<int>[
        for (var i = 0; i < r.slots.length; i++) slots.length + i,
      ], key: r.key),
    );
    slots.addAll(r.slots);
  }
  return PlateSpec(
    id: id,
    country: KyrgyzstanCountry.kyrgyzstan,
    canvasWidth: width,
    canvasHeight: height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    background: background,
    slots: slots,
    labels: labels,
    decals: <PlateDecal>[
      for (final PlateBox box in flags) PlateDecal(image: _flagImage, box: box),
    ],
    textGroups: groups,
  );
}

PlateLabel _kg(PlateBox box, double glyph) =>
    PlateLabel(text: 'KG', box: box, glyphHeight: glyph);

/// The Kyrgyz plates since 2015, in the designs the article shows.
///
/// - [private], [government], [eco]: `01 | 123 ABC`. A two-digit region code
///   over the flag and `KG`, an edge-to-edge divider, three digits and two or
///   three letters. [government] ends in `PT` and sits two cells left of the
///   private serial; [eco] is dark grey with a green strip after a thinner
///   divider.
/// - [president]: the flag as a block at the left, then `01 KG`.
/// - [foreign]: black on yellow, `01 | 1234 H`; the class letter is H, K, M
///   or P. `KG` stands alone, no flag.
/// - [diplomatic], [honorary], [mission]: white on red or blue; the colour
///   is the theme's. Letter, mission code and number, with a dated box (month
///   over year) after a divider on the first two.
/// - [square], [squareGovernment], [motorcycle]: the two-row plates.
///
/// Not implemented: the 1980 Soviet-style and 1994 / 2009 `B 0123 BI` plates
/// (`License_plate_of_Kyrgyzstan2`, `Pelak_shakhsi_Kyrgyzstan_2009`) — the
/// article calls them superseded — and the logos of the international
/// organisations (EBRD, World Bank, JICA, ADB, Aga Khan), which are not plates.
/// The consular, diplomatic and technical red plates share one spec with the
/// blue UN ones; only the theme differs. The blue and red `CMD 001` flats sit
/// 9 units apart in the photographs; the red one (centred on the plate) is used.
abstract final class KyrgyzstanPlates {
  static final PlateSpec private = _spec(
    id: 'kg.private',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.region,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.digits,
        3,
        _Layout.height,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        _Layout.letters,
        3,
        _Layout.height,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.kg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.flag],
  );

  static final PlateSpec government = _spec(
    id: 'kg.government',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.region,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.governmentDigits,
        3,
        _Layout.height,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        _Layout.governmentLetters,
        2,
        _Layout.height,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.kg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.flag],
  );

  static final PlateSpec eco = _spec(
    id: 'kg.eco',
    background: PlateSection.columns(<PlatePart>[
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
    ]),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.ecoRegion,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.ecoDigits,
        3,
        _Layout.height,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        _Layout.ecoLetters,
        3,
        _Layout.height,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.ecoKg, _Layout.ecoKgGlyph)],
    flags: const <PlateBox>[_Layout.ecoFlag],
  );

  static final PlateSpec president = _spec(
    id: 'kg.president',
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.presidentRegion,
        2,
        _Layout.height,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.presidentKg, _Layout.presidentKgGlyph)],
    flags: const <PlateBox>[_Layout.presidentFlag],
  );

  static final PlateSpec foreign = _spec(
    id: 'kg.foreign',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.foreignRegion,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.foreignDigits,
        4,
        _Layout.height,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        _Layout.foreignLetter,
        1,
        _Layout.height,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.foreignKg, _Layout.foreignKgGlyph)],
  );

  static final PlateSection _dated = _split(
    _Layout.dateDividerCx,
    _Layout.dateDividerThickness,
    PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.dateRuleCy,
        divider: _Layout.dateRuleThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
  );

  static List<_Register> _issued() => <_Register>[
    _Register(
      'month',
      KyrgyzstanAlphabets.digits,
      _Layout.month,
      2,
      _Layout.height,
    ),
    _Register(
      'year',
      KyrgyzstanAlphabets.digits,
      _Layout.year,
      2,
      _Layout.height,
    ),
  ];

  static final PlateSpec diplomatic = _spec(
    id: 'kg.diplomatic',
    background: _dated,
    registers: <_Register>[
      _Register(
        'class',
        KyrgyzstanAlphabets.letters,
        _Layout.diplomaticClass,
        1,
        _Layout.height,
      ),
      _Register(
        'mission',
        KyrgyzstanAlphabets.digits,
        _Layout.diplomaticMission,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.diplomaticNumber,
        3,
        _Layout.height,
      ),
      ..._issued(),
    ],
  );

  static final PlateSpec honorary = _spec(
    id: 'kg.honorary',
    background: _dated,
    registers: <_Register>[
      _Register(
        'class',
        KyrgyzstanAlphabets.letters,
        _Layout.honoraryClass,
        2,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.honoraryNumber,
        4,
        _Layout.height,
      ),
      ..._issued(),
    ],
  );

  static final PlateSpec mission = _spec(
    id: 'kg.mission',
    registers: <_Register>[
      _Register(
        'class',
        KyrgyzstanAlphabets.letters,
        _Layout.missionClass,
        3,
        _Layout.height,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.missionNumber,
        3,
        _Layout.height,
      ),
    ],
  );

  static PlateSpec _square(String id, _Run letters, int count) => _spec(
    id: id,
    width: _Layout.squareWidth,
    height: _Layout.squareHeight,
    background: _split(_Layout.squareDividerCx, _Layout.squareDividerThickness),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.squareRegion,
        2,
        _Layout.squareHeight,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.squareDigits,
        3,
        _Layout.squareHeight,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        letters,
        count,
        _Layout.squareHeight,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.squareKg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.squareFlag],
  );

  static final PlateSpec square = _square(
    'kg.square',
    _Layout.squareLetters,
    3,
  );

  static final PlateSpec squareGovernment = _square(
    'kg.square_government',
    _Layout.squareGovernmentLetters,
    2,
  );

  static final PlateSpec motorcycle = _spec(
    id: 'kg.motorcycle',
    width: _Layout.motoWidth,
    height: _Layout.motoHeight,
    background: PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(
            PlateSection.plain,
            end: _Layout.motoRuleCy,
            divider: _Layout.motoRuleThickness,
          ),
          PlatePart(PlateSection.plain),
        ]),
        end: _Layout.motoDividerCx,
        divider: _Layout.motoDividerThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
    registers: <_Register>[
      _Register(
        'region',
        KyrgyzstanAlphabets.digits,
        _Layout.motoRegion,
        2,
        _Layout.motoHeight,
      ),
      _Register(
        'number',
        KyrgyzstanAlphabets.digits,
        _Layout.motoDigits,
        3,
        _Layout.motoHeight,
      ),
      _Register(
        'letters',
        KyrgyzstanAlphabets.letters,
        _Layout.motoLetters,
        2,
        _Layout.motoHeight,
      ),
    ],
    labels: <PlateLabel>[_kg(_Layout.motoKg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.motoFlag],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    government,
    eco,
    president,
    foreign,
    diplomatic,
    honorary,
    mission,
    square,
    squareGovernment,
    motorcycle,
  ];
}
