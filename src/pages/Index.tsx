import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import HeroSection from "@/components/sections/HeroSection";
import RolesSection from "@/components/sections/RolesSection";
import StatsSection from "@/components/sections/StatsSection";
import HowItWorksSection from "@/components/sections/HowItWorksSection";
import BloodTypesSection from "@/components/sections/BloodTypesSection";
import FeaturedDonorsSection from "@/components/sections/FeaturedDonorsSection";
import CTASection from "@/components/sections/CTASection";

const Index = () => {
  return (
    <main className="min-h-screen bg-background">
      <Header />
      <HeroSection />
      <RolesSection />
      <StatsSection />
      <FeaturedDonorsSection />
      <HowItWorksSection />
      <BloodTypesSection />
      <CTASection />
      <Footer />
    </main>
  );
};

export default Index;
