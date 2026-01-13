import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { useState } from "react";
import { toast } from "sonner";
import { AlertCircle } from "lucide-react";

const RequestBlood = () => {
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setTimeout(() => {
            setIsSubmitting(false);
            toast.success("Request Submitted", {
                description: "Your blood request has been broadcasted to nearby donors and blood banks.",
            });
        }, 2000);
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="max-w-3xl mx-auto animate-fade-up">
                    <div className="text-center mb-8">
                        <h1 className="text-3xl font-bold mb-4">Request Blood</h1>
                        <p className="text-muted-foreground">
                            Submit a request for blood. We will notify nearby donors and blood banks immediately.
                        </p>
                    </div>

                    <Card className="border-red-100 shadow-md">
                        <CardHeader className="bg-red-50/50 border-b border-red-100">
                            <div className="flex items-center gap-2 text-red-600 mb-2">
                                <AlertCircle className="w-5 h-5" />
                                <span className="font-semibold">Urgent Request</span>
                            </div>
                            <CardTitle>Patient Details</CardTitle>
                            <CardDescription>
                                Please provide accurate information to avoid delays.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="pt-6">
                            <form onSubmit={handleSubmit} className="space-y-6">
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div className="space-y-2">
                                        <Label htmlFor="patient-name">Patient Name</Label>
                                        <Input id="patient-name" required placeholder="Full Name" />
                                    </div>
                                    <div className="space-y-2">
                                        <Label htmlFor="patient-age">Patient Age</Label>
                                        <Input id="patient-age" type="number" required placeholder="Age" />
                                    </div>
                                    <div className="space-y-2">
                                        <Label htmlFor="blood-group">Blood Group Required</Label>
                                        <Select required>
                                            <SelectTrigger>
                                                <SelectValue placeholder="Select Blood Group" />
                                            </SelectTrigger>
                                            <SelectContent>
                                                {["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"].map((bg) => (
                                                    <SelectItem key={bg} value={bg}>{bg}</SelectItem>
                                                ))}
                                            </SelectContent>
                                        </Select>
                                    </div>
                                    <div className="space-y-2">
                                        <Label htmlFor="units">Units Required</Label>
                                        <Input id="units" type="number" required placeholder="Number of units" min="1" />
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    <Label>Urgency Level</Label>
                                    <RadioGroup defaultValue="normal" className="flex gap-4">
                                        <div className="flex items-center space-x-2">
                                            <RadioGroupItem value="critical" id="critical" className="text-red-600 border-red-600" />
                                            <Label htmlFor="critical" className="text-red-600 font-medium">Critical (Within hours)</Label>
                                        </div>
                                        <div className="flex items-center space-x-2">
                                            <RadioGroupItem value="urgent" id="urgent" />
                                            <Label htmlFor="urgent">Urgent (Within 24 hours)</Label>
                                        </div>
                                        <div className="flex items-center space-x-2">
                                            <RadioGroupItem value="normal" id="normal" />
                                            <Label htmlFor="normal">Normal</Label>
                                        </div>
                                    </RadioGroup>
                                </div>

                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div className="space-y-2">
                                        <Label htmlFor="hospital">Hospital Name</Label>
                                        <Input id="hospital" required placeholder="Hospital Name" />
                                    </div>
                                    <div className="space-y-2">
                                        <Label htmlFor="contact">Contact Number</Label>
                                        <Input id="contact" type="tel" required placeholder="Primary Contact" />
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    <Label htmlFor="address">Hospital Address / Location</Label>
                                    <Textarea id="address" required placeholder="Full address of the hospital/clinic" />
                                </div>

                                <div className="space-y-2">
                                    <Label htmlFor="note">Additional Note</Label>
                                    <Textarea id="note" placeholder="Any specific instructions or medical details..." />
                                </div>

                                <Button type="submit" className="w-full bg-red-600 hover:bg-red-700 text-white" size="lg" disabled={isSubmitting}>
                                    {isSubmitting ? "Submitting Request..." : "Submit Blood Request"}
                                </Button>
                            </form>
                        </CardContent>
                    </Card>
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default RequestBlood;
