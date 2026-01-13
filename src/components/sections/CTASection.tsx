import { Heart, ArrowRight, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";

const CTASection = () => {
  return (
    <section className="py-20 md:py-32 relative overflow-hidden">
      <div className="container mx-auto px-4">
        <div className="relative bg-gradient-hero rounded-3xl p-8 md:p-16 overflow-hidden shadow-glow">
          {/* Decorative Elements */}
          <div className="absolute top-0 left-0 w-64 h-64 bg-primary-foreground/10 rounded-full blur-3xl" />
          <div className="absolute bottom-0 right-0 w-96 h-96 bg-primary-foreground/5 rounded-full blur-3xl" />
          
          {/* Floating Hearts */}
          <div className="absolute top-10 right-10 opacity-20 animate-float">
            <Heart className="w-16 h-16 text-primary-foreground" fill="currentColor" />
          </div>
          <div className="absolute bottom-10 left-10 opacity-10 animate-float-delayed">
            <Heart className="w-24 h-24 text-primary-foreground" fill="currentColor" />
          </div>

          <div className="relative z-10 text-center max-w-3xl mx-auto">
            {/* Badge */}
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary-foreground/20 text-primary-foreground text-sm font-medium mb-6 backdrop-blur-sm">
              <Sparkles className="w-4 h-4" />
              <span>Join 120,000+ donors worldwide</span>
            </div>

            {/* Headline */}
            <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold text-primary-foreground mb-6">
              Ready to Make a Difference?
            </h2>

            {/* Description */}
            <p className="text-primary-foreground/80 text-lg md:text-xl mb-10 max-w-2xl mx-auto">
              Your single donation can save up to 3 lives. Join our community today and 
              become a hero in someone's story.
            </p>

            {/* CTA Buttons */}
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Button 
                size="xl" 
                className="bg-primary-foreground text-primary hover:bg-primary-foreground/90 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1"
              >
                Register as Donor
                <ArrowRight className="w-5 h-5 ml-1" />
              </Button>
              <Button 
                size="xl" 
                variant="outline"
                className="border-2 border-primary-foreground/30 text-primary-foreground bg-transparent hover:bg-primary-foreground/10 backdrop-blur-sm"
              >
                Request Blood
              </Button>
            </div>

            {/* Trust Note */}
            <p className="mt-8 text-primary-foreground/60 text-sm">
              🔒 Your data is secure and HIPAA compliant
            </p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default CTASection;
