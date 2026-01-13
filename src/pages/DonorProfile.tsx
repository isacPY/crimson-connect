import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { Droplet, MapPin, ShieldCheck, Heart, MessageCircle } from "lucide-react";
import { useParams, Link } from "react-router-dom";

const DonorProfile = () => {
    const { id } = useParams();

    // Mock data based on ID
    const donor = {
        name: "Michael Chen",
        location: "New York, NY",
        bloodGroup: "O+",
        status: "Available",
        donations: 12,
        verified: true,
        bio: "Regular donor for the past 5 years. Committed to helping my community.",
        badges: ["Hero Donor", "Rapid Responder"]
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="max-w-2xl mx-auto animate-fade-up">
                    <Card className="text-center overflow-hidden">
                        <div className="h-32 bg-primary/10"></div>
                        <div className="-mt-16 flex justify-center mb-4">
                            <Avatar className="w-32 h-32 border-4 border-white shadow-lg">
                                <AvatarImage src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${id}`} />
                                <AvatarFallback>MC</AvatarFallback>
                            </Avatar>
                        </div>
                        <CardHeader>
                            <div className="flex justify-center items-center gap-2 mb-2">
                                <CardTitle className="text-3xl">{donor.name}</CardTitle>
                                {donor.verified && <ShieldCheck className="w-6 h-6 text-blue-500" />}
                            </div>
                            <CardDescription className="text-lg flex items-center justify-center gap-2">
                                <MapPin className="w-4 h-4" /> {donor.location}
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            <div className="flex justify-center gap-2 flex-wrap">
                                {donor.badges.map(badge => (
                                    <Badge key={badge} variant="secondary" className="bg-yellow-100 text-yellow-800 border-yellow-200">
                                        {badge}
                                    </Badge>
                                ))}
                            </div>

                            <div className="grid grid-cols-3 gap-4 py-6 border-y bg-slate-50/50">
                                <div>
                                    <div className="text-2xl font-bold text-primary">{donor.bloodGroup}</div>
                                    <div className="text-sm text-muted-foreground">Blood Type</div>
                                </div>
                                <div>
                                    <div className="text-2xl font-bold text-primary">{donor.donations}</div>
                                    <div className="text-sm text-muted-foreground">Lives Saved (Est.)</div>
                                </div>
                                <div>
                                    <Badge className={donor.status === 'Available' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}>
                                        {donor.status}
                                    </Badge>
                                    <div className="text-sm text-muted-foreground mt-1">Status</div>
                                </div>
                            </div>

                            <p className="text-muted-foreground italic">"{donor.bio}"</p>
                        </CardContent>
                        <CardFooter className="flex flex-col gap-3 pb-8">
                            <Link to={`/contact-donor/${id}`} className="w-full">
                                <Button className="w-full" size="lg">
                                    <MessageCircle className="w-5 h-5 mr-2" /> Contact Donor
                                </Button>
                            </Link>
                            <p className="text-xs text-muted-foreground">
                                Protected by BloodLink Safety Guarantee. Your request will be relayed securely.
                            </p>
                        </CardFooter>
                    </Card>
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default DonorProfile;
