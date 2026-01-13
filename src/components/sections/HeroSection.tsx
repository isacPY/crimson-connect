import { Heart, ArrowRight, Droplets } from "lucide-react";
import { Button } from "@/components/ui/button";

const HeroSection = () => {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden pt-20">
      {/* Background Elements */}
      <div className="absolute inset-0 bg-gradient-subtle" />
      
      {/* Floating Decorations */}
      <div className="absolute top-1/4 left-10 w-20 h-20 rounded-full bg-primary/10 animate-float" />
      <div className="absolute top-1/3 right-20 w-32 h-32 rounded-full bg-primary/5 animate-float-delayed" />
      <div className="absolute bottom-1/4 left-1/4 w-16 h-16 rounded-full bg-accent animate-float" />
      <div className="absolute bottom-1/3 right-1/3 w-24 h-24 rounded-full bg-primary/5 animate-float-delayed" />

      {/* Blood Drop SVG Decoration */}
      <div className="absolute top-40 right-[15%] opacity-10 animate-float">
        <Droplets className="w-40 h-40 text-primary" />
      </div>

      <div className="container mx-auto px-4 relative z-10">
        <div className="max-w-4xl mx-auto text-center">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent text-accent-foreground text-sm font-medium mb-8 animate-fade-up border border-primary/20">
            <Heart className="w-4 h-4" fill="currentColor" />
            <span>Saving lives, one donation at a time</span>
          </div>

          {/* Headline */}
          <h1 className="text-4xl md:text-5xl lg:text-6xl xl:text-7xl font-bold leading-tight mb-6 animate-fade-up">
            Your Blood Can Be
            <br />
            <span className="text-gradient">Someone's Lifeline</span>
          </h1>

          {/* Subheadline */}
          <p className="text-lg md:text-xl text-muted-foreground max-w-2xl mx-auto mb-10 animate-fade-up-delayed">
            Connect with donors and patients in your area. Join our community of 
            life-savers and make a difference today.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 animate-fade-up-delayed">
            <Button variant="hero" size="xl">
              Donate Blood
              <ArrowRight className="w-5 h-5 ml-1" />
            </Button>
            <Button variant="heroOutline" size="xl">
              Find a Donor
            </Button>
          </div>

          {/* Trust Indicators */}
          <div className="mt-16 pt-8 border-t border-border animate-fade-up-delayed">
            <p className="text-sm text-muted-foreground mb-6">Trusted by healthcare organizations worldwide</p>
            <div className="flex flex-wrap items-center justify-center gap-8 md:gap-12 opacity-60">
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded bg-secondary flex items-center justify-center">
                  <Heart className="w-4 h-4 text-primary" />
                </div>
                <span className="text-sm font-medium">Red Cross</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded bg-secondary flex items-center justify-center">
                  <Heart className="w-4 h-4 text-primary" />
                </div>
                <span className="text-sm font-medium">WHO Certified</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded bg-secondary flex items-center justify-center">
                  <Heart className="w-4 h-4 text-primary" />
                </div>
                <span className="text-sm font-medium">500+ Hospitals</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded bg-secondary flex items-center justify-center">
                  <Heart className="w-4 h-4 text-primary" />
                </div>
                <span className="text-sm font-medium">HIPAA Compliant</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Wave */}
      <div className="absolute bottom-0 left-0 right-0">
        <svg viewBox="0 0 1440 120" fill="none" xmlns="http://www.w3.org/2000/svg" className="w-full">
          <path
            d="M0 120L48 110C96 100 192 80 288 75C384 70 480 80 576 85C672 90 768 90 864 85C960 80 1056 70 1152 70C1248 70 1344 80 1392 85L1440 90V120H1392C1344 120 1248 120 1152 120C1056 120 960 120 864 120C768 120 672 120 576 120C480 120 384 120 288 120C192 120 96 120 48 120H0Z"
            fill="hsl(var(--background))"
          />
        </svg>
      </div>
    </section>
  );
};

export default HeroSection;
