import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, Droplet, Building2, Activity } from "lucide-react";

const AdminDashboard = () => {
    const stats = [
        { title: "Total Users", value: "2,345", icon: Users, color: "text-blue-600", bg: "bg-blue-100" },
        { title: "Blood Units", value: "450", icon: Droplet, color: "text-red-600", bg: "bg-red-100" },
        { title: "Blood Banks", value: "12", icon: Building2, color: "text-green-600", bg: "bg-green-100" },
        { title: "Active Requests", value: "34", icon: Activity, color: "text-orange-600", bg: "bg-orange-100" },
    ];

    return (
        <div className="space-y-8 animate-fade-up">
            <div>
                <h1 className="text-3xl font-bold tracking-tight">Dashboard</h1>
                <p className="text-muted-foreground">Overview of system activity and statistics.</p>
            </div>

            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                {stats.map((stat) => (
                    <Card key={stat.title}>
                        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                            <CardTitle className="text-sm font-medium">
                                {stat.title}
                            </CardTitle>
                            <div className={`p-2 rounded-full ${stat.bg}`}>
                                <stat.icon className={`h-4 w-4 ${stat.color}`} />
                            </div>
                        </CardHeader>
                        <CardContent>
                            <div className="text-2xl font-bold">{stat.value}</div>
                            <p className="text-xs text-muted-foreground">
                                +20.1% from last month
                            </p>
                        </CardContent>
                    </Card>
                ))}
            </div>

            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-7">
                <Card className="col-span-4">
                    <CardHeader>
                        <CardTitle>Recent Activity</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-4">
                            {[1, 2, 3].map(i => (
                                <div key={i} className="flex items-center gap-4 border-b pb-4 last:border-0 last:pb-0">
                                    <div className="w-2 h-2 rounded-full bg-primary" />
                                    <div>
                                        <p className="text-sm font-medium">New donor registered: John Doe</p>
                                        <p className="text-xs text-muted-foreground uppercase">2 minutes ago</p>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>
                <Card className="col-span-3">
                    <CardHeader>
                        <CardTitle>Pending Approvals</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-4">
                            {[1, 2].map(i => (
                                <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0 last:pb-0">
                                    <div>
                                        <p className="text-sm font-medium">Blood Bank: Saint Hops</p>
                                        <p className="text-xs text-muted-foreground">Kyoto, JP</p>
                                    </div>
                                    <span className="text-xs bg-yellow-100 text-yellow-800 px-2 py-1 rounded">Pending</span>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>
            </div>
        </div>
    );
};

export default AdminDashboard;
