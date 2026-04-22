import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/models.dart';
import '../../../shared/widgets/app_widgets.dart';

class DiagResultScreen extends StatelessWidget {
  const DiagResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final report = DiagnosticReport.mock;
    final ai     = report.aiPrediction;

    return Scaffold(
      backgroundColor: AC.bg,
      appBar: SAppBar(
        title: 'AI Diagnostic Report',
        actions: [
          _BarAction(Icons.share_outlined, () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Health Gauge Card ────────────────────────────────────────
            _HealthCard(report: report).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3),
            const SizedBox(height: 20),

            // ─── AI Prediction Card ───────────────────────────────────────
            if (ai != null) ...[
              _AiPredictionCard(ai: ai).animate().fadeIn(duration: 400.ms, delay: 80.ms).slideY(begin: 0.3),
              const SizedBox(height: 20),
            ],

            // ─── Vitals Grid ─────────────────────────────────────────────
            _SectionLabel('Vehicle Vitals'),
            const SizedBox(height: 12),
            _VitalsGrid(vitals: report.vitals).animate().fadeIn(duration: 400.ms, delay: 140.ms),
            const SizedBox(height: 20),

            // ─── Fault Codes ─────────────────────────────────────────────
            if (report.faultCodes.isNotEmpty) ...[
              _SectionLabel('OBD Fault Codes  (${report.faultCodes.length})'),
              const SizedBox(height: 12),
              ...report.faultCodes.asMap().entries.map((e) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _FaultCodeTile(code: e.value)
                      .animate().fadeIn(duration: 350.ms, delay: (160 + e.key * 50).ms),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // ─── Recommendations ─────────────────────────────────────────
            _SectionLabel('Recommendations'),
            const SizedBox(height: 12),
            ACard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: report.recommendations.asMap().entries.map((e) =>
                  Padding(
                    padding: EdgeInsets.only(bottom: e.key < report.recommendations.length - 1 ? 12.0 : 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22, height: 22,
                          decoration: BoxDecoration(gradient: AC.redGrad, borderRadius: Rd.fullA),
                          child: Center(child: Text('${e.key + 1}',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e.value,
                            style: const TextStyle(fontSize: 13, color: AC.t2, height: 1.5))),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 220.ms),

            const SizedBox(height: 24),
            // ─── CTA Buttons ─────────────────────────────────────────────
            AppBtn(
              label: 'Book Service Now',
              icon: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 18),
              onTap: () => Navigator.pushNamed(context, R.bookService),
            ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            const SizedBox(height: 12),
            AppBtn(
              label: 'View History',
              outline: true,
              icon: const Icon(Icons.history_rounded, color: AC.red, size: 18),
              onTap: () => Navigator.pushNamed(context, R.diagHistory),
            ).animate().fadeIn(duration: 400.ms, delay: 360.ms),
          ],
        ),
      ),
    );
  }
}

// ─── BAR ACTION ──────────────────────────────────────────────────────────────
class _BarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _BarAction(this.icon, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40, height: 40,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: AC.s2, borderRadius: Rd.smA, border: Border.all(color: AC.border)),
      child: Icon(icon, color: AC.t2, size: 18),
    ),
  );
}

// ─── HEALTH CARD ─────────────────────────────────────────────────────────────
class _HealthCard extends StatelessWidget {
  final DiagnosticReport report;
  const _HealthCard({required this.report});

  Color get _riskColor => switch (report.riskLevel) {
    RiskLevel.healthy  => AC.success,
    RiskLevel.critical => AC.error,
    _                  => AC.warning,
  };

  String get _riskLabel => switch (report.riskLevel) {
    RiskLevel.healthy  => 'HEALTHY',
    RiskLevel.critical => 'CRITICAL',
    _                  => 'WARNING',
  };

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_riskColor.withOpacity(0.18), AC.s2, AC.s1],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: Rd.lgA,
      border: Border.all(color: _riskColor.withOpacity(0.35)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _riskColor.withOpacity(0.15),
                  borderRadius: Rd.fullA,
                  border: Border.all(color: _riskColor.withOpacity(0.4)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: _riskColor, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(_riskLabel, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: _riskColor, letterSpacing: 1)),
                ]),
              ),
              const SizedBox(height: 12),
              Text(report.summary, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AC.t1, height: 1.4)),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.calendar_today_rounded, size: 12, color: AC.t3),
                const SizedBox(width: 5),
                Text(report.date, style: const TextStyle(fontSize: 12, color: AC.t3)),
              ]),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _GaugePainter(value: report.health, color: _riskColor),
      ],
    ),
  );
}

class _GaugePainter extends StatelessWidget {
  final double value;
  final Color color;
  const _GaugePainter({required this.value, required this.color});

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _ArcPaint(value: value, color: color),
    child: SizedBox(width: 110, height: 66, child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('${value.toInt()}%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
        const Text('Health', style: TextStyle(fontSize: 10, color: AC.t3)),
        const SizedBox(height: 4),
      ],
    )),
  );
}

class _ArcPaint extends CustomPainter {
  final double value;
  final Color color;
  const _ArcPaint({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height - 4);
    const r = 48.0; const sw = 7.0;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), math.pi, math.pi, false,
        Paint()..color = AC.border..style = PaintingStyle.stroke..strokeWidth = sw..strokeCap = StrokeCap.round);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), math.pi, math.pi * (value / 100), false,
        Paint()
          ..shader = LinearGradient(colors: [color.withOpacity(0.5), color])
              .createShader(Rect.fromCircle(center: c, radius: r))
          ..style = PaintingStyle.stroke..strokeWidth = sw..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(_ArcPaint o) => o.value != value;
}

// ─── AI PREDICTION CARD ───────────────────────────────────────────────────────
class _AiPredictionCard extends StatelessWidget {
  final AIPrediction ai;
  const _AiPredictionCard({required this.ai});

  Color get _urgColor => switch (ai.urgency) {
    RiskLevel.critical => AC.error,
    RiskLevel.warning  => AC.warning,
    _                  => AC.success,
  };

  @override
  Widget build(BuildContext context) => ACard(
    glow: true,
    glowColor: AC.purple,
    padding: const EdgeInsets.all(18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF7C3AED), AC.red]),
            borderRadius: Rd.mdA,
          ),
          child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('AI Diagnosis', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AC.t1)),
          Text('Machine learning analysis', style: TextStyle(fontSize: 11, color: AC.t3)),
        ])),
        GoldBadge('AI Powered', icon: Icons.auto_awesome_rounded),
      ]),
      const SizedBox(height: 16),
      const Div(),
      const SizedBox(height: 16),

      // Issue
      Row(children: [
        const Icon(Icons.warning_amber_rounded, size: 16, color: AC.warning),
        const SizedBox(width: 8),
        Expanded(child: Text(ai.issue, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AC.t1))),
      ]),
      const SizedBox(height: 6),

      // Confidence + Category
      Row(children: [
        _ConfBadge(ai.confidence),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AC.s3, borderRadius: Rd.fullA, border: Border.all(color: AC.border)),
          child: Text(ai.repairCategory, style: const TextStyle(fontSize: 10, color: AC.t2, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: _urgColor.withOpacity(0.12), borderRadius: Rd.fullA, border: Border.all(color: _urgColor.withOpacity(0.4))),
          child: Text(ai.urgency.toUpperCase(), style: TextStyle(fontSize: 10, color: _urgColor, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
        ),
      ]),
      const SizedBox(height: 14),

      // Technical Note
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AC.bg, borderRadius: Rd.mdA, border: Border.all(color: AC.border)),
        child: Text(ai.technicalNote, style: const TextStyle(fontSize: 12, color: AC.t2, height: 1.5)),
      ),
      const SizedBox(height: 12),

      // Recommended Fix
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: AC.success.withOpacity(0.12), borderRadius: Rd.smA),
          child: const Icon(Icons.build_circle_rounded, size: 14, color: AC.success),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(ai.recommendedFix, style: const TextStyle(fontSize: 12, color: AC.t2, height: 1.5))),
      ]),
    ]),
  );
}

class _ConfBadge extends StatelessWidget {
  final double confidence;
  const _ConfBadge(this.confidence);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(gradient: AC.goldGrad, borderRadius: Rd.fullA),
    child: Text('${(confidence * 100).toInt()}% confident',
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AC.bg)),
  );
}

// ─── VITALS GRID ──────────────────────────────────────────────────────────────
class _VitalsGrid extends StatelessWidget {
  final List<OBDVital> vitals;
  const _VitalsGrid({required this.vitals});

  Color _color(double v) => v >= 75 ? AC.success : v >= 50 ? AC.warning : AC.error;

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: vitals.map((v) {
      final col = _color(v.value);
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: col.withOpacity(0.08),
          borderRadius: Rd.mdA,
          border: Border.all(color: col.withOpacity(0.25)),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('${v.value.toInt()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: col)),
          Text(v.unit, style: TextStyle(fontSize: 10, color: col.withOpacity(0.7))),
          const SizedBox(height: 4),
          Text(v.key, style: const TextStyle(fontSize: 10, color: AC.t3), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ]),
      );
    }).toList(),
  );
}

// ─── FAULT CODE TILE ─────────────────────────────────────────────────────────
class _FaultCodeTile extends StatelessWidget {
  final OBDFaultCode code;
  const _FaultCodeTile({required this.code});

  Color get _col => switch (code.severity) {
    RiskLevel.critical => AC.error,
    RiskLevel.warning  => AC.warning,
    _                  => AC.success,
  };

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _col.withOpacity(0.06),
      borderRadius: Rd.mdA,
      border: Border.all(color: _col.withOpacity(0.25)),
    ),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: _col.withOpacity(0.15), borderRadius: Rd.smA),
        child: Text(code.code, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _col)),
      ),
      const SizedBox(width: 12),
      Expanded(child: Text(code.description, style: const TextStyle(fontSize: 12, color: AC.t2, height: 1.4))),
    ]),
  );
}

// ─── SECTION LABEL ───────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AC.t1, letterSpacing: -0.2));
}