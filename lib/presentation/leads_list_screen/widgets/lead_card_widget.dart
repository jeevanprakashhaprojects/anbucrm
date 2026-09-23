import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/status_badge_widget.dart';
import '../leads_list_screen.dart' as leads_screen;
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';

// Global starred leads set — persists across screens
final Set<String> globalStarredLeadIds = {};

class LeadCardWidget extends StatefulWidget {
  final leads_screen.LeadModel lead;
  final int index;
  final VoidCallback? onRemove;

  const LeadCardWidget({
    super.key,
    required this.lead,
    required this.index,
    this.onRemove,
  });

  @override
  State<LeadCardWidget> createState() => _LeadCardWidgetState();
}

class _LeadCardWidgetState extends State<LeadCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnim = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    Future.delayed(
      Duration(milliseconds: (widget.index * 60).clamp(0, 400)),
      () {
        if (mounted) _entranceController.forward();
      },
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  Color _priorityColor(String p) => AppTheme.priorityColor(p);

  bool get _isStarred => globalStarredLeadIds.contains(widget.lead.id);

  void _toggleStar() {
    setState(() {
      if (_isStarred) {
        globalStarredLeadIds.remove(widget.lead.id);
      } else {
        globalStarredLeadIds.add(widget.lead.id);
      }
      // Also update the globalLeadMaps
      final idx = leads_screen.globalLeadMaps.indexWhere(
        (m) => m['id'] == widget.lead.id,
      );
      if (idx >= 0) {
        leads_screen.globalLeadMaps[idx]['isStarred'] = !_isStarred;
      }
    });
  }

  /// Returns relative time string like "2 days ago", "1 week ago"
  String _relativeAge(dynamic dt) {
    final diff = dt is DateTime
        ? DateTime.now().difference(dt)
        : const Duration();
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? 's' : ''} ago';
    }
    if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() > 1 ? 's' : ''} ago';
    }
    return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() > 1 ? 's' : ''} ago';
  }

  /// Format date as "25 Aug 2026"
  String _formatDate(dynamic dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  /// Format time as "2:32 PM"
  String _formatTime(dynamic dt) {
    final hour = (dt as dynamic).hour > 12
        ? (dt as dynamic).hour - 12
        : ((dt as dynamic).hour == 0 ? 12 : (dt as dynamic).hour);
    final ampm = (dt as dynamic).hour >= 12 ? 'PM' : 'AM';
    final min = (dt as dynamic).minute.toString().padLeft(2, '0');
    return '$hour:$min $ampm';
  }

  /// Format scheduled action date string "d/m/yyyy" + time "HH:mm" into readable form
  String _formatScheduledDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    final parts = dateStr.split('/');
    if (parts.length != 3) return dateStr;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final day = int.tryParse(parts[0]) ?? 0;
    final month = int.tryParse(parts[1]) ?? 1;
    final year = parts[2];
    if (month < 1 || month > 12) return dateStr;
    return '$day ${months[month - 1]} $year';
  }

  String _formatScheduledTime(String timeStr) {
    if (timeStr.isEmpty) return '';
    final parts = timeStr.split(':');
    if (parts.length != 2) return timeStr;
    final hour = int.tryParse(parts[0]) ?? 0;
    final min = parts[1];
    final ampm = hour >= 12 ? 'PM' : 'AM';
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$h:$min $ampm';
  }

  /// Icon for scheduled action
  IconData _actionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'appointment':
        return Icons.calendar_today_rounded;
      case 'follow-up':
        return Icons.repeat_rounded;
      case 'video call':
        return Icons.videocam_outlined;
      case 'call back':
        return Icons.phone_callback_rounded;
      case 'not interested':
        return Icons.do_not_disturb_alt_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }

  Color _actionColor(String action) {
    switch (action.toLowerCase()) {
      case 'appointment':
        return AppTheme.primary;
      case 'follow-up':
        return const Color(0xFF7C3AED);
      case 'video call':
        return const Color(0xFF0891B2);
      case 'call back':
        return AppTheme.success;
      case 'not interested':
        return AppTheme.error;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lead = widget.lead;
    final statusColor = AppTheme.leadStatusColor(lead.status);
    final priorityColor = _priorityColor(lead.priority);
    final isVip = lead.tags.contains('VIP');
    final isStarred = _isStarred;

    // Get scheduled action from global map
    final map = leads_screen.globalLeadMaps.firstWhere(
      (m) => m['id'] == lead.id,
      orElse: () => {},
    );
    final scheduledAction = map['scheduledAction'] as String? ?? '';
    final scheduledActionDate = map['scheduledActionDate'] as String? ?? '';
    final scheduledActionTime = map['scheduledActionTime'] as String? ?? '';
    final createdAt = map['createdAt'] is DateTime
        ? map['createdAt'] as DateTime
        : lead.createdAt;
    final showDateTime =
        scheduledAction.isNotEmpty &&
        scheduledAction.toLowerCase() != 'not interested';

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Dismissible(
          key: Key(lead.id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          confirmDismiss: (_) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      'Remove Lead',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: Text(
                      'Remove ${lead.name} from your pipeline?',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.error,
                        ),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                ) ??
                false;
          },
          onDismissed: (_) => widget.onRemove?.call(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(color: priorityColor, width: 3),
                top: isStarred
                    ? BorderSide(
                        color: const Color(0xFFF59E0B).withAlpha(120),
                        width: 1,
                      )
                    : BorderSide.none,
                right: isStarred
                    ? BorderSide(
                        color: const Color(0xFFF59E0B).withAlpha(120),
                        width: 1,
                      )
                    : BorderSide.none,
                bottom: isStarred
                    ? BorderSide(
                        color: const Color(0xFFF59E0B).withAlpha(120),
                        width: 1,
                      )
                    : BorderSide.none,
              ),
              boxShadow: [
                BoxShadow(
                  color: isStarred
                      ? const Color(0xFFF59E0B).withAlpha(30)
                      : Colors.black.withAlpha(13),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => context.go(AppRoutes.leadDetailScreen, extra: lead),
              borderRadius: BorderRadius.circular(16),
              splashColor: AppTheme.primaryContainer.withAlpha(128),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── TOP ROW: Priority + Status + VIP + Star + relative age ──
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Priority badge (Low/Medium/High)
                        StatusBadgeWidget(
                          label: lead.priority,
                          color: priorityColor,
                        ),
                        const SizedBox(width: 6),
                        // Status badge (Won/Lost/New/etc.)
                        StatusBadgeWidget(
                          label: lead.status,
                          color: statusColor,
                        ),
                        // VIP badge right after status if VIP
                        if (isVip) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFB45309).withAlpha(80),
                              ),
                            ),
                            child: Text(
                              'VIP',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        // Star toggle button
                        GestureDetector(
                          onTap: _toggleStar,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isStarred
                                  ? const Color(0xFFFEF3C7)
                                  : AppTheme.surface100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isStarred
                                    ? const Color(0xFFF59E0B).withAlpha(120)
                                    : AppTheme.surface200,
                              ),
                            ),
                            child: Icon(
                              isStarred
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              size: 16,
                              color: isStarred
                                  ? const Color(0xFFF59E0B)
                                  : AppTheme.textMuted,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Relative age on the right
                        if (createdAt != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 11,
                                color: AppTheme.textMuted,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                _relativeAge(createdAt),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    // Important badge if starred
                    if (isStarred) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withAlpha(80),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 10,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Important',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 10),

                    // ── NAME ──
                    Text(
                      lead.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),

                    // ── PHONE ──
                    if (lead.phone.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_rounded,
                            size: 12,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lead.phone,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // ── CREATED DATE + TIME (separate date and time) ──
                    if (createdAt != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 11,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(createdAt),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time_rounded,
                            size: 11,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            _formatTime(createdAt),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 10),

                    // ── INTEREST TAGS ──
                    if (lead.interests?.isNotEmpty ?? false) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: lead.interests!.map((interest) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryContainer.withAlpha(180),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              interest,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // ── SCHEDULED ACTION BADGE ──
                    if (scheduledAction.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _actionColor(scheduledAction).withAlpha(18),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _actionColor(scheduledAction).withAlpha(60),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _actionIcon(scheduledAction),
                              size: 12,
                              color: _actionColor(scheduledAction),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              scheduledAction,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _actionColor(scheduledAction),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Show scheduled date + time only when NOT "Not Interested"
                      if (showDateTime &&
                          (scheduledActionDate.isNotEmpty ||
                              scheduledActionTime.isNotEmpty)) ...[
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (scheduledActionDate.isNotEmpty) ...[
                              Icon(
                                Icons.event_rounded,
                                size: 11,
                                color: _actionColor(scheduledAction),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                _formatScheduledDate(scheduledActionDate),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: _actionColor(scheduledAction),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            if (scheduledActionDate.isNotEmpty &&
                                scheduledActionTime.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                width: 1,
                                height: 10,
                                color: _actionColor(
                                  scheduledAction,
                                ).withAlpha(80),
                              ),
                            if (scheduledActionTime.isNotEmpty) ...[
                              Icon(
                                Icons.access_time_rounded,
                                size: 11,
                                color: _actionColor(scheduledAction),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                _formatScheduledTime(scheduledActionTime),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: _actionColor(scheduledAction),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
