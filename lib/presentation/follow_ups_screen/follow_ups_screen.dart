import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../leads_list_screen/leads_list_screen.dart' as leads_list;

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
    color: Color(0xFF059669),
  ),
  _AgentInfo(
    name: 'Kavya Menon',
    initials: 'KM',
    role: 'Sales Rep',
    id: 'EMP-3012',
    phone: '+91 65432 44444',
    color: Color(0xFF059669),
  ),
  _AgentInfo(
    name: 'Arjun Das',
    initials: 'AD',
    role: 'Sales Rep',
    id: 'EMP-2756',
    phone: '+91 54321 55555',
    color: Color(0xFF059669),
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

final List<Map<String, dynamic>> globalFollowUpMaps = [
  {
    'id': 'fu-001',
    'title': 'Send revised quotation to Rahul Mehta',
    'type': 'Email',
    'status': 'Pending',
    'priority': 'High',
    'dueDate': DateTime.now().copyWith(hour: 10, minute: 30, second: 0),
    'assignedAgent': 'Priya Sharma',
    'agentInitials': 'PS',
    'linkedLead': 'Rahul Mehta',
    'linkedLeadId': 'default-1',
    'customerPhone': '+91 98765 43210',
    'notes':
        'Client requested revised pricing for ₹1Cr life cover + health floater bundle. Include 5% loyalty discount.',
    'outcome': '',
    'isRecurring': true,
    'recurringFrequency': 'Monthly',
    'isOverdue': false,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    'tags': ['Life Insurance', 'Health Cover'],
    'preferredContact': ['Email'],
    'contactMethod': 'Email',
    'reminderBefore': '30 minutes',
    'isExistingCustomer': true,
    'callsDone': 0,
    'messagesDone': 0,
    'whatsappDone': 0,
    'emailDone': 0,
    'videoDone': 0,
    'upcomingFollowUps': ['Monthly check-in', 'Renewal reminder'],
  },
  {
    'id': 'fu-002',
    'title': 'Call back Sneha Kapoor — comparison sheet',
    'type': 'Calls',
    'status': 'Pending',
    'priority': 'Medium',
    'dueDate': DateTime.now().copyWith(hour: 14, minute: 0, second: 0),
    'assignedAgent': 'Rahul Singh',
    'agentInitials': 'RS',
    'linkedLead': 'Sneha Kapoor',
    'linkedLeadId': 'default-2',
    'customerPhone': '+91 87654 32109',
    'notes':
        'Send health insurance comparison sheet. Client comparing with HDFC Ergo.',
    'outcome': '',
    'isRecurring': true,
    'recurringFrequency': 'Weekly',
    'isOverdue': false,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
    'tags': ['Health Cover'],
    'preferredContact': ['Calls', 'WhatsApp Messages'],
    'contactMethod': 'Calls',
    'reminderBefore': '1 hour',
    'isExistingCustomer': false,
    'callsDone': 2,
    'messagesDone': 1,
    'whatsappDone': 0,
    'emailDone': 0,
    'videoDone': 0,
    'upcomingFollowUps': ['Weekly check-in'],
  },
  {
    'id': 'fu-003',
    'title': 'Monthly check-in — Vikram Singh',
    'type': 'Calls',
    'status': 'Overdue',
    'priority': 'Medium',
    'dueDate': DateTime.now().subtract(const Duration(hours: 3)),
    'assignedAgent': 'Priya Sharma',
    'agentInitials': 'PS',
    'linkedLead': 'Vikram Singh',
    'linkedLeadId': 'default-3',
    'customerPhone': '+91 76543 21098',
    'notes':
        'Monthly relationship check-in. Discuss proposal progress and any concerns.',
    'outcome': '',
    'isRecurring': true,
    'recurringFrequency': 'Monthly',
    'isOverdue': true,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 30)),
    'tags': ['Term Insurance', 'Health Cover'],
    'preferredContact': ['Calls'],
    'contactMethod': 'Calls',
    'reminderBefore': '1 day',
    'isExistingCustomer': true,
    'callsDone': 5,
    'messagesDone': 2,
    'whatsappDone': 1,
    'emailDone': 0,
    'videoDone': 0,
    'upcomingFollowUps': ['Monthly check-in next cycle'],
  },
  {
    'id': 'fu-004',
    'title': 'WhatsApp — Policy renewal reminder Anita Desai',
    'type': 'WhatsApp Messages',
    'status': 'Completed',
    'priority': 'Low',
    'dueDate': DateTime.now().subtract(const Duration(days: 1)),
    'assignedAgent': 'Ananya Patel',
    'agentInitials': 'AP',
    'linkedLead': 'Anita Desai',
    'linkedLeadId': 'default-4',
    'customerPhone': '+91 65432 10987',
    'notes':
        'Annual policy renewal due. Send renewal notice with updated premium.',
    'outcome': 'Client confirmed renewal. Payment received.',
    'isRecurring': true,
    'recurringFrequency': 'Yearly',
    'isOverdue': false,
    'completedAt': DateTime.now().subtract(const Duration(hours: 20)),
    'createdAt': DateTime.now().subtract(const Duration(days: 7)),
    'tags': ['Add-on Cover'],
    'preferredContact': ['WhatsApp Messages'],
    'contactMethod': 'WhatsApp Messages',
    'reminderBefore': '2 days',
    'isExistingCustomer': true,
    'callsDone': 0,
    'messagesDone': 0,
    'whatsappDone': 3,
    'emailDone': 1,
    'videoDone': 0,
    'upcomingFollowUps': ['Yearly renewal reminder'],
  },
  {
    'id': 'fu-005',
    'title': 'Send SIP calculator to Karan Joshi',
    'type': 'Email',
    'status': 'Upcoming',
    'priority': 'Medium',
    'dueDate': DateTime.now().add(const Duration(days: 1)),
    'assignedAgent': 'Kavya Menon',
    'agentInitials': 'KM',
    'linkedLead': 'Karan Joshi',
    'linkedLeadId': 'default-5',
    'customerPhone': '+91 54321 09876',
    'notes':
        'Prepare SIP calculator showing returns at 12%, 15%, 18% CAGR. Include tax saving options.',
    'outcome': '',
    'isRecurring': false,
    'recurringFrequency': 'Daily',
    'isOverdue': false,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    'tags': ['Mutual Funds', 'SIP'],
    'preferredContact': ['Email'],
    'contactMethod': 'Email',
    'reminderBefore': '30 minutes',
    'isExistingCustomer': false,
    'callsDone': 0,
    'messagesDone': 0,
    'whatsappDone': 0,
    'emailDone': 1,
    'videoDone': 0,
    'upcomingFollowUps': ['Daily SIP update', 'Tax planning session'],
  },
  {
    'id': 'fu-006',
    'title': 'Draft Key Man policy terms — Al-Rashid',
    'type': 'Video Call',
    'status': 'Upcoming',
    'priority': 'High',
    'dueDate': DateTime.now().add(const Duration(days: 3)),
    'assignedAgent': 'Priya Sharma',
    'agentInitials': 'PS',
    'linkedLead': 'Mohammed Al-Rashid',
    'linkedLeadId': 'default-6',
    'customerPhone': '+971 50 123 4567',
    'notes':
        'Draft key man insurance policy terms for 3 C-suite executives. Budget AED 200K/yr approved.',
    'outcome': '',
    'isRecurring': false,
    'recurringFrequency': 'Custom',
    'isOverdue': false,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    'tags': ['Corporate Plan', 'Key Man Insurance'],
    'preferredContact': ['Video Call', 'Email'],
    'contactMethod': 'Video Call',
    'reminderBefore': '1 day',
    'isExistingCustomer': true,
    'callsDone': 1,
    'messagesDone': 0,
    'whatsappDone': 0,
    'emailDone': 2,
    'videoDone': 1,
    'upcomingFollowUps': ['Contract review', 'Legal sign-off'],
  },
  {
    'id': 'fu-007',
    'title': 'Reschedule call — Deepa Nair',
    'type': 'Calls',
    'status': 'Overdue',
    'priority': 'High',
    'dueDate': DateTime.now().subtract(const Duration(days: 2)),
    'assignedAgent': 'Rahul Singh',
    'agentInitials': 'RS',
    'linkedLead': 'Deepa Nair',
    'linkedLeadId': '',
    'customerPhone': '+91 99887 76655',
    'notes':
        'Client cancelled previous session. Need to reschedule SIP & tax planning meeting.',
    'outcome': '',
    'isRecurring': false,
    'recurringFrequency': 'Weekly',
    'isOverdue': true,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    'tags': ['SIP', 'Tax Planning'],
    'preferredContact': ['Calls'],
    'contactMethod': 'Calls',
    'reminderBefore': '1 hour',
    'isExistingCustomer': false,
    'callsDone': 1,
    'messagesDone': 0,
    'whatsappDone': 1,
    'emailDone': 0,
    'videoDone': 0,
    'upcomingFollowUps': [],
  },
  {
    'id': 'fu-008',
    'title': 'Weekly pipeline review — all leads',
    'type': 'Messages',
    'status': 'Upcoming',
    'priority': 'Medium',
    'dueDate': DateTime.now().add(const Duration(days: 4)),
    'assignedAgent': 'Priya Sharma',
    'agentInitials': 'PS',
    'linkedLead': 'Team',
    'linkedLeadId': '',
    'customerPhone': '',
    'notes':
        'Weekly team pipeline review. Discuss conversion rates, pending proposals, and upcoming sessions.',
    'outcome': '',
    'isRecurring': true,
    'recurringFrequency': 'Weekly',
    'isOverdue': false,
    'completedAt': null,
    'createdAt': DateTime.now().subtract(const Duration(days: 7)),
    'tags': ['Pipeline Review'],
    'preferredContact': ['Messages'],
    'contactMethod': 'Messages',
    'reminderBefore': '1 hour',
    'isExistingCustomer': false,
    'callsDone': 0,
    'messagesDone': 3,
    'whatsappDone': 0,
    'emailDone': 0,
    'videoDone': 0,
    'upcomingFollowUps': ['Next weekly review'],
  },
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class FollowUpsScreen extends StatefulWidget {
  const FollowUpsScreen({super.key});

  @override
  State<FollowUpsScreen> createState() => _FollowUpsScreenState();
}

enum _FollowUpSortOption {
  dueDateSoonest,
  dueDateLatest,
  priorityHigh,
  createdNewest,
  leadAZ,
}

class _FollowUpsScreenState extends State<FollowUpsScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  bool _isSearchActive = false;
  _FollowUpSortOption _sortOption = _FollowUpSortOption.dueDateSoonest;

  // Filter state
  List<String> _selectedAgents = [];
  List<String> _selectedTypes = [];
  List<String> _selectedFrequencies = [];
  bool? _existingCustomerFilter;
  DateTime? _dateFrom;
  DateTime? _dateTo;
  bool _showCompleted = false;
  bool _showUpcoming = false;
  bool _showOverdue = false;
  bool _showCancelled = false;
  bool _showDues = false;
  bool _showToday = false;

  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> _followUps = [];

  static const _typeOptions = [
    'Calls',
    'Video Call',
    'WhatsApp Messages',
    'Email',
    'Messages',
    'Instagram',
    'Facebook',
    'X (Twitter)',
    'Telegram',
  ];
  static const _frequencyOptions = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom',
  ];

  @override
  void initState() {
    super.initState();
    _loadFollowUps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFollowUps() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _followUps = List.from(globalFollowUpMaps);
        _isLoading = false;
      });
    }
  }

  bool get _hasActiveFilters =>
      _selectedAgents.isNotEmpty ||
      _selectedTypes.isNotEmpty ||
      _selectedFrequencies.isNotEmpty ||
      _existingCustomerFilter != null ||
      _dateFrom != null ||
      _dateTo != null ||
      _showCompleted ||
      _showUpcoming ||
      _showOverdue ||
      _showCancelled ||
      _showDues ||
      _showToday;

  bool _isToday(DateTime dt) {
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }

  List<Map<String, dynamic>> get _filteredFollowUps {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<Map<String, dynamic>> result = _followUps.where((f) {
      final status = f['status'] as String;
      final dueDate = f['dueDate'] as DateTime;

      // Default: show only today's follow-ups + overdue (not completed/upcoming unless filtered)
      if (!_hasActiveFilters) {
        if (status == 'Completed') return false;
        if (status == 'Upcoming') return false;
        if (status == 'Cancelled') return false;
        // Show today's pending + overdue
        final isToday = _isToday(dueDate);
        final isOverdue = f['isOverdue'] == true || status == 'Overdue';
        return isToday || isOverdue;
      }

      // With status filters active: apply status logic
      final bool anyStatusFilter =
          _showCompleted ||
          _showUpcoming ||
          _showOverdue ||
          _showCancelled ||
          _showDues ||
          _showToday;
      if (anyStatusFilter) {
        bool matchesStatus = false;
        if (_showCompleted && status == 'Completed') matchesStatus = true;
        if (_showUpcoming && status == 'Upcoming') matchesStatus = true;
        if (_showOverdue && (f['isOverdue'] == true || status == 'Overdue'))
          matchesStatus = true;
        if (_showCancelled && status == 'Cancelled') matchesStatus = true;
        if (_showDues) {
          final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
          if (dueDay.isBefore(today) &&
              status != 'Completed' &&
              status != 'Cancelled')
            matchesStatus = true;
        }
        if (_showToday && _isToday(dueDate) && status != 'Completed')
          matchesStatus = true;
        if (!matchesStatus) return false;
      }

      final matchesSearch =
          _searchQuery.isEmpty ||
          (f['linkedLead'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (f['customerPhone'] as String? ?? '').toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (f['assignedAgent'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (f['title'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesAgent =
          _selectedAgents.isEmpty ||
          _selectedAgents.contains(f['assignedAgent']);
      final matchesType =
          _selectedTypes.isEmpty || _selectedTypes.contains(f['type']);
      final matchesFreq =
          _selectedFrequencies.isEmpty ||
          _selectedFrequencies.contains(f['recurringFrequency']);
      final matchesExisting =
          _existingCustomerFilter == null ||
          (_existingCustomerFilter == true &&
              f['isExistingCustomer'] == true) ||
          (_existingCustomerFilter == false && f['isExistingCustomer'] != true);

      bool matchesDate = true;
      if (_dateFrom != null && dueDate.isBefore(_dateFrom!)) {
        matchesDate = false;
      }
      if (_dateTo != null &&
          dueDate.isAfter(_dateTo!.add(const Duration(days: 1)))) {
        matchesDate = false;
      }

      return matchesSearch &&
          matchesAgent &&
          matchesType &&
          matchesFreq &&
          matchesExisting &&
          matchesDate;
    }).toList();

    // Sort: today first (time asc), then overdue desc, then rest
    if (!_hasActiveFilters) {
      result.sort((a, b) {
        final aDate = a['dueDate'] as DateTime;
        final bDate = b['dueDate'] as DateTime;
        final aIsToday = _isToday(aDate);
        final bIsToday = _isToday(bDate);
        final aIsOverdue = a['isOverdue'] == true || a['status'] == 'Overdue';
        final bIsOverdue = b['isOverdue'] == true || b['status'] == 'Overdue';

        // Today first (time ascending)
        if (aIsToday && !bIsToday) return -1;
        if (!aIsToday && bIsToday) return 1;
        if (aIsToday && bIsToday) return aDate.compareTo(bDate); // time asc

        // Both overdue: sort desc (most recently overdue first)
        if (aIsOverdue && bIsOverdue) return bDate.compareTo(aDate);

        return aDate.compareTo(bDate);
      });
    } else {
      switch (_sortOption) {
        case _FollowUpSortOption.dueDateSoonest:
          result.sort(
            (a, b) =>
                (a['dueDate'] as DateTime).compareTo(b['dueDate'] as DateTime),
          );
          break;
        case _FollowUpSortOption.dueDateLatest:
          result.sort(
            (a, b) =>
                (b['dueDate'] as DateTime).compareTo(a['dueDate'] as DateTime),
          );
          break;
        case _FollowUpSortOption.priorityHigh:
          const order = {'High': 0, 'Medium': 1, 'Low': 2};
          result.sort(
            (a, b) => (order[a['priority']] ?? 1).compareTo(
              order[b['priority']] ?? 1,
            ),
          );
          break;
        case _FollowUpSortOption.createdNewest:
          result.sort(
            (a, b) => (b['createdAt'] as DateTime).compareTo(
              a['createdAt'] as DateTime,
            ),
          );
          break;
        case _FollowUpSortOption.leadAZ:
          result.sort(
            (a, b) => (a['linkedLead'] as String).compareTo(
              b['linkedLead'] as String,
            ),
          );
          break;
      }
    }
    return result;
  }

  int get _totalCount => _followUps.length;
  int get _todayCount => _followUps
      .where(
        (f) => _isToday(f['dueDate'] as DateTime) && f['status'] != 'Completed',
      )
      .length;
  int get _overdueCount => _followUps
      .where((f) => f['isOverdue'] == true || f['status'] == 'Overdue')
      .length;
  int get _upcomingCount =>
      _followUps.where((f) => f['status'] == 'Upcoming').length;
  int get _completedCount =>
      _followUps.where((f) => f['status'] == 'Completed').length;
  int get _cancelledCount =>
      _followUps.where((f) => f['status'] == 'Cancelled').length;
  int get _duesCount {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _followUps.where((f) {
      final dueDate = f['dueDate'] as DateTime;
      final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
      final status = f['status'] as String;
      return dueDay.isBefore(today) &&
          status != 'Completed' &&
          status != 'Cancelled';
    }).length;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedAgents = [];
      _selectedTypes = [];
      _selectedFrequencies = [];
      _existingCustomerFilter = null;
      _dateFrom = null;
      _dateTo = null;
      _showCompleted = false;
      _showUpcoming = false;
      _showOverdue = false;
      _showCancelled = false;
      _showDues = false;
      _showToday = false;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FUFilterSheet(
        selectedAgents: List.from(_selectedAgents),
        selectedTypes: List.from(_selectedTypes),
        selectedFrequencies: List.from(_selectedFrequencies),
        existingCustomerFilter: _existingCustomerFilter,
        showCompleted: _showCompleted,
        showUpcoming: _showUpcoming,
        showOverdue: _showOverdue,
        showCancelled: _showCancelled,
        showDues: _showDues,
        showToday: _showToday,
        typeOptions: _typeOptions,
        frequencyOptions: _frequencyOptions,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        onApply:
            (
              agents,
              types,
              freqs,
              existing,
              from,
              to,
              showCompleted,
              showUpcoming,
              showOverdue,
              showCancelled,
              showDues,
              showToday,
            ) {
              setState(() {
                _selectedAgents = agents;
                _selectedTypes = types;
                _selectedFrequencies = freqs;
                _existingCustomerFilter = existing;
                _dateFrom = from;
                _dateTo = to;
                _showCompleted = showCompleted;
                _showUpcoming = showUpcoming;
                _showOverdue = showOverdue;
                _showCancelled = showCancelled;
                _showDues = showDues;
                _showToday = showToday;
              });
            },
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _FUSortSheet(
        current: _sortOption,
        onSelect: (o) => setState(() => _sortOption = o),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredFollowUps;
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(filtered.length),
            if (_isSearchActive) _buildSearchBar(),
            _buildKpiRow(),
            if (_hasActiveFilters) _buildActiveFilterChips(),
            if (_hasActiveFilters) _buildFilteredCountBanner(filtered.length),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      onRefresh: _loadFollowUps,
                      child: _buildSectionedList(filtered),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'fu_template',
            onPressed: _showTemplatesSheet,
            backgroundColor: AppTheme.primary,
            child: const Icon(
              Icons.library_books_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'fu_new',
            onPressed: _showNewFollowUpSheet,
            backgroundColor: AppTheme.warning,
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: Text(
              'New Follow-up',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
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
              color: AppTheme.warning.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.warning.withAlpha(40)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  size: 13,
                  color: AppTheme.warning,
                ),
                const SizedBox(width: 5),
                Text(
                  '$count follow-up${count == 1 ? '' : 's'} found',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int filteredCount) {
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
              color: AppTheme.warning.withAlpha(31),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.repeat_rounded,
              color: AppTheme.warning,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Follow Ups',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '$filteredCount shown',
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
          _HeaderBtn(
            icon: Icons.filter_list_rounded,
            label: 'Filter',
            hasActive: _hasActiveFilters,
            onTap: _showFilterSheet,
          ),
          const SizedBox(width: 6),
          _HeaderBtn(
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
          hintText: 'Search name, phone, agent...',
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
      _KpiData(
        'Total',
        '$_totalCount',
        Icons.repeat_rounded,
        AppTheme.warning,
        '+5%',
        true,
      ),
      _KpiData(
        'Today',
        '$_todayCount',
        Icons.today_rounded,
        AppTheme.primary,
        '$_todayCount due',
        false,
      ),
      _KpiData(
        'Overdue',
        '$_overdueCount',
        Icons.warning_rounded,
        AppTheme.error,
        '$_overdueCount urgent',
        false,
      ),
      _KpiData(
        'Upcoming',
        '$_upcomingCount',
        Icons.schedule_rounded,
        const Color(0xFF0891B2),
        'scheduled',
        false,
      ),
      _KpiData(
        'Completed',
        '$_completedCount',
        Icons.check_circle_rounded,
        AppTheme.success,
        '+8%',
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
        itemBuilder: (_, i) => _KpiCard(data: kpis[i]),
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
          ..._selectedAgents.map(
            (a) => _ActiveFilterChip(
              label: 'Agent: $a',
              onRemove: () => setState(() => _selectedAgents.remove(a)),
            ),
          ),
          ..._selectedTypes.map(
            (t) => _ActiveFilterChip(
              label: 'Type: $t',
              onRemove: () => setState(() => _selectedTypes.remove(t)),
            ),
          ),
          ..._selectedFrequencies.map(
            (f) => _ActiveFilterChip(
              label: 'Freq: $f',
              onRemove: () => setState(() => _selectedFrequencies.remove(f)),
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
          if (_showOverdue)
            _ActiveFilterChip(
              label: 'Overdue',
              onRemove: () => setState(() => _showOverdue = false),
            ),
          if (_showCompleted)
            _ActiveFilterChip(
              label: 'Completed',
              onRemove: () => setState(() => _showCompleted = false),
            ),
          if (_showUpcoming)
            _ActiveFilterChip(
              label: 'Upcoming',
              onRemove: () => setState(() => _showUpcoming = false),
            ),
          if (_showCancelled)
            _ActiveFilterChip(
              label: 'Cancelled',
              onRemove: () => setState(() => _showCancelled = false),
            ),
          if (_showDues)
            _ActiveFilterChip(
              label: 'Dues',
              onRemove: () => setState(() => _showDues = false),
            ),
          if (_showToday)
            _ActiveFilterChip(
              label: 'Today',
              onRemove: () => setState(() => _showToday = false),
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
          Icon(Icons.repeat_rounded, size: 56, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          Text(
            'No follow-ups for today',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Use filters to view all follow-ups',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sectioned list with sticky date headers ───────────────────────────────

  String _sectionLabel(Map<String, dynamic> f) {
    final dueDate = f['dueDate'] as DateTime;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
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
    final h = dueDate.hour > 12
        ? dueDate.hour - 12
        : (dueDate.hour == 0 ? 12 : dueDate.hour);
    final ampm = dueDate.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '$h:${dueDate.minute.toString().padLeft(2, '0')} $ampm';
    final dateStr =
        '${dueDate.day} ${months[dueDate.month - 1]} ${dueDate.year}';

    if (due == today) return 'Today · $timeStr';
    if (due.isBefore(today)) {
      final diff = today.difference(due).inDays;
      final overdueLabel = diff == 1 ? 'Yesterday' : '${diff}d Overdue';
      return '$overdueLabel · $dateStr $timeStr';
    }
    if (due == today.add(const Duration(days: 1))) return 'Tomorrow · $timeStr';
    return '$dateStr · $timeStr';
  }

  Widget _buildSectionedList(List<Map<String, dynamic>> filtered) {
    // Build sections: group by date label
    final List<dynamic> items = []; // String = header, Map = card
    String? lastLabel;
    for (final f in filtered) {
      final label = _sectionLabel(f);
      if (label != lastLabel) {
        items.add(label);
        lastLabel = label;
      }
      items.add(f);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        if (item is String) {
          final isToday = item.startsWith('Today');
          final isOverdue =
              item.contains('Overdue') || item.startsWith('Yesterday');
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
                        : isOverdue
                        ? AppTheme.error.withAlpha(20)
                        : AppTheme.surface200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isToday
                          ? AppTheme.primary.withAlpha(60)
                          : isOverdue
                          ? AppTheme.error.withAlpha(60)
                          : AppTheme.surface200,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isToday
                            ? Icons.today_rounded
                            : isOverdue
                            ? Icons.warning_rounded
                            : Icons.calendar_today_rounded,
                        size: 12,
                        color: isToday
                            ? AppTheme.primary
                            : isOverdue
                            ? AppTheme.error
                            : AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isToday
                              ? AppTheme.primary
                              : isOverdue
                              ? AppTheme.error
                              : AppTheme.textSecondary,
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
                        : isOverdue
                        ? AppTheme.error.withAlpha(40)
                        : AppTheme.surface200,
                    height: 1,
                  ),
                ),
              ],
            ),
          );
        }
        final f = item as Map<String, dynamic>;
        final idx = filtered.indexOf(f);
        return _FollowUpCard(
          followUp: f,
          index: idx,
          onUpdate: () => setState(() {
            _followUps = List.from(globalFollowUpMaps);
          }),
        );
      },
    );
  }

  void _showNewFollowUpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewFollowUpSheet(
        agents: _kAgents,
        onSave: (followUpData) {
          globalFollowUpMaps.insert(0, followUpData);
          setState(() {
            _followUps = List.from(globalFollowUpMaps);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Text('Follow-up created successfully!'),
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

  void _showTemplatesSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FollowUpTemplatesSheet(
        onUseTemplate: (templateData) {
          globalFollowUpMaps.insert(0, templateData);
          setState(() {
            _followUps = List.from(globalFollowUpMaps);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Follow-up created from template!'),
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
}

// ─── Follow-Up Card ───────────────────────────────────────────────────────────

class _FollowUpCard extends StatefulWidget {
  final Map<String, dynamic> followUp;
  final int index;
  final VoidCallback onUpdate;
  const _FollowUpCard({
    required this.followUp,
    required this.index,
    required this.onUpdate,
  });

  @override
  State<_FollowUpCard> createState() => _FollowUpCardState();
}

class _FollowUpCardState extends State<_FollowUpCard>
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
      case 'Pending':
        return AppTheme.primary;
      case 'Overdue':
        return AppTheme.error;
      case 'Upcoming':
        return const Color(0xFF0891B2);
      default:
        return AppTheme.textMuted;
    }
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'Calls':
        return Icons.phone_rounded;
      case 'Email':
        return Icons.email_rounded;
      case 'WhatsApp Messages':
        return Icons.chat_rounded;
      case 'Messages':
        return Icons.message_rounded;
      case 'Video Call':
        return Icons.videocam_rounded;
      default:
        return Icons.repeat_rounded;
    }
  }

  Color _typeColor(String t) {
    switch (t) {
      case 'Calls':
        return AppTheme.success;
      case 'Email':
        return AppTheme.primary;
      case 'WhatsApp Messages':
        return const Color(0xFF25D366);
      case 'Messages':
        return const Color(0xFF8B5CF6);
      case 'Video Call':
        return const Color(0xFF0891B2);
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatDue(DateTime dt) {
    final now = DateTime.now();
    final diff = dt.difference(now);
    if (diff.isNegative) {
      final abs = diff.abs();
      if (abs.inMinutes < 60) return '${abs.inMinutes}m overdue';
      if (abs.inHours < 24) return '${abs.inHours}h overdue';
      // Show actual date+time for overdue
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
      return 'Overdue · ${dt.day} ${months[dt.month - 1]} $h:${dt.minute.toString().padLeft(2, '0')} $ampm';
    }
    if (diff.inMinutes < 60) return 'In ${diff.inMinutes}m';
    if (diff.inHours < 24) return 'In ${diff.inHours}h';
    if (diff.inDays == 1) return 'Tomorrow';
    return 'In ${diff.inDays} days';
  }

  String _formatCreatedAt(DateTime dt) {
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
    return 'Created ${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  void _showThreeDots(BuildContext context) {
    final f = widget.followUp;
    final preferred = (f['preferredContact'] as List?)?.cast<String>() ?? [];
    final customerName = f['linkedLead'] as String;

    // Get lead data to check social/contact fields
    final leadMap = leads_list.globalLeadMaps.firstWhere(
      (m) => m['id'] == f['linkedLeadId'] || m['name'] == customerName,
      orElse: () => {},
    );
    final hasInstagram = (leadMap['instagram'] as String? ?? '').isNotEmpty;
    final hasFacebook = (leadMap['facebook'] as String? ?? '').isNotEmpty;
    final hasTwitter = (leadMap['twitter'] as String? ?? '').isNotEmpty;
    final hasTelegram = (leadMap['telegram'] as String? ?? '').isNotEmpty;

    void doAction(String action, String actionKey) {
      // Check preferred contact warning
      bool isPreferred = preferred.isEmpty || preferred.contains(action);
      if (!isPreferred) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Not Preferred',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
            ),
            content: Text(
              '$action is not in preferred contact for $customerName. Are you sure you want to send $action to $customerName?',
              style: GoogleFonts.plusJakartaSans(fontSize: 13),
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
                  setState(() {
                    f[actionKey] = (f[actionKey] as int? ?? 0) + 1;
                  });
                  widget.onUpdate();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.warning,
                ),
                child: Text(
                  'Yes, Proceed',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          f[actionKey] = (f[actionKey] as int? ?? 0) + 1;
        });
        widget.onUpdate();
      }
    }

    void doSocialAction(String platform, bool hasData) {
      if (!hasData) {
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
                Text(
                  'No Data Found',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            content: Text(
              'No $platform data found for $customerName. Please add their $platform handle/profile in the lead details first.',
              style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.5),
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                ),
                child: Text(
                  'OK',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          f['messagesDone'] = (f['messagesDone'] as int? ?? 0) + 1;
        });
        widget.onUpdate();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$platform message logged for $customerName'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 8,
      items: <PopupMenuEntry<dynamic>>[
        PopupMenuItem(
          onTap: () => Future.microtask(() => _showDetailsSheet(context)),
          child: _MenuRow(
            icon: Icons.info_outline_rounded,
            label: 'Show Details',
            color: AppTheme.primary,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          onTap: () => Future.microtask(() => doAction('Calls', 'callsDone')),
          child: _MenuRow(
            icon: Icons.phone_rounded,
            label: 'Call',
            color: AppTheme.success,
          ),
        ),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doAction('Messages', 'messagesDone')),
          child: _MenuRow(
            icon: Icons.message_rounded,
            label: 'Send Message',
            color: const Color(0xFF8B5CF6),
          ),
        ),
        PopupMenuItem(
          onTap: () => Future.microtask(
            () => doAction('WhatsApp Messages', 'whatsappDone'),
          ),
          child: _MenuRow(
            icon: Icons.chat_rounded,
            label: 'WhatsApp Message',
            color: const Color(0xFF25D366),
          ),
        ),
        PopupMenuItem(
          onTap: () => Future.microtask(() => doAction('Email', 'emailDone')),
          child: _MenuRow(
            icon: Icons.email_rounded,
            label: 'Email',
            color: AppTheme.primary,
          ),
        ),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doAction('Video Call', 'videoDone')),
          child: _MenuRow(
            icon: Icons.videocam_rounded,
            label: 'Video Call',
            color: const Color(0xFF0891B2),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doSocialAction('Instagram', hasInstagram)),
          child: _MenuRow(
            icon: Icons.camera_alt_rounded,
            label: hasInstagram ? 'Instagram' : 'Instagram (No data)',
            color: hasInstagram ? const Color(0xFFE1306C) : AppTheme.textMuted,
          ),
        ),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doSocialAction('Facebook', hasFacebook)),
          child: _MenuRow(
            icon: Icons.facebook_rounded,
            label: hasFacebook ? 'Facebook' : 'Facebook (No data)',
            color: hasFacebook ? const Color(0xFF1877F2) : AppTheme.textMuted,
          ),
        ),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doSocialAction('X (Twitter)', hasTwitter)),
          child: _MenuRow(
            icon: Icons.close_rounded,
            label: hasTwitter ? 'X (Twitter)' : 'X (Twitter) (No data)',
            color: hasTwitter ? const Color(0xFF000000) : AppTheme.textMuted,
          ),
        ),
        PopupMenuItem(
          onTap: () =>
              Future.microtask(() => doSocialAction('Telegram', hasTelegram)),
          child: _MenuRow(
            icon: Icons.send_rounded,
            label: hasTelegram ? 'Telegram' : 'Telegram (No data)',
            color: hasTelegram ? const Color(0xFF0088CC) : AppTheme.textMuted,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          onTap: () => Future.microtask(() => _markComplete(context)),
          child: _MenuRow(
            icon: Icons.check_circle_rounded,
            label: 'Mark Complete',
            color: AppTheme.success,
          ),
        ),
      ],
    );
  }

  void _showDetailsSheet(BuildContext context) {
    final f = widget.followUp;
    final agent = _agentByName(f['assignedAgent'] as String);
    final tags = (f['tags'] as List?)?.cast<String>() ?? [];
    final upcoming = (f['upcomingFollowUps'] as List?)?.cast<String>() ?? [];
    final preferred = (f['preferredContact'] as List?)?.cast<String>() ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.surfaceLight,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surface200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Follow-up Details',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    if ((f['linkedLeadId'] as String? ?? '').isNotEmpty)
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          final leadMap = leads_list.globalLeadMaps.firstWhere(
                            (m) => m['id'] == f['linkedLeadId'],
                            orElse: () => {},
                          );
                          if (leadMap.isNotEmpty) {
                            context.push(
                              AppRoutes.leadDetailScreen,
                              extra: leads_list.LeadModel.fromMap(leadMap),
                            );
                          }
                        },
                        icon: const Icon(Icons.open_in_new_rounded, size: 14),
                        label: Text(
                          'Lead Details',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primary,
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Customer contact
                    _SectionHeader(title: 'Contact'),
                    _DetailRow(
                      icon: Icons.person_rounded,
                      label: 'Customer',
                      value: f['linkedLead'] as String,
                    ),
                    if ((f['customerPhone'] as String? ?? '').isNotEmpty)
                      _DetailRow(
                        icon: Icons.phone_rounded,
                        label: 'Phone',
                        value: f['customerPhone'] as String,
                      ),
                    const SizedBox(height: 12),
                    // Agent details
                    _SectionHeader(title: 'Agent'),
                    _DetailRow(
                      icon: Icons.badge_rounded,
                      label: 'Agent',
                      value: agent.name,
                    ),
                    _DetailRow(
                      icon: Icons.work_rounded,
                      label: 'Role',
                      value: '${agent.role} · ${agent.id}',
                    ),
                    if (agent.phone.isNotEmpty)
                      _DetailRow(
                        icon: Icons.phone_rounded,
                        label: 'Agent Phone',
                        value: agent.phone,
                      ),
                    const SizedBox(height: 12),
                    // Follow-up info
                    _SectionHeader(title: 'Follow-up Info'),
                    _DetailRow(
                      icon: Icons.title_rounded,
                      label: 'Title',
                      value: f['title'] as String,
                    ),
                    _DetailRow(
                      icon: Icons.schedule_rounded,
                      label: 'Due',
                      value: _formatDue(f['dueDate'] as DateTime),
                    ),
                    _DetailRow(
                      icon: Icons.autorenew_rounded,
                      label: 'Frequency',
                      value: f['recurringFrequency'] as String,
                    ),
                    _DetailRow(
                      icon: Icons.contact_phone_rounded,
                      label: 'Type',
                      value: f['type'] as String,
                    ),
                    if (preferred.isNotEmpty)
                      _DetailRow(
                        icon: Icons.star_rounded,
                        label: 'Preferred',
                        value: preferred.join(', '),
                      ),
                    if ((f['notes'] as String? ?? '').isNotEmpty)
                      _DetailRow(
                        icon: Icons.notes_rounded,
                        label: 'Notes',
                        value: f['notes'] as String,
                      ),
                    if ((f['outcome'] as String? ?? '').isNotEmpty)
                      _DetailRow(
                        icon: Icons.flag_rounded,
                        label: 'Outcome',
                        value: f['outcome'] as String,
                      ),
                    const SizedBox(height: 12),
                    // Interest tags
                    if (tags.isNotEmpty) ...[
                      _SectionHeader(title: 'Interest Tags'),
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
                      const SizedBox(height: 12),
                    ],
                    // Upcoming follow-ups
                    if (upcoming.isNotEmpty) ...[
                      _SectionHeader(title: 'Upcoming Follow-ups'),
                      ...upcoming.map(
                        (u) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_right_rounded,
                                size: 18,
                                color: AppTheme.warning,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  u,
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
                      const SizedBox(height: 12),
                    ],
                    // Contact counts
                    _SectionHeader(title: 'Contact Activity'),
                    _buildContactCounts(f),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCounts(Map<String, dynamic> f) {
    final items = [
      (
        'Calls',
        Icons.phone_rounded,
        AppTheme.success,
        f['callsDone'] as int? ?? 0,
      ),
      (
        'Messages',
        Icons.message_rounded,
        const Color(0xFF8B5CF6),
        f['messagesDone'] as int? ?? 0,
      ),
      (
        'WhatsApp',
        Icons.chat_rounded,
        const Color(0xFF25D366),
        f['whatsappDone'] as int? ?? 0,
      ),
      (
        'Email',
        Icons.email_rounded,
        AppTheme.primary,
        f['emailDone'] as int? ?? 0,
      ),
      (
        'Video',
        Icons.videocam_rounded,
        const Color(0xFF0891B2),
        f['videoDone'] as int? ?? 0,
      ),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final (label, icon, color, count) = item;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                '$label: $count',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _markComplete(BuildContext context) {
    final f = widget.followUp;
    final type = f['type'] as String? ?? '';

    // Gate: check if the required action has been performed at least once
    bool actionDone = false;
    String requiredAction = '';
    if (type == 'Calls') {
      actionDone = (f['callsDone'] as int? ?? 0) > 0;
      requiredAction = 'Call';
    } else if (type == 'Messages') {
      actionDone = (f['messagesDone'] as int? ?? 0) > 0;
      requiredAction = 'Send Message';
    } else if (type == 'WhatsApp Messages') {
      actionDone = (f['whatsappDone'] as int? ?? 0) > 0;
      requiredAction = 'Send WhatsApp Message';
    } else if (type == 'Email') {
      actionDone = (f['emailDone'] as int? ?? 0) > 0;
      requiredAction = 'Send Email';
    } else if (type == 'Video Call') {
      actionDone = (f['videoDone'] as int? ?? 0) > 0;
      requiredAction = 'Start Video Call';
    } else {
      actionDone = true; // unknown type — allow
    }

    if (!actionDone) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.block_rounded, color: AppTheme.error, size: 22),
              const SizedBox(width: 8),
              Text(
                'Action Required',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          content: Text(
            'You must "$requiredAction" before marking this follow-up as completed. Please perform the scheduled action first using the action menu.',
            style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.5),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Got it',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      f['status'] = 'Completed';
      f['completedAt'] = DateTime.now();
    });
    widget.onUpdate();
    // Show reschedule sheet — non-dismissible until filled
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _RescheduleSheetWidget(
        followUp: f,
        onReschedule: (newFu) {
          globalFollowUpMaps.add(newFu);
          widget.onUpdate();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.followUp;
    final isOverdue = f['isOverdue'] == true || f['status'] == 'Overdue';
    final statusColor = _statusColor(f['status'] as String);
    final typeColor = _typeColor(f['type'] as String);
    final tags = (f['tags'] as List?)?.cast<String>() ?? [];
    final agent = _agentByName(f['assignedAgent'] as String);
    final freq = f['recurringFrequency'] as String? ?? '';
    final callsDone = f['callsDone'] as int? ?? 0;
    final msgDone = f['messagesDone'] as int? ?? 0;
    final waDone = f['whatsappDone'] as int? ?? 0;
    final emailDone = f['emailDone'] as int? ?? 0;
    final videoDone = f['videoDone'] as int? ?? 0;
    final hasActivity =
        callsDone + msgDone + waDone + emailDone + videoDone > 0;
    // Overdue escalation: calculate hours overdue
    final dueDate = f['dueDate'] as DateTime;
    final now = DateTime.now();
    final hoursOverdue = isOverdue ? now.difference(dueDate).inHours : 0;
    final isEscalated = hoursOverdue > 24;
    final isCritical = hoursOverdue > 48;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTap: () {
            _showDetailsSheet(context);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCritical
                    ? AppTheme.error
                    : isOverdue
                    ? AppTheme.error.withAlpha(80)
                    : AppTheme.surface200,
                width: isCritical || isOverdue ? 2 : 1,
              ),
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
                if (isOverdue)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isCritical
                          ? AppTheme.error.withAlpha(30)
                          : AppTheme.error.withAlpha(20),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isCritical
                              ? Icons.error_rounded
                              : Icons.warning_rounded,
                          size: 13,
                          color: AppTheme.error,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isCritical
                              ? '⚠️ CRITICAL — ${hoursOverdue}h overdue — Escalate now!'
                              : isEscalated
                              ? '🔴 ESCALATED — ${hoursOverdue}h overdue'
                              : 'OVERDUE — ${_formatDue(dueDate)}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
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
                              _typeIcon(f['type'] as String),
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
                                  f['title'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 2),
                                // Stack name and phone vertically
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
                                        f['linkedLead'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: AppTheme.textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                if ((f['customerPhone'] as String? ?? '')
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
                                          f['customerPhone'] as String,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10,
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
                            label: f['status'] as String,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Builder(
                            builder: (btnCtx) => GestureDetector(
                              onTap: () => _showThreeDots(btnCtx),
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
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: agent.color.withAlpha(40),
                            child: Text(
                              agent.initials,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: agent.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              freq.isNotEmpty
                                  ? '${agent.name} · $freq'
                                  : agent.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _InfoChip(
                            icon: Icons.schedule_rounded,
                            label: _formatDue(dueDate),
                            color: isOverdue
                                ? AppTheme.error
                                : AppTheme.textSecondary,
                          ),
                        ],
                      ),
                      // Created date row
                      if (f['createdAt'] != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _InfoChip(
                              icon: Icons.calendar_today_rounded,
                              label: _formatCreatedAt(
                                f['createdAt'] as DateTime,
                              ),
                              color: AppTheme.textMuted,
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _TypeBadge(
                            label: f['type'] as String,
                            color: typeColor,
                          ),
                          const SizedBox(width: 8),
                          _PriorityBadge(priority: f['priority'] as String),
                          if (freq.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            _InfoChip(
                              icon: Icons.autorenew_rounded,
                              label: freq,
                              color: const Color(0xFF8B5CF6),
                            ),
                          ],
                        ],
                      ),
                      if (tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
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
                      if (hasActivity) ...[
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (callsDone > 0)
                                _CountChip(
                                  icon: Icons.phone_rounded,
                                  count: callsDone,
                                  color: AppTheme.success,
                                ),
                              if (msgDone > 0)
                                _CountChip(
                                  icon: Icons.message_rounded,
                                  count: msgDone,
                                  color: const Color(0xFF8B5CF6),
                                ),
                              if (waDone > 0)
                                _CountChip(
                                  icon: Icons.chat_rounded,
                                  count: waDone,
                                  color: const Color(0xFF25D366),
                                ),
                              if (emailDone > 0)
                                _CountChip(
                                  icon: Icons.email_rounded,
                                  count: emailDone,
                                  color: AppTheme.primary,
                                ),
                              if (videoDone > 0)
                                _CountChip(
                                  icon: Icons.videocam_rounded,
                                  count: videoDone,
                                  color: const Color(0xFF0891B2),
                                ),
                            ],
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

// ─── Reschedule Sheet ─────────────────────────────────────────────────────────

class _RescheduleSheetWidget extends StatefulWidget {
  final Map<String, dynamic> followUp;
  final void Function(Map<String, dynamic>) onReschedule;
  const _RescheduleSheetWidget({
    required this.followUp,
    required this.onReschedule,
  });

  @override
  State<_RescheduleSheetWidget> createState() => _RescheduleSheetWidgetState();
}

class _RescheduleSheetWidgetState extends State<_RescheduleSheetWidget> {
  DateTime? _newDate;
  TimeOfDay? _newTime;
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
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
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.success,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Follow-up Completed!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Schedule the next follow-up to keep track of this lead.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Next Follow-up Date & Time *',
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
                        if (d != null) setState(() => _newDate = d);
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
                            color: _newDate != null
                                ? AppTheme.warning.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: AppTheme.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _newDate != null
                                  ? _formatDate(_newDate!)
                                  : 'Select date',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _newDate != null
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
                        if (t != null) setState(() => _newTime = t);
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
                            color: _newTime != null
                                ? AppTheme.warning.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: AppTheme.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _newTime != null
                                  ? _newTime!.format(context)
                                  : 'Select time',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _newTime != null
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
              Text(
                'Notes (optional)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _notesCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Add notes for next follow-up...',
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
                  onPressed: _newDate == null
                      ? null
                      : () {
                          final f = widget.followUp;
                          final date = _newDate!;
                          final time = _newTime ?? TimeOfDay.now();
                          final dueDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          final newFu = Map<String, dynamic>.from(f)
                            ..['id'] =
                                'fu-${DateTime.now().millisecondsSinceEpoch}'
                            ..['status'] = 'Upcoming'
                            ..['dueDate'] = dueDateTime
                            ..['isOverdue'] = false
                            ..['completedAt'] = null
                            ..['createdAt'] = DateTime.now()
                            ..['notes'] = _notesCtrl.text.trim().isNotEmpty
                                ? _notesCtrl.text.trim()
                                : f['notes']
                            ..['outcome'] = '';
                          Navigator.pop(context);
                          widget.onReschedule(newFu);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.warning,
                    disabledBackgroundColor: AppTheme.surface200,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Schedule Next Follow-up',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: _newDate != null
                          ? Colors.white
                          : AppTheme.textMuted,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Skip for now',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
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

// ─── New Follow-Up Sheet ──────────────────────────────────────────────────────

class _NewFollowUpSheet extends StatefulWidget {
  final List<_AgentInfo> agents;
  final void Function(Map<String, dynamic>) onSave;
  const _NewFollowUpSheet({required this.agents, required this.onSave});

  @override
  State<_NewFollowUpSheet> createState() => _NewFollowUpSheetState();
}

class _NewFollowUpSheetState extends State<_NewFollowUpSheet> {
  final _titleCtrl = TextEditingController();
  final _leadCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _type = 'Calls';
  String _priority = 'Medium';
  String _frequency = 'Weekly';
  final List<String> _preferredContact = ['Calls'];
  _AgentInfo? _selectedAgent;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;

  static const _types = [
    'Calls',
    'Video Call',
    'WhatsApp Messages',
    'Email',
    'Messages',
  ];
  static const _priorities = ['High', 'Medium', 'Low'];
  static const _frequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom',
  ];
  static const _contactModes = [
    'Calls',
    'Messages',
    'WhatsApp Messages',
    'Email',
    'Video Call',
  ];

  bool get _canSave =>
      _titleCtrl.text.trim().isNotEmpty &&
      _leadCtrl.text.trim().isNotEmpty &&
      _selectedAgent != null &&
      _dueDate != null &&
      _preferredContact.isNotEmpty;

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
  void dispose() {
    _titleCtrl.dispose();
    _leadCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
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
                      'New Follow-up',
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
              _buildField(
                'Title *',
                _titleCtrl,
                'e.g. Follow up with Rahul Mehta',
              ),
              const SizedBox(height: 12),
              _buildField('Customer / Lead Name *', _leadCtrl, 'Customer name'),
              const SizedBox(height: 12),
              _buildField(
                'Customer Phone',
                _phoneCtrl,
                '+91 XXXXX XXXXX',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              // Type
              _buildLabel('Follow-up Type *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _types.map((t) {
                  final sel = _type == t;
                  return GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: sel
                            ? AppTheme.warning.withAlpha(30)
                            : AppTheme.surface100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? AppTheme.warning : AppTheme.surface200,
                        ),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: sel
                              ? AppTheme.warning
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
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
              // Frequency
              _buildLabel('Frequency *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _frequencies.map((f) {
                  final sel = _frequency == f;
                  return GestureDetector(
                    onTap: () => setState(() => _frequency = f),
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
                        f,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: sel
                              ? AppTheme.primary
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              // Preferred Contact
              _buildLabel('Preferred Mode of Contact *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _contactModes.map((m) {
                  final sel = _preferredContact.contains(m);
                  return GestureDetector(
                    onTap: () => setState(
                      () => sel
                          ? _preferredContact.remove(m)
                          : _preferredContact.add(m),
                    ),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (sel) ...[
                            const Icon(
                              Icons.check_rounded,
                              size: 12,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            m,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel
                                  ? AppTheme.primary
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
              // Assign Agent
              _buildLabel('Assign Agent *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.agents.map((a) {
                  final sel = _selectedAgent?.name == a.name;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAgent = a),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: sel
                            ? a.color.withAlpha(30)
                            : AppTheme.surface100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? a.color : AppTheme.surface200,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: a.color.withAlpha(40),
                            child: Text(
                              a.initials,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: a.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            a.name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel ? a.color : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              // Due Date & Time
              _buildLabel('Due Date & Time *'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 1),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (d != null) setState(() => _dueDate = d);
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
                            color: _dueDate != null
                                ? AppTheme.warning.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: AppTheme.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _dueDate != null
                                  ? _formatDate(_dueDate!)
                                  : 'Select date',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _dueDate != null
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
                        if (t != null) setState(() => _dueTime = t);
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
                            color: _dueTime != null
                                ? AppTheme.warning.withAlpha(60)
                                : AppTheme.surface200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: AppTheme.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _dueTime != null
                                  ? _dueTime!.format(context)
                                  : 'Select time',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: _dueTime != null
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
              _buildField(
                'Notes (optional)',
                _notesCtrl,
                'Add notes...',
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSave
                      ? () {
                          final date = _dueDate!;
                          final time = _dueTime ?? TimeOfDay.now();
                          final dueDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          final newFu = {
                            'id': 'fu-${DateTime.now().millisecondsSinceEpoch}',
                            'title': _titleCtrl.text.trim(),
                            'type': _type,
                            'status': 'Upcoming',
                            'priority': _priority,
                            'dueDate': dueDateTime,
                            'assignedAgent': _selectedAgent!.name,
                            'agentInitials': _selectedAgent!.initials,
                            'linkedLead': _leadCtrl.text.trim(),
                            'linkedLeadId': '',
                            'customerPhone': _phoneCtrl.text.trim(),
                            'notes': _notesCtrl.text.trim(),
                            'outcome': '',
                            'isRecurring': _frequency != 'Custom',
                            'recurringFrequency': _frequency,
                            'isOverdue': false,
                            'completedAt': null,
                            'createdAt': DateTime.now(),
                            'tags': <String>[],
                            'preferredContact': List<String>.from(
                              _preferredContact,
                            ),
                            'contactMethod': _preferredContact.isNotEmpty
                                ? _preferredContact.first
                                : _type,
                            'reminderBefore': '1 hour',
                            'isExistingCustomer': false,
                            'callsDone': 0,
                            'messagesDone': 0,
                            'whatsappDone': 0,
                            'emailDone': 0,
                            'videoDone': 0,
                            'upcomingFollowUps': <String>[],
                          };
                          Navigator.pop(context);
                          widget.onSave(newFu);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.warning,
                    disabledBackgroundColor: AppTheme.surface200,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Create Follow-up',
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

  Widget _buildField(
    String label,
    TextEditingController ctrl,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hint,
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
      ],
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

// ─── Follow-Up Templates Sheet ────────────────────────────────────────────────

class _FollowUpTemplatesSheet extends StatelessWidget {
  final void Function(Map<String, dynamic>) onUseTemplate;
  const _FollowUpTemplatesSheet({required this.onUseTemplate});

  static final _templates = [
    {
      'name': 'Quick Call Check-in',
      'icon': Icons.phone_rounded,
      'color': AppTheme.success,
      'type': 'Calls',
      'priority': 'Medium',
      'frequency': 'Weekly',
      'preferredContact': ['Calls'],
      'titlePrefix': 'Weekly call with',
    },
    {
      'name': 'Policy Renewal Reminder',
      'icon': Icons.autorenew_rounded,
      'color': AppTheme.warning,
      'type': 'Email',
      'priority': 'High',
      'frequency': 'Yearly',
      'preferredContact': ['Email', 'Calls'],
      'titlePrefix': 'Policy renewal for',
    },
    {
      'name': 'Post-Session Follow-up',
      'icon': Icons.videocam_rounded,
      'color': const Color(0xFF0891B2),
      'type': 'Calls',
      'priority': 'High',
      'frequency': 'Custom',
      'preferredContact': ['Calls', 'WhatsApp Messages'],
      'titlePrefix': 'Post-session follow-up with',
    },
    {
      'name': 'WhatsApp Check-in',
      'icon': Icons.chat_rounded,
      'color': const Color(0xFF25D366),
      'type': 'WhatsApp Messages',
      'priority': 'Low',
      'frequency': 'Monthly',
      'preferredContact': ['WhatsApp Messages'],
      'titlePrefix': 'Monthly WhatsApp check-in with',
    },
    {
      'name': 'Proposal Follow-up',
      'icon': Icons.description_rounded,
      'color': const Color(0xFF8B5CF6),
      'type': 'Calls',
      'priority': 'High',
      'frequency': 'Weekly',
      'preferredContact': ['Calls', 'Email'],
      'titlePrefix': 'Proposal follow-up with',
    },
    {
      'name': 'Birthday Greeting',
      'icon': Icons.cake_rounded,
      'color': AppTheme.error,
      'type': 'WhatsApp Messages',
      'priority': 'Low',
      'frequency': 'Yearly',
      'preferredContact': ['WhatsApp Messages'],
      'titlePrefix': 'Birthday greeting for',
    },
  ];

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
                'Follow-up Templates',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
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
          const SizedBox(height: 4),
          Text(
            'Tap a template to create a follow-up instantly',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ..._templates.map(
            (t) => GestureDetector(
              onTap: () {
                Navigator.pop(context);
                final newFu = {
                  'id': 'fu-tpl-${DateTime.now().millisecondsSinceEpoch}',
                  'title': '${t['titlePrefix']} Customer',
                  'type': t['type'] as String,
                  'status': 'Upcoming',
                  'priority': t['priority'] as String,
                  'dueDate': DateTime.now().add(const Duration(days: 1)),
                  'assignedAgent': 'Priya Sharma',
                  'agentInitials': 'PS',
                  'linkedLead': 'Customer',
                  'linkedLeadId': '',
                  'customerPhone': '',
                  'notes': 'Created from template: ${t['name']}',
                  'outcome': '',
                  'isRecurring': t['frequency'] != 'Custom',
                  'recurringFrequency': t['frequency'] as String,
                  'isOverdue': false,
                  'completedAt': null,
                  'createdAt': DateTime.now(),
                  'tags': <String>[],
                  'preferredContact': List<String>.from(
                    t['preferredContact'] as List,
                  ),
                  'contactMethod': (t['preferredContact'] as List).first,
                  'reminderBefore': '1 hour',
                  'isExistingCustomer': false,
                  'callsDone': 0,
                  'messagesDone': 0,
                  'whatsappDone': 0,
                  'emailDone': 0,
                  'videoDone': 0,
                  'upcomingFollowUps': <String>[],
                };
                onUseTemplate(newFu);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: (t['color'] as Color).withAlpha(40),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (t['color'] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        t['icon'] as IconData,
                        color: t['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t['name'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${t['type']} · ${t['frequency']} · ${t['priority']} priority',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: t['color'] as Color,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bulk Action Button ───────────────────────────────────────────────────────

class _BulkBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _BulkBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withAlpha(60)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _CountChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  const _CountChip({
    required this.icon,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 3),
          Text(
            '$count',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

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
        ),
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasActive;
  final VoidCallback onTap;
  const _HeaderBtn({
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

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge({required this.label, required this.color});

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

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TypeBadge({required this.label, required this.color});

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

class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({required this.priority});

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
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({
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

class _KpiData {
  final String label, value, trend;
  final IconData icon;
  final Color color;
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

// ─── Filter Sheet ─────────────────────────────────────────────────────────────

class _FUFilterSheet extends StatefulWidget {
  final List<String> selectedAgents,
      selectedTypes,
      selectedFrequencies,
      typeOptions,
      frequencyOptions;
  final bool? existingCustomerFilter;
  final bool showCompleted,
      showUpcoming,
      showOverdue,
      showCancelled,
      showDues,
      showToday;
  final DateTime? dateFrom, dateTo;
  final Function(
    List<String>,
    List<String>,
    List<String>,
    bool?,
    DateTime?,
    DateTime?,
    bool,
    bool,
    bool,
    bool,
    bool,
    bool,
  )
  onApply;

  const _FUFilterSheet({
    required this.selectedAgents,
    required this.selectedTypes,
    required this.selectedFrequencies,
    required this.existingCustomerFilter,
    required this.showCompleted,
    required this.showUpcoming,
    required this.showOverdue,
    required this.showCancelled,
    required this.showDues,
    required this.showToday,
    required this.typeOptions,
    required this.frequencyOptions,
    required this.dateFrom,
    required this.dateTo,
    required this.onApply,
  });

  @override
  State<_FUFilterSheet> createState() => _FUFilterSheetState();
}

class _FUFilterSheetState extends State<_FUFilterSheet> {
  late List<String> _agents, _types, _freqs;
  bool? _existingCustomer;
  bool _showCompleted = false, _showUpcoming = false, _showOverdue = false;
  bool _showCancelled = false, _showDues = false, _showToday = false;
  DateTime? _from, _to;

  @override
  void initState() {
    super.initState();
    _agents = List.from(widget.selectedAgents);
    _types = List.from(widget.selectedTypes);
    _freqs = List.from(widget.selectedFrequencies);
    _existingCustomer = widget.existingCustomerFilter;
    _showCompleted = widget.showCompleted;
    _showUpcoming = widget.showUpcoming;
    _showOverdue = widget.showOverdue;
    _showCancelled = widget.showCancelled;
    _showDues = widget.showDues;
    _showToday = widget.showToday;
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
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
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
                  'Filter Follow-ups',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() {
                    _agents = [];
                    _types = [];
                    _freqs = [];
                    _existingCustomer = null;
                    _from = null;
                    _to = null;
                    _showCompleted = false;
                    _showUpcoming = false;
                    _showOverdue = false;
                    _showCancelled = false;
                    _showDues = false;
                    _showToday = false;
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
            // ─── Status Section ───────────────────────────────────────────
            Text(
              'Status',
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
              children: [
                _FilterChip(
                  label: 'Completed',
                  isSelected: _showCompleted,
                  onTap: () => setState(() => _showCompleted = !_showCompleted),
                ),
                _FilterChip(
                  label: 'Cancelled',
                  isSelected: _showCancelled,
                  onTap: () => setState(() => _showCancelled = !_showCancelled),
                ),
                _FilterChip(
                  label: 'Dues',
                  isSelected: _showDues,
                  onTap: () => setState(() => _showDues = !_showDues),
                ),
                _FilterChip(
                  label: 'Today',
                  isSelected: _showToday,
                  onTap: () => setState(() => _showToday = !_showToday),
                ),
                _FilterChip(
                  label: 'Upcoming',
                  isSelected: _showUpcoming,
                  onTap: () => setState(() => _showUpcoming = !_showUpcoming),
                ),
                _FilterChip(
                  label: 'Overdue',
                  isSelected: _showOverdue,
                  onTap: () => setState(() => _showOverdue = !_showOverdue),
                ),
              ],
            ),
            const Divider(height: 24),
            // Type
            Text(
              'Type',
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
              children: widget.typeOptions.map((t) {
                final sel = _types.contains(t);
                return _FilterChip(
                  label: t,
                  isSelected: sel,
                  onTap: () =>
                      setState(() => sel ? _types.remove(t) : _types.add(t)),
                );
              }).toList(),
            ),
            const Divider(height: 24),
            // Frequency
            Text(
              'Follow-up Frequency',
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
              children: widget.frequencyOptions.map((f) {
                final sel = _freqs.contains(f);
                return _FilterChip(
                  label: f,
                  isSelected: sel,
                  onTap: () =>
                      setState(() => sel ? _freqs.remove(f) : _freqs.add(f)),
                );
              }).toList(),
            ),
            const Divider(height: 24),
            // Existing Customer
            Text(
              'Existing Customer',
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
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: _existingCustomer == null,
                  onTap: () => setState(() => _existingCustomer = null),
                ),
                _FilterChip(
                  label: 'Yes',
                  isSelected: _existingCustomer == true,
                  onTap: () => setState(() => _existingCustomer = true),
                ),
                _FilterChip(
                  label: 'No',
                  isSelected: _existingCustomer == false,
                  onTap: () => setState(() => _existingCustomer = false),
                ),
              ],
            ),
            const Divider(height: 24),
            // Assigned Member (same as leads)
            Text(
              'Assigned Member',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            _FUAssignedFilter(
              selectedAgents: _agents,
              onChanged: (a) => setState(() => _agents = a),
            ),
            const Divider(height: 24),
            // Date range
            Text(
              'Date Range',
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
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate:
                            _from ??
                            DateTime.now().subtract(const Duration(days: 30)),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (d != null) setState(() => _from = d);
                    },
                    icon: const Icon(Icons.calendar_today_rounded, size: 14),
                    label: Text(
                      _from != null
                          ? '${_from!.day}/${_from!.month}/${_from!.year}'
                          : 'From',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _to ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (d != null) setState(() => _to = d);
                    },
                    icon: const Icon(Icons.calendar_today_rounded, size: 14),
                    label: Text(
                      _to != null
                          ? '${_to!.day}/${_to!.month}/${_to!.year}'
                          : 'To',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                if (_from != null || _to != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 18,
                      color: AppTheme.error,
                    ),
                    onPressed: () => setState(() {
                      _from = null;
                      _to = null;
                    }),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                widget.onApply(
                  _agents,
                  _types,
                  _freqs,
                  _existingCustomer,
                  _from,
                  _to,
                  _showCompleted,
                  _showUpcoming,
                  _showOverdue,
                  _showCancelled,
                  _showDues,
                  _showToday,
                );
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.warning,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryContainer : AppTheme.surface100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.surface200,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ─── Assigned Filter (same as leads) ─────────────────────────────────────────

class _FUAssignedFilter extends StatefulWidget {
  final List<String> selectedAgents;
  final ValueChanged<List<String>> onChanged;
  const _FUAssignedFilter({
    required this.selectedAgents,
    required this.onChanged,
  });

  @override
  State<_FUAssignedFilter> createState() => _FUAssignedFilterState();
}

class _FUAssignedFilterState extends State<_FUAssignedFilter> {
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
        .where((a) => widget.selectedAgents.contains(a.name))
        .toList();
    final unselected = _kAgents
        .where((a) => !widget.selectedAgents.contains(a.name))
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
          widget.selectedAgents.isEmpty,
          () => widget.onChanged([]),
        ),
        ..._displayList.map(
          (a) => _buildRow(
            a.initials,
            a.name,
            a.role,
            a.id,
            a.color,
            widget.selectedAgents.contains(a.name),
            () {
              final updated = List<String>.from(widget.selectedAgents);
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

class _FUSortSheet extends StatelessWidget {
  final _FollowUpSortOption current;
  final ValueChanged<_FollowUpSortOption> onSelect;
  const _FUSortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        _FollowUpSortOption.dueDateSoonest,
        'Due Date — Soonest First',
        Icons.arrow_upward_rounded,
      ),
      (
        _FollowUpSortOption.dueDateLatest,
        'Due Date — Latest First',
        Icons.arrow_downward_rounded,
      ),
      (
        _FollowUpSortOption.priorityHigh,
        'Priority — High to Low',
        Icons.priority_high_rounded,
      ),
      (
        _FollowUpSortOption.createdNewest,
        'Created — Newest First',
        Icons.fiber_new_rounded,
      ),
      (
        _FollowUpSortOption.leadAZ,
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
            'Sort Follow-ups',
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
                color: sel ? AppTheme.warning : AppTheme.textSecondary,
                size: 20,
              ),
              title: Text(
                o.$2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                  color: sel ? AppTheme.warning : AppTheme.textPrimary,
                ),
              ),
              trailing: sel
                  ? Icon(Icons.check_rounded, color: AppTheme.warning, size: 18)
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
