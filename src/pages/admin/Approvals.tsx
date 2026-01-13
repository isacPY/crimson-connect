import { Button } from "@/components/ui/button";
import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from "@/components/ui/card";
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import { Check, X, FileText, AlertTriangle, Activity } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { Textarea } from "@/components/ui/textarea";

// Mock Data for Pending Approvals
const PENDING_APPROVALS = [
    {
        id: 1,
        name: "John Doe",
        type: "Donor",
        submitted: "2 hours ago",
        details: {
            age: 28,
            gender: "Male",
            bloodGroup: "O+",
            weight: "72kg",
            lastDonation: "None",
            medicalHistory: [
                { question: "Chronic Illnesses?", answer: "None", flag: false },
                { question: "Recent Surgeries?", answer: "Appendectomy (2020)", flag: false },
                { question: "Current Medications?", answer: "None", flag: false },
                { question: "Travel History?", answer: "Brazil (3 months ago)", flag: true },
            ],
            vitals: {
                hemoglobin: "14.5 g/dL",
                bp: "120/80",
                pulse: "72 bpm"
            }
        }
    },
    {
        id: 2,
        name: "Red Cross Center",
        type: "Blood Bank",
        submitted: "1 day ago",
        details: {
            licenseNumber: "LIC-2024-001",
            address: "123 Health Ave, Brooklyn, NY",
            contact: "+1 555-0123",
            director: "Dr. Sarah Smith",
            capacity: "5000 Units",
            facilities: ["Cold Storage", "Component Separation", "Mobile Van"]
        }
    }
];

const AdminApprovals = () => {
    const [approvals, setApprovals] = useState(PENDING_APPROVALS);
    const [rejectionReason, setRejectionReason] = useState("");

    const handleApprove = (id: number) => {
        setApprovals(approvals.filter(a => a.id !== id));
        toast.success("Registration Approved", {
            description: "User has been notified and account is active."
        });
    };

    const handleReject = (id: number) => {
        setApprovals(approvals.filter(a => a.id !== id));
        toast.error("Registration Rejected", {
            description: `User notified. Reason: ${rejectionReason}`
        });
        setRejectionReason("");
    };

    return (
        <div className="space-y-8 animate-fade-up">
            <div>
                <h1 className="text-3xl font-bold tracking-tight">Pending Approvals</h1>
                <p className="text-muted-foreground">Review and verify registration requests requiring medical or administrative attention.</p>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {approvals.map((item) => (
                    <Card key={item.id} className="border-l-4 border-l-yellow-400 shadow-sm">
                        <CardHeader>
                            <div className="flex justify-between items-start">
                                <div>
                                    <CardTitle className="text-xl">{item.name}</CardTitle>
                                    <CardDescription>
                                        Request for <Badge variant="outline">{item.type}</Badge> • Submitted {item.submitted}
                                    </CardDescription>
                                </div>
                                {item.type === "Donor" && (
                                    <Badge variant="secondary" className="bg-blue-50 text-blue-700">Medical Review</Badge>
                                )}
                            </div>
                        </CardHeader>
                        <CardContent>
                            {item.type === "Donor" ? (
                                <div className="space-y-4">
                                    <div className="grid grid-cols-3 gap-2 text-sm">
                                        <div className="text-muted-foreground">Age: <span className="text-foreground font-medium">{item.details.age}</span></div>
                                        <div className="text-muted-foreground">Weight: <span className="text-foreground font-medium">{item.details.weight}</span></div>
                                        <div className="text-muted-foreground">Group: <span className="text-foreground font-medium">{item.details.bloodGroup}</span></div>
                                    </div>

                                    <Separator />

                                    <div className="space-y-2">
                                        <h4 className="text-sm font-semibold flex items-center gap-2">
                                            <Activity className="w-4 h-4 text-primary" /> Vitals (Self-Reported)
                                        </h4>
                                        <div className="grid grid-cols-3 gap-2 text-sm bg-slate-50 p-2 rounded">
                                            <div><span className="text-muted-foreground">Hb:</span> {item.details?.vitals?.hemoglobin}</div>
                                            <div><span className="text-muted-foreground">BP:</span> {item.details?.vitals?.bp}</div>
                                            <div><span className="text-muted-foreground">HR:</span> {item.details?.vitals?.pulse}</div>
                                        </div>
                                    </div>

                                    <Separator />

                                    <div className="space-y-2">
                                        <h4 className="text-sm font-semibold flex items-center gap-2">
                                            <FileText className="w-4 h-4 text-primary" /> Medical History
                                        </h4>
                                        <ScrollArea className="h-[120px] rounded-md border p-2 bg-slate-50">
                                            <ul className="space-y-2 text-sm">
                                                {item.details?.medicalHistory?.map((h, i) => (
                                                    <li key={i} className="flex justify-between items-start">
                                                        <span className="text-muted-foreground">{h.question}</span>
                                                        <span className={`font-medium ${h.flag ? "text-yellow-600 flex items-center gap-1" : "text-green-600"}`}>
                                                            {h.flag && <AlertTriangle className="w-3 h-3" />}
                                                            {h.answer}
                                                        </span>
                                                    </li>
                                                ))}
                                            </ul>
                                        </ScrollArea>
                                    </div>
                                </div>
                            ) : (
                                <div className="space-y-4 text-sm">
                                    <div className="grid grid-cols-1 gap-2">
                                        <div className="flex justify-between border-b pb-2">
                                            <span className="text-muted-foreground">License No:</span>
                                            <span className="font-mono">{item.details.licenseNumber}</span>
                                        </div>
                                        <div className="flex justify-between border-b pb-2">
                                            <span className="text-muted-foreground">Director:</span>
                                            <span>{item.details.director}</span>
                                        </div>
                                        <div className="flex justify-between border-b pb-2">
                                            <span className="text-muted-foreground">Capacity:</span>
                                            <span>{item.details.capacity}</span>
                                        </div>
                                        <div>
                                            <span className="text-muted-foreground block mb-1">Facilities:</span>
                                            <div className="flex flex-wrap gap-1">
                                                {item.details?.facilities?.map((f: string) => (
                                                    <Badge key={f} variant="outline" className="text-xs">{f}</Badge>
                                                ))}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            )}
                        </CardContent>
                        <CardFooter className="flex justify-end gap-3 bg-slate-50/50 pt-4">
                            <Dialog>
                                <DialogTrigger asChild>
                                    <Button variant="destructive" size="sm">
                                        <X className="w-4 h-4 mr-1" /> Reject
                                    </Button>
                                </DialogTrigger>
                                <DialogContent>
                                    <DialogHeader>
                                        <DialogTitle>Reject Registration</DialogTitle>
                                        <DialogDescription>
                                            Please provide a reason for rejecting this application. This will be sent to the user.
                                        </DialogDescription>
                                    </DialogHeader>
                                    <Textarea
                                        placeholder="E.g., Low hemoglobin count, Invalid license..."
                                        value={rejectionReason}
                                        onChange={(e) => setRejectionReason(e.target.value)}
                                    />
                                    <DialogFooter>
                                        <Button variant="destructive" onClick={() => handleReject(item.id)}>Confirm Rejection</Button>
                                    </DialogFooter>
                                </DialogContent>
                            </Dialog>

                            <Button variant="default" size="sm" className="bg-green-600 hover:bg-green-700" onClick={() => handleApprove(item.id)}>
                                <Check className="w-4 h-4 mr-1" /> Approve
                            </Button>
                        </CardFooter>
                    </Card>
                ))}

                {approvals.length === 0 && (
                    <div className="col-span-full text-center py-12 text-muted-foreground bg-slate-50 rounded-lg border border-dashed">
                        <Check className="w-12 h-12 mx-auto text-green-500 mb-4" />
                        <h3 className="text-lg font-medium">All caught up!</h3>
                        <p>No pending approvals at this time.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default AdminApprovals;
