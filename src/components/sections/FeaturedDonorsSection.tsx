import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { MapPin, Phone, ArrowRight } from "lucide-react";
import { Link } from "react-router-dom";

// Subset of dummy data
const FEATURED_DONORS = [
    { id: 1, name: "Michael Chen", bloodType: "O+", location: "New York, NY", lastDonation: "2 months ago", status: "Available" },
    { id: 2, name: "Sarah Johnson", bloodType: "A-", location: "Brooklyn, NY", lastDonation: "1 month ago", status: "Available" },
    { id: 4, name: "Emily Davis", bloodType: "AB+", location: "Manhattan, NY", lastDonation: "4 months ago", status: "Available" },
    { id: 5, name: "James Wilson", bloodType: "O-", location: "Jersey City, NJ", lastDonation: "1 week ago", status: "Available" },
];

const FeaturedDonorsSection = () => {
    return (
        <section className="py-20 bg-slate-50">
            <div className="container mx-auto px-4">
                <div className="flex justify-between items-end mb-12">
                    <div className="max-w-2xl">
                        <h2 className="text-3xl font-bold mb-4">Recent Hero Donors</h2>
                        <p className="text-muted-foreground text-lg">
                            Meet some of the selfless individuals who have recently joined our community to save lives.
                        </p>
                    </div>
                    <Link to="/donors">
                        <Button variant="outline" className="hidden md:flex">
                            View All Donors <ArrowRight className="ml-2 w-4 h-4" />
                        </Button>
                    </Link>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    {FEATURED_DONORS.map((donor) => (
                        <Card key={donor.id} className="hover:shadow-md transition-shadow bg-white">
                            <CardHeader className="pb-3">
                                <div className="flex justify-between items-start">
                                    <div>
                                        <h3 className="font-semibold text-lg">{donor.name}</h3>
                                        <div className="flex items-center text-sm text-muted-foreground mt-1">
                                            <MapPin className="w-3 h-3 mr-1" />
                                            {donor.location}
                                        </div>
                                    </div>
                                    <Badge variant={donor.bloodType.includes("-") ? "secondary" : "default"} className="text-lg font-bold px-2 py-1 h-auto">
                                        {donor.bloodType}
                                    </Badge>
                                </div>
                            </CardHeader>
                            <CardContent className="pb-3">
                                <div className="text-sm">
                                    <span className="text-muted-foreground">Last Donation: </span>
                                    <span className="font-medium">{donor.lastDonation}</span>
                                </div>
                                <div className="mt-2 text-sm">
                                    <span className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${donor.status === 'Available' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                                        {donor.status}
                                    </span>
                                </div>
                            </CardContent>
                            <CardFooter>
                                <Button className="w-full" variant="ghost">
                                    View Profile
                                </Button>
                            </CardFooter>
                        </Card>
                    ))}
                </div>

                <div className="text-center md:hidden">
                    <Link to="/donors">
                        <Button variant="outline">
                            View All Donors <ArrowRight className="ml-2 w-4 h-4" />
                        </Button>
                    </Link>
                </div>
            </div>
        </section>
    );
};

export default FeaturedDonorsSection;
