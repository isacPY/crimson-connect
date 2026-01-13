import { Button } from "@/components/ui/button";
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Search, Download, Calendar } from "lucide-react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

const AdminDonations = () => {
    const donations = [
        { id: "DON-001", donor: "John Doe", bloodType: "O+", units: 1, date: "2024-03-15", location: "City Hospital", status: "Completed" },
        { id: "DON-002", donor: "Sarah Smith", bloodType: "A-", units: 1, date: "2024-03-14", location: "Mobile Camp #4", status: "Processing" },
        { id: "DON-003", donor: "Mike Jones", bloodType: "B+", units: 1, date: "2024-03-14", location: "Red Cross Center", status: "Completed" },
        { id: "DON-004", donor: "Emily Davis", bloodType: "AB+", units: 1, date: "2024-03-13", location: "City Hospital", status: "Failed (Low Hb)" },
        { id: "DON-005", donor: "Robert Brown", bloodType: "O-", units: 1, date: "2024-03-12", location: "Main Blood Bank", status: "Completed" },
    ];

    return (
        <div className="space-y-8 animate-fade-up">
            <div className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-bold tracking-tight">Donation Logs</h1>
                    <p className="text-muted-foreground">Track and manage blood donation records system-wide.</p>
                </div>
                <Button variant="outline">
                    <Download className="mr-2 h-4 w-4" /> Export Report
                </Button>
            </div>

            <div className="flex flex-col md:flex-row gap-4">
                <div className="relative flex-1">
                    <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                    <Input placeholder="Search by donor, ID, or location..." className="pl-9" />
                </div>
                <div className="w-[180px]">
                    <Select defaultValue="all">
                        <SelectTrigger>
                            <SelectValue placeholder="Status" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">All Status</SelectItem>
                            <SelectItem value="completed">Completed</SelectItem>
                            <SelectItem value="processing">Processing</SelectItem>
                            <SelectItem value="failed">Failed</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                <div className="w-[180px]">
                    <Button variant="outline" className="w-full justify-start font-normal text-muted-foreground">
                        <Calendar className="mr-2 h-4 w-4" /> Date Range
                    </Button>
                </div>
            </div>

            <div className="bg-white rounded-lg border shadow-sm">
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Donation ID</TableHead>
                            <TableHead>Donor Name</TableHead>
                            <TableHead>Blood Group</TableHead>
                            <TableHead>Location</TableHead>
                            <TableHead>Date</TableHead>
                            <TableHead>Status</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {donations.map((donation) => (
                            <TableRow key={donation.id}>
                                <TableCell className="font-mono text-xs text-muted-foreground">{donation.id}</TableCell>
                                <TableCell className="font-medium">{donation.donor}</TableCell>
                                <TableCell>
                                    <Badge variant="outline" className="font-bold">{donation.bloodType}</Badge>
                                </TableCell>
                                <TableCell>{donation.location}</TableCell>
                                <TableCell>{donation.date}</TableCell>
                                <TableCell>
                                    <Badge variant={
                                        donation.status === "Completed" ? "default" :
                                            donation.status === "Processing" ? "secondary" :
                                                "destructive"
                                    }>
                                        {donation.status}
                                    </Badge>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </div>
        </div>
    );
};

export default AdminDonations;
