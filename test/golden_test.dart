import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyrgyzstan_plate/kyrgyzstan_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
        'private': (
          KyrgyzstanPlates.private,
          KyrgyzstanThemes.private,
          '0 1 1 2 3 A B C',
        ),
        'government': (
          KyrgyzstanPlates.government,
          KyrgyzstanThemes.private,
          '0 2 0 1 2 P T',
        ),
        'eco': (KyrgyzstanPlates.eco, KyrgyzstanThemes.eco, '0 1 9 2 3 A R X'),
        'president': (
          KyrgyzstanPlates.president,
          KyrgyzstanThemes.private,
          '0 1',
        ),
        'foreign_h': (
          KyrgyzstanPlates.foreign,
          KyrgyzstanThemes.foreign,
          '0 1 1 2 3 4 H',
        ),
        'diplomatic': (
          KyrgyzstanPlates.diplomatic,
          KyrgyzstanThemes.diplomatic,
          'D 0 1 0 0 1 0 5 1 6',
        ),
        'consular': (
          KyrgyzstanPlates.diplomatic,
          KyrgyzstanThemes.diplomatic,
          'C 0 1 0 0 1 0 5 1 6',
        ),
        'technical': (
          KyrgyzstanPlates.diplomatic,
          KyrgyzstanThemes.diplomatic,
          'T 0 1 0 0 1 0 5 1 6',
        ),
        'diplomatic_un': (
          KyrgyzstanPlates.diplomatic,
          KyrgyzstanThemes.unitedNations,
          'D 0 1 0 0 1 0 5 1 6',
        ),
        'technical_un': (
          KyrgyzstanPlates.diplomatic,
          KyrgyzstanThemes.unitedNations,
          'T 0 1 0 0 1 0 5 1 6',
        ),
        'honorary': (
          KyrgyzstanPlates.honorary,
          KyrgyzstanThemes.diplomatic,
          'H C 1 0 0 1 0 5 1 6',
        ),
        'mission': (
          KyrgyzstanPlates.mission,
          KyrgyzstanThemes.diplomatic,
          'C M D 0 0 1',
        ),
        'mission_un': (
          KyrgyzstanPlates.mission,
          KyrgyzstanThemes.unitedNations,
          'C M D 0 0 1',
        ),
        'square': (
          KyrgyzstanPlates.square,
          KyrgyzstanThemes.square,
          '0 1 1 2 3 A B C',
        ),
        'square_government': (
          KyrgyzstanPlates.squareGovernment,
          KyrgyzstanThemes.square,
          '0 2 0 1 2 P T',
        ),
        'motorcycle': (
          KyrgyzstanPlates.motorcycle,
          KyrgyzstanThemes.motorcycle,
          '0 1 1 2 3 D Q',
        ),
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: KyrgyzstanCountry.kyrgyzstan,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // The flag decal decodes off the test clock; let it land before the shot.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 200)),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/kg_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
