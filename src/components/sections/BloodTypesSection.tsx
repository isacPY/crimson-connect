import { Check, X } from "lucide-react";

const bloodTypes = [
  { type: "A+", canGiveTo: ["A+", "AB+"], canReceiveFrom: ["A+", "A-", "O+", "O-"], population: "35.7%" },
  { type: "A-", canGiveTo: ["A+", "A-", "AB+", "AB-"], canReceiveFrom: ["A-", "O-"], population: "6.3%" },
  { type: "B+", canGiveTo: ["B+", "AB+"], canReceiveFrom: ["B+", "B-", "O+", "O-"], population: "8.5%" },
  { type: "B-", canGiveTo: ["B+", "B-", "AB+", "AB-"], canReceiveFrom: ["B-", "O-"], population: "1.5%" },
  { type: "AB+", canGiveTo: ["AB+"], canReceiveFrom: ["All Types"], population: "3.4%", universal: "receiver" },
  { type: "AB-", canGiveTo: ["AB+", "AB-"], canReceiveFrom: ["A-", "B-", "AB-", "O-"], population: "0.6%" },
  { type: "O+", canGiveTo: ["A+", "B+", "AB+", "O+"], canReceiveFrom: ["O+", "O-"], population: "37.4%" },
  { type: "O-", canGiveTo: ["All Types"], canReceiveFrom: ["O-"], population: "6.6%", universal: "donor" },
];

const BloodTypesSection = () => {
  return (
    <section id="blood-types" className="py-20 md:py-32 bg-gradient-subtle relative overflow-hidden">
      <div className="container mx-auto px-4">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <span className="inline-block px-4 py-1.5 rounded-full bg-accent text-accent-foreground text-sm font-medium mb-4">
            Blood Compatibility
          </span>
          <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">
            Know Your <span className="text-gradient">Blood Type</span>
          </h2>
          <p className="text-muted-foreground text-lg">
            Understanding blood type compatibility is crucial for safe transfusions. Find out who you can help.
          </p>
        </div>

        {/* Blood Type Cards Grid */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 md:gap-6 max-w-5xl mx-auto">
          {bloodTypes.map((blood, index) => (
            <div
              key={blood.type}
              className="group relative bg-card rounded-2xl p-5 md:p-6 shadow-soft hover:shadow-card transition-all duration-500 border border-border hover:border-primary/30"
            >
              {/* Universal Badge */}
              {blood.universal && (
                <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 rounded-full bg-gradient-hero text-primary-foreground text-xs font-medium whitespace-nowrap">
                  Universal {blood.universal === "donor" ? "Donor" : "Receiver"}
                </div>
              )}

              {/* Blood Type */}
              <div className="text-center mb-4">
                <div className="inline-flex items-center justify-center w-16 h-16 md:w-20 md:h-20 rounded-2xl bg-accent group-hover:bg-gradient-hero transition-all duration-300">
                  <span className="text-2xl md:text-3xl font-bold text-primary group-hover:text-primary-foreground transition-colors duration-300">
                    {blood.type}
                  </span>
                </div>
              </div>

              {/* Population */}
              <div className="text-center mb-4">
                <span className="text-sm text-muted-foreground">Population</span>
                <div className="text-lg font-bold text-foreground">{blood.population}</div>
              </div>

              {/* Can Give To */}
              <div className="mb-3">
                <span className="text-xs text-muted-foreground block mb-2">Can donate to:</span>
                <div className="flex flex-wrap gap-1">
                  {blood.canGiveTo.map((type) => (
                    <span
                      key={type}
                      className="px-2 py-0.5 rounded bg-primary/10 text-primary text-xs font-medium"
                    >
                      {type}
                    </span>
                  ))}
                </div>
              </div>

              {/* Can Receive From */}
              <div>
                <span className="text-xs text-muted-foreground block mb-2">Can receive from:</span>
                <div className="flex flex-wrap gap-1">
                  {blood.canReceiveFrom.map((type) => (
                    <span
                      key={type}
                      className="px-2 py-0.5 rounded bg-accent text-accent-foreground text-xs font-medium"
                    >
                      {type}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Compatibility Legend */}
        <div className="mt-12 flex flex-wrap items-center justify-center gap-6 text-sm">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-primary/10" />
            <span className="text-muted-foreground">Can donate to</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-accent" />
            <span className="text-muted-foreground">Can receive from</span>
          </div>
        </div>
      </div>
    </section>
  );
};

export default BloodTypesSection;
