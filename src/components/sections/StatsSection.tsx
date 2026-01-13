import { Heart, Users, MapPin, Clock } from "lucide-react";

const stats = [
  {
    icon: Heart,
    value: "50K+",
    label: "Lives Saved",
    description: "Through our donor network",
  },
  {
    icon: Users,
    value: "120K+",
    label: "Active Donors",
    description: "Ready to help anytime",
  },
  {
    icon: MapPin,
    value: "500+",
    label: "Cities Covered",
    description: "Across the country",
  },
  {
    icon: Clock,
    value: "< 2hrs",
    label: "Average Response",
    description: "For emergency requests",
  },
];

const StatsSection = () => {
  return (
    <section id="impact" className="py-20 md:py-28 bg-gradient-subtle relative overflow-hidden">
      {/* Decorative Background */}
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-0 left-1/4 w-96 h-96 bg-primary/10 rounded-full blur-3xl" />
        <div className="absolute bottom-0 right-1/4 w-96 h-96 bg-accent/30 rounded-full blur-3xl" />
      </div>

      <div className="container mx-auto px-4 relative z-10">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <span className="inline-block px-4 py-1.5 rounded-full bg-accent text-accent-foreground text-sm font-medium mb-4">
            Our Impact
          </span>
          <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">
            Making a <span className="text-gradient">Difference</span>
          </h2>
          <p className="text-muted-foreground text-lg">
            Every number represents a life touched, a family helped, and hope renewed.
          </p>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6 md:gap-8">
          {stats.map((stat, index) => (
            <div
              key={stat.label}
              className="relative group"
            >
              <div className="bg-card rounded-2xl p-6 md:p-8 text-center shadow-soft hover:shadow-card transition-all duration-500 border border-border hover:border-primary/20 h-full">
                {/* Icon */}
                <div className="w-12 h-12 md:w-14 md:h-14 rounded-xl bg-accent flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                  <stat.icon className="w-6 h-6 md:w-7 md:h-7 text-primary" />
                </div>

                {/* Value */}
                <div className="text-3xl md:text-4xl lg:text-5xl font-bold text-gradient mb-2">
                  {stat.value}
                </div>

                {/* Label */}
                <div className="font-semibold text-foreground mb-1">
                  {stat.label}
                </div>

                {/* Description */}
                <div className="text-sm text-muted-foreground">
                  {stat.description}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default StatsSection;
