import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { useState } from "react";
import { toast } from "sonner";

const Donate = () => {
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleDonorSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setTimeout(() => {
            setIsSubmitting(false);
            toast.success("Donor Registration Successful", {
                description: "Thank you for registering as a donor. We will contact you soon.",
            });
        }, 2000);
    };

    const handlePatientSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setTimeout(() => {
            setIsSubmitting(false);
            toast.success("Patient Registration Successful", {
                description: "Your patient profile has been created.",
            });
        }, 2000);
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="max-w-4xl mx-auto space-y-8 animate-fade-up">
                    <div className="text-center space-y-4">
                        <h1 className="text-4xl font-bold">Join the Life Saving Community</h1>
                        <p className="text-muted-foreground text-lg max-w-2xl mx-auto">
                            Whether you are here to donate blood or registering a patient, your participation helps save lives.
                        </p>
                    </div>

                    <Tabs defaultValue="donor" className="w-full">
                        <TabsList className="grid w-full grid-cols-2 mb-8 h-12">
                            <TabsTrigger value="donor" className="text-base">Register as Donor</TabsTrigger>
                            <TabsTrigger value="patient" className="text-base">Register as Patient/Caretaker</TabsTrigger>
                        </TabsList>

                        <TabsContent value="donor">
                            <Card>
                                <CardHeader>
                                    <CardTitle>Donor Registration</CardTitle>
                                    <CardDescription>
                                        Please fill out the details honestly to help us match you with those in need.
                                    </CardDescription>
                                </CardHeader>
                                <CardContent>
                                    <form onSubmit={handleDonorSubmit} className="space-y-6">
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div className="space-y-2">
                                                <Label htmlFor="donor-name">Full Name</Label>
                                                <Input id="donor-name" required placeholder="John Doe" />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="donor-dob">Date of Birth</Label>
                                                <Input id="donor-dob" type="date" required />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="donor-blood-group">Blood Group</Label>
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
                                                <Label htmlFor="donor-gender">Gender</Label>
                                                <Select required>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select Gender" />
                                                    </SelectTrigger>
                                                    <SelectContent>
                                                        <SelectItem value="male">Male</SelectItem>
                                                        <SelectItem value="female">Female</SelectItem>
                                                        <SelectItem value="other">Other</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="donor-phone">Phone Number</Label>
                                                <Input id="donor-phone" type="tel" required placeholder="+1 234 567 890" />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="donor-weight">Weight (kg)</Label>
                                                <Input id="donor-weight" type="number" required placeholder="65" />
                                            </div>
                                        </div>

                                        <div className="space-y-4">
                                            <Label className="text-base">Medical History & Eligibility</Label>
                                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                <div className="flex items-center space-x-2">
                                                    <Checkbox id="med-1" />
                                                    <Label htmlFor="med-1">Have you donated blood in the last 3 months?</Label>
                                                </div>
                                                <div className="flex items-center space-x-2">
                                                    <Checkbox id="med-2" />
                                                    <Label htmlFor="med-2">Do you have any chronic illnesses?</Label>
                                                </div>
                                                <div className="flex items-center space-x-2">
                                                    <Checkbox id="med-3" />
                                                    <Label htmlFor="med-3">Are you currently on any medication?</Label>
                                                </div>
                                                <div className="flex items-center space-x-2">
                                                    <Checkbox id="med-4" />
                                                    <Label htmlFor="med-4">Have you had any recent surgeries?</Label>
                                                </div>
                                            </div>
                                        </div>

                                        <div className="space-y-2">
                                            <Label htmlFor="donor-address">Address</Label>
                                            <Textarea id="donor-address" required placeholder="123 Main St, City, Country" />
                                        </div>

                                        <Button type="submit" className="w-full" size="lg" disabled={isSubmitting}>
                                            {isSubmitting ? "Registering..." : "Register as Donor"}
                                        </Button>
                                    </form>
                                </CardContent>
                            </Card>
                        </TabsContent>

                        <TabsContent value="patient">
                            <Card>
                                <CardHeader>
                                    <CardTitle>Patient/Caretaker Registration</CardTitle>
                                    <CardDescription>
                                        Create a profile for the patient to request blood or find donors more easily.
                                    </CardDescription>
                                </CardHeader>
                                <CardContent>
                                    <form onSubmit={handlePatientSubmit} className="space-y-6">
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div className="space-y-2">
                                                <Label htmlFor="patient-name">Patient Name</Label>
                                                <Input id="patient-name" required placeholder="Jane Doe" />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="caretaker-name">Caretaker Name (if applicable)</Label>
                                                <Input id="caretaker-name" placeholder="John Doe" />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="patient-dob">Patient Date of Birth</Label>
                                                <Input id="patient-dob" type="date" required />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="patient-blood-group">Blood Group Needed/Type</Label>
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
                                                <Label htmlFor="patient-hospital">Current Hospital (Optional)</Label>
                                                <Input id="patient-hospital" placeholder="City General Hospital" />
                                            </div>
                                            <div className="space-y-2">
                                                <Label htmlFor="patient-phone">Contact Number</Label>
                                                <Input id="patient-phone" type="tel" required placeholder="+1 234 567 890" />
                                            </div>
                                        </div>

                                        <div className="space-y-2">
                                            <Label htmlFor="patient-condition">Medical Condition/Reason</Label>
                                            <Textarea id="patient-condition" required placeholder="Briefly describe the medical need..." />
                                        </div>

                                        <div className="space-y-2">
                                            <Label htmlFor="patient-address">Address</Label>
                                            <Textarea id="patient-address" required placeholder="123 Main St, City, Country" />
                                        </div>

                                        <Button type="submit" className="w-full" size="lg" disabled={isSubmitting}>
                                            {isSubmitting ? "Creating Profile..." : "Create Patient Profile"}
                                        </Button>
                                    </form>
                                </CardContent>
                            </Card>
                        </TabsContent>
                    </Tabs>
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default Donate;
