import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Heart, Search, Users } from "lucide-react";
import { useNavigate } from "react-router-dom";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";

const GetStarted = () => {
    const navigate = useNavigate();

    return (
        <div className="min-h-screen bg-slate-50 flex flex-col">
            <Header />
            <main className="flex-1 container mx-auto px-4 py-24 flex flex-col items-center justify-center">
                <div className="text-center max-w-2xl mb-12 animate-fade-up">
                    <h1 className="text-4xl font-bold mb-4">Welcome to BloodLink</h1>
                    <p className="text-muted-foreground text-lg">
                        Thank you for joining our community. How would you like to proceed today?
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-8 w-full max-w-5xl animate-fade-up delay-100">
                    {/* Donate Card */}
                    <Card className="hover:shadow-lg transition-all duration-300 hover:-translate-y-1 cursor-pointer border-2 border-transparent hover:border-primary/20" onClick={() => navigate("/donate")}>
                        <CardHeader className="text-center">
                            <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4 text-primary">
                                <Heart className="w-8 h-8 fill-primary" />
                            </div>
                            <CardTitle>Donate Blood</CardTitle>
                            <CardDescription>
                                Register as a donor and save lives in your community.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="text-center">
                            <Button className="w-full">Register as Donor</Button>
                        </CardContent>
                    </Card>

                    {/* Request Card */}
                    <Card className="hover:shadow-lg transition-all duration-300 hover:-translate-y-1 cursor-pointer border-2 border-transparent hover:border-primary/20" onClick={() => navigate("/request-blood")}>
                        <CardHeader className="text-center">
                            <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4 text-blue-600">
                                <Users className="w-8 h-8" />
                            </div>
                            <CardTitle>Request Blood</CardTitle>
                            <CardDescription>
                                Find donors for yourself or a patient in need.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="text-center">
                            <Button variant="outline" className="w-full">Request Blood</Button>
                        </CardContent>
                    </Card>

                    {/* Find Donors Card */}
                    <Card className="hover:shadow-lg transition-all duration-300 hover:-translate-y-1 cursor-pointer border-2 border-transparent hover:border-primary/20" onClick={() => navigate("/donors")}>
                        <CardHeader className="text-center">
                            <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 text-green-600">
                                <Search className="w-8 h-8" />
                            </div>
                            <CardTitle>Find Donors</CardTitle>
                            <CardDescription>
                                Browse our database of available donors near you.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="text-center">
                            <Button variant="secondary" className="w-full">Search Donors</Button>
                        </CardContent>
                    </Card>
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default GetStarted;
