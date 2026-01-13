import { UserPlus, Search, Calendar, Heart, ArrowRight } from "lucide-react";

const steps = [
  {
    icon: UserPlus,
    step: "01",
    title: "Create Your Profile",
    description: "Sign up and complete your profile with blood type, location, and health information. It only takes 2 minutes.",
  },
  {
    icon: Search,
    step: "02",
    title: "Get Matched",
    description: "Our smart system connects donors with patients based on blood type compatibility and proximity.",
  },
  {
    icon: Calendar,
    step: "03",
    title: "Schedule Donation",
    description: "Choose a convenient time and location. We'll send you reminders and preparation tips.",
  },
  {
    icon: Heart,
    step: "04",
    title: "Save a Life",
    description: "Complete your donation and track the impact you've made. Every donation can save up to 3 lives!",
  },
];

const HowItWorksSection = () => {
  return (
    <section id="how-it-works" className="py-20 md:py-32 relative overflow-hidden">
      <div className="container mx-auto px-4">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <span className="inline-block px-4 py-1.5 rounded-full bg-accent text-accent-foreground text-sm font-medium mb-4">
            How It Works
          </span>
          <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">
            Simple Steps to <span className="text-gradient">Save Lives</span>
          </h2>
          <p className="text-muted-foreground text-lg">
            Our streamlined process makes blood donation easy and accessible for everyone.
          </p>
        </div>

        {/* Steps */}
        <div className="relative">
          {/* Connection Line - Desktop */}
          <div className="hidden lg:block absolute top-24 left-[12.5%] right-[12.5%] h-0.5 bg-gradient-to-r from-primary/20 via-primary to-primary/20" />

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {steps.map((step, index) => (
              <div key={step.step} className="relative group">
                {/* Step Card */}
                <div className="text-center">
                  {/* Step Number & Icon */}
                  <div className="relative inline-block mb-6">
                    <div className="w-20 h-20 rounded-2xl bg-gradient-hero flex items-center justify-center shadow-card group-hover:shadow-glow transition-all duration-500 group-hover:scale-110">
                      <step.icon className="w-9 h-9 text-primary-foreground" />
                    </div>
                    <div className="absolute -top-2 -right-2 w-8 h-8 rounded-full bg-card border-2 border-primary flex items-center justify-center text-xs font-bold text-primary shadow-soft">
                      {step.step}
                    </div>
                  </div>

                  {/* Content */}
                  <h3 className="text-xl font-bold mb-3">{step.title}</h3>
                  <p className="text-muted-foreground text-sm leading-relaxed max-w-xs mx-auto">
                    {step.description}
                  </p>
                </div>

                {/* Arrow for mobile/tablet */}
                {index < steps.length - 1 && (
                  <div className="lg:hidden flex justify-center my-6">
                    <ArrowRight className="w-6 h-6 text-primary rotate-90 md:rotate-0" />
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default HowItWorksSection;
