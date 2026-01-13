import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { MapPin, Phone, Building2, Clock, Share2, Navigation, AlertCircle } from "lucide-react";
import { useParams, Link } from "react-router-dom";
import { useState } from "react";
import { toast } from "sonner";

const BloodBankDetails = () => {
    const { id } = useParams();
    const [selectedBloodType, setSelectedBloodType] = useState<string | null>(null);
    const [isRequesting, setIsRequesting] = useState(false);
    const [isOpen, setIsOpen] = useState(false);

    // Mock data fetching logic
    const bank = {
        id: id,
        name: "City General Blood Bank",
        location: "123 Medical Center Dr, New York, NY 10001",
        contact: "+1 222-333-4444",
        email: "contact@citygeneral.org",
        status: "Open",
        hours: "8:00 AM - 8:00 PM",
        type: "Public",
        availableStock: {
            "A+": "High",
            "A-": "Low",
            "B+": "Medium",
            "B-": "Critical",
            "O+": "High",
            "O-": "Medium",
            "AB+": "Low",
            "AB-": "Critical"
        }
    };

    const handleStockClick = (type: string) => {
        setSelectedBloodType(type);
        setIsOpen(true);
    };

    const handleOneClickRequest = () => {
        setIsRequesting(true);
        setTimeout(() => {
            setIsRequesting(false);
            setIsOpen(false);
            toast.success("Request Sent Successfully", {
                description: `We have notified ${bank.name} about your need for ${selectedBloodType}.`,
                duration: 5000,
            });
        }, 1500);
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                {/* Breadcrumb / Back */}
                <div className="mb-6">
                    <Link to="/banks">
                        <Button variant="ghost" className="pl-0 hover:pl-0 hover:bg-transparent text-muted-foreground">
                            ← Back to Directory
                        </Button>
                    </Link>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 animate-fade-up">
                    {/* Main Info */}
                    <div className="lg:col-span-2 space-y-6">
                        <Card className="overflow-hidden">
                            <div className="h-48 bg-slate-200 w-full relative">
                                {/* Placeholder for map or image */}
                                <div className="absolute inset-0 flex items-center justify-center text-muted-foreground">
                                    Map Placeholder
                                </div>
                            </div>
                            <CardHeader>
                                <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                    <div>
                                        <h1 className="text-2xl font-bold flex items-center gap-2">
                                            <Building2 className="h-6 w-6 text-primary" />
                                            {bank.name}
                                        </h1>
                                        <p className="text-muted-foreground flex items-center gap-2 mt-1">
                                            <MapPin className="h-4 w-4" /> {bank.location}
                                        </p>
                                    </div>
                                    <Badge variant="outline" className="px-3 py-1 text-base">{bank.type}</Badge>
                                </div>
                            </CardHeader>
                            <CardContent className="space-y-6">
                                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                    <div className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                                        <Phone className="h-5 w-5 text-primary" />
                                        <div>
                                            <p className="text-sm text-muted-foreground">Phone</p>
                                            <p className="font-medium">{bank.contact}</p>
                                        </div>
                                    </div>
                                    <div className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                                        <Clock className="h-5 w-5 text-primary" />
                                        <div>
                                            <p className="text-sm text-muted-foreground">Hours</p>
                                            <p className="font-medium">{bank.hours}</p>
                                            <span className="text-xs text-green-600 font-medium">{bank.status} Now</span>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <h2 className="text-lg font-semibold mb-3">About Us</h2>
                                    <p className="text-muted-foreground leading-relaxed">
                                        Committed to providing safe and reliable blood services to the community.
                                        We operate 24/7 for emergency requests and organize regular donation camps.
                                    </p>
                                </div>
                            </CardContent>
                        </Card>

                        {/* Stock Status */}
                        <Card>
                            <CardHeader>
                                <CardTitle>Current Blood Availability</CardTitle>
                                <p className="text-sm text-muted-foreground">Click on a blood type to request it instantly.</p>
                            </CardHeader>
                            <CardContent>
                                <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                                    {Object.entries(bank.availableStock).map(([type, level]) => (
                                        <div
                                            key={type}
                                            className="p-4 border rounded-lg text-center cursor-pointer hover:border-primary hover:bg-primary/5 transition-all active:scale-95 ring-offset-2 focus-visible:ring-2"
                                            onClick={() => handleStockClick(type)}
                                        >
                                            <div className="text-2xl font-bold text-primary mb-1">{type}</div>
                                            <Badge variant={level === 'Critical' ? 'destructive' : level === 'Low' ? 'secondary' : 'default'} className="w-full justify-center">
                                                {level}
                                            </Badge>
                                        </div>
                                    ))}
                                </div>
                            </CardContent>
                        </Card>
                    </div>

                    {/* Sidebar Actions */}
                    <div className="space-y-6">
                        <Card>
                            <CardHeader>
                                <CardTitle>Actions</CardTitle>
                            </CardHeader>
                            <CardContent className="space-y-3">
                                <Button className="w-full bg-primary" size="lg">
                                    <Phone className="mr-2 h-4 w-4" /> Call Now
                                </Button>
                                <Button variant="outline" className="w-full">
                                    <Navigation className="mr-2 h-4 w-4" /> Get Directions
                                </Button>
                                <Button variant="outline" className="w-full">
                                    <Share2 className="mr-2 h-4 w-4" /> Share
                                </Button>
                            </CardContent>
                        </Card>

                        <Card className="bg-red-50 border-red-100">
                            <CardHeader>
                                <CardTitle className="text-red-700 flex items-center gap-2">
                                    <AlertCircle className="h-5 w-5" /> Urgent Needs
                                </CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-red-600 mb-4">
                                    We are currently facing a critical shortage of <strong>O- and B-</strong> blood types.
                                </p>
                                <Link to="/donate">
                                    <Button className="w-full bg-red-600 hover:bg-red-700">
                                        Donate Now
                                    </Button>
                                </Link>
                            </CardContent>
                        </Card>
                    </div>
                </div>

                {/* One Click Request Dialog */}
                <Dialog open={isOpen} onOpenChange={setIsOpen}>
                    <DialogContent>
                        <DialogHeader>
                            <DialogTitle>Request {selectedBloodType} Blood</DialogTitle>
                            <DialogDescription>
                                Share your details directly with {bank.name} to request {selectedBloodType} units.
                            </DialogDescription>
                        </DialogHeader>
                        <div className="space-y-4 py-4">
                            <div className="space-y-2">
                                <Label>Patient Information</Label>
                                <Input value="John Doe (You)" disabled className="bg-muted" />
                            </div>
                            <div className="space-y-2">
                                <Label>Contact Number</Label>
                                <Input value="+1 234 567 890" disabled className="bg-muted" />
                            </div>
                            <div className="flex items-start space-x-2">
                                <Checkbox id="terms" className="mt-1" />
                                <Label htmlFor="terms" className="text-sm font-normal">
                                    I consent to sharing my medical need and contact details with this blood bank for immediate processing.
                                </Label>
                            </div>
                        </div>
                        <DialogFooter>
                            <Button variant="outline" onClick={() => setIsOpen(false)}>Cancel</Button>
                            <Button onClick={handleOneClickRequest} disabled={isRequesting}>
                                {isRequesting ? "Sending..." : "Send Request"}
                            </Button>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            </main>
            <Footer />
        </div>
    );
};

export default BloodBankDetails;
