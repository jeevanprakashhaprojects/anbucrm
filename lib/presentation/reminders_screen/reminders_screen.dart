import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';

// ─── Mock Data ────────────────────────────────────────────────────────────────

final List<Map<String, dynamic>> globalReminderMaps = [
  {
    'id': 'rem-001',
    'title': 'Rahul Mehta — Policy renewal due',
    'type': 'Policy Renewal',
    'status': 'Active',
    'priority': 'High',
    'dateTime': DateTime.now().add(const Duration(hours: 1)),
    'repeatFrequency': 'Yearly',
    'linkedLead': 'Rahul Mehta',
    'linkedLeadId': 'default-1',
    'notificationChannels': ['Push', 'SMS', 'Email'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '1 day before',
    'notes':
        'Life insurance annual premium due. Amount: ₹25,000. Send renewal notice with updated terms.',
    'createdAt': DateTime.now().subtract(const Duration(days: 360)),
    'createdBy': 'Priya Sharma',
    'tags': ['Life Insurance', 'Renewal'],
    'isCompleted': false,
  },
  {
    'id': 'rem-002',
    'title': 'Sneha Kapoor — Follow-up call',
    'type': 'Follow-up',
    'status': 'Active',
    'priority': 'Medium',
    'dateTime': DateTime.now().add(const Duration(hours: 3)),
    'repeatFrequency': 'None',
    'linkedLead': 'Sneha Kapoor',
    'linkedLeadId': 'default-2',
    'notificationChannels': ['Push', 'Email'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '30 minutes before',
    'notes':
        'Call to discuss health insurance comparison sheet sent yesterday.',
    'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    'createdBy': 'Rahul Singh',
    'tags': ['Health Cover'],
    'isCompleted': false,
  },
  {
    'id': 'rem-003',
    'title': 'Vikram Singh — Proposal review session',
    'type': 'Meeting',
    'status': 'Snoozed',
    'priority': 'High',
    'dateTime': DateTime.now().add(const Duration(hours: 5)),
    'repeatFrequency': 'None',
    'linkedLead': 'Vikram Singh',
    'linkedLeadId': 'default-3',
    'notificationChannels': ['Push', 'SMS'],
    'snoozed': true,
    'snoozeUntil': DateTime.now().add(const Duration(hours: 4)),
    'preReminderWindow': '1 hour before',
    'notes':
        'In-person meeting at client office. Bring term plan proposal and policy documents.',
    'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    'createdBy': 'Priya Sharma',
    'tags': ['Term Insurance'],
    'isCompleted': false,
  },
  {
    'id': 'rem-004',
    'title': 'Weekly pipeline review — Team',
    'type': 'Team Meeting',
    'status': 'Active',
    'priority': 'Medium',
    'dateTime': DateTime.now().add(const Duration(days: 3)),
    'repeatFrequency': 'Weekly',
    'linkedLead': '',
    'linkedLeadId': '',
    'notificationChannels': ['Push', 'Email'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '1 hour before',
    'notes':
        'Every Monday 10 AM — team pipeline review. Discuss conversion rates and upcoming sessions.',
    'createdAt': DateTime.now().subtract(const Duration(days: 30)),
    'createdBy': 'Priya Sharma',
    'tags': ['Team', 'Pipeline'],
    'isCompleted': false,
  },
  {
    'id': 'rem-005',
    'title': 'Mohammed Al-Rashid — Contract signing deadline',
    'type': 'Deadline',
    'status': 'Active',
    'priority': 'High',
    'dateTime': DateTime.now().add(const Duration(days: 5)),
    'repeatFrequency': 'None',
    'linkedLead': 'Mohammed Al-Rashid',
    'linkedLeadId': 'default-6',
    'notificationChannels': ['Push', 'SMS', 'Email', 'WhatsApp'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '2 days before',
    'notes':
        'Key man insurance contract signing deadline. AED 200K/yr deal. Legal review must be completed before.',
    'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    'createdBy': 'Priya Sharma',
    'tags': ['Corporate Plan', 'Key Man Insurance'],
    'isCompleted': false,
  },
  {
    'id': 'rem-006',
    'title': 'Anita Desai — Birthday greeting',
    'type': 'Birthday',
    'status': 'Active',
    'priority': 'Low',
    'dateTime': DateTime.now().add(const Duration(days: 7)),
    'repeatFrequency': 'Yearly',
    'linkedLead': 'Anita Desai',
    'linkedLeadId': 'default-4',
    'notificationChannels': ['Push', 'WhatsApp'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '1 day before',
    'notes': 'Send birthday wishes and check on policy renewal status.',
    'createdAt': DateTime.now().subtract(const Duration(days: 358)),
    'createdBy': 'Ananya Patel',
    'tags': ['Relationship'],
    'isCompleted': false,
  },
  {
    'id': 'rem-007',
    'title': 'Karan Joshi — SIP portfolio review',
    'type': 'Review',
    'status': 'Active',
    'priority': 'Medium',
    'dateTime': DateTime.now().add(const Duration(days: 10)),
    'repeatFrequency': 'Monthly',
    'linkedLead': 'Karan Joshi',
    'linkedLeadId': 'default-5',
    'notificationChannels': ['Push', 'Email'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '1 day before',
    'notes':
        'Monthly SIP portfolio review. Check fund performance and discuss rebalancing if needed.',
    'createdAt': DateTime.now().subtract(const Duration(days: 20)),
    'createdBy': 'Kavya Menon',
    'tags': ['Mutual Funds', 'SIP'],
    'isCompleted': false,
  },
  {
    'id': 'rem-008',
    'title': 'Q3 target review — Management',
    'type': 'Deadline',
    'status': 'Completed',
    'priority': 'High',
    'dateTime': DateTime.now().subtract(const Duration(days: 2)),
    'repeatFrequency': 'Quarterly',
    'linkedLead': '',
    'linkedLeadId': '',
    'notificationChannels': ['Push', 'Email'],
    'snoozed': false,
    'snoozeUntil': null,
    'preReminderWindow': '3 days before',
    'notes':
        'Q3 sales target review with management. Prepare performance report.',
    'createdAt': DateTime.now().subtract(const Duration(days: 90)),
    'createdBy': 'Priya Sharma',
    'tags': ['Management', 'Targets'],
    'isCompleted': true,
  },
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

enum _ReminderSortOption {
  dateTimeNearest,
  dateTimeFarthest,
  priorityHigh,
  createdNewest,
  leadAZ,
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isSearchActive = false;
  _ReminderSortOption _sortOption = _ReminderSortOption.dateTimeNearest;
  List<String> _selectedTypes = [];
  DateTime? _dateFrom;
  DateTime? _dateTo;
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> _reminders = [];

  final _statusFilters = ['All', 'Active', 'Snoozed', 'Completed'];
  final _typeOptions = [
    'Policy Renewal',
    'Follow-up',
    'Meeting',
    'Team Meeting',
    'Deadline',
    'Birthday',
    'Review',
  ];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadReminders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _reminders = List.from(globalReminderMaps);
        _isLoading = false;
      });
    }
  }

  bool get _hasActiveFilters =>
      _selectedTypes.isNotEmpty || _dateFrom != null || _dateTo != null;

  List<Map<String, dynamic>> get _filteredReminders {
    List<Map<String, dynamic>> result = _reminders.where((r) {
      final matchesFilter =
          _selectedFilter == 'All' || r['status'] == _selectedFilter;
      final matchesSearch =
          _searchQuery.isEmpty ||
          (r['title'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (r['linkedLead'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (r['type'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesType =
          _selectedTypes.isEmpty || _selectedTypes.contains(r['type']);
      bool matchesDate = true;
      final dt = r['dateTime'] as DateTime;
      if (_dateFrom != null && dt.isBefore(_dateFrom!)) matchesDate = false;
      if (_dateTo != null &&
          dt.isAfter(_dateTo!.add(const Duration(days: 1)))) {
        matchesDate = false;
      }
      return matchesFilter && matchesSearch && matchesType && matchesDate;
    }).toList();

    switch (_sortOption) {
      case _ReminderSortOption.dateTimeNearest:
        result.sort(
          (a, b) =>
              (a['dateTime'] as DateTime).compareTo(b['dateTime'] as DateTime),
        );
        break;
      case _ReminderSortOption.dateTimeFarthest:
        result.sort(
          (a, b) =>
              (b['dateTime'] as DateTime).compareTo(a['dateTime'] as DateTime),
        );
        break;
      case _ReminderSortOption.priorityHigh:
        const order = {'High': 0, 'Medium': 1, 'Low': 2};
        result.sort(
          (a, b) =>
              (order[a['priority']] ?? 1).compareTo(order[b['priority']] ?? 1),
        );
        break;
      case _ReminderSortOption.createdNewest:
        result.sort(
          (a, b) => (b['createdAt'] as DateTime).compareTo(
            a['createdAt'] as DateTime,
          ),
        );
        break;
      case _ReminderSortOption.leadAZ:
        result.sort(
          (a, b) =>
              (a['linkedLead'] as String).compareTo(b['linkedLead'] as String),
        );
        break;
    }
    return result;
  }

  int get _totalCount => _reminders.length;
  int get _activeCount =>
      _reminders.where((r) => r['status'] == 'Active').length;
  int get _snoozedCount =>
      _reminders.where((r) => r['status'] == 'Snoozed').length;
  int get _completedCount =>
      _reminders.where((r) => r['status'] == 'Completed').length;
  int get _todayCount => _reminders.where((r) {
    final dt = r['dateTime'] as DateTime;
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }).length;

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReminderFilterSheet(
        selectedTypes: List.from(_selectedTypes),
        typeOptions: _typeOptions,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        onApply: (types, from, to) => setState(() {
          _selectedTypes = types;
          _dateFrom = from;
          _dateTo = to;
        }),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReminderSortSheet(
        current: _sortOption,
        onSelect: (o) => setState(() => _sortOption = o),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredReminders;
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_isSearchActive) _buildSearchBar(),
            _buildKpiRow(),
            _buildStatusFilterBar(),
            if (_hasActiveFilters) _buildActiveFilterChips(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      onRefresh: _loadReminders,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                        itemCount: filtered.length,
                        itemBuilder: (ctx, i) =>
                            _ReminderCard(reminder: filtered[i], index: i),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF0891B2),
        icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
        label: Text(
          'New Reminder',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.surfaceLight,
      padding: const EdgeInsets.fromLTRB(4, 12, 8, 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 22),
            color: AppTheme.textPrimary,
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.go(AppRoutes.dashboardScreen);
              }
            },
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF0891B2).withAlpha(31),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.alarm_rounded,
              color: Color(0xFF0891B2),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reminders',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${_filteredReminders.length} of $_totalCount reminders',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isSearchActive ? Icons.search_off_rounded : Icons.search_rounded,
              color: AppTheme.textSecondary,
              size: 22,
            ),
            onPressed: () => setState(() {
              _isSearchActive = !_isSearchActive;
              if (!_isSearchActive) {
                _searchQuery = '';
                _searchController.clear();
              }
            }),
          ),
          _RHeaderBtn(
            icon: Icons.filter_list_rounded,
            label: 'Filter',
            hasActive: _hasActiveFilters,
            onTap: _showFilterSheet,
          ),
          const SizedBox(width: 6),
          _RHeaderBtn(
            icon: Icons.sort_rounded,
            label: 'Sort',
            hasActive: false,
            onTap: _showSortSheet,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppTheme.surfaceLight,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: GoogleFonts.plusJakartaSans(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search reminders, leads, types...',
          prefixIcon: const Icon(Icons.search_rounded, size: 18),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          filled: true,
          fillColor: AppTheme.surface100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildKpiRow() {
    final kpis = [
      _RKpiData(
        'Total',
        '$_totalCount',
        Icons.alarm_rounded,
        const Color(0xFF0891B2),
        '+3%',
        true,
      ),
      _RKpiData(
        'Active',
        '$_activeCount',
        Icons.notifications_active_rounded,
        AppTheme.primary,
        '$_activeCount set',
        false,
      ),
      _RKpiData(
        'Today',
        '$_todayCount',
        Icons.today_rounded,
        AppTheme.warning,
        'due today',
        false,
      ),
      _RKpiData(
        'Snoozed',
        '$_snoozedCount',
        Icons.snooze_rounded,
        AppTheme.textSecondary,
        '$_snoozedCount paused',
        false,
      ),
      _RKpiData(
        'Done',
        '$_completedCount',
        Icons.check_circle_rounded,
        AppTheme.success,
        '+5%',
        true,
      ),
    ];
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: kpis.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _RKpiCard(data: kpis[i]),
      ),
    );
  }

  Widget _buildStatusFilterBar() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        itemCount: _statusFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final f = _statusFilters[i];
          final selected = _selectedFilter == f;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF0891B2)
                    : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF0891B2)
                      : AppTheme.surface200,
                ),
              ),
              child: Text(
                f,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : AppTheme.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _selectedTypes = [];
      _dateFrom = null;
      _dateTo = null;
    });
  }

  Widget _buildActiveFilterChips() {
    return Container(
      color: AppTheme.surfaceLight,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          ..._selectedTypes.map(
            (t) => _RActiveFilterChip(
              label: 'Type: $t',
              onRemove: () => setState(() => _selectedTypes.remove(t)),
            ),
          ),
          if (_dateFrom != null)
            _RActiveFilterChip(
              label: 'From: ${_dateFrom!.day}/${_dateFrom!.month}',
              onRemove: () => setState(() => _dateFrom = null),
            ),
          if (_dateTo != null)
            _RActiveFilterChip(
              label: 'To: ${_dateTo!.day}/${_dateTo!.month}',
              onRemove: () => setState(() => _dateTo = null),
            ),
          GestureDetector(
            onTap: _clearAllFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.error.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.error.withAlpha(60)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.clear_all_rounded,
                    size: 14,
                    color: AppTheme.error,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Clear All',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppTheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm_off_rounded, size: 56, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          Text(
            'No reminders found',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try adjusting your filters',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reminder Card ────────────────────────────────────────────────────────────

class _ReminderCard extends StatefulWidget {
  final Map<String, dynamic> reminder;
  final int index;
  const _ReminderCard({required this.reminder, required this.index});

  @override
  State<_ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<_ReminderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(
      Duration(milliseconds: (widget.index * 50).clamp(0, 350)),
      () {
        if (mounted) _ctrl.forward();
      },
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'Active':
        return AppTheme.primary;
      case 'Snoozed':
        return AppTheme.textSecondary;
      case 'Completed':
        return AppTheme.success;
      default:
        return AppTheme.textMuted;
    }
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'Policy Renewal':
        return Icons.autorenew_rounded;
      case 'Follow-up':
        return Icons.repeat_rounded;
      case 'Meeting':
        return Icons.people_rounded;
      case 'Team Meeting':
        return Icons.groups_rounded;
      case 'Deadline':
        return Icons.flag_rounded;
      case 'Birthday':
        return Icons.cake_rounded;
      case 'Review':
        return Icons.rate_review_rounded;
      default:
        return Icons.alarm_rounded;
    }
  }

  Color _typeColor(String t) {
    switch (t) {
      case 'Policy Renewal':
        return AppTheme.success;
      case 'Follow-up':
        return AppTheme.warning;
      case 'Meeting':
        return const Color(0xFF8B5CF6);
      case 'Team Meeting':
        return AppTheme.primary;
      case 'Deadline':
        return AppTheme.error;
      case 'Birthday':
        return const Color(0xFFEC4899);
      case 'Review':
        return const Color(0xFF0891B2);
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final diff = dt.difference(now);
    if (diff.isNegative) {
      final abs = diff.abs();
      if (abs.inMinutes < 60) return '${abs.inMinutes}m ago';
      if (abs.inHours < 24) return '${abs.inHours}h ago';
      return '${abs.inDays}d ago';
    }
    if (diff.inMinutes < 60) return 'In ${diff.inMinutes}m';
    if (diff.inHours < 24) return 'In ${diff.inHours}h';
    if (diff.inDays == 1) return 'Tomorrow';
    if (diff.inDays < 7) return 'In ${diff.inDays} days';
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
    return '${dt.day} ${months[dt.month - 1]}';
  }

  void _showReminderDetailsSheet(BuildContext context, Map<String, dynamic> r) {
    final statusColor = _statusColor(r['status'] as String);
    final typeColor = _typeColor(r['type'] as String);
    final channels = (r['notificationChannels'] as List).cast<String>();
    final tags = (r['tags'] as List).cast<String>();
    final isCompleted = r['isCompleted'] == true;
    final isSnoozed = r['snoozed'] == true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.82,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.surface200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(31),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _typeIcon(r['type'] as String),
                        color: typeColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r['title'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isCompleted
                                  ? AppTheme.textMuted
                                  : AppTheme.textPrimary,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  r['status'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: typeColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  r['type'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: typeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.surface100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: AppTheme.surface200),
              // Content
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Linked lead / customer
                    if ((r['linkedLead'] as String).isNotEmpty) ...[
                      _RDSection(title: 'Customer / Lead'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppTheme.primary.withAlpha(40),
                              child: Text(
                                (r['linkedLead'] as String)[0],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                r['linkedLead'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Reminder details
                    _RDSection(title: 'Reminder Details'),
                    _RDRow(
                      icon: Icons.access_time_rounded,
                      label: 'Date & Time',
                      value: _formatDateTime(r['dateTime'] as DateTime),
                    ),
                    _RDRow(
                      icon: Icons.autorenew_rounded,
                      label: 'Repeat',
                      value: r['repeatFrequency'] as String,
                    ),
                    _RDRow(
                      icon: Icons.alarm_rounded,
                      label: 'Pre-reminder',
                      value: r['preReminderWindow'] as String,
                    ),
                    _RDRow(
                      icon: Icons.person_rounded,
                      label: 'Created by',
                      value: r['createdBy'] as String,
                    ),
                    if (isSnoozed && r['snoozeUntil'] != null)
                      _RDRow(
                        icon: Icons.snooze_rounded,
                        label: 'Snoozed until',
                        value: _formatDateTime(r['snoozeUntil'] as DateTime),
                      ),
                    const SizedBox(height: 16),
                    // Notification channels
                    if (channels.isNotEmpty) ...[
                      _RDSection(title: 'Notify Via'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: channels.map((ch) {
                          IconData ico;
                          switch (ch) {
                            case 'Push':
                              ico = Icons.notifications_rounded;
                              break;
                            case 'SMS':
                              ico = Icons.sms_rounded;
                              break;
                            case 'Email':
                              ico = Icons.email_rounded;
                              break;
                            case 'WhatsApp':
                              ico = Icons.chat_rounded;
                              break;
                            default:
                              ico = Icons.notifications_rounded;
                          }
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surface100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.surface200),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(ico, size: 14, color: AppTheme.primary),
                                const SizedBox(width: 6),
                                Text(
                                  ch,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Notes
                    if ((r['notes'] as String).isNotEmpty) ...[
                      _RDSection(title: 'Notes'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surface100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          r['notes'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Tags
                    if (tags.isNotEmpty) ...[
                      _RDSection(title: 'Tags'),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: tags
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  t,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Actions
                    if (!isCompleted) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.snooze_rounded, size: 16),
                              label: Text(
                                'Snooze',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.textSecondary,
                                side: const BorderSide(
                                  color: AppTheme.surface200,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Mark Done',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.success,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.reminder;
    final statusColor = _statusColor(r['status'] as String);
    final typeColor = _typeColor(r['type'] as String);
    final channels = (r['notificationChannels'] as List).cast<String>();
    final tags = (r['tags'] as List).cast<String>();
    final isSnoozed = r['snoozed'] == true;
    final isCompleted = r['isCompleted'] == true;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTap: () => _showReminderDetailsSheet(context, r),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isCompleted ? AppTheme.surface100 : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.surface200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(31),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _typeIcon(r['type'] as String),
                              color: typeColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r['title'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isCompleted
                                        ? AppTheme.textMuted
                                        : AppTheme.textPrimary,
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                if ((r['linkedLead'] as String).isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        size: 12,
                                        color: AppTheme.textMuted,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        r['linkedLead'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _RStatusBadge(
                            label: r['status'] as String,
                            color: statusColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _RInfoChip(
                            icon: Icons.access_time_rounded,
                            label: _formatDateTime(r['dateTime'] as DateTime),
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          _RInfoChip(
                            icon: Icons.autorenew_rounded,
                            label: r['repeatFrequency'] as String,
                            color: const Color(0xFF8B5CF6),
                          ),
                          if (isSnoozed) ...[
                            const SizedBox(width: 8),
                            _RInfoChip(
                              icon: Icons.snooze_rounded,
                              label: 'Snoozed',
                              color: AppTheme.textSecondary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _RTypeBadge(
                            label: r['type'] as String,
                            color: typeColor,
                          ),
                          const SizedBox(width: 8),
                          _RPriorityBadge(priority: r['priority'] as String),
                          const Spacer(),
                          // Notification channel icons
                          Row(
                            children: channels.take(3).map((ch) {
                              IconData ico;
                              switch (ch) {
                                case 'Push':
                                  ico = Icons.notifications_rounded;
                                  break;
                                case 'SMS':
                                  ico = Icons.sms_rounded;
                                  break;
                                case 'Email':
                                  ico = Icons.email_rounded;
                                  break;
                                case 'WhatsApp':
                                  ico = Icons.chat_rounded;
                                  break;
                                default:
                                  ico = Icons.notifications_rounded;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(
                                  ico,
                                  size: 14,
                                  color: AppTheme.textMuted,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_expanded) ...[
                  Divider(height: 1, color: AppTheme.surface200),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((r['notes'] as String).isNotEmpty)
                          _RDetailRow(
                            icon: Icons.notes_rounded,
                            label: 'Notes',
                            value: r['notes'] as String,
                          ),
                        _RDetailRow(
                          icon: Icons.alarm_rounded,
                          label: 'Pre-reminder',
                          value: r['preReminderWindow'] as String,
                        ),
                        _RDetailRow(
                          icon: Icons.person_rounded,
                          label: 'Created by',
                          value: r['createdBy'] as String,
                        ),
                        if (channels.isNotEmpty)
                          _RDetailRow(
                            icon: Icons.notifications_rounded,
                            label: 'Notify via',
                            value: channels.join(', '),
                          ),
                        if (tags.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: tags
                                .map(
                                  (t) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      t,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        color: AppTheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.snooze_rounded,
                                  size: 16,
                                ),
                                label: Text(
                                  'Snooze',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.textSecondary,
                                  side: const BorderSide(
                                    color: AppTheme.surface200,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Mark Done',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.success,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.surface100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _expanded ? 'Show less' : 'Show details',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _RHeaderBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasActive;
  final VoidCallback onTap;
  const _RHeaderBtn({
    required this.icon,
    required this.label,
    required this.hasActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: hasActive ? AppTheme.primaryContainer : AppTheme.surface100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasActive ? AppTheme.primary : AppTheme.surface200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: hasActive ? AppTheme.primary : AppTheme.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hasActive ? AppTheme.primary : AppTheme.textSecondary,
              ),
            ),
            if (hasActive) ...[
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RStatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _RStatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _RTypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _RTypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _RPriorityBadge extends StatelessWidget {
  final String priority;
  const _RPriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.priorityColor(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: color),
          const SizedBox(width: 4),
          Text(
            priority,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _RInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _RInfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _RDSection extends StatelessWidget {
  final String title;
  const _RDSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _RDRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _RDRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: AppTheme.textMuted),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _RDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: AppTheme.textMuted),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RKpiData {
  final String label, value, trend;
  final IconData icon;
  final Color color;
  final bool trendUp;
  const _RKpiData(
    this.label,
    this.value,
    this.icon,
    this.color,
    this.trend,
    this.trendUp,
  );
}

class _RKpiCard extends StatelessWidget {
  final _RKpiData data;
  const _RKpiCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: data.color.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon, size: 14, color: data.color),
              ),
              Row(
                children: [
                  Icon(
                    data.trendUp
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    size: 11,
                    color: data.trendUp ? AppTheme.success : AppTheme.warning,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    data.trend,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: data.trendUp ? AppTheme.success : AppTheme.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: AppTheme.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Active Filter Chip ───────────────────────────────────────────────────────

class _RActiveFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _RActiveFilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppTheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close_rounded,
              size: 13,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Sheet ─────────────────────────────────────────────────────────────

class _ReminderFilterSheet extends StatefulWidget {
  final List<String> selectedTypes, typeOptions;
  final DateTime? dateFrom, dateTo;
  final Function(List<String>, DateTime?, DateTime?) onApply;
  const _ReminderFilterSheet({
    required this.selectedTypes,
    required this.typeOptions,
    required this.dateFrom,
    required this.dateTo,
    required this.onApply,
  });

  @override
  State<_ReminderFilterSheet> createState() => _ReminderFilterSheetState();
}

class _ReminderFilterSheetState extends State<_ReminderFilterSheet> {
  late List<String> _types;
  DateTime? _from, _to;

  @override
  void initState() {
    super.initState();
    _types = List.from(widget.selectedTypes);
    _from = widget.dateFrom;
    _to = widget.dateTo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surface200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Filter Reminders',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() {
                  _types = [];
                  _from = null;
                  _to = null;
                }),
                child: Text(
                  'Clear All',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: AppTheme.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Reminder Type',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.typeOptions.map((t) {
              final sel = _types.contains(t);
              return GestureDetector(
                onTap: () =>
                    setState(() => sel ? _types.remove(t) : _types.add(t)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: sel
                        ? AppTheme.primaryContainer
                        : AppTheme.surface100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: sel ? AppTheme.primary : AppTheme.surface200,
                    ),
                  ),
                  child: Text(
                    t,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: sel ? AppTheme.primary : AppTheme.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_types, _from, _to);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0891B2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderSortSheet extends StatelessWidget {
  final _ReminderSortOption current;
  final ValueChanged<_ReminderSortOption> onSelect;
  const _ReminderSortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        _ReminderSortOption.dateTimeNearest,
        'Date/Time — Nearest First',
        Icons.arrow_upward_rounded,
      ),
      (
        _ReminderSortOption.dateTimeFarthest,
        'Date/Time — Farthest First',
        Icons.arrow_downward_rounded,
      ),
      (
        _ReminderSortOption.priorityHigh,
        'Priority — High to Low',
        Icons.priority_high_rounded,
      ),
      (
        _ReminderSortOption.createdNewest,
        'Created — Newest First',
        Icons.fiber_new_rounded,
      ),
      (
        _ReminderSortOption.leadAZ,
        'Lead Name — A to Z',
        Icons.sort_by_alpha_rounded,
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surface200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sort Reminders',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...options.map((o) {
            final sel = current == o.$1;
            return ListTile(
              leading: Icon(
                o.$3,
                color: sel ? const Color(0xFF0891B2) : AppTheme.textSecondary,
                size: 20,
              ),
              title: Text(
                o.$2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                  color: sel ? const Color(0xFF0891B2) : AppTheme.textPrimary,
                ),
              ),
              trailing: sel
                  ? const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF0891B2),
                      size: 18,
                    )
                  : null,
              onTap: () {
                onSelect(o.$1);
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }
}
