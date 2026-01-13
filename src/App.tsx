import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ThemeProvider } from "next-themes";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";

import Login from "./pages/auth/Login";
import Signup from "./pages/auth/Signup";
import GetStarted from "./pages/GetStarted";
import Donate from "./pages/Donate";
import FindDonors from "./pages/FindDonors";
import RequestBlood from "./pages/RequestBlood";
import BloodBanks from "./pages/BloodBanks";
import BloodBankDetails from "./pages/BloodBankDetails";
import AdminLayout from "./pages/admin/Layout";
import AdminDashboard from "./pages/admin/Dashboard";
import AdminUsers from "./pages/admin/Users";
import AdminApprovals from "./pages/admin/Approvals";
import AdminDonations from "./pages/admin/Donations";
import AdminSettings from "./pages/admin/Settings";
import ContactDonor from "./pages/ContactDonor";
import Profile from "./pages/Profile";
import DonorProfile from "./pages/DonorProfile";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <ThemeProvider attribute="class" defaultTheme="system" enableSystem>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Index />} />
            <Route path="/auth/login" element={<Login />} />
            <Route path="/auth/signup" element={<Signup />} />
            <Route path="/get-started" element={<GetStarted />} />
            <Route path="/donate" element={<Donate />} />
            <Route path="/donors" element={<FindDonors />} />
            <Route path="/request-blood" element={<RequestBlood />} />
            <Route path="/banks" element={<BloodBanks />} />
            <Route path="/banks/:id" element={<BloodBankDetails />} />
            <Route path="/contact-donor/:id" element={<ContactDonor />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/profile/:id" element={<DonorProfile />} />

            {/* Admin Routes */}
            <Route path="/admin" element={<AdminLayout />}>
              <Route index element={<AdminDashboard />} />
              <Route path="users" element={<AdminUsers />} />
              <Route path="approvals" element={<AdminApprovals />} />
              <Route path="donations" element={<AdminDonations />} />
              <Route path="settings" element={<AdminSettings />} />
            </Route>

            {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </ThemeProvider>
  </QueryClientProvider>
);


export default App;
