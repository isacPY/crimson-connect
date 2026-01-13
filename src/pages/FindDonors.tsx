import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { MapPin, Phone, Search, Filter } from "lucide-react";
import { useState } from "react";

// Dummy Data
const DUMMY_DONORS = [
    { id: 1, name: "Michael Chen", bloodType: "O+", location: "New York, NY", lastDonation: "2 months ago", status: "Available" },
    { id: 2, name: "Sarah Johnson", bloodType: "A-", location: "Brooklyn, NY", lastDonation: "1 month ago", status: "Available" },
    { id: 3, name: "David Kim", bloodType: "B+", location: "Queens, NY", lastDonation: "3 weeks ago", status: "Unavailable" },
    { id: 4, name: "Emily Davis", bloodType: "AB+", location: "Manhattan, NY", lastDonation: "4 months ago", status: "Available" },
    { id: 5, name: "James Wilson", bloodType: "O-", location: "Jersey City, NJ", lastDonation: "1 week ago", status: "Available" },
    { id: 6, name: "Linda Martinez", bloodType: "A+", location: "New York, NY", lastDonation: "5 months ago", status: "Unavailable" },
    { id: 7, name: "Robert Taylor", bloodType: "B-", location: "Bronx, NY", lastDonation: "2 months ago", status: "Available" },
    { id: 8, name: "Patricia White", bloodType: "AB-", location: "Staten Island, NY", lastDonation: "6 months ago", status: "Available" },
];

const FindDonors = () => {
    const [searchTerm, setSearchTerm] = useState("");
    const [bloodTypeFilter, setBloodTypeFilter] = useState("all");

    const filteredDonors = DUMMY_DONORS.filter(donor => {
        const matchesSearch = donor.location.toLowerCase().includes(searchTerm.toLowerCase()) ||
            donor.name.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesBlood = bloodTypeFilter === "all" || donor.bloodType === bloodTypeFilter;
        return matchesSearch && matchesBlood;
    });

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="flex flex-col md:flex-row justify-between items-end md:items-center mb-8 gap-4 animate-fade-up">
                    <div>
                        <h1 className="text-3xl font-bold mb-2">Find Blood Donors</h1>
                        <p className="text-muted-foreground">Search for available donors near you.</p>
                    </div>
                </div>

                {/* Filters */}
                <div className="bg-white p-4 rounded-lg shadow-sm border mb-8 flex flex-col md:flex-row gap-4 animate-fade-up delay-100">
                    <div className="flex-1 relative">
                        <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                        <Input
                            placeholder="Search by location or name..."
                            className="pl-9"
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                    <div className="w-full md:w-48">
                        <Select value={bloodTypeFilter} onValueChange={setBloodTypeFilter}>
                            <SelectTrigger>
                                <SelectValue placeholder="Blood Type" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem value="all">All Types</SelectItem>
                                {["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"].map((bg) => (
                                    <SelectItem key={bg} value={bg}>{bg}</SelectItem>
                                ))}
                            </SelectContent>
                        </Select>
                    </div>
                    <Button variant="outline" className="w-full md:w-auto">
                        <Filter className="w-4 h-4 mr-2" />
                        More Filters
                    </Button>
                </div>

                {/* Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 animate-fade-up delay-200">
                    {filteredDonors.map((donor) => (
                        <Card key={donor.id} className="hover:shadow-md transition-shadow">
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
                                <Button className="w-full" variant="outline">
                                    <Phone className="w-4 h-4 mr-2" />
                                    Contact Donor
                                </Button>
                            </CardFooter>
                        </Card>
                    ))}
                </div>

                {filteredDonors.length === 0 && (
                    <div className="text-center py-12 text-muted-foreground">
                        No donors found matching your criteria.
                    </div>
                )}
            </main>
            <Footer />
        </div>
    );
};

export default FindDonors;
