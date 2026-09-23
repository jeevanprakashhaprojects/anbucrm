import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../follow_ups_screen/follow_ups_screen.dart' as fu_screen;
import '../leads_list_screen/leads_list_screen.dart' as leads_list;
import '../leads_list_screen/widgets/lead_card_widget.dart'
    show globalStarredLeadIds;

// ─── Agent Data ───────────────────────────────────────────────────────────────

class _AgentInfo {
  final String name;
  final String initials;
  final String role;
  final String id;
  final String phone;
  final Color color;
  const _AgentInfo({
    required this.name,
    required this.initials,
    required this.role,
    required this.id,
    required this.phone,
    required this.color,
  });
}

const _kAgents = [
  _AgentInfo(
    name: 'Priya Sharma',
    initials: 'PS',
    role: 'Admin',
    id: 'ADM-1042',
    phone: '+91 98765 11111',
    color: Color(0xFF7C3AED),
  ),
  _AgentInfo(
    name: 'Rahul Singh',
    initials: 'RS',
    role: 'Senior Rep',
    id: 'EMP-2391',
    phone: '+91 87654 22222',
    color: Color(0xFF059669),
  ),
  _AgentInfo(
    name: 'Ananya Patel',
    initials: 'AP',
    role: 'Manager',
    id: 'EMP-1874',
    phone: '+91 76543 33333',
    color: Color(0xFF0891B2),
  ),
  _AgentInfo(
    name: 'Kavya Menon',
    initials: 'KM',
    role: 'Sales Rep',
    id: 'EMP-3012',
    phone: '+91 65432 44444',
    color: Color(0xFFEC4899),
  ),
  _AgentInfo(
    name: 'Arjun Das',
    initials: 'AD',
    role: 'Sales Rep',
    id: 'EMP-2756',
    phone: '+91 54321 55555',
    color: Color(0xFFF59E0B),
  ),
];

_AgentInfo _agentByName(String name) {
  return _kAgents.firstWhere(
    (a) => a.name == name,
    orElse: () => _AgentInfo(
      name: name,
      initials: name.isNotEmpty ? name[0] : '?',
      role: 'Agent',
      id: '',
      phone: '',
      color: AppTheme.primary,
    ),
  );
}

// ─── Mock Data ────────────────────────────────────────────────────────────────

final List<Map<String, dynamic>> globalSessionMaps = [
  {
    'id': 'ses-001',
    'title': 'Enterprise Insurance Review',
    'type': 'Video Call',
    'status': 'Completed',
    'date': DateTime.now().subtract(const Duration(hours: 2)),
    'host': 'Priya Sharma',
    'hostInitials': 'PS',
    'participants': ['Rahul Mehta', 'Priya Mehta'],
    'linkedLead': 'Rahul Mehta',
    'linkedLeadId': 'default-1',
    'customerPhone': '+91 98765 43210',
    'preferredContact': ['Video Call', 'Email'],
    'meetingLink': 'meet.google.com/abc-defg-hij',
    'platform': 'Google Meet',
    'recording': true,
    'recordingUrl': 'drive.google.com/rec/ses-001',
    'notes':
        'Discussed enterprise plan pricing. Client interested in ₹1Cr life cover + health floater.',
    'actionItems': [
      'Send revised quotation',
      'Schedule follow-up call',
      'Share policy brochure',
    ],
    'outcome': 'Positive — Moving to Proposal',
    'rating': 4,
    'agenda': 'Review insurance portfolio and finalize premium structure',
    'location': 'Online',
    'reminderSent': true,
    'followUpScheduled': true,
    'followUpDate': DateTime.now().add(const Duration(days: 3)),
    'dealValue': 1250000.0,
    'priority': 'High',
    'startedAt': DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
    'endedAt': DateTime.now().subtract(const Duration(hours: 2)),
    'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    'videoCallCount': 1,
    'callCount': 0,
    'appointmentCount': 0,
    'isExistingCustomer': true,
  },
  {
    'id': 'ses-002',
    'title': 'Health Cover Consultation',
    'type': 'Call Back',
    'status': 'Completed',
    'date': DateTime.now().subtract(const Duration(hours: 5)),
    'host': 'Rahul Singh',
    'hostInitials': 'RS',
    'participants': ['Sneha Kapoor'],
    'linkedLead': 'Sneha Kapoor',
    'linkedLeadId': 'default-2',
    'customerPhone': '+91 87654 32109',
    'preferredContact': ['Calls', 'WhatsApp Messages'],
    'meetingLink': '',
    'platform': 'Phone',
    'recording': false,
    'notes':
        'Explained family floater benefits. Client comparing with competitor.',
    'actionItems': ['Send comparison sheet', 'Call back in 2 days'],
    'outcome': 'Neutral — Client comparing options',
    'rating': 3,
    'agenda': 'Health insurance options for family of 4',
    'location': 'Phone',
    'reminderSent': true,
    'followUpScheduled': true,
    'followUpDate': DateTime.now().add(const Duration(days: 2)),
    'dealValue': 280000.0,
    'priority': 'Medium',
    'startedAt': DateTime.now().subtract(const Duration(hours: 5, minutes: 20)),
    'endedAt': DateTime.now().subtract(const Duration(hours: 5)),
    'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    'videoCallCount': 0,
    'callCount': 2,
    'appointmentCount': 0,
    'isExistingCustomer': false,
  },
  {
    'id': 'ses-003',
    'title': 'Term Plan Proposal Meeting',
    'type': 'Appointment',
    'status': 'Scheduled',
    'date': DateTime.now().add(const Duration(hours: 3)),
    'host': 'Priya Sharma',
    'hostInitials': 'PS',
    'participants': ['Vikram Singh', 'Ananya Patel'],
    'linkedLead': 'Vikram Singh',
    'linkedLeadId': 'default-3',
    'customerPhone': '+91 76543 21098',
    'preferredContact': ['Calls', 'Email'],
    'meetingLink': '',
    'platform': 'In-Person',
    'recording': false,
    'notes': '',
    'actionItems': ['Prepare proposal deck', 'Bring policy documents'],
    'outcome': '',
    'rating': 0,
    'agenda': 'Present term plan proposal and discuss premium options',
    'location': 'Client Office, Hyderabad',
    'reminderSent': true,
    'followUpScheduled': false,
    'dealValue': 620000.0,
    'priority': 'High',
    'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    'videoCallCount': 0,
    'callCount': 0,
    'appointmentCount': 1,
    'isExistingCustomer': true,
  },
  {
    'id': 'ses-004',
    'title': 'Mutual Fund Portfolio Review',
    'type': 'Video Call',
    'status': 'Scheduled',
    'date': DateTime.now().add(const Duration(days: 1, hours: 2)),
    'host': 'Kavya Menon',
    'hostInitials': 'KM',
    'participants': ['Karan Joshi'],
    'linkedLead': 'Karan Joshi',
    'linkedLeadId': 'default-5',
    'customerPhone': '+91 65432 10987',
    'preferredContact': ['Video Call', 'Email'],
    'meetingLink': 'zoom.us/j/123456789',
    'platform': 'Zoom',
    'recording': false,
    'notes': '',
    'actionItems': ['Prepare fund comparison', 'SIP calculator'],
    'outcome': '',
    'rating': 0,
    'agenda': 'Review SIP options and risk profile',
    'location': 'Online',
    'reminderSent': false,
    'followUpScheduled': false,
    'dealValue': 95000.0,
    'priority': 'Medium',
    'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    'videoCallCount': 0,
    'callCount': 0,
    'appointmentCount': 0,
    'isExistingCustomer': false,
  },
  {
    'id': 'ses-005',
    'title': 'Corporate Key Man Insurance',
    'type': 'Video Call',
    'status': 'In Progress',
    'date': DateTime.now().subtract(const Duration(minutes: 20)),
    'host': 'Priya Sharma',
    'hostInitials': 'PS',
    'participants': ['Mohammed Al-Rashid', 'CFO Team'],
    'linkedLead': 'Mohammed Al-Rashid',
    'linkedLeadId': 'default-6',
    'customerPhone': '+971 50 123 4567',
    'preferredContact': ['Video Call', 'Email'],
    'meetingLink': 'teams.microsoft.com/meet/abc',
    'platform': 'MS Teams',
    'recording': true,
    'recordingUrl': '',
    'notes': 'Presenting key man insurance for 3 directors.',
    'actionItems': [
      'Draft policy terms',
      'Legal review',
      'Send final proposal',
    ],
    'outcome': '',
    'rating': 0,
    'agenda': 'Key man insurance for C-suite executives',
    'location': 'Online',
    'reminderSent': true,
    'followUpScheduled': false,
    'dealValue': 4500000.0,
    'priority': 'High',
    'startedAt': DateTime.now().subtract(const Duration(minutes: 20)),
    'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    'videoCallCount': 1,
    'callCount': 0,
    'appointmentCount': 0,
    'isExistingCustomer': true,
  },
  {
    'id': 'ses-006',
    'title': 'Retirement Planning Session',
    'type': 'Call Back',
    'status': 'Cancelled',
    'date': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    'host': 'Ananya Patel',
    'hostInitials': 'AP',
    'participants': ['Deepa Krishnan'],
    'linkedLead': 'Deepa Krishnan',
    'linkedLeadId': 'default-7',
    'customerPhone': '+91 54321 09876',
    'preferredContact': ['Calls'],
    'meetingLink': '',
    'platform': 'Phone',
    'recording': false,
    'notes':
        'Client did not join. Sent follow-up message.\nCancelled Reason: Client had a family emergency and requested reschedule.',
    'actionItems': ['Reschedule session', 'Send reminder'],
    'outcome': 'Cancelled — Reschedule needed',
    'rating': 0,
    'agenda': 'Retirement corpus planning and pension options',
    'location': 'Phone',
    'reminderSent': true,
    'followUpScheduled': true,
    'followUpDate': DateTime.now().add(const Duration(days: 1)),
    'dealValue': 350000.0,
    'priority': 'Medium',
    'createdAt': DateTime.now().subtract(const Duration(days: 4)),
    'videoCallCount': 0,
    'callCount': 1,
    'appointmentCount': 0,
    'cancelReason': 'Client had a family emergency and requested reschedule.',
    'isExistingCustomer': false,
  },
  // ─── Default Due Sessions (for testing Dues filter) ───────────────────────
  {
    'id': 'ses-007',
    'title': 'Life Insurance Review — Overdue',
    'type': 'Call Back',
    'status': 'Scheduled',
    'date': DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    'host': 'Rahul Singh',
    'hostInitials': 'RS',
    'participants': ['Arjun Mehta'],
    'linkedLead': 'Arjun Mehta',
    'linkedLeadId': '',
    'customerPhone': '+91 91234 56789',
    'preferredContact': ['Calls'],
    'meetingLink': '',
    'platform': 'Phone',
    'recording': false,
    'notes': 'Missed call — needs rescheduling. Client was unavailable.',
    'actionItems': ['Reschedule call', 'Send reminder SMS'],
    'outcome': '',
    'rating': 0,
    'agenda': 'Review term life insurance options',
    'location': 'Phone',
    'reminderSent': true,
    'followUpScheduled': false,
    'dealValue': 450000.0,
    'priority': 'High',
    'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    'videoCallCount': 0,
    'callCount': 1,
    'appointmentCount': 0,
    'isExistingCustomer': false,
  },
  {
    'id': 'ses-008',
    'title': 'Health Floater Appointment — Overdue',
    'type': 'Appointment',
    'status': 'Scheduled',
    'date': DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    'host': 'Kavya Menon',
    'hostInitials': 'KM',
    'participants': ['Sunita Rao'],
    'linkedLead': 'Sunita Rao',
    'linkedLeadId': '',
    'customerPhone': '+91 80123 45678',
    'preferredContact': ['Email', 'Calls'],
    'meetingLink': '',
    'platform': 'In-Person',
    'recording': false,
    'notes': 'Client did not show up. Needs follow-up.',
    'actionItems': ['Call to reschedule', 'Send apology email'],
    'outcome': '',
    'rating': 0,
    'agenda': 'Health floater plan for family of 5',
    'location': 'Branch Office, Chennai',
    'reminderSent': true,
    'followUpScheduled': false,
    'dealValue': 180000.0,
    'priority': 'Medium',
    'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    'videoCallCount': 0,
    'callCount': 0,
    'appointmentCount': 1,
    'isExistingCustomer': true,
  },
  {
    'id': 'ses-009',
    'title': 'SIP Investment Video Call — Overdue',
    'type': 'Video Call',
    'status': 'Scheduled',
    'date': DateTime.now().subtract(const Duration(hours: 6)),
    'host': 'Arjun Das',
    'hostInitials': 'AD',
    'participants': ['Pradeep Kumar'],
    'linkedLead': 'Pradeep Kumar',
    'linkedLeadId': '',
    'customerPhone': '+91 70987 65432',
    'preferredContact': ['Video Call'],
    'meetingLink': 'meet.google.com/xyz-abcd-efg',
    'platform': 'Google Meet',
    'recording': false,
    'notes': 'Client joined late and call dropped. Needs to be rescheduled.',
    'actionItems': ['Resend meeting link', 'Reschedule for tomorrow'],
    'outcome': '',
    'rating': 0,
    'agenda': 'SIP investment planning and portfolio review',
    'location': 'Online',
    'reminderSent': true,
    'followUpScheduled': false,
    'dealValue': 120000.0,
    'priority': 'Medium',
    'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    'videoCallCount': 0,
    'callCount': 0,
    'appointmentCount': 0,
    'isExistingCustomer': false,
  },
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

enum _SessionSortOption { dateAscending, dateDescending, priorityHigh, leadAZ }

class _SessionsScreenState extends State<SessionsScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  bool _isSearchActive = false;
  String _selectedFilter = 'All';
  _SessionSortOption _sortOption = _SessionSortOption.dateDescending;

  List<String> _selectedHosts = [];
  List<String> _selectedTypes = [];
  bool? _existingCustomerFilter;
  DateTime? _dateFrom;
  DateTime? _dateTo;

  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> _sessions = [];

  static const _statusFilters = [
    'All',
    'Today',
    'Dues',
    'Completed',
    'Appointments',
    'Call Backs',
    'Video Call',
    'Cancelled',
  ];
  static const _typeOptions = ['Video Call', 'Appointment', 'Call Back'];

  List<String> get _hostOptions => _kAgents.map((a) => a.name).toList();

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadSessions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _sessions = List.from(globalSessionMaps);
        _isLoading = false;
      });
    }
  }

  bool get _hasActiveFilters =>
      _selectedHosts.isNotEmpty ||
      _selectedTypes.isNotEmpty ||
      _existingCustomerFilter != null ||
      _dateFrom != null ||
      _dateTo != null;

  List<Map<String, dynamic>> get _filteredSessions {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<Map<String, dynamic>> result = _sessions.where((s) {
      bool matchesFilter = true;
      switch (_selectedFilter) {
        case 'All':
          matchesFilter = true;
          break;
        case 'Today':
          final d = s['date'] as DateTime;
          final day = DateTime(d.year, d.month, d.day);
          matchesFilter = day == today;
          break;
        case 'Dues':
          final d = s['date'] as DateTime;
          matchesFilter =
              d.isBefore(now) &&
              s['status'] != 'Completed' &&
              s['status'] != 'Cancelled';
          break;
        case 'Completed':
          matchesFilter = s['status'] == 'Completed';
          break;
        case 'Appointments':
          matchesFilter = s['type'] == 'Appointment';
          break;
        case 'Call Backs':
          matchesFilter = s['type'] == 'Call Back';
          break;
        case 'Video Call':
          matchesFilter = s['type'] == 'Video Call';
          break;
        case 'Cancelled':
          matchesFilter = s['status'] == 'Cancelled';
          break;
        default:
          matchesFilter = true;
      }
      final matchesSearch =
          _searchQuery.isEmpty ||
          (s['title'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (s['linkedLead'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (s['host'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (s['customerPhone'] as String? ?? '').contains(_searchQuery);
      final matchesHost =
          _selectedHosts.isEmpty || _selectedHosts.contains(s['host']);
      final matchesType =
          _selectedTypes.isEmpty || _selectedTypes.contains(s['type']);
      final matchesExisting =
          _existingCustomerFilter == null ||
          (_existingCustomerFilter == true &&
              s['isExistingCustomer'] == true) ||
          (_existingCustomerFilter == false && s['isExistingCustomer'] != true);
      bool matchesDate = true;
      final date = s['date'] as DateTime;
      if (_dateFrom != null && date.isBefore(_dateFrom!)) matchesDate = false;
      if (_dateTo != null &&
          date.isAfter(_dateTo!.add(const Duration(days: 1))))
        matchesDate = false;
      return matchesFilter &&
          matchesSearch &&
          matchesHost &&
          matchesType &&
          matchesExisting &&
          matchesDate;
    }).toList();

    // Sort ascending by date (as per requirement)
    switch (_sortOption) {
      case _SessionSortOption.dateAscending:
        result.sort(
          (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
        );
        break;
      case _SessionSortOption.dateDescending:
        result.sort(
          (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
        );
        break;
      case _SessionSortOption.priorityHigh:
        const order = {'High': 0, 'Medium': 1, 'Low': 2};
        result.sort(
          (a, b) =>
              (order[a['priority']] ?? 1).compareTo(order[b['priority']] ?? 1),
        );
        break;
      case _SessionSortOption.leadAZ:
        result.sort(
          (a, b) =>
              (a['linkedLead'] as String).compareTo(b['linkedLead'] as String),
        );
        break;
    }
    return result;
  }

  int get _totalSessions => _sessions.length;
  int get _videoCallCount =>
      _sessions.where((s) => s['type'] == 'Video Call').length;
  int get _appointmentCount =>
      _sessions.where((s) => s['type'] == 'Appointment').length;
  int get _callBackCount =>
      _sessions.where((s) => s['type'] == 'Call Back').length;
  int get _completedCount =>
      _sessions.where((s) => s['status'] == 'Completed').length;

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterSheet(
        selectedHosts: List.from(_selectedHosts),
        selectedTypes: List.from(_selectedTypes),
        existingCustomerFilter: _existingCustomerFilter,
        hostOptions: _hostOptions,
        typeOptions: _typeOptions,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        onApply: (hosts, types, existingCustomer, from, to) {
          setState(() {
            _selectedHosts = hosts;
            _selectedTypes = types;
            _existingCustomerFilter = existingCustomer;
            _dateFrom = from;
            _dateTo = to;
          });
        },
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _SortSheet(
        current: _sortOption,
        onSelect: (opt) => setState(() => _sortOption = opt),
      ),
    );
  }

  void _showAddSessionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewSessionSheet(
        agents: _kAgents,
        onSave: (sessionData) {
          globalSessionMaps.insert(0, sessionData);
          setState(() {
            _sessions = List.from(globalSessionMaps);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text('Session scheduled successfully!'),
                ],
              ),
              backgroundColor: AppTheme.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _selectedHosts = [];
      _selectedTypes = [];
      _existingCustomerFilter = null;
      _dateFrom = null;
      _dateTo = null;
    });
  }

  // ─── Section label for date grouping ──────────────────────────────────────
  String _sectionLabel(Map<String, dynamic> s) {
    final date = s['date'] as DateTime;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
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
    final h = date.hour > 12
        ? date.hour - 12
        : (date.hour == 0 ? 12 : date.hour);
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '$h:${date.minute.toString().padLeft(2, '0')} $ampm';
    final dateStr = '${date.day} ${months[date.month - 1]} ${date.year}';

    if (d == today) return 'Today · $timeStr';
    if (d.isBefore(today)) {
      final diff = today.difference(d).inDays;
      final label = diff == 1 ? 'Yesterday' : '${diff}d ago';
      return '$label · $dateStr $timeStr';
    }
    if (d == today.add(const Duration(days: 1))) return 'Tomorrow · $timeStr';
    return '$dateStr · $timeStr';
  }

  Widget _buildSectionedList(List<Map<String, dynamic>> filtered) {
    final List<dynamic> items = [];
    String? lastDateKey;
    for (final s in filtered) {
      final date = s['date'] as DateTime;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final d = DateTime(date.year, date.month, date.day);
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
      final dateKey = '${d.day} ${months[d.month - 1]} ${d.year}';
      String headerLabel;
      if (d == today) {
        headerLabel = 'Today';
      } else if (d.isBefore(today)) {
        final diff = today.difference(d).inDays;
        headerLabel = diff == 1 ? 'Yesterday' : '${diff}d ago · $dateKey';
      } else if (d == today.add(const Duration(days: 1))) {
        headerLabel = 'Tomorrow';
      } else {
        headerLabel = dateKey;
      }

      if (headerLabel != lastDateKey) {
        items.add({
          '_header': headerLabel,
          '_isPast': d.isBefore(today),
          '_isToday': d == today,
        });
        lastDateKey = headerLabel;
      }
      items.add(s);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        if (item is Map && item.containsKey('_header')) {
          final header = item['_header'] as String;
          final isPast = item['_isPast'] as bool;
          final isToday = item['_isToday'] as bool;
          return Container(
            margin: const EdgeInsets.only(top: 12, bottom: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isToday
                        ? AppTheme.primary.withAlpha(20)
                        : isPast
                        ? AppTheme.textMuted.withAlpha(20)
                        : AppTheme.success.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isToday
                          ? AppTheme.primary.withAlpha(60)
                          : isPast
                          ? AppTheme.textMuted.withAlpha(40)
                          : AppTheme.success.withAlpha(60),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isToday
                            ? Icons.today_rounded
                            : isPast
                            ? Icons.history_rounded
                            : Icons.calendar_today_rounded,
                        size: 12,
                        color: isToday
                            ? AppTheme.primary
                            : isPast
                            ? AppTheme.textMuted
                            : AppTheme.success,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        header,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isToday
                              ? AppTheme.primary
                              : isPast
                              ? AppTheme.textMuted
                              : AppTheme.success,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Divider(
                    color: isToday
                        ? AppTheme.primary.withAlpha(40)
                        : isPast
                        ? AppTheme.textMuted.withAlpha(30)
                        : AppTheme.success.withAlpha(40),
                    height: 1,
                  ),
                ),
              ],
            ),
          );
        }
        final s = item as Map<String, dynamic>;
        final idx = filtered.indexOf(s);
        return _SessionCard(
          session: s,
          index: idx,
          onUpdate: () => setState(() {
            _sessions = List.from(globalSessionMaps);
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredSessions;
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
            if (_hasActiveFilters || _selectedFilter != 'All')
              _buildFilteredCountBanner(filtered.length),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      onRefresh: _loadSessions,
                      child: _buildSectionedList(filtered),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSessionSheet,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
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
              if (Navigator.canPop(context))
                Navigator.pop(context);
              else
                context.go(AppRoutes.dashboardScreen);
            },
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withAlpha(31),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.event_note_rounded,
              color: Color(0xFF8B5CF6),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sessions',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${_filteredSessions.length} of $_totalSessions sessions',
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
          _HeaderButton(
            icon: Icons.filter_list_rounded,
            label: 'Filter',
            hasActive: _hasActiveFilters,
            onTap: _showFilterSheet,
          ),
          const SizedBox(width: 6),
          _HeaderButton(
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
          hintText: 'Search sessions, leads, hosts, phone...',
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
    final now = DateTime.now();
    final dueCount = _sessions
        .where(
          (s) =>
              (s['date'] as DateTime).isBefore(now) &&
              s['status'] != 'Completed' &&
              s['status'] != 'Cancelled',
        )
        .length;
    final cancelledCount = _sessions
        .where((s) => s['status'] == 'Cancelled')
        .length;
    final kpis = [
      _KpiData(
        'Video Calls',
        '$_videoCallCount',
        Icons.videocam_rounded,
        const Color(0xFF0891B2),
        '$_videoCallCount total',
        false,
      ),
      _KpiData(
        'Appointments',
        '$_appointmentCount',
        Icons.people_rounded,
        const Color(0xFF8B5CF6),
        '$_appointmentCount total',
        false,
      ),
      _KpiData(
        'Call Backs',
        '$_callBackCount',
        Icons.phone_callback_rounded,
        AppTheme.success,
        '$_callBackCount total',
        false,
      ),
      _KpiData(
        'Completed',
        '$_completedCount',
        Icons.check_circle_rounded,
        AppTheme.warning,
        '+${_completedCount > 0 ? _completedCount : 0}',
        true,
      ),
      _KpiData(
        'Dues',
        '$dueCount',
        Icons.warning_rounded,
        AppTheme.error,
        '$dueCount overdue',
        false,
      ),
      _KpiData(
        'Cancelled',
        '$cancelledCount',
        Icons.cancel_rounded,
        AppTheme.textMuted,
        '$cancelledCount total',
        false,
      ),
    ];
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: kpis.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _KpiCard(data: kpis[i]),
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
                color: selected ? AppTheme.primary : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppTheme.primary : AppTheme.surface200,
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

  Widget _buildActiveFilterChips() {
    return Container(
      color: AppTheme.surfaceLight,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          ..._selectedHosts.map(
            (h) => _ActiveFilterChip(
              label: 'Host: $h',
              onRemove: () => setState(() => _selectedHosts.remove(h)),
            ),
          ),
          ..._selectedTypes.map(
            (t) => _ActiveFilterChip(
              label: 'Type: $t',
              onRemove: () => setState(() => _selectedTypes.remove(t)),
            ),
          ),
          if (_existingCustomerFilter != null)
            _ActiveFilterChip(
              label: 'Existing: ${_existingCustomerFilter! ? 'Yes' : 'No'}',
              onRemove: () => setState(() => _existingCustomerFilter = null),
            ),
          if (_dateFrom != null)
            _ActiveFilterChip(
              label: 'From: ${_dateFrom!.day}/${_dateFrom!.month}',
              onRemove: () => setState(() => _dateFrom = null),
            ),
          if (_dateTo != null)
            _ActiveFilterChip(
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
          Icon(Icons.event_note_rounded, size: 56, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          Text(
            'No sessions found',
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

  Widget _buildFilteredCountBanner(int count) {
    return Container(
      color: AppTheme.surfaceLight,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primary.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.primary.withAlpha(40)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  size: 13,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  '$count session${count == 1 ? '' : 's'} found',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Session Card ─────────────────────────────────────────────────────────────

class _SessionCard extends StatefulWidget {
  final Map<String, dynamic> session;
  final int index;
  final VoidCallback onUpdate;
  const _SessionCard({
    required this.session,
    required this.index,
    required this.onUpdate,
  });

  @override
  State<_SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<_SessionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

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
      case 'Completed':
        return AppTheme.success;
      case 'Scheduled':
        return AppTheme.primary;
      case 'In Progress':
        return AppTheme.error;
      case 'Cancelled':
        return AppTheme.textMuted;
      default:
        return AppTheme.textMuted;
    }
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'Video Call':
        return Icons.videocam_rounded;
      case 'Appointment':
        return Icons.people_rounded;
      case 'Call Back':
        return Icons.phone_callback_rounded;
      default:
        return Icons.event_rounded;
    }
  }

  Color _typeColor(String t) {
    switch (t) {
      case 'Video Call':
        return const Color(0xFF0891B2);
      case 'Appointment':
        return const Color(0xFF8B5CF6);
      case 'Call Back':
        return AppTheme.success;
      default:
        return AppTheme.primary;
    }
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = dt.difference(now);
    if (diff.inMinutes.abs() < 60 && diff.inDays == 0) {
      if (diff.inMinutes < 0) return '${(-diff.inMinutes)}m ago';
      if (diff.inMinutes == 0) return 'Now';
      return 'In ${diff.inMinutes}m';
    }
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final ampm = dt.hour >= 12 ? 'PM' : 'AM';
      return 'Today $h:${dt.minute.toString().padLeft(2, '0')} $ampm';
    }
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
    return '${dt.day} ${months[dt.month - 1]}, ${dt.hour > 12 ? dt.hour - 12 : dt.hour}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}';
  }

  String _formatFullDateTime(DateTime dt) {
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
    final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}, $h:${dt.minute.toString().padLeft(2, '0')} $ampm';
  }

  String _computedDuration(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '';
    final diff = end.difference(start);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    final h = diff.inHours;
    final m = diff.inMinutes % 60;
    return m > 0 ? '${h}h ${m}m' : '${h}h';
  }

  bool _canStartSession(Map<String, dynamic> s) {
    if (s['type'] != 'Video Call') return false;
    if (s['status'] != 'Scheduled') return false;
    final scheduledDate = s['date'] as DateTime;
    final now = DateTime.now();
    final diff = scheduledDate.difference(now);
    return diff.inMinutes <= 30;
  }

  // Check if lead is starred
  bool _isLeadStarred(Map<String, dynamic> s) {
    final leadId = s['linkedLeadId'] as String? ?? '';
    final leadName = s['linkedLead'] as String? ?? '';
    if (leadId.isNotEmpty && globalStarredLeadIds.contains(leadId)) return true;
    // Also check by name
    final lead = leads_list.globalLeadMaps.firstWhere(
      (m) => m['name'] == leadName,
      orElse: () => {},
    );
    if (lead.isNotEmpty) {
      return globalStarredLeadIds.contains(lead['id'] as String? ?? '');
    }
    return false;
  }

  void _showThreeDotsMenu(BuildContext context, Map<String, dynamic> s) {
    final preferred = (s['preferredContact'] as List?)?.cast<String>() ?? [];
    final customerName = s['linkedLead'] as String;

    void checkPreferenceAndProceed(String action, VoidCallback onConfirm) {
      bool isPreferred = preferred.isEmpty || preferred.contains(action);
      if (!isPreferred) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppTheme.warning,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Preference Mismatch',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              '$customerName has not preferred $action. Do you want to continue?',
              style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.warning,
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        onConfirm();
      }
    }

    void logAction(String actionKey) {
      final idx = globalSessionMaps.indexWhere((m) => m['id'] == s['id']);
      if (idx >= 0) {
        globalSessionMaps[idx][actionKey] =
            (globalSessionMaps[idx][actionKey] as int? ?? 0) + 1;
        s[actionKey] = (s[actionKey] as int? ?? 0) + 1;
      }
      widget.onUpdate();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Action logged for $customerName'),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    void cancelSession() {
      // Ask for cancel reason
      final reasonCtrl = TextEditingController();
      showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (ctx, setS) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.cancel_rounded, color: AppTheme.error, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Cancel Session',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please provide a reason for cancellation:',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: reasonCtrl,
                  maxLines: 3,
                  onChanged: (_) => setS(() {}),
                  decoration: InputDecoration(
                    hintText: 'e.g. Customer requested reschedule...',
                    filled: true,
                    fillColor: AppTheme.surface100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Back',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              FilledButton(
                onPressed: reasonCtrl.text.trim().isEmpty
                    ? null
                    : () {
                        Navigator.pop(ctx);
                        final reason = reasonCtrl.text.trim();
                        final idx = globalSessionMaps.indexWhere(
                          (m) => m['id'] == s['id'],
                        );
                        if (idx >= 0) {
                          globalSessionMaps[idx]['status'] = 'Cancelled';
                          globalSessionMaps[idx]['cancelReason'] = reason;
                          final existingNotes =
                              globalSessionMaps[idx]['notes'] as String? ?? '';
                          globalSessionMaps[idx]['notes'] =
                              existingNotes.isNotEmpty
                              ? '$existingNotes\nCancelled Reason: $reason'
                              : 'Cancelled Reason: $reason';
                        }
                        s['status'] = 'Cancelled';
                        s['cancelReason'] = reason;
                        widget.onUpdate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Session cancelled'),
                            backgroundColor: AppTheme.error,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                style: FilledButton.styleFrom(backgroundColor: AppTheme.error),
                child: Text(
                  'Cancel Session',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void showScheduledAction() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _ScheduledActionSheet(
          session: s,
          onSave: (actionData) {
            final idx = globalSessionMaps.indexWhere((m) => m['id'] == s['id']);
            if (idx >= 0) {
              globalSessionMaps[idx]['scheduledAction'] = actionData;
            }
            widget.onUpdate();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Scheduled action added'),
                backgroundColor: AppTheme.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surface200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  // Star indicator if lead is important
                  if (_isLeadStarred(s)) ...[
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      customerName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            _MenuTile(
              icon: Icons.info_outline_rounded,
              label: 'Session Details',
              color: AppTheme.primary,
              onTap: () {
                Navigator.pop(context);
                _showSessionDetailsSheet(context, s);
              },
            ),
            _MenuTile(
              icon: Icons.phone_rounded,
              label: 'Call',
              color: AppTheme.success,
              onTap: () {
                Navigator.pop(context);
                checkPreferenceAndProceed(
                  'Calls',
                  () => logAction('callCount'),
                );
              },
            ),
            _MenuTile(
              icon: Icons.videocam_rounded,
              label: 'Video Call',
              color: const Color(0xFF0891B2),
              onTap: () {
                Navigator.pop(context);
                checkPreferenceAndProceed(
                  'Video Call',
                  () => logAction('videoCallCount'),
                );
              },
            ),
            if (s['status'] != 'Completed' && s['status'] != 'Cancelled')
              _DisabledMenuTile(
                icon: Icons.calendar_month_rounded,
                label: 'Scheduled Action (Complete session first)',
                color: AppTheme.textMuted,
              )
            else
              _MenuTile(
                icon: Icons.calendar_month_rounded,
                label: 'Scheduled Action',
                color: const Color(0xFF8B5CF6),
                onTap: () {
                  Navigator.pop(context);
                  showScheduledAction();
                },
              ),
            _MenuTile(
              icon: Icons.cancel_rounded,
              label: 'Cancel Session',
              color: AppTheme.error,
              onTap: () {
                Navigator.pop(context);
                cancelSession();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _startSession(BuildContext context, Map<String, dynamic> s) {
    if (!_canStartSession(s)) {
      final scheduledDate = s['date'] as DateTime;
      final now = DateTime.now();
      final diff = scheduledDate.difference(now);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.schedule_rounded, color: AppTheme.warning, size: 22),
              const SizedBox(width: 8),
              Text(
                'Too Early',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          content: Text(
            'You can only start this session 30 minutes before the scheduled time.\n\nScheduled: ${_formatFullDateTime(scheduledDate)}\nAvailable in: ${diff.inMinutes - 30} more minutes.',
            style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.5),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(backgroundColor: AppTheme.primary),
              child: Text(
                'OK',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.play_circle_rounded, color: AppTheme.primary, size: 22),
            const SizedBox(width: 8),
            Text(
              'Start Session',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: Text(
          'Start "${s['title']}" with ${s['linkedLead']}?',
          style: GoogleFonts.plusJakartaSans(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(color: AppTheme.textSecondary),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              final idx = globalSessionMaps.indexWhere(
                (m) => m['id'] == s['id'],
              );
              if (idx >= 0) {
                globalSessionMaps[idx]['status'] = 'In Progress';
                globalSessionMaps[idx]['startedAt'] = DateTime.now();
                globalSessionMaps[idx]['videoCallCount'] =
                    (globalSessionMaps[idx]['videoCallCount'] as int? ?? 0) + 1;
              }
              s['status'] = 'In Progress';
              s['startedAt'] = DateTime.now();
              widget.onUpdate();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Session started!'),
                  backgroundColor: AppTheme.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppTheme.primary),
            child: Text(
              'Start',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _endSession(BuildContext context, Map<String, dynamic> s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _CompleteSessionSheet(
        session: s,
        onComplete:
            (
              outcome,
              rating,
              notes,
              scheduleFollowUp,
              followUpDate,
              nextActionType,
            ) {
              final endTime = DateTime.now();
              final idx = globalSessionMaps.indexWhere(
                (m) => m['id'] == s['id'],
              );
              if (idx >= 0) {
                globalSessionMaps[idx]['status'] = 'Completed';
                globalSessionMaps[idx]['outcome'] = outcome;
                globalSessionMaps[idx]['rating'] = rating;
                globalSessionMaps[idx]['notes'] = notes;
                globalSessionMaps[idx]['endedAt'] = endTime;
                globalSessionMaps[idx]['followUpScheduled'] = scheduleFollowUp;
                if (scheduleFollowUp && followUpDate != null) {
                  globalSessionMaps[idx]['followUpDate'] = followUpDate;
                  final fuType = nextActionType ?? 'Calls';
                  final newFu = {
                    'id': 'fu-ses-${DateTime.now().millisecondsSinceEpoch}',
                    'title': 'Follow up after session: ${s['title']}',
                    'type': fuType == 'Follow Up' ? 'Calls' : fuType,
                    'status': 'Upcoming',
                    'priority': 'High',
                    'dueDate': followUpDate,
                    'assignedAgent': s['host'] as String,
                    'agentInitials': s['hostInitials'] as String,
                    'linkedLead': s['linkedLead'] as String,
                    'linkedLeadId': s['linkedLeadId'] as String? ?? '',
                    'customerPhone': s['customerPhone'] as String? ?? '',
                    'notes':
                        'Post-session follow-up. Outcome: $outcome. Next action: $fuType',
                    'outcome': '',
                    'isRecurring': false,
                    'recurringFrequency': 'Custom',
                    'isOverdue': false,
                    'completedAt': null,
                    'createdAt': DateTime.now(),
                    'tags': <String>[],
                    'preferredContact': ['Calls'],
                    'contactMethod': 'Calls',
                    'reminderBefore': '1 hour',
                    'isExistingCustomer': false,
                    'callsDone': 0,
                    'messagesDone': 0,
                    'whatsappDone': 0,
                    'emailDone': 0,
                    'videoDone': 0,
                    'upcomingFollowUps': <String>[],
                    'linkedSessionId': s['id'],
                  };
                  fu_screen.globalFollowUpMaps.add(newFu);
                }
              }
              s['status'] = 'Completed';
              s['outcome'] = outcome;
              s['rating'] = rating;
              s['notes'] = notes;
              s['endedAt'] = endTime;
              widget.onUpdate();
            },
      ),
    );
  }

  void _showSessionDetailsSheet(BuildContext context, Map<String, dynamic> s) {
    final statusColor = _statusColor(s['status'] as String);
    final typeColor = _typeColor(s['type'] as String);
    final rating = s['rating'] as int;
    final actionItems = (s['actionItems'] as List).cast<String>();
    final participants = (s['participants'] as List).cast<String>();
    final agent = _agentByName(s['host'] as String);
    final startedAt = s['startedAt'] as DateTime?;
    final endedAt = s['endedAt'] as DateTime?;
    final duration = _computedDuration(startedAt, endedAt);
    final videoCallCount = s['videoCallCount'] as int? ?? 0;
    final callCount = s['callCount'] as int? ?? 0;
    final appointmentCount = s['appointmentCount'] as int? ?? 0;
    final createdAt = s['createdAt'] as DateTime?;
    final cancelReason = s['cancelReason'] as String? ?? '';
    final notes = s['notes'] as String? ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.surface200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
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
                        _typeIcon(s['type'] as String),
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
                            s['title'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
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
                                  s['status'] as String,
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
                                  s['type'] as String,
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
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Customer info
                    if ((s['linkedLead'] as String).isNotEmpty) ...[
                      _SDetailSection(title: 'Customer'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppTheme.primary.withAlpha(40),
                              child: Text(
                                (s['linkedLead'] as String).isNotEmpty
                                    ? (s['linkedLead'] as String)[0]
                                    : '?',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        s['linkedLead'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                      if (_isLeadStarred(s)) ...[
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 14,
                                          color: Color(0xFFF59E0B),
                                        ),
                                        Text(
                                          ' Important',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            color: Color(0xFFB45309),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  if ((s['customerPhone'] as String? ?? '')
                                      .isNotEmpty)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone_rounded,
                                          size: 12,
                                          color: AppTheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          s['customerPhone'] as String,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            color: AppTheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Host
                    _SDetailSection(title: 'Assigned Host'),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: agent.color.withAlpha(15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: agent.color.withAlpha(40)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: agent.color.withAlpha(40),
                            child: Text(
                              agent.initials,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: agent.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  agent.name,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${agent.role} · ${agent.id}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                if (agent.phone.isNotEmpty)
                                  Text(
                                    agent.phone,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      color: AppTheme.textMuted,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Session details
                    _SDetailSection(title: 'Session Details'),
                    _SDetailRow(
                      icon: Icons.access_time_rounded,
                      label: 'Date & Time',
                      value: _formatFullDateTime(s['date'] as DateTime),
                    ),
                    if (createdAt != null)
                      _SDetailRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Created',
                        value: _formatFullDateTime(createdAt),
                      ),
                    if (startedAt != null)
                      _SDetailRow(
                        icon: Icons.play_arrow_rounded,
                        label: 'Started',
                        value: _formatFullDateTime(startedAt),
                      ),
                    if (endedAt != null)
                      _SDetailRow(
                        icon: Icons.stop_rounded,
                        label: 'Ended',
                        value: _formatFullDateTime(endedAt),
                      ),
                    if (duration.isNotEmpty)
                      _SDetailRow(
                        icon: Icons.timer_outlined,
                        label: 'Duration',
                        value: duration,
                      ),
                    _SDetailRow(
                      icon: Icons.devices_rounded,
                      label: 'Platform',
                      value: s['platform'] as String,
                    ),
                    if ((s['location'] as String? ?? '').isNotEmpty)
                      _SDetailRow(
                        icon: Icons.location_on_rounded,
                        label: 'Location',
                        value: s['location'] as String,
                      ),
                    if ((s['agenda'] as String? ?? '').isNotEmpty)
                      _SDetailRow(
                        icon: Icons.assignment_rounded,
                        label: 'Agenda',
                        value: s['agenda'] as String,
                      ),
                    if (participants.isNotEmpty)
                      _SDetailRow(
                        icon: Icons.group_rounded,
                        label: 'Participants',
                        value: participants.join(', '),
                      ),
                    if ((s['meetingLink'] as String? ?? '').isNotEmpty)
                      _SDetailRow(
                        icon: Icons.link_rounded,
                        label: 'Meeting Link',
                        value: s['meetingLink'] as String,
                      ),
                    if (s['recording'] == true)
                      _SDetailRow(
                        icon: Icons.fiber_manual_record_rounded,
                        label: 'Recording',
                        value: 'Available',
                      ),
                    const SizedBox(height: 16),
                    // Contact attempt counters
                    _SDetailSection(title: 'Contact Attempts'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (videoCallCount > 0)
                          _CountBadge(
                            icon: Icons.videocam_rounded,
                            label: 'Video Call: $videoCallCount',
                            color: const Color(0xFF0891B2),
                          ),
                        if (callCount > 0)
                          _CountBadge(
                            icon: Icons.phone_rounded,
                            label: 'Call: $callCount',
                            color: AppTheme.success,
                          ),
                        if (appointmentCount > 0)
                          _CountBadge(
                            icon: Icons.people_rounded,
                            label: 'Appointment: $appointmentCount',
                            color: const Color(0xFF8B5CF6),
                          ),
                        if (videoCallCount == 0 &&
                            callCount == 0 &&
                            appointmentCount == 0)
                          Text(
                            'No contact attempts yet',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Rating
                    if (rating > 0) ...[
                      _SDetailSection(title: 'Rating'),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < rating
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 24,
                            color: AppTheme.warning,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Outcome
                    if ((s['outcome'] as String? ?? '').isNotEmpty) ...[
                      _SDetailSection(title: 'Outcome'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withAlpha(15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppTheme.success.withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.flag_rounded,
                              size: 16,
                              color: AppTheme.success,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                s['outcome'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Notes (includes cancel reason if present)
                    if (notes.isNotEmpty) ...[
                      _SDetailSection(title: 'Notes'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cancelReason.isNotEmpty
                              ? AppTheme.error.withAlpha(10)
                              : AppTheme.surface100,
                          borderRadius: BorderRadius.circular(10),
                          border: cancelReason.isNotEmpty
                              ? Border.all(color: AppTheme.error.withAlpha(40))
                              : null,
                        ),
                        child: Text(
                          notes,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Action Items
                    if (actionItems.isNotEmpty) ...[
                      _SDetailSection(title: 'Action Items'),
                      ...actionItems.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  size: 14,
                                  color: AppTheme.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Follow-up
                    if (s['followUpScheduled'] == true &&
                        s['followUpDate'] != null) ...[
                      _SDetailSection(title: 'Follow-up Scheduled'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatFullDateTime(
                                s['followUpDate'] as DateTime,
                              ),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Deal value
                    if ((s['dealValue'] as double? ?? 0) > 0) ...[
                      _SDetailSection(title: 'Deal Value'),
                      Text(
                        '₹${((s['dealValue'] as double) / 100000).toStringAsFixed(1)}L',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.success,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Lifecycle actions
                    if (s['status'] == 'Scheduled' &&
                        s['type'] == 'Video Call') ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _canStartSession(s)
                              ? () {
                                  Navigator.pop(context);
                                  _startSession(context, s);
                                }
                              : null,
                          icon: Icon(
                            _canStartSession(s)
                                ? Icons.play_arrow_rounded
                                : Icons.lock_clock_rounded,
                          ),
                          label: Text(
                            _canStartSession(s)
                                ? 'Start Session'
                                : 'Available 30 min before',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            disabledBackgroundColor: AppTheme.surface200,
                            foregroundColor: Colors.white,
                            disabledForegroundColor: AppTheme.textMuted,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (s['status'] == 'In Progress') ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _endSession(context, s);
                          },
                          icon: const Icon(Icons.stop_rounded),
                          label: Text(
                            'End & Complete Session',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
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
    final s = widget.session;
    final statusColor = _statusColor(s['status'] as String);
    final typeColor = _typeColor(s['type'] as String);
    final rating = s['rating'] as int;
    final isInProgress = s['status'] == 'In Progress';
    final isScheduled = s['status'] == 'Scheduled';
    final isVideoCall = s['type'] == 'Video Call';
    final startedAt = s['startedAt'] as DateTime?;
    final endedAt = s['endedAt'] as DateTime?;
    final duration = _computedDuration(startedAt, endedAt);
    final videoCallCount = s['videoCallCount'] as int? ?? 0;
    final callCount = s['callCount'] as int? ?? 0;
    final appointmentCount = s['appointmentCount'] as int? ?? 0;
    final hasAttempts = videoCallCount + callCount + appointmentCount > 0;
    final createdAt = s['createdAt'] as DateTime?;
    final isStarred = _isLeadStarred(s);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTap: () => _showSessionDetailsSheet(context, s),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isInProgress
                    ? AppTheme.error.withAlpha(80)
                    : AppTheme.surface200,
                width: isInProgress ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isStarred
                      ? const Color(0xFFF59E0B).withAlpha(25)
                      : Colors.black.withAlpha(10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // In Progress LIVE banner
                if (isInProgress)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withAlpha(20),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'LIVE — In Progress',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.error,
                          ),
                        ),
                        const Spacer(),
                        if (startedAt != null)
                          Text(
                            'Started ${_formatDate(startedAt)}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: AppTheme.error,
                            ),
                          ),
                      ],
                    ),
                  ),
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
                              _typeIcon(s['type'] as String),
                              color: typeColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (isStarred) ...[
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 13,
                                        color: Color(0xFFF59E0B),
                                      ),
                                      const SizedBox(width: 4),
                                    ],
                                    Expanded(
                                      child: Text(
                                        s['title'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline_rounded,
                                      size: 12,
                                      color: AppTheme.textMuted,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        s['linkedLead'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: AppTheme.textSecondary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                if ((s['customerPhone'] as String? ?? '')
                                    .isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_rounded,
                                        size: 11,
                                        color: AppTheme.textMuted,
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        child: Text(
                                          s['customerPhone'] as String,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            color: AppTheme.textMuted,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _StatusBadge(
                            label: s['status'] as String,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Builder(
                            builder: (btnCtx) => GestureDetector(
                              onTap: () => _showThreeDotsMenu(btnCtx, s),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppTheme.surface100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  size: 16,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _InfoChip(
                            icon: Icons.access_time_rounded,
                            label: _formatDate(s['date'] as DateTime),
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          if (duration.isNotEmpty) ...[
                            _InfoChip(
                              icon: Icons.timer_outlined,
                              label: duration,
                              color: AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: _InfoChip(
                              icon: Icons.person_rounded,
                              label: s['host'] as String,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _TypeBadge(
                            label: s['type'] as String,
                            color: typeColor,
                          ),
                          const SizedBox(width: 8),
                          if (createdAt != null)
                            _InfoChip(
                              icon: Icons.calendar_today_rounded,
                              label: 'Created ${_formatDate(createdAt)}',
                              color: AppTheme.textMuted,
                            ),
                          const Spacer(),
                          if (s['recording'] == true)
                            _InfoChip(
                              icon: Icons.fiber_manual_record_rounded,
                              label: 'Rec',
                              color: AppTheme.error,
                            ),
                          if (rating > 0) ...[
                            const SizedBox(width: 6),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < rating
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  size: 12,
                                  color: AppTheme.warning,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Contact attempt counters
                      if (hasAttempts) ...[
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (videoCallCount > 0)
                                _CountChip(
                                  icon: Icons.videocam_rounded,
                                  label: 'Video Call: $videoCallCount',
                                  color: const Color(0xFF0891B2),
                                ),
                              if (callCount > 0)
                                _CountChip(
                                  icon: Icons.phone_rounded,
                                  label: 'Call: $callCount',
                                  color: AppTheme.success,
                                ),
                              if (appointmentCount > 0)
                                _CountChip(
                                  icon: Icons.people_rounded,
                                  label: 'Appointment: $appointmentCount',
                                  color: const Color(0xFF8B5CF6),
                                ),
                            ],
                          ),
                        ),
                      ],
                      if ((s['outcome'] as String? ?? '').isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.surface100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag_rounded,
                                size: 13,
                                color: AppTheme.success,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  s['outcome'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      // Start Session button (Video Call only, within 30 mins) — lock bar style
                      if (isScheduled && isVideoCall) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _startSession(context, s),
                            icon: Icon(
                              _canStartSession(s)
                                  ? Icons.play_arrow_rounded
                                  : Icons.lock_clock_rounded,
                              size: 16,
                            ),
                            label: Text(
                              _canStartSession(s)
                                  ? 'Start Session'
                                  : 'Available 30 min before',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _canStartSession(s)
                                  ? AppTheme.primary
                                  : AppTheme.textMuted,
                              side: BorderSide(
                                color: _canStartSession(s)
                                    ? AppTheme.primary
                                    : AppTheme.surface200,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // End & Complete button for In Progress
                      if (isInProgress) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _endSession(context, s),
                            icon: const Icon(Icons.stop_rounded, size: 16),
                            label: Text(
                              'End & Complete',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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

// ─── Scheduled Action Sheet ───────────────────────────────────────────────────

class _ScheduledActionSheet extends StatefulWidget {
  final Map<String, dynamic> session;
  final void Function(Map<String, dynamic>) onSave;

  const _ScheduledActionSheet({required this.session, required this.onSave});

  @override
  State<_ScheduledActionSheet> createState() => _ScheduledActionSheetState();
}

class _ScheduledActionSheetState extends State<_ScheduledActionSheet> {
  String _actionType = 'Appointment';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _notesCtrl = TextEditingController();

  static const _actionTypes = ['Appointment', 'Video Call', 'Call Back'];

  bool get _canSave => _selectedDate != null && _selectedTime != null;

  String _formatDate(DateTime dt) {
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

  Color _actionColor(String a) {
    switch (a) {
      case 'Appointment':
        return const Color(0xFF8B5CF6);
      case 'Video Call':
        return const Color(0xFF0891B2);
      case 'Call Back':
        return AppTheme.success;
      default:
        return AppTheme.primary;
    }
  }

  IconData _actionIcon(String a) {
    switch (a) {
      case 'Appointment':
        return Icons.people_rounded;
      case 'Video Call':
        return Icons.videocam_rounded;
      case 'Call Back':
        return Icons.phone_callback_rounded;
      default:
        return Icons.calendar_today_rounded;
    }
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surface200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6).withAlpha(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Color(0xFF8B5CF6),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scheduled Action',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'For ${widget.session['linkedLead']}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Action Type *',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _actionTypes.map((t) {
                        final sel = _actionType == t;
                        final color = _actionColor(t);
                        return GestureDetector(
                          onTap: () => setState(() => _actionType = t),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: sel
                                  ? color.withAlpha(25)
                                  : AppTheme.surface100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel ? color : AppTheme.surface200,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _actionIcon(t),
                                  size: 14,
                                  color: sel ? color : AppTheme.textMuted,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  t,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: sel ? color : AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Date & Time *',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(
                                  const Duration(days: 1),
                                ),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (d != null) setState(() => _selectedDate = d);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.surface100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedDate != null
                                      ? AppTheme.primary.withAlpha(60)
                                      : AppTheme.surface200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_rounded,
                                    size: 16,
                                    color: AppTheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedDate != null
                                        ? _formatDate(_selectedDate!)
                                        : 'Select date',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      color: _selectedDate != null
                                          ? AppTheme.textPrimary
                                          : AppTheme.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final t = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (t != null) setState(() => _selectedTime = t);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.surface100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedTime != null
                                      ? AppTheme.primary.withAlpha(60)
                                      : AppTheme.surface200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    size: 16,
                                    color: AppTheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedTime != null
                                        ? _selectedTime!.format(context)
                                        : 'Select time',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      color: _selectedTime != null
                                          ? AppTheme.textPrimary
                                          : AppTheme.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Notes (optional)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesCtrl,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add notes for this scheduled action...',
                        filled: true,
                        fillColor: AppTheme.surface100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _canSave
                            ? () {
                                final date = _selectedDate!;
                                final time = _selectedTime!;
                                final actionDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  time.hour,
                                  time.minute,
                                );
                                Navigator.pop(context);
                                widget.onSave({
                                  'type': _actionType,
                                  'date': actionDate,
                                  'notes': _notesCtrl.text.trim(),
                                });
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Add Scheduled Action',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Complete Session Sheet ───────────────────────────────────────────────────

class _CompleteSessionSheet extends StatefulWidget {
  final Map<String, dynamic> session;
  final void Function(
    String outcome,
    int rating,
    String notes,
    bool scheduleFollowUp,
    DateTime? followUpDate,
    String? nextActionType,
  )
  onComplete;
  const _CompleteSessionSheet({
    required this.session,
    required this.onComplete,
  });

  @override
  State<_CompleteSessionSheet> createState() => _CompleteSessionSheetState();
}

class _CompleteSessionSheetState extends State<_CompleteSessionSheet> {
  final _outcomeCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  int _rating = 0;
  bool _scheduleNextAction = false;
  String _nextActionType = 'Appointment';
  DateTime? _nextActionDate;
  TimeOfDay? _nextActionTime;

  static const _nextActionTypes = [
    'Appointment',
    'Video Call',
    'Call Back',
    'Follow Up',
  ];

  bool get _canComplete => _outcomeCtrl.text.trim().isNotEmpty && _rating > 0;

  Color _actionColor(String a) {
    switch (a) {
      case 'Appointment':
        return const Color(0xFF8B5CF6);
      case 'Video Call':
        return const Color(0xFF0891B2);
      case 'Call Back':
        return AppTheme.success;
      case 'Follow Up':
        return AppTheme.warning;
      default:
        return AppTheme.primary;
    }
  }

  IconData _actionIcon(String a) {
    switch (a) {
      case 'Appointment':
        return Icons.people_rounded;
      case 'Video Call':
        return Icons.videocam_rounded;
      case 'Call Back':
        return Icons.phone_callback_rounded;
      case 'Follow Up':
        return Icons.repeat_rounded;
      default:
        return Icons.calendar_today_rounded;
    }
  }

  @override
  void dispose() {
    _outcomeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime dt) {
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

  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: SingleChildScrollView(
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
              Text(
                'Complete Session',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Fill in the session outcome to complete.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.primary.withAlpha(60)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppTheme.primary.withAlpha(30),
                      child: Text(
                        (s['linkedLead'] as String).isNotEmpty
                            ? (s['linkedLead'] as String)[0]
                            : '?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s['linkedLead'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                            ),
                          ),
                          if ((s['customerPhone'] as String? ?? '').isNotEmpty)
                            Text(
                              s['customerPhone'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppTheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      s['title'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Session Rating',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppTheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  5,
                  (i) => GestureDetector(
                    onTap: () => setState(() => _rating = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        i < _rating
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 32,
                        color: AppTheme.warning,
                      ),
                    ),
                  ),
                ),
              ),
              if (_rating == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Rating is required',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: AppTheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Outcome',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppTheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _outcomeCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'e.g. Positive — Moving to Proposal',
                  filled: true,
                  fillColor: AppTheme.surface100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
              const SizedBox(height: 16),
              Text(
                'Notes (optional)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Session notes, key discussion points...',
                  filled: true,
                  fillColor: AppTheme.surface100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
              const SizedBox(height: 16),
              // ── Schedule Next Action ──────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _scheduleNextAction
                      ? AppTheme.primaryContainer
                      : AppTheme.surface100,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _scheduleNextAction
                        ? AppTheme.primary.withAlpha(80)
                        : AppTheme.surface200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.next_plan_rounded,
                          size: 18,
                          color: _scheduleNextAction
                              ? AppTheme.primary
                              : AppTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Schedule Next Action',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _scheduleNextAction
                                  ? AppTheme.primary
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        Switch(
                          value: _scheduleNextAction,
                          onChanged: (v) => setState(() {
                            _scheduleNextAction = v;
                            if (v && _nextActionDate == null) {
                              _nextActionDate = DateTime.now().add(
                                const Duration(days: 1),
                              );
                            }
                          }),
                          activeColor: AppTheme.primary,
                        ),
                      ],
                    ),
                    if (_scheduleNextAction) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Action Type',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _nextActionTypes.map((t) {
                          final sel = _nextActionType == t;
                          final color = _actionColor(t);
                          return GestureDetector(
                            onTap: () => setState(() => _nextActionType = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: sel
                                    ? color.withAlpha(25)
                                    : AppTheme.surfaceLight,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: sel ? color : AppTheme.surface200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _actionIcon(t),
                                    size: 13,
                                    color: sel ? color : AppTheme.textMuted,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    t,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: sel
                                          ? color
                                          : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Date & Time',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final d = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      _nextActionDate ??
                                      DateTime.now().add(
                                        const Duration(days: 1),
                                      ),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (d != null)
                                  setState(() => _nextActionDate = d);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _nextActionDate != null
                                        ? AppTheme.primary.withAlpha(60)
                                        : AppTheme.surface200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: AppTheme.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _nextActionDate != null
                                          ? _formatDate(_nextActionDate!)
                                          : 'Select date',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: _nextActionDate != null
                                            ? AppTheme.textPrimary
                                            : AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final t = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      _nextActionTime ?? TimeOfDay.now(),
                                );
                                if (t != null)
                                  setState(() => _nextActionTime = t);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _nextActionTime != null
                                        ? AppTheme.primary.withAlpha(60)
                                        : AppTheme.surface200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 14,
                                      color: AppTheme.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _nextActionTime != null
                                          ? _nextActionTime!.format(context)
                                          : 'Select time',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: _nextActionTime != null
                                            ? AppTheme.textPrimary
                                            : AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canComplete
                      ? () {
                          DateTime? actionDateTime;
                          if (_scheduleNextAction && _nextActionDate != null) {
                            final t =
                                _nextActionTime ??
                                const TimeOfDay(hour: 10, minute: 0);
                            actionDateTime = DateTime(
                              _nextActionDate!.year,
                              _nextActionDate!.month,
                              _nextActionDate!.day,
                              t.hour,
                              t.minute,
                            );
                          }
                          Navigator.pop(context);
                          widget.onComplete(
                            _outcomeCtrl.text.trim(),
                            _rating,
                            _notesCtrl.text.trim(),
                            _scheduleNextAction,
                            actionDateTime,
                            _scheduleNextAction ? _nextActionType : null,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.success,
                    disabledBackgroundColor: AppTheme.surface200,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Complete Session',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: _canComplete ? Colors.white : AppTheme.textMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── New Session Sheet ────────────────────────────────────────────────────────

class _NewSessionSheet extends StatefulWidget {
  final List<_AgentInfo> agents;
  final void Function(Map<String, dynamic>) onSave;
  const _NewSessionSheet({required this.agents, required this.onSave});

  @override
  State<_NewSessionSheet> createState() => _NewSessionSheetState();
}

class _NewSessionSheetState extends State<_NewSessionSheet> {
  final _titleCtrl = TextEditingController();
  final _agendaCtrl = TextEditingController();
  final _meetingLinkCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _leadSearchCtrl = TextEditingController();

  String _selectedType = 'Video Call';
  _AgentInfo? _selectedAgent;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _priority = 'Medium';
  Map<String, dynamic>? _selectedLead;
  String _leadSearchQuery = '';
  bool _showLeadSearch = false;

  // Scheduled action
  String _scheduledActionType = 'Appointment';
  DateTime? _scheduledActionDate;
  TimeOfDay? _scheduledActionTime;
  bool _hasScheduledAction = false;

  static const _types = ['Video Call', 'Appointment', 'Call Back'];
  static const _priorities = ['High', 'Medium', 'Low'];
  static const _scheduledActionTypes = [
    'Appointment',
    'Video Call',
    'Call Back',
  ];

  bool get _canSave =>
      _titleCtrl.text.trim().isNotEmpty &&
      _selectedLead != null &&
      _selectedAgent != null &&
      _selectedDate != null &&
      _selectedTime != null;

  String _formatDate(DateTime dt) {
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

  List<Map<String, dynamic>> get _filteredLeads {
    final q = _leadSearchQuery.toLowerCase();
    return leads_list.globalLeadMaps.where((m) {
      final name = (m['name'] as String? ?? '').toLowerCase();
      final phone = (m['phone'] as String? ?? '').toLowerCase();
      return q.isEmpty || name.contains(q) || phone.contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _agendaCtrl.dispose();
    _meetingLinkCtrl.dispose();
    _locationCtrl.dispose();
    _leadSearchCtrl.dispose();
    super.dispose();
  }

  Color _typeColor(String t) {
    switch (t) {
      case 'Video Call':
        return const Color(0xFF0891B2);
      case 'Appointment':
        return const Color(0xFF8B5CF6);
      case 'Call Back':
        return AppTheme.success;
      default:
        return AppTheme.primary;
    }
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'Video Call':
        return Icons.videocam_rounded;
      case 'Appointment':
        return Icons.people_rounded;
      case 'Call Back':
        return Icons.phone_callback_rounded;
      default:
        return Icons.event_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: SingleChildScrollView(
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
                  Expanded(
                    child: Text(
                      'Schedule New Session',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.surface100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildLabel('Session Title *'),
              const SizedBox(height: 6),
              TextField(
                controller: _titleCtrl,
                onChanged: (_) => setState(() {}),
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'e.g. Insurance Review with Rahul',
                  filled: true,
                  fillColor: AppTheme.surface100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Customer search from existing leads
              _buildLabel('Customer *'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => setState(() => _showLeadSearch = !_showLeadSearch),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedLead != null
                        ? AppTheme.primaryContainer
                        : AppTheme.surface100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedLead != null
                          ? AppTheme.primary.withAlpha(60)
                          : AppTheme.surface200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_search_rounded,
                        size: 16,
                        color: _selectedLead != null
                            ? AppTheme.primary
                            : AppTheme.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _selectedLead != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedLead!['name'] as String? ?? '',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                  if ((_selectedLead!['phone'] as String? ?? '')
                                      .isNotEmpty)
                                    Text(
                                      _selectedLead!['phone'] as String,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                ],
                              )
                            : Text(
                                'Search and select customer from leads',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                      ),
                      Icon(
                        _showLeadSearch
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                        size: 18,
                        color: AppTheme.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
              if (_showLeadSearch) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: _leadSearchCtrl,
                  autofocus: true,
                  onChanged: (v) => setState(() => _leadSearchQuery = v),
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Search by name or phone...',
                    prefixIcon: const Icon(Icons.search_rounded, size: 16),
                    filled: true,
                    fillColor: AppTheme.surface100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.surface200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: _filteredLeads.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'No leads found',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _filteredLeads.length,
                          itemBuilder: (_, i) {
                            final lead = _filteredLeads[i];
                            final name = lead['name'] as String? ?? '';
                            final phone = lead['phone'] as String? ?? '';
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedLead = lead;
                                  _showLeadSearch = false;
                                  _leadSearchQuery = '';
                                  _leadSearchCtrl.clear();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppTheme.surface200,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppTheme.primary
                                          .withAlpha(30),
                                      child: Text(
                                        name.isNotEmpty ? name[0] : '?',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (phone.isNotEmpty)
                                            Text(
                                              phone,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontSize: 11,
                                                    color:
                                                        AppTheme.textSecondary,
                                                  ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
              const SizedBox(height: 12),

              // Session Type
              _buildLabel('Session Type *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _types.map((t) {
                  final sel = _selectedType == t;
                  final color = _typeColor(t);
                  return GestureDetector(
                    onTap: () => setState(() => _selectedType = t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? color.withAlpha(25) : AppTheme.surface100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? color : AppTheme.surface200,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _typeIcon(t),
                            size: 14,
                            color: sel ? color : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            t,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel ? color : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Assign Host / Agent — same design as follow-up assigned host
              _buildLabel('Assign Host / Agent *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.agents.map((a) {
                  final sel = _selectedAgent?.name == a.name;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAgent = a),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel
                            ? a.color.withAlpha(25)
                            : AppTheme.surface100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? a.color : AppTheme.surface200,
                          width: sel ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: a.color.withAlpha(40),
                            child: Text(
                              a.initials,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: a.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                a.name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: sel ? a.color : AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                a.role,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  color: sel
                                      ? a.color.withAlpha(180)
                                      : AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                          if (sel) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 14,
                              color: a.color,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Date & Time
              _buildLabel('Date & Time *'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(
                            const Duration(days: 1),
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (d != null) setState(() => _selectedDate = d);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surface100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedDate != null
                                ? AppTheme.primary.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedDate != null
                                  ? _formatDate(_selectedDate!)
                                  : 'Select date',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _selectedDate != null
                                    ? AppTheme.textPrimary
                                    : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (t != null) setState(() => _selectedTime = t);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surface100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedTime != null
                                ? AppTheme.primary.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedTime != null
                                  ? _selectedTime!.format(context)
                                  : 'Select time',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _selectedTime != null
                                    ? AppTheme.textPrimary
                                    : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Priority
              _buildLabel('Priority'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _priorities.map((p) {
                  final sel = _priority == p;
                  final color = p == 'High'
                      ? AppTheme.error
                      : p == 'Medium'
                      ? AppTheme.warning
                      : AppTheme.success;
                  return GestureDetector(
                    onTap: () => setState(() => _priority = p),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? color.withAlpha(30) : AppTheme.surface100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? color : AppTheme.surface200,
                        ),
                      ),
                      child: Text(
                        p,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: sel ? color : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Scheduled Action
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _hasScheduledAction
                      ? const Color(0xFF8B5CF6).withAlpha(10)
                      : AppTheme.surface100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hasScheduledAction
                        ? const Color(0xFF8B5CF6).withAlpha(60)
                        : AppTheme.surface200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 18,
                          color: _hasScheduledAction
                              ? const Color(0xFF8B5CF6)
                              : AppTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Scheduled Action',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _hasScheduledAction
                                  ? const Color(0xFF8B5CF6)
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        Switch(
                          value: _hasScheduledAction,
                          onChanged: (v) =>
                              setState(() => _hasScheduledAction = v),
                          activeThumbColor: const Color(0xFF8B5CF6),
                        ),
                      ],
                    ),
                    if (_hasScheduledAction) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _scheduledActionTypes.map((t) {
                          final sel = _scheduledActionType == t;
                          final color = t == 'Appointment'
                              ? const Color(0xFF8B5CF6)
                              : t == 'Video Call'
                              ? const Color(0xFF0891B2)
                              : AppTheme.success;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _scheduledActionType = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: sel
                                    ? color.withAlpha(25)
                                    : AppTheme.surfaceLight,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: sel ? color : AppTheme.surface200,
                                ),
                              ),
                              child: Text(
                                t,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: sel ? color : AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final d = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().add(
                                    const Duration(days: 1),
                                  ),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (d != null)
                                  setState(() => _scheduledActionDate = d);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _scheduledActionDate != null
                                        ? const Color(0xFF8B5CF6).withAlpha(60)
                                        : AppTheme.surface200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: Color(0xFF8B5CF6),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _scheduledActionDate != null
                                          ? _formatDate(_scheduledActionDate!)
                                          : 'Date',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: _scheduledActionDate != null
                                            ? AppTheme.textPrimary
                                            : AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final t = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (t != null)
                                  setState(() => _scheduledActionTime = t);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _scheduledActionTime != null
                                        ? const Color(0xFF8B5CF6).withAlpha(60)
                                        : AppTheme.surface200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 14,
                                      color: Color(0xFF8B5CF6),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _scheduledActionTime != null
                                          ? _scheduledActionTime!.format(
                                              context,
                                            )
                                          : 'Time',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: _scheduledActionTime != null
                                            ? AppTheme.textPrimary
                                            : AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Agenda
              _buildLabel('Agenda'),
              const SizedBox(height: 6),
              TextField(
                controller: _agendaCtrl,
                maxLines: 2,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'What will be discussed?',
                  filled: true,
                  fillColor: AppTheme.surface100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
              const SizedBox(height: 12),

              if (_selectedType == 'Video Call') ...[
                _buildLabel('Meeting Link'),
                const SizedBox(height: 6),
                TextField(
                  controller: _meetingLinkCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'meet.google.com/...',
                    filled: true,
                    fillColor: AppTheme.surface100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                  ),
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                ),
                const SizedBox(height: 12),
              ],

              _buildLabel('Location'),
              const SizedBox(height: 6),
              TextField(
                controller: _locationCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Online / Office address',
                  filled: true,
                  fillColor: AppTheme.surface100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSave
                      ? () {
                          final date = _selectedDate!;
                          final time = _selectedTime!;
                          final sessionDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          final lead = _selectedLead!;
                          final newSession = {
                            'id':
                                'ses-${DateTime.now().millisecondsSinceEpoch}',
                            'title': _titleCtrl.text.trim(),
                            'type': _selectedType,
                            'status': 'Scheduled',
                            'date': sessionDate,
                            'host': _selectedAgent!.name,
                            'hostInitials': _selectedAgent!.initials,
                            'participants': [lead['name'] as String? ?? ''],
                            'linkedLead': lead['name'] as String? ?? '',
                            'linkedLeadId': lead['id'] as String? ?? '',
                            'customerPhone': lead['phone'] as String? ?? '',
                            'preferredContact':
                                (lead['preferredContact'] as List?)
                                    ?.cast<String>() ??
                                <String>[],
                            'meetingLink': _meetingLinkCtrl.text.trim(),
                            'platform': _selectedType == 'Video Call'
                                ? 'Online'
                                : _selectedType == 'Appointment'
                                ? 'In-Person'
                                : 'Phone',
                            'recording': false,
                            'notes': '',
                            'actionItems': <String>[],
                            'outcome': '',
                            'rating': 0,
                            'agenda': _agendaCtrl.text.trim(),
                            'location': _locationCtrl.text.trim(),
                            'reminderSent': false,
                            'followUpScheduled': false,
                            'dealValue': 0.0,
                            'priority': _priority,
                            'createdAt': DateTime.now(),
                            'videoCallCount': 0,
                            'callCount': 0,
                            'appointmentCount': 0,
                            if (_hasScheduledAction &&
                                _scheduledActionDate != null &&
                                _scheduledActionTime != null)
                              'scheduledAction': {
                                'type': _scheduledActionType,
                                'date': DateTime(
                                  _scheduledActionDate!.year,
                                  _scheduledActionDate!.month,
                                  _scheduledActionDate!.day,
                                  _scheduledActionTime!.hour,
                                  _scheduledActionTime!.minute,
                                ),
                              },
                          };
                          Navigator.pop(context);
                          widget.onSave(newSession);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    disabledBackgroundColor: AppTheme.surface200,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Schedule Session',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: _canSave ? Colors.white : AppTheme.textMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppTheme.textSecondary,
      ),
    );
  }
}

// ─── Filter Sheet ─────────────────────────────────────────────────────────────

class _FilterSheet extends StatefulWidget {
  final List<String> selectedHosts;
  final List<String> selectedTypes;
  final List<String> hostOptions;
  final List<String> typeOptions;
  final bool? existingCustomerFilter;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final void Function(
    List<String> hosts,
    List<String> types,
    bool? existingCustomer,
    DateTime? from,
    DateTime? to,
  )
  onApply;

  const _FilterSheet({
    required this.selectedHosts,
    required this.selectedTypes,
    required this.hostOptions,
    required this.typeOptions,
    required this.existingCustomerFilter,
    required this.dateFrom,
    required this.dateTo,
    required this.onApply,
  });

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late List<String> _hosts;
  late List<String> _types;
  bool? _existingCustomer;
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _hosts = List.from(widget.selectedHosts);
    _types = List.from(widget.selectedTypes);
    _existingCustomer = widget.existingCustomerFilter;
    _from = widget.dateFrom;
    _to = widget.dateTo;
  }

  String _formatDate(DateTime dt) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.surface200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Text(
                  'Filter Sessions',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() {
                    _hosts.clear();
                    _types.clear();
                    _existingCustomer = null;
                    _from = null;
                    _to = null;
                  }),
                  child: Text(
                    'Clear All',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppTheme.error,
                      fontSize: 13,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Session Type
                  Text(
                    'Session Type',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.typeOptions.map((t) {
                      final sel = _types.contains(t);
                      final color = t == 'Video Call'
                          ? const Color(0xFF0891B2)
                          : t == 'Appointment'
                          ? const Color(0xFF8B5CF6)
                          : AppTheme.success;
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (sel)
                            _types.remove(t);
                          else
                            _types.add(t);
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: sel
                                ? color.withAlpha(25)
                                : AppTheme.surface100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: sel ? color : AppTheme.surface200,
                            ),
                          ),
                          child: Text(
                            t,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel ? color : AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // Existing Customer
                  Text(
                    'Existing Customer',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _existingCustomer = null),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _existingCustomer == null
                                ? AppTheme.primaryContainer
                                : AppTheme.surface100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _existingCustomer == null
                                  ? AppTheme.primary
                                  : AppTheme.surface200,
                            ),
                          ),
                          child: Text(
                            'All',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _existingCustomer == null
                                  ? AppTheme.primary
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _existingCustomer = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _existingCustomer == true
                                ? AppTheme.success.withAlpha(25)
                                : AppTheme.surface100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _existingCustomer == true
                                  ? AppTheme.success
                                  : AppTheme.surface200,
                            ),
                          ),
                          child: Text(
                            'Yes',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _existingCustomer == true
                                  ? AppTheme.success
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _existingCustomer = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _existingCustomer == false
                                ? AppTheme.error.withAlpha(25)
                                : AppTheme.surface100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _existingCustomer == false
                                  ? AppTheme.error
                                  : AppTheme.surface200,
                            ),
                          ),
                          child: Text(
                            'No',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _existingCustomer == false
                                  ? AppTheme.error
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Assigned Host — search bar + list rows (same as follow-up)
                  Text(
                    'Assigned Host',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _SessionAssignedFilter(
                    selectedHosts: _hosts,
                    onChanged: (h) => setState(() => _hosts = h),
                  ),
                  const SizedBox(height: 16),
                  // Date Range
                  Text(
                    'Date Range',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: _from ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (d != null) setState(() => _from = d);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surface100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _from != null
                                    ? AppTheme.primary.withAlpha(60)
                                    : AppTheme.surface200,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 14,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _from != null ? _formatDate(_from!) : 'From',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: _from != null
                                        ? AppTheme.textPrimary
                                        : AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: _to ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (d != null) setState(() => _to = d);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surface100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _to != null
                                    ? AppTheme.primary.withAlpha(60)
                                    : AppTheme.surface200,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 14,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _to != null ? _formatDate(_to!) : 'To',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: _to != null
                                        ? AppTheme.textPrimary
                                        : AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onApply(
                          _hosts,
                          _types,
                          _existingCustomer,
                          _from,
                          _to,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Apply Filters',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
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
}

// ─── Session Assigned Filter (search bar + list rows) ─────────────────────────

class _SessionAssignedFilter extends StatefulWidget {
  final List<String> selectedHosts;
  final ValueChanged<List<String>> onChanged;
  const _SessionAssignedFilter({
    required this.selectedHosts,
    required this.onChanged,
  });

  @override
  State<_SessionAssignedFilter> createState() => _SessionAssignedFilterState();
}

class _SessionAssignedFilterState extends State<_SessionAssignedFilter> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_AgentInfo> get _displayList {
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      return _kAgents
          .where(
            (a) =>
                a.name.toLowerCase().contains(q) ||
                a.role.toLowerCase().contains(q),
          )
          .toList();
    }
    final selected = _kAgents
        .where((a) => widget.selectedHosts.contains(a.name))
        .toList();
    final unselected = _kAgents
        .where((a) => !widget.selectedHosts.contains(a.name))
        .take(3)
        .toList();
    return [...selected, ...unselected];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceVariantLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surface200),
          ),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Search agents...',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: AppTheme.textMuted,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 18,
                color: AppTheme.textMuted,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              isDense: true,
            ),
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        const SizedBox(height: 8),
        _buildRow(
          'ALL',
          'All Agents',
          'Show all',
          '',
          AppTheme.textSecondary,
          widget.selectedHosts.isEmpty,
          () => widget.onChanged([]),
        ),
        ..._displayList.map(
          (a) => _buildRow(
            a.initials,
            a.name,
            a.role,
            a.id,
            a.color,
            widget.selectedHosts.contains(a.name),
            () {
              final updated = List<String>.from(widget.selectedHosts);
              updated.contains(a.name)
                  ? updated.remove(a.name)
                  : updated.add(a.name);
              widget.onChanged(updated);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    String initials,
    String name,
    String role,
    String id,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: isSelected
            ? BoxDecoration(
                color: AppTheme.primaryContainer.withAlpha(80),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withAlpha(40),
              child: Text(
                initials.length > 2 ? initials.substring(0, 2) : initials,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    role,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: AppTheme.primary,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Sort Sheet ───────────────────────────────────────────────────────────────

class _SortSheet extends StatelessWidget {
  final _SessionSortOption current;
  final void Function(_SessionSortOption) onSelect;

  const _SortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        _SessionSortOption.dateAscending,
        'Date (Ascending)',
        Icons.arrow_upward_rounded,
      ),
      (
        _SessionSortOption.dateDescending,
        'Date (Descending)',
        Icons.arrow_downward_rounded,
      ),
      (
        _SessionSortOption.priorityHigh,
        'Priority (High First)',
        Icons.flag_rounded,
      ),
      (
        _SessionSortOption.leadAZ,
        'Lead Name (A-Z)',
        Icons.sort_by_alpha_rounded,
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.surface200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Text(
                  'Sort Sessions',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...options.map((opt) {
            final isSelected = current == opt.$1;
            return ListTile(
              leading: Icon(
                opt.$3,
                color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                size: 20,
              ),
              title: Text(
                opt.$2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_rounded, color: AppTheme.primary, size: 18)
                  : null,
              onTap: () {
                Navigator.pop(context);
                onSelect(opt.$1);
              },
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasActive;
  final VoidCallback onTap;

  const _HeaderButton({
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
          color: hasActive
              ? AppTheme.primary.withAlpha(20)
              : AppTheme.surface100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasActive
                ? AppTheme.primary.withAlpha(60)
                : AppTheme.surface200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
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
                  color: AppTheme.primary,
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

class _KpiData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;
  final bool trendUp;
  const _KpiData(
    this.label,
    this.value,
    this.icon,
    this.color,
    this.trend,
    this.trendUp,
  );
}

class _KpiCard extends StatelessWidget {
  final _KpiData data;
  const _KpiCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
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
              fontSize: 22,
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

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
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

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(50)),
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip({
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
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(fontSize: 11, color: color),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CountChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CountChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
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

class _CountBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CountBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

class _DisabledMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _DisabledMenuTile({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
      trailing: Icon(Icons.lock_rounded, size: 14, color: color),
    );
  }
}

class _ActiveFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _ActiveFilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withAlpha(60)),
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
            child: Icon(Icons.close_rounded, size: 12, color: AppTheme.primary),
          ),
        ],
      ),
    );
  }
}

class _SDetailSection extends StatelessWidget {
  final String title;
  const _SDetailSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }
}

class _SDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _SDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                fontSize: 12,
                color: AppTheme.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
