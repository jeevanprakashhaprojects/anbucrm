import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';

// ─── Mock Data ────────────────────────────────────────────────────────────────

final List<Map<String, dynamic>> globalEmployeeMaps = [
  {
    'id': 'emp-001',
    'name': 'Priya Sharma',
    'initials': 'PS',
    'role': 'Senior Sales Agent',
    'department': 'Sales',
    'employeeId': 'EMP-001',
    'email': 'priya.sharma@anbucrm.com',
    'phone': '+91 98765 11111',
    'alternatePhone': '+91 98765 22222',
    'reportingManager': 'Anbu Raj (CEO)',
    'team': 'Enterprise Team',
    'territory': 'South India',
    'status': 'Active',
    'accessLevel': 'Manager',
    'joinDate': DateTime(2021, 3, 15),
    'profilePhoto':
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
    'leadsAssigned': 42,
    'leadsConverted': 18,
    'sessionsCompleted': 67,
    'followUpsDone': 89,
    'targetAmount': 5000000.0,
    'achievedAmount': 4250000.0,
    'commission': 127500.0,
    'commissionRate': '3%',
    'conversionRate': 42.8,
    'avgDealValue': 236111.0,
    'lastActivity': DateTime.now().subtract(const Duration(minutes: 30)),
    'activityLog': [
      {
        'action': 'Closed deal — Rahul Mehta',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'action': 'Session completed — Vikram Singh',
        'time': DateTime.now().subtract(const Duration(hours: 5)),
      },
      {
        'action': 'Follow-up sent — Sneha Kapoor',
        'time': DateTime.now().subtract(const Duration(days: 1)),
      },
    ],
    'skills': [
      'Life Insurance',
      'Health Cover',
      'Corporate Plans',
      'Negotiation',
    ],
    'certifications': ['IRDA Licensed', 'AMFI Certified', 'CFP'],
    'languages': ['English', 'Hindi', 'Tamil'],
    'location': 'Bangalore',
    'workMode': 'Hybrid',
    'gender': 'Female',
    'dob': '12/05/1990',
    'emergencyContact': 'Raj Sharma — +91 98765 33333',
    'bankAccount': 'HDFC Bank — ****4521',
    'pfNumber': 'KA/BAN/12345/001',
    'panNumber': 'ABCPS1234D',
    'rating': 4.8,
  },
  {
    'id': 'emp-002',
    'name': 'Rahul Singh',
    'initials': 'RS',
    'role': 'Sales Agent',
    'department': 'Sales',
    'employeeId': 'EMP-002',
    'email': 'rahul.singh@anbucrm.com',
    'phone': '+91 87654 22222',
    'alternatePhone': '',
    'reportingManager': 'Priya Sharma (Senior Agent)',
    'team': 'SME Team',
    'territory': 'West India',
    'status': 'Active',
    'accessLevel': 'Agent',
    'joinDate': DateTime(2022, 7, 1),
    'profilePhoto':
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
    'leadsAssigned': 28,
    'leadsConverted': 9,
    'sessionsCompleted': 41,
    'followUpsDone': 55,
    'targetAmount': 3000000.0,
    'achievedAmount': 1800000.0,
    'commission': 54000.0,
    'commissionRate': '3%',
    'conversionRate': 32.1,
    'avgDealValue': 200000.0,
    'lastActivity': DateTime.now().subtract(const Duration(hours: 1)),
    'activityLog': [
      {
        'action': 'Call logged — Sneha Kapoor',
        'time': DateTime.now().subtract(const Duration(hours: 1)),
      },
      {
        'action': 'Follow-up scheduled — Deepa Nair',
        'time': DateTime.now().subtract(const Duration(hours: 3)),
      },
    ],
    'skills': ['Health Cover', 'Motor Insurance', 'Cold Calling'],
    'certifications': ['IRDA Licensed'],
    'languages': ['English', 'Hindi', 'Marathi'],
    'location': 'Mumbai',
    'workMode': 'On-site',
    'gender': 'Male',
    'dob': '25/08/1994',
    'emergencyContact': 'Sunita Singh — +91 87654 33333',
    'bankAccount': 'SBI — ****7823',
    'pfNumber': 'MH/MUM/23456/002',
    'panNumber': 'ABCRS5678E',
    'rating': 3.9,
  },
  {
    'id': 'emp-003',
    'name': 'Ananya Patel',
    'initials': 'AP',
    'role': 'Sales Agent',
    'department': 'Sales',
    'employeeId': 'EMP-003',
    'email': 'ananya.patel@anbucrm.com',
    'phone': '+91 76543 33333',
    'alternatePhone': '+91 76543 44444',
    'reportingManager': 'Priya Sharma (Senior Agent)',
    'team': 'Retail Team',
    'territory': 'North India',
    'status': 'Active',
    'accessLevel': 'Agent',
    'joinDate': DateTime(2022, 1, 10),
    'profilePhoto':
        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
    'leadsAssigned': 35,
    'leadsConverted': 14,
    'sessionsCompleted': 52,
    'followUpsDone': 71,
    'targetAmount': 3500000.0,
    'achievedAmount': 2800000.0,
    'commission': 84000.0,
    'commissionRate': '3%',
    'conversionRate': 40.0,
    'avgDealValue': 200000.0,
    'lastActivity': DateTime.now().subtract(const Duration(hours: 2)),
    'activityLog': [
      {
        'action': 'Deal closed — Anita Desai',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'action': 'Session scheduled — New lead',
        'time': DateTime.now().subtract(const Duration(hours: 4)),
      },
    ],
    'skills': [
      'Mutual Funds',
      'SIP',
      'Retail Insurance',
      'Relationship Building',
    ],
    'certifications': ['IRDA Licensed', 'AMFI Certified'],
    'languages': ['English', 'Hindi', 'Gujarati'],
    'location': 'Delhi',
    'workMode': 'Hybrid',
    'gender': 'Female',
    'dob': '03/11/1993',
    'emergencyContact': 'Ravi Patel — +91 76543 55555',
    'bankAccount': 'ICICI Bank — ****3456',
    'pfNumber': 'DL/DEL/34567/003',
    'panNumber': 'ABCAP9012F',
    'rating': 4.3,
  },
  {
    'id': 'emp-004',
    'name': 'Kavya Menon',
    'initials': 'KM',
    'role': 'Junior Sales Agent',
    'department': 'Sales',
    'employeeId': 'EMP-004',
    'email': 'kavya.menon@anbucrm.com',
    'phone': '+91 65432 44444',
    'alternatePhone': '',
    'reportingManager': 'Priya Sharma (Senior Agent)',
    'team': 'SME Team',
    'territory': 'South India',
    'status': 'Active',
    'accessLevel': 'Agent',
    'joinDate': DateTime(2023, 4, 20),
    'profilePhoto':
        'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg',
    'leadsAssigned': 18,
    'leadsConverted': 5,
    'sessionsCompleted': 22,
    'followUpsDone': 31,
    'targetAmount': 2000000.0,
    'achievedAmount': 950000.0,
    'commission': 28500.0,
    'commissionRate': '3%',
    'conversionRate': 27.7,
    'avgDealValue': 190000.0,
    'lastActivity': DateTime.now().subtract(const Duration(hours: 3)),
    'activityLog': [
      {
        'action': 'Session completed — Karan Joshi',
        'time': DateTime.now().subtract(const Duration(hours: 3)),
      },
      {
        'action': 'Reminder set — SIP review',
        'time': DateTime.now().subtract(const Duration(hours: 6)),
      },
    ],
    'skills': ['SIP', 'Education Plans', 'Customer Service'],
    'certifications': ['IRDA Licensed (In Progress)'],
    'languages': ['English', 'Malayalam', 'Tamil'],
    'location': 'Kochi',
    'workMode': 'Remote',
    'gender': 'Female',
    'dob': '18/02/1998',
    'emergencyContact': 'Suresh Menon — +91 65432 55555',
    'bankAccount': 'Federal Bank — ****8901',
    'pfNumber': 'KL/KOC/45678/004',
    'panNumber': 'ABCKM3456G',
    'rating': 3.5,
  },
  {
    'id': 'emp-005',
    'name': 'Arjun Nair',
    'initials': 'AN',
    'role': 'Team Lead',
    'department': 'Sales',
    'employeeId': 'EMP-005',
    'email': 'arjun.nair@anbucrm.com',
    'phone': '+91 54321 55555',
    'alternatePhone': '+91 54321 66666',
    'reportingManager': 'Anbu Raj (CEO)',
    'team': 'Enterprise Team',
    'territory': 'Pan India',
    'status': 'Active',
    'accessLevel': 'Team Lead',
    'joinDate': DateTime(2020, 6, 1),
    'profilePhoto':
        'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg',
    'leadsAssigned': 55,
    'leadsConverted': 28,
    'sessionsCompleted': 92,
    'followUpsDone': 120,
    'targetAmount': 8000000.0,
    'achievedAmount': 7200000.0,
    'commission': 216000.0,
    'commissionRate': '3%',
    'conversionRate': 50.9,
    'avgDealValue': 257142.0,
    'lastActivity': DateTime.now().subtract(const Duration(minutes: 10)),
    'activityLog': [
      {
        'action': 'Team review completed',
        'time': DateTime.now().subtract(const Duration(minutes: 10)),
      },
      {
        'action': 'Deal closed — Mohammed Al-Rashid',
        'time': DateTime.now().subtract(const Duration(hours: 1)),
      },
      {
        'action': 'Pipeline review — team',
        'time': DateTime.now().subtract(const Duration(hours: 4)),
      },
    ],
    'skills': [
      'Corporate Insurance',
      'Key Man Insurance',
      'Team Management',
      'Strategic Sales',
    ],
    'certifications': ['IRDA Licensed', 'AMFI Certified', 'CFP', 'PMP'],
    'languages': ['English', 'Hindi', 'Malayalam'],
    'location': 'Bangalore',
    'workMode': 'Hybrid',
    'gender': 'Male',
    'dob': '07/09/1988',
    'emergencyContact': 'Meera Nair — +91 54321 77777',
    'bankAccount': 'Axis Bank — ****2345',
    'pfNumber': 'KA/BAN/56789/005',
    'panNumber': 'ABCAN7890H',
    'rating': 4.9,
  },
  {
    'id': 'emp-006',
    'name': 'Deepa Krishnan',
    'initials': 'DK',
    'role': 'CRM Administrator',
    'department': 'Operations',
    'employeeId': 'EMP-006',
    'email': 'deepa.krishnan@anbucrm.com',
    'phone': '+91 43210 66666',
    'alternatePhone': '',
    'reportingManager': 'Anbu Raj (CEO)',
    'team': 'Operations',
    'territory': 'All',
    'status': 'Active',
    'accessLevel': 'Admin',
    'joinDate': DateTime(2021, 9, 1),
    'profilePhoto':
        'https://images.pexels.com/photos/1181424/pexels-photo-1181424.jpeg',
    'leadsAssigned': 0,
    'leadsConverted': 0,
    'sessionsCompleted': 12,
    'followUpsDone': 45,
    'targetAmount': 0.0,
    'achievedAmount': 0.0,
    'commission': 0.0,
    'commissionRate': 'N/A',
    'conversionRate': 0.0,
    'avgDealValue': 0.0,
    'lastActivity': DateTime.now().subtract(const Duration(hours: 1)),
    'activityLog': [
      {
        'action': 'System configuration updated',
        'time': DateTime.now().subtract(const Duration(hours: 1)),
      },
      {
        'action': 'User access review completed',
        'time': DateTime.now().subtract(const Duration(days: 1)),
      },
    ],
    'skills': ['CRM Management', 'Data Analysis', 'Process Optimization'],
    'certifications': ['Salesforce Admin', 'Google Analytics'],
    'languages': ['English', 'Tamil', 'Kannada'],
    'location': 'Bangalore',
    'workMode': 'On-site',
    'gender': 'Female',
    'dob': '22/04/1992',
    'emergencyContact': 'Ravi Krishnan — +91 43210 77777',
    'bankAccount': 'Kotak Bank — ****6789',
    'pfNumber': 'KA/BAN/67890/006',
    'panNumber': 'ABCDK2345I',
    'rating': 4.5,
  },
  {
    'id': 'emp-007',
    'name': 'Suresh Pillai',
    'initials': 'SP',
    'role': 'Sales Agent',
    'department': 'Sales',
    'employeeId': 'EMP-007',
    'email': 'suresh.pillai@anbucrm.com',
    'phone': '+91 32109 77777',
    'alternatePhone': '',
    'reportingManager': 'Arjun Nair (Team Lead)',
    'team': 'Enterprise Team',
    'territory': 'East India',
    'status': 'On Leave',
    'accessLevel': 'Agent',
    'joinDate': DateTime(2022, 11, 15),
    'profilePhoto':
        'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg',
    'leadsAssigned': 22,
    'leadsConverted': 7,
    'sessionsCompleted': 30,
    'followUpsDone': 42,
    'targetAmount': 2500000.0,
    'achievedAmount': 1400000.0,
    'commission': 42000.0,
    'commissionRate': '3%',
    'conversionRate': 31.8,
    'avgDealValue': 200000.0,
    'lastActivity': DateTime.now().subtract(const Duration(days: 3)),
    'activityLog': [
      {
        'action': 'Leave approved — 5 days',
        'time': DateTime.now().subtract(const Duration(days: 3)),
      },
    ],
    'skills': ['Life Insurance', 'Term Plans', 'Bengali Market'],
    'certifications': ['IRDA Licensed'],
    'languages': ['English', 'Hindi', 'Bengali'],
    'location': 'Kolkata',
    'workMode': 'On-site',
    'gender': 'Male',
    'dob': '14/06/1991',
    'emergencyContact': 'Latha Pillai — +91 32109 88888',
    'bankAccount': 'UCO Bank — ****1234',
    'pfNumber': 'WB/KOL/78901/007',
    'panNumber': 'ABCSP6789J',
    'rating': 3.7,
  },
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

enum _EmployeeSortOption {
  nameAZ,
  nameZA,
  conversionHigh,
  leadsAssignedHigh,
  achievementHigh,
  ratingHigh,
  joinDateNewest,
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isSearchActive = false;
  _EmployeeSortOption _sortOption = _EmployeeSortOption.conversionHigh;
  List<String> _selectedDepts = [];
  List<String> _selectedRoles = [];
  DateTime? _dateFrom;
  DateTime? _dateTo;
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> _employees = [];

  final _statusFilters = ['All', 'Active', 'On Leave', 'Inactive'];
  final _deptOptions = ['Sales', 'Operations', 'Marketing', 'Support'];
  final _roleOptions = [
    'Senior Sales Agent',
    'Sales Agent',
    'Junior Sales Agent',
    'Team Lead',
    'CRM Administrator',
  ];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadEmployees() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _employees = List.from(globalEmployeeMaps);
        _isLoading = false;
      });
    }
  }

  bool get _hasActiveFilters =>
      _selectedDepts.isNotEmpty || _selectedRoles.isNotEmpty;

  List<Map<String, dynamic>> get _filteredEmployees {
    List<Map<String, dynamic>> result = _employees.where((e) {
      final matchesFilter =
          _selectedFilter == 'All' || e['status'] == _selectedFilter;
      final matchesSearch =
          _searchQuery.isEmpty ||
          (e['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (e['role'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (e['employeeId'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (e['department'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesDept =
          _selectedDepts.isEmpty || _selectedDepts.contains(e['department']);
      final matchesRole =
          _selectedRoles.isEmpty || _selectedRoles.contains(e['role']);
      return matchesFilter && matchesSearch && matchesDept && matchesRole;
    }).toList();

    switch (_sortOption) {
      case _EmployeeSortOption.nameAZ:
        result.sort(
          (a, b) => (a['name'] as String).compareTo(b['name'] as String),
        );
        break;
      case _EmployeeSortOption.nameZA:
        result.sort(
          (a, b) => (b['name'] as String).compareTo(a['name'] as String),
        );
        break;
      case _EmployeeSortOption.conversionHigh:
        result.sort(
          (a, b) => (b['conversionRate'] as double).compareTo(
            a['conversionRate'] as double,
          ),
        );
        break;
      case _EmployeeSortOption.leadsAssignedHigh:
        result.sort(
          (a, b) =>
              (b['leadsAssigned'] as int).compareTo(a['leadsAssigned'] as int),
        );
        break;
      case _EmployeeSortOption.achievementHigh:
        result.sort(
          (a, b) => (b['achievedAmount'] as double).compareTo(
            a['achievedAmount'] as double,
          ),
        );
        break;
      case _EmployeeSortOption.ratingHigh:
        result.sort(
          (a, b) => (b['rating'] as double).compareTo(a['rating'] as double),
        );
        break;
      case _EmployeeSortOption.joinDateNewest:
        result.sort(
          (a, b) =>
              (b['joinDate'] as DateTime).compareTo(a['joinDate'] as DateTime),
        );
        break;
    }
    return result;
  }

  int get _totalCount => _employees.length;
  int get _activeCount =>
      _employees.where((e) => e['status'] == 'Active').length;
  int get _onLeaveCount =>
      _employees.where((e) => e['status'] == 'On Leave').length;
  double get _avgConversion => _employees.isEmpty
      ? 0
      : _employees
                .map((e) => e['conversionRate'] as double)
                .reduce((a, b) => a + b) /
            _employees.length;
  double get _totalAchieved =>
      _employees.fold(0.0, (sum, e) => sum + (e['achievedAmount'] as double));

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EmpFilterSheet(
        selectedDepts: List.from(_selectedDepts),
        selectedRoles: List.from(_selectedRoles),
        deptOptions: _deptOptions,
        roleOptions: _roleOptions,
        onApply: (depts, roles) => setState(() {
          _selectedDepts = depts;
          _selectedRoles = roles;
        }),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _EmpSortSheet(
        current: _sortOption,
        onSelect: (o) => setState(() => _sortOption = o),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEmployees;
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
                      onRefresh: _loadEmployees,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                        itemCount: filtered.length,
                        itemBuilder: (ctx, i) =>
                            _EmployeeCard(employee: filtered[i], index: i),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF059669),
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: Text(
          'Add Employee',
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
              color: const Color(0xFF059669).withAlpha(31),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.badge_rounded,
              color: Color(0xFF059669),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employees',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${_filteredEmployees.length} of $_totalCount employees',
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
          _EHeaderBtn(
            icon: Icons.filter_list_rounded,
            label: 'Filter',
            hasActive: _hasActiveFilters,
            onTap: _showFilterSheet,
          ),
          const SizedBox(width: 6),
          _EHeaderBtn(
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
          hintText: 'Search employees, roles, ID...',
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
      _EKpiData(
        'Total',
        '$_totalCount',
        Icons.badge_rounded,
        const Color(0xFF059669),
        '+2%',
        true,
      ),
      _EKpiData(
        'Active',
        '$_activeCount',
        Icons.check_circle_rounded,
        AppTheme.primary,
        '$_activeCount online',
        false,
      ),
      _EKpiData(
        'On Leave',
        '$_onLeaveCount',
        Icons.beach_access_rounded,
        AppTheme.warning,
        'today',
        false,
      ),
      _EKpiData(
        'Avg Conv.',
        '${_avgConversion.toStringAsFixed(1)}%',
        Icons.trending_up_rounded,
        const Color(0xFF8B5CF6),
        '+3%',
        true,
      ),
      _EKpiData(
        'Revenue',
        _formatValue(_totalAchieved),
        Icons.currency_rupee_rounded,
        AppTheme.success,
        '+15%',
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
        itemBuilder: (_, i) => _EKpiCard(data: kpis[i]),
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
                    ? const Color(0xFF059669)
                    : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF059669)
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
      _selectedDepts = [];
      _selectedRoles = [];
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
          ..._selectedDepts.map(
            (d) => _ActiveFilterChip(
              label: 'Dept: $d',
              onRemove: () => setState(() => _selectedDepts.remove(d)),
            ),
          ),
          ..._selectedRoles.map(
            (r) => _ActiveFilterChip(
              label: 'Role: $r',
              onRemove: () => setState(() => _selectedRoles.remove(r)),
            ),
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
          Icon(Icons.badge_rounded, size: 56, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          Text(
            'No employees found',
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

  String _formatValue(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}K';
    return v.toStringAsFixed(0);
  }
}

// ─── Employee Card ────────────────────────────────────────────────────────────

class _EmployeeCard extends StatefulWidget {
  final Map<String, dynamic> employee;
  final int index;
  const _EmployeeCard({required this.employee, required this.index});

  @override
  State<_EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<_EmployeeCard>
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
        return AppTheme.success;
      case 'On Leave':
        return AppTheme.warning;
      case 'Inactive':
        return AppTheme.textMuted;
      default:
        return AppTheme.textMuted;
    }
  }

  Color _accessColor(String a) {
    switch (a) {
      case 'Admin':
        return AppTheme.error;
      case 'Team Lead':
        return const Color(0xFF8B5CF6);
      case 'Manager':
        return AppTheme.primary;
      case 'Agent':
        return AppTheme.success;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatValue(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}K';
    return v.toStringAsFixed(0);
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

  String _relativeActivity(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.employee;
    final statusColor = _statusColor(e['status'] as String);
    final accessColor = _accessColor(e['accessLevel'] as String);
    final target = e['targetAmount'] as double;
    final achieved = e['achievedAmount'] as double;
    final achievementPct = target > 0
        ? (achieved / target * 100).clamp(0.0, 100.0)
        : 0.0;
    final skills = (e['skills'] as List).cast<String>();
    final certs = (e['certifications'] as List).cast<String>();
    final activityLog = (e['activityLog'] as List).cast<Map<String, dynamic>>();
    final rating = e['rating'] as double;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
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
                      // Header row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              e['profilePhoto'] as String,
                            ),
                            backgroundColor: AppTheme.primaryContainer,
                            child: null,
                            onBackgroundImageError: (_, __) {},
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e['name'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.textPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    _EStatusBadge(
                                      label: e['status'] as String,
                                      color: statusColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  e['role'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      e['employeeId'] as String,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        color: AppTheme.textMuted,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: accessColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        e['accessLevel'] as String,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: accessColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Performance metrics
                      Row(
                        children: [
                          _EMetricBox(
                            label: 'Leads',
                            value: '${e['leadsAssigned']}',
                            sub: '${e['leadsConverted']} conv.',
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 8),
                          _EMetricBox(
                            label: 'Sessions',
                            value: '${e['sessionsCompleted']}',
                            sub: 'done',
                            color: const Color(0xFF8B5CF6),
                          ),
                          const SizedBox(width: 8),
                          _EMetricBox(
                            label: 'Follow-ups',
                            value: '${e['followUpsDone']}',
                            sub: 'done',
                            color: AppTheme.warning,
                          ),
                          const SizedBox(width: 8),
                          _EMetricBox(
                            label: 'Conv. Rate',
                            value: '${e['conversionRate'].toStringAsFixed(1)}%',
                            sub: '',
                            color: AppTheme.success,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Target vs Achievement
                      if (target > 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Target vs Achievement',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            Text(
                              '${achievementPct.toStringAsFixed(0)}%',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: achievementPct >= 80
                                    ? AppTheme.success
                                    : AppTheme.warning,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: achievementPct / 100,
                            backgroundColor: AppTheme.surface200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              achievementPct >= 80
                                  ? AppTheme.success
                                  : AppTheme.warning,
                            ),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${_formatValue(achieved)} achieved',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            Text(
                              '₹${_formatValue(target)} target',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _EInfoChip(
                            icon: Icons.location_on_rounded,
                            label: e['location'] as String,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          _EInfoChip(
                            icon: Icons.work_outline_rounded,
                            label: e['workMode'] as String,
                            color: AppTheme.textSecondary,
                          ),
                          const Spacer(),
                          // Star rating
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  i < rating.floor()
                                      ? Icons.star_rounded
                                      : (i < rating
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                  size: 12,
                                  color: AppTheme.warning,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toStringAsFixed(1),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
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
                        _EDetailRow(
                          icon: Icons.email_rounded,
                          label: 'Email',
                          value: e['email'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.phone_rounded,
                          label: 'Phone',
                          value: e['phone'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.business_rounded,
                          label: 'Department',
                          value: e['department'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.people_rounded,
                          label: 'Team',
                          value: e['team'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.map_rounded,
                          label: 'Territory',
                          value: e['territory'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.supervisor_account_rounded,
                          label: 'Reports To',
                          value: e['reportingManager'] as String,
                        ),
                        _EDetailRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Joined',
                          value: _formatDate(e['joinDate'] as DateTime),
                        ),
                        if (target > 0)
                          _EDetailRow(
                            icon: Icons.currency_rupee_rounded,
                            label: 'Commission',
                            value:
                                '₹${_formatValue(e['commission'] as double)} (${e['commissionRate']})',
                          ),
                        const SizedBox(height: 8),
                        Text(
                          'Skills',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: skills
                              .map(
                                (s) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    s,
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
                        const SizedBox(height: 8),
                        Text(
                          'Certifications',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: certs
                              .map(
                                (c) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successContainer,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    c,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: AppTheme.success,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        if (activityLog.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            'Recent Activity',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...activityLog
                              .take(3)
                              .map(
                                (log) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(
                                          top: 4,
                                          right: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          log['action'] as String,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _relativeActivity(
                                          log['time'] as DateTime,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10,
                                          color: AppTheme.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
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

class _EHeaderBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasActive;
  final VoidCallback onTap;
  const _EHeaderBtn({
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

class _EStatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _EStatusBadge({required this.label, required this.color});

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

class _EMetricBox extends StatelessWidget {
  final String label, value, sub;
  final Color color;
  const _EMetricBox({
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                color: AppTheme.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (sub.isNotEmpty)
              Text(
                sub,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9,
                  color: AppTheme.textMuted,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class _EInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _EInfoChip({
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

class _EDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _EDetailRow({
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

class _EKpiData {
  final String label, value, trend;
  final IconData icon;
  final Color color;
  final bool trendUp;
  const _EKpiData(
    this.label,
    this.value,
    this.icon,
    this.color,
    this.trend,
    this.trendUp,
  );
}

class _EKpiCard extends StatelessWidget {
  final _EKpiData data;
  const _EKpiCard({required this.data});

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

// ─── Filter Sheet ─────────────────────────────────────────────────────────────

class _EmpFilterSheet extends StatefulWidget {
  final List<String> selectedDepts, selectedRoles, deptOptions, roleOptions;
  final Function(List<String>, List<String>) onApply;
  const _EmpFilterSheet({
    required this.selectedDepts,
    required this.selectedRoles,
    required this.deptOptions,
    required this.roleOptions,
    required this.onApply,
  });

  @override
  State<_EmpFilterSheet> createState() => _EmpFilterSheetState();
}

class _EmpFilterSheetState extends State<_EmpFilterSheet> {
  late List<String> _depts, _roles;

  @override
  void initState() {
    super.initState();
    _depts = List.from(widget.selectedDepts);
    _roles = List.from(widget.selectedRoles);
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
                'Filter Employees',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() {
                  _depts = [];
                  _roles = [];
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
            'Department',
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
            children: widget.deptOptions.map((d) {
              final sel = _depts.contains(d);
              return GestureDetector(
                onTap: () =>
                    setState(() => sel ? _depts.remove(d) : _depts.add(d)),
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
                    d,
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
          const SizedBox(height: 16),
          Text(
            'Role',
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
            children: widget.roleOptions.map((r) {
              final sel = _roles.contains(r);
              return GestureDetector(
                onTap: () =>
                    setState(() => sel ? _roles.remove(r) : _roles.add(r)),
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
                    r,
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
                widget.onApply(_depts, _roles);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
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

class _EmpSortSheet extends StatelessWidget {
  final _EmployeeSortOption current;
  final ValueChanged<_EmployeeSortOption> onSelect;
  const _EmpSortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        _EmployeeSortOption.conversionHigh,
        'Conversion Rate — High to Low',
        Icons.trending_up_rounded,
      ),
      (
        _EmployeeSortOption.leadsAssignedHigh,
        'Leads Assigned — High to Low',
        Icons.people_rounded,
      ),
      (
        _EmployeeSortOption.achievementHigh,
        'Achievement — High to Low',
        Icons.emoji_events_rounded,
      ),
      (
        _EmployeeSortOption.ratingHigh,
        'Rating — High to Low',
        Icons.star_rounded,
      ),
      (
        _EmployeeSortOption.nameAZ,
        'Name — A to Z',
        Icons.sort_by_alpha_rounded,
      ),
      (
        _EmployeeSortOption.nameZA,
        'Name — Z to A',
        Icons.sort_by_alpha_rounded,
      ),
      (
        _EmployeeSortOption.joinDateNewest,
        'Join Date — Newest First',
        Icons.fiber_new_rounded,
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
            'Sort Employees',
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
                color: sel ? const Color(0xFF059669) : AppTheme.textSecondary,
                size: 20,
              ),
              title: Text(
                o.$2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                  color: sel ? const Color(0xFF059669) : AppTheme.textPrimary,
                ),
              ),
              trailing: sel
                  ? const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF059669),
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
