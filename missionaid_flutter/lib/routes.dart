import 'package:go_router/go_router.dart';
import 'pages/index_page.dart';
import 'pages/not_found_page.dart';
import 'pages/admin/admin_layout.dart';
import 'pages/admin/dashboard_page.dart';
import 'pages/admin/approvals_page.dart';
import 'pages/donate_page.dart';
import 'pages/find_donors_page.dart';
import 'pages/blood_banks_page.dart';
import 'pages/blood_bank_details_page.dart';
import 'pages/contact_donor_page.dart';
import 'pages/donor_profile_page.dart';
import 'pages/get_started_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/profile_page.dart';
import 'pages/request_blood_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexPage(),
    ),

    // Auth Pages
    GoRoute(path: '/auth/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/auth/signup', builder: (context, state) => const SignupPage()),
    
    // Feature Pages
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(path: '/donate', builder: (context, state) => const DonatePage()),
    GoRoute(path: '/request-blood', builder: (context, state) => const RequestBloodPage()),
    GoRoute(path: '/donors', builder: (context, state) => const FindDonorsPage()),
    GoRoute(path: '/banks', builder: (context, state) => const BloodBanksPage()),
    GoRoute(path: '/banks/:id', builder: (context, state) => BloodBankDetailsPage(id: state.pathParameters['id']!)),
    GoRoute(path: '/contact-donor/:id', builder: (context, state) => ContactDonorPage(id: state.pathParameters['id']!)),
    GoRoute(path: '/donor-profile/:id', builder: (context, state) => DonorProfilePage(id: state.pathParameters['id']!)),
    GoRoute(path: '/get-started', builder: (context, state) => const GetStartedPage()),
    
    // Admin Shell
    ShellRoute(
      builder: (context, state, child) {
        return AdminLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminDashboardPage(),
        ),
        GoRoute(
          path: '/admin/approvals',
          builder: (context, state) => const AdminApprovalsPage(),
        ),
        // Add other admin routes here
      ],
    ),
  ],
);
