import { Heart, Users, HandHeart, ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";

const roles = [
  {
    icon: Heart,
    title: "Donor",
    description: "Register as a blood donor and receive notifications when someone nearby needs your blood type. Track your donation history and earn recognition.",
    features: ["Donation tracking", "Location-based alerts", "Health reminders", "Reward badges"],
    color: "primary",
    gradient: "from-primary to-primary/80",
  },
  {
    icon: Users,
    title: "Patient / Caretaker",
    description: "Post blood requirements for yourself or loved ones. Get matched with compatible donors in your area and track request status in real-time.",
    features: ["Emergency requests", "Donor matching", "Hospital integration", "Real-time updates"],
    color: "accent-foreground",
    gradient: "from-accent-foreground to-primary",
  },
  {
    icon: HandHeart,
    title: "Receiver",
    description: "Healthcare facilities and blood banks can register to receive blood donations. Manage inventory and coordinate with donors efficiently.",
    features: ["Inventory management", "Donor coordination", "Scheduled pickups", "Analytics dashboard"],
    color: "primary",
    gradient: "from-primary/80 to-primary",
  },
];

const RolesSection = () => {
  return (
    <section className="py-20 md:py-32 relative overflow-hidden">
      <div className="container mx-auto px-4">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <span className="inline-block px-4 py-1.5 rounded-full bg-accent text-accent-foreground text-sm font-medium mb-4">
            Choose Your Role
          </span>
          <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">
            Join Our <span className="text-gradient">Community</span>
          </h2>
          <p className="text-muted-foreground text-lg">
            Whether you're giving or receiving, we make the process simple, secure, and meaningful.
          </p>
        </div>

        {/* Role Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 lg:gap-8">
          {roles.map((role, index) => (
            <div
              key={role.title}
              className="group relative bg-card rounded-2xl p-8 shadow-soft hover:shadow-hover transition-all duration-500 border border-border hover:border-primary/20 hover:-translate-y-2"
              style={{ animationDelay: `${index * 0.1}s` }}
            >
              {/* Icon */}
              <div className={`w-14 h-14 rounded-xl bg-gradient-to-br ${role.gradient} flex items-center justify-center mb-6 shadow-card group-hover:scale-110 transition-transform duration-300`}>
                <role.icon className="w-7 h-7 text-primary-foreground" />
              </div>

              {/* Content */}
              <h3 className="text-xl font-bold mb-3">{role.title}</h3>
              <p className="text-muted-foreground text-sm leading-relaxed mb-6">
                {role.description}
              </p>

              {/* Features */}
              <ul className="space-y-2 mb-8">
                {role.features.map((feature) => (
                  <li key={feature} className="flex items-center gap-2 text-sm">
                    <div className="w-1.5 h-1.5 rounded-full bg-primary" />
                    <span className="text-muted-foreground">{feature}</span>
                  </li>
                ))}
              </ul>

              {/* CTA */}
              <Button variant="outline" className="w-full group-hover:bg-primary group-hover:text-primary-foreground group-hover:border-primary transition-all duration-300">
                Get Started
                <ArrowRight className="w-4 h-4 ml-1 group-hover:translate-x-1 transition-transform" />
              </Button>

              {/* Decorative Element */}
              <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-primary/5 to-transparent rounded-2xl -z-10 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default RolesSection;
