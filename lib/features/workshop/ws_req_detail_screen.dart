// lib/features/workshop/ws_req_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '_ws_shared.dart';
import 'ws_diagnostics_screen.dart';
import 'ws_chat_screen.dart';
import '../../core/theme/app_theme.dart';

class WsReqDetailScreen extends StatefulWidget {
  final WsBookingData booking;
  const WsReqDetailScreen({super.key, required this.booking});
  @override
  State<WsReqDetailScreen> createState() => _WsReqDetailScreenState();
}

class _WsReqDetailScreenState extends State<WsReqDetailScreen> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.booking.status;
  }

  void _accept()  => setState(() => _status = RequestStatus.accepted);
  void _start()   => setState(() => _status = RequestStatus.inProgress);
  void _complete(){ setState(() => _status = RequestStatus.completed); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AC.bg,
    appBar: WsBar(
      title: 'Request Details',
      showBack: true,
      actions: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => WsChatScreen(bookingId: widget.booking.id, customerName: widget.booking.customerName))),
          child: Container(
            width: 38, height: 38,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: AC.s2, borderRadius: Rd.smA, border: Border.all(color: AC.border)),
            child: const Icon(Icons.chat_bubble_outline_rounded, color: AC.t2, size: 18),
          ),
        ),
      ],
    ),
    body: Column(children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          children: [
            // ── Status Banner ─────────────────────────────────────────────
            _StatusBanner(status: _status).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 16),

            // ── Service Card ──────────────────────────────────────────────
            WsCard(
              glowColor: AC.warning,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const WsIconBox(Icons.build_circle_rounded, size: 48),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.booking.serviceName,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AC.t1, letterSpacing: -0.3)),
                    const SizedBox(height: 6),
                    WsChip(_status),
                  ])),
                ]),
                const SizedBox(height: 18),
                const WsDiv(),
                const SizedBox(height: 14),
                WsInfoRow(label: 'Date',    value: widget.booking.date),
                const SizedBox(height: 8),
                WsInfoRow(label: 'Time',    value: widget.booking.time),
                const SizedBox(height: 8),
                WsInfoRow(label: 'Vehicle', value: widget.booking.vehicleInfo),
                const SizedBox(height: 10),
                const WsDiv(),
                const SizedBox(height: 10),
                WsInfoRow(label: 'Total',   value: '\$${widget.booking.price.toInt()}', bold: true),
              ]),
            ).animate().fadeIn(duration: 350.ms, delay: 60.ms),

            const SizedBox(height: 14),

            // ── Customer Card ─────────────────────────────────────────────
            WsCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('CUSTOMER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AC.t3, letterSpacing: 1)),
                const SizedBox(height: 14),
                Row(children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(gradient: AC.redGrad, shape: BoxShape.circle),
                    child: Center(child: Text(
                      widget.booking.customerName.isNotEmpty ? widget.booking.customerName[0] : '?',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    )),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.booking.customerName,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AC.t1)),
                    const SizedBox(height: 3),
                    Text(widget.booking.customerPhone,
                        style: const TextStyle(fontSize: 13, color: AC.t3)),
                  ])),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AC.success.withOpacity(0.12), borderRadius: Rd.mdA, border: Border.all(color: AC.success.withOpacity(0.35))),
                      child: const Icon(Icons.call_rounded, color: AC.success, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => WsChatScreen(bookingId: widget.booking.id, customerName: widget.booking.customerName))),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AC.info.withOpacity(0.12), borderRadius: Rd.mdA, border: Border.all(color: AC.info.withOpacity(0.35))),
                      child: const Icon(Icons.chat_rounded, color: AC.info, size: 20),
                    ),
                  ),
                ]),
              ]),
            ).animate().fadeIn(duration: 350.ms, delay: 110.ms),

            const SizedBox(height: 14),

            // ── Notes Card ────────────────────────────────────────────────
            WsCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('CUSTOMER NOTES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AC.t3, letterSpacing: 1)),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity, padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AC.bg, borderRadius: Rd.mdA, border: Border.all(color: AC.border)),
                  child: const Text(
                    'Please check the oil level and inspect the brake pads. The car has been making a clicking sound from the front left wheel.',
                    style: TextStyle(fontSize: 13, color: AC.t2, height: 1.5),
                  ),
                ),
              ]),
            ).animate().fadeIn(duration: 350.ms, delay: 150.ms),

            const SizedBox(height: 14),

            // ── Diagnostics Quick Action ───────────────────────────────────
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WsDiagnosticsScreen())),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AC.purple.withOpacity(0.2), AC.s2]),
                  borderRadius: Rd.lgA,
                  border: Border.all(color: AC.purple.withOpacity(0.3)),
                ),
                child: Row(children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF7C3AED), AC.red]),
                      borderRadius: Rd.mdA,
                    ),
                    child: const Icon(Icons.radar_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Run AI Diagnostics', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AC.t1)),
                    Text('Analyze OBD data for this vehicle', style: TextStyle(fontSize: 12, color: AC.t3)),
                  ])),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AC.t3),
                ]),
              ),
            ).animate().fadeIn(duration: 350.ms, delay: 200.ms),
          ],
        ),
      ),

      // ── Footer Actions ─────────────────────────────────────────────────
      Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        decoration: const BoxDecoration(
          color: AC.s1,
          border: Border(top: BorderSide(color: AC.border, width: 0.5)),
        ),
        child: _buildFooter(),
      ),
    ]),
  );

  Widget _buildFooter() {
    if (_status == RequestStatus.pending) {
      return Row(children: [
        Expanded(child: WsBtn(label: 'Accept', gold: true, icon: Icons.check_circle_rounded, onTap: _accept)),
        const SizedBox(width: 12),
        Expanded(child: WsBtn(label: 'Decline', outline: true, onTap: () => Navigator.pop(context))),
      ]);
    }
    if (_status == RequestStatus.accepted) {
      return WsBtn(label: 'Start Job', icon: Icons.play_arrow_rounded, onTap: _start);
    }
    if (_status == RequestStatus.inProgress) {
      return Row(children: [
        Expanded(child: WsBtn(label: 'Mark Complete', gold: true, icon: Icons.check_rounded, onTap: _complete)),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WsDiagnosticsScreen())),
          child: Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF7C3AED), AC.red]),
              borderRadius: Rd.mdA,
            ),
            child: const Icon(Icons.radar_rounded, color: Colors.white, size: 22),
          ),
        ),
      ]);
    }
    if (_status == RequestStatus.completed) {
      return Container(
        height: 52,
        decoration: BoxDecoration(color: AC.success.withOpacity(0.12), borderRadius: Rd.mdA, border: Border.all(color: AC.success.withOpacity(0.35))),
        child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.check_circle_rounded, color: AC.success, size: 20),
          SizedBox(width: 8),
          Text('Completed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AC.success)),
        ]),
      );
    }
    return const SizedBox.shrink();
  }
}

// ─── STATUS BANNER ────────────────────────────────────────────────────────────
class _StatusBanner extends StatelessWidget {
  final String status;
  const _StatusBanner({required this.status});

  Color get _color => switch (status) {
    RequestStatus.accepted         => AC.success,
    RequestStatus.inProgress       => AC.warning,
    RequestStatus.repairInProgress => AC.warning,
    RequestStatus.completed        => AC.info,
    RequestStatus.cancelled        => AC.error,
    _                              => AC.red,
  };

  IconData get _icon => switch (status) {
    RequestStatus.accepted         => Icons.check_circle_outline_rounded,
    RequestStatus.inProgress       => Icons.autorenew_rounded,
    RequestStatus.repairInProgress => Icons.build_circle_rounded,
    RequestStatus.completed        => Icons.task_alt_rounded,
    RequestStatus.cancelled        => Icons.cancel_outlined,
    _                              => Icons.hourglass_empty_rounded,
  };

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: _color.withOpacity(0.08),
      borderRadius: Rd.mdA,
      border: Border.all(color: _color.withOpacity(0.3)),
    ),
    child: Row(children: [
      Icon(_icon, color: _color, size: 16),
      const SizedBox(width: 10),
      Text('Status: ${RequestStatus.label(status)}',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _color)),
    ]),
  );
}