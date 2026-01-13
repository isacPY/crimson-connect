import { Outlet, Link, useLocation } from "react-router-dom";
import { LayoutDashboard, Users, UserCheck, Settings, LogOut, Heart } from "lucide-react";
import { Button } from "@/components/ui/button";

const AdminLayout = () => {
    const location = useLocation();

    const isActive = (path: string) => {
        return location.pathname === path || (path !== "/admin" && location.pathname.startsWith(path));
    };

    const navItems = [
        { name: "Dashboard", path: "/admin", icon: LayoutDashboard },
        { name: "User Management", path: "/admin/users", icon: Users },
        { name: "Approvals", path: "/admin/approvals", icon: UserCheck },
        { name: "Donations", path: "/admin/donations", icon: Heart },
        { name: "Settings", path: "/admin/settings", icon: Settings },
    ];

    return (
        <div className="flex h-screen w-full bg-slate-100 dark:bg-slate-900">
            {/* Sidebar */}
            <div className="w-64 bg-white dark:bg-slate-800 shadow-md flex flex-col h-full hidden md:flex border-r">
                <div className="p-6">
                    <Link to="/" className="flex items-center gap-2">
                        <span className="text-xl font-bold text-primary">BloodLink Admin</span>
                    </Link>
                </div>

                <nav className="flex-1 px-4 py-4 space-y-1">
                    {navItems.map((item) => (
                        <Link key={item.path} to={item.path}>
                            <Button
                                variant={isActive(item.path) ? "secondary" : "ghost"}
                                className={`w-full justify-start ${isActive(item.path) ? "bg-slate-100 text-primary font-semibold" : "text-muted-foreground"}`}
                            >
                                <item.icon className="mr-3 h-5 w-5" />
                                {item.name}
                            </Button>
                        </Link>
                    ))}
                </nav>

                <div className="p-4 border-t">
                    <Link to="/">
                        <Button variant="outline" className="w-full justify-start text-red-600 hover:text-red-700 hover:bg-red-50">
                            <LogOut className="mr-3 h-5 w-5" />
                            Logout
                        </Button>
                    </Link>
                </div>
            </div>

            {/* Main Content */}
            <div className="flex-1 overflow-auto">
                <header className="bg-white px-6 py-4 shadow-sm flex justify-between items-center md:hidden">
                    <span className="font-bold">Admin Panel</span>
                    <Button variant="ghost" size="sm">Menu</Button>
                </header>
                <div className="p-8">
                    <Outlet />
                </div>
            </div>
        </div>
    );
};

export default AdminLayout;
