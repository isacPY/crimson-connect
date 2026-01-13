import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { MapPin, Phone, Search, Building2, Clock } from "lucide-react";
import { useState } from "react";
import { Link } from "react-router-dom";

// Dummy Data
const BLOOD_BANKS = [
    { id: 1, name: "City General Blood Bank", location: "New York, NY", contact: "+1 222-333-4444", status: "Open", type: "Public" },
    { id: 2, name: "Red Cross Donation Center", location: "Brooklyn, NY", contact: "+1 222-333-5555", status: "Open", type: "Non-Profit" },
    { id: 3, name: "Community Life Bank", location: "Queens, NY", contact: "+1 222-333-6666", status: "Closed", type: "Private" },
    { id: 4, name: "Mercy Health Blood Center", location: "Manhattan, NY", contact: "+1 222-333-7777", status: "Open", type: "Public" },
    { id: 5, name: "St. Mary's Blood Services", location: "Jersey City, NJ", contact: "+1 222-333-8888", status: "Open", type: "Public" },
];

const BloodBanks = () => {
    const [searchTerm, setSearchTerm] = useState("");

    const filteredBanks = BLOOD_BANKS.filter(bank =>
        bank.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        bank.location.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="flex flex-col md:flex-row justify-between items-end md:items-center mb-8 gap-4 animate-fade-up">
                    <div>
                        <h1 className="text-3xl font-bold mb-2">Blood Banks Directory</h1>
                        <p className="text-muted-foreground">Find blood banks and donation centers near you.</p>
                    </div>
                </div>

                {/* Search */}
                <div className="bg-white p-4 rounded-lg shadow-sm border mb-8 animate-fade-up delay-100">
                    <div className="relative">
                        <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                        <Input
                            placeholder="Search by name or location..."
                            className="pl-9"
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                </div>

                {/* Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 animate-fade-up delay-200">
                    {filteredBanks.map((bank) => (
                        <Card key={bank.id} className="hover:shadow-md transition-shadow">
                            <CardHeader className="pb-3">
                                <div className="flex justify-between items-start">
                                    <div className="flex items-center gap-2">
                                        <div className="h-10 w-10 bg-red-100 text-red-600 rounded-lg flex items-center justify-center">
                                            <Building2 className="h-5 w-5" />
                                        </div>
                                        <div>
                                            <h3 className="font-semibold text-lg">{bank.name}</h3>
                                            <Badge variant="outline" className="text-xs font-normal">{bank.type}</Badge>
                                        </div>
                                    </div>
                                </div>
                            </CardHeader>
                            <CardContent className="pb-3 space-y-2">
                                <div className="flex items-center text-sm text-muted-foreground">
                                    <MapPin className="w-4 h-4 mr-2 text-primary" />
                                    {bank.location}
                                </div>
                                <div className="flex items-center text-sm text-muted-foreground">
                                    <Phone className="w-4 h-4 mr-2 text-primary" />
                                    {bank.contact}
                                </div>
                                <div className="flex items-center text-sm text-muted-foreground">
                                    <Clock className="w-4 h-4 mr-2 text-primary" />
                                    <span className={bank.status === "Open" ? "text-green-600 font-medium" : "text-red-500 font-medium"}>
                                        {bank.status}
                                    </span>
                                </div>
                            </CardContent>
                            <CardFooter>
                                <Link to={`/banks/${bank.id}`} className="w-full">
                                    <Button className="w-full" variant="outline">
                                        View Details
                                    </Button>
                                </Link>
                            </CardFooter>
                        </Card>
                    ))}
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default BloodBanks;
