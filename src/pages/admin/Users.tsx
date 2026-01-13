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
import { MoreHorizontal, Search, Trash, UserCheck, Shield } from "lucide-react";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

const AdminUsers = () => {
    const users = [
        { id: 1, name: "Alice Smith", role: "Donor", email: "alice@example.com", status: "Active" },
        { id: 2, name: "City Hospital", role: "Blood Bank", email: "admin@cityhospital.com", status: "Active" },
        { id: 3, name: "Bob Jones", role: "Patient", email: "bob@example.com", status: "Inactive" },
        { id: 4, name: "Admin Staff", role: "Staff", email: "staff@bloodlink.org", status: "Active" },
    ];

    return (
        <div className="space-y-8 animate-fade-up">
            <div className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-bold tracking-tight">User Management</h1>
                    <p className="text-muted-foreground">Manage donors, patients, and staff access.</p>
                </div>
                <Button>
                    <Shield className="mr-2 h-4 w-4" /> Add Staff Member
                </Button>
            </div>

            <div className="bg-white rounded-lg border shadow-sm">
                <div className="p-4 border-b flex gap-4">
                    <div className="relative flex-1 max-w-sm">
                        <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                        <Input placeholder="Search users..." className="pl-9" />
                    </div>
                </div>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Name</TableHead>
                            <TableHead>Role</TableHead>
                            <TableHead>Email</TableHead>
                            <TableHead>Status</TableHead>
                            <TableHead className="text-right">Actions</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {users.map((user) => (
                            <TableRow key={user.id}>
                                <TableCell className="font-medium">{user.name}</TableCell>
                                <TableCell>
                                    <Badge variant="outline">{user.role}</Badge>
                                </TableCell>
                                <TableCell>{user.email}</TableCell>
                                <TableCell>
                                    <Badge variant={user.status === "Active" ? "default" : "secondary"}>
                                        {user.status}
                                    </Badge>
                                </TableCell>
                                <TableCell className="text-right">
                                    <DropdownMenu>
                                        <DropdownMenuTrigger asChild>
                                            <Button variant="ghost" className="h-8 w-8 p-0">
                                                <span className="sr-only">Open menu</span>
                                                <MoreHorizontal className="h-4 w-4" />
                                            </Button>
                                        </DropdownMenuTrigger>
                                        <DropdownMenuContent align="end">
                                            <DropdownMenuLabel>Actions</DropdownMenuLabel>
                                            <DropdownMenuItem>
                                                <UserCheck className="mr-2 h-4 w-4" /> View Profile
                                            </DropdownMenuItem>
                                            <DropdownMenuSeparator />
                                            <DropdownMenuItem className="text-red-600">
                                                <Trash className="mr-2 h-4 w-4" /> Delete User
                                            </DropdownMenuItem>
                                        </DropdownMenuContent>
                                    </DropdownMenu>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </div>
        </div>
    );
};

export default AdminUsers;
