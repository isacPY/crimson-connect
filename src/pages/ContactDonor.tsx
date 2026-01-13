import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { useState } from "react";
import { toast } from "sonner";
import { useParams, useNavigate } from "react-router-dom";
import { MessageSquare, ShieldCheck } from "lucide-react";

const ContactDonor = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setTimeout(() => {
            setIsSubmitting(false);
            toast.success("Message Sent", {
                description: "The donor has been notified. They will contact you if they are available.",
            });
            navigate("/donors");
        }, 1500);
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24 flex justify-center">
                <Card className="w-full max-w-lg shadow-lg">
                    <CardHeader className="bg-primary/5 rounded-t-lg border-b border-primary/10">
                        <div className="flex items-center gap-3 mb-2">
                            <div className="p-2 bg-primary/10 rounded-full">
                                <MessageSquare className="w-6 h-6 text-primary" />
                            </div>
                            <div>
                                <CardTitle>Contact Donor</CardTitle>
                                <CardDescription>Send a secure message to Donor #{id}</CardDescription>
                            </div>
                        </div>
                    </CardHeader>
                    <CardContent className="pt-6">
                        <form onSubmit={handleSubmit} className="space-y-6">
                            <div className="bg-blue-50 p-4 rounded-md flex gap-3 text-sm text-blue-800">
                                <ShieldCheck className="w-5 h-5 flex-shrink-0" />
                                <p>
                                    Your contact details are shared securely. We do not reveal the donor's direct contact info until they accept your request.
                                </p>
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="reason">Reason for Contact</Label>
                                <Input id="reason" placeholder="e.g., Urgent Blood Requirement for Surgery" required />
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="message">Message</Label>
                                <Textarea
                                    id="message"
                                    placeholder="Please describe the patient condition, hospital location, and urgency..."
                                    className="min-h-[120px]"
                                    required
                                />
                            </div>

                            <div className="space-y-2">
                                <Label>Share My Contact Info</Label>
                                <div className="grid grid-cols-2 gap-4">
                                    <Input placeholder="Your Name" required />
                                    <Input placeholder="Your Phone Number" type="tel" required />
                                </div>
                            </div>

                            <div className="flex items-start space-x-2">
                                <Checkbox id="consent" required />
                                <Label htmlFor="consent" className="text-sm font-normal leading-tight">
                                    I agree to share my details with this donor and understand that BloodLink is a platform connector, not a medical provider.
                                </Label>
                            </div>

                            <Button type="submit" className="w-full" size="lg" disabled={isSubmitting}>
                                {isSubmitting ? "Sending..." : "Send Message"}
                            </Button>
                        </form>
                    </CardContent>
                    <CardFooter className="flex justify-center border-t p-4 text-xs text-muted-foreground bg-slate-50 rounded-b-lg">
                        Messages are monitored for safety and compliance.
                    </CardFooter>
                </Card>
            </main>
            <Footer />
        </div>
    );
};

export default ContactDonor;
