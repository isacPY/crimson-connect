import { Button } from "@/components/ui/button";
import {
    Card,
    CardContent,
    CardDescription,
    CardHeader,
    CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import { Bell, Shield, Globe, Save } from "lucide-react";
import { toast } from "sonner";

const AdminSettings = () => {
    const handleSave = () => {
        toast.success("Settings Saved", {
            description: "System configurations have been updated successfully."
        });
    };

    return (
        <div className="space-y-8 animate-fade-up max-w-4xl">
            <div>
                <h1 className="text-3xl font-bold tracking-tight">Settings</h1>
                <p className="text-muted-foreground">Manage global system preferences and limitations.</p>
            </div>

            <Tabs defaultValue="general" className="w-full">
                <TabsList className="grid w-full grid-cols-3 lg:w-[400px]">
                    <TabsTrigger value="general">General</TabsTrigger>
                    <TabsTrigger value="notifications">Notifications</TabsTrigger>
                    <TabsTrigger value="security">Security</TabsTrigger>
                </TabsList>

                <TabsContent value="general" className="mt-6">
                    <Card>
                        <CardHeader>
                            <CardTitle className="flex items-center gap-2">
                                <Globe className="w-5 h-5" /> Donation Parameters
                            </CardTitle>
                            <CardDescription>
                                Configure the standard rules for donation eligibility across the platform.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div className="space-y-2">
                                    <Label htmlFor="min-age">Minimum Donor Age</Label>
                                    <Input id="min-age" type="number" defaultValue="18" />
                                </div>
                                <div className="space-y-2">
                                    <Label htmlFor="max-age">Maximum Donor Age</Label>
                                    <Input id="max-age" type="number" defaultValue="65" />
                                </div>
                                <div className="space-y-2">
                                    <Label htmlFor="min-weight">Minimum Weight (kg)</Label>
                                    <Input id="min-weight" type="number" defaultValue="50" />
                                </div>
                                <div className="space-y-2">
                                    <Label htmlFor="interval">Donation Interval (Days)</Label>
                                    <Input id="interval" type="number" defaultValue="90" />
                                    <p className="text-xs text-muted-foreground">Minimum days between donations.</p>
                                </div>
                            </div>
                            <Separator />
                            <div className="space-y-4">
                                <h4 className="font-medium">Emergency Broadcast System</h4>
                                <div className="flex items-center justify-between">
                                    <div className="space-y-0.5">
                                        <Label>Auto-Broadcast Critical Requests</Label>
                                        <p className="text-sm text-muted-foreground">Automatically notify donors for urgent requests.</p>
                                    </div>
                                    <Switch defaultChecked />
                                </div>
                            </div>
                        </CardContent>
                    </Card>
                </TabsContent>

                <TabsContent value="notifications" className="mt-6">
                    <Card>
                        <CardHeader>
                            <CardTitle className="flex items-center gap-2">
                                <Bell className="w-5 h-5" /> Notification Preferences
                            </CardTitle>
                            <CardDescription>
                                Manage how administrators and users receive alerts.
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            <div className="space-y-4">
                                <div className="flex items-center justify-between border-b pb-4">
                                    <div className="space-y-0.5">
                                        <Label>New Donor Registration</Label>
                                        <p className="text-sm text-muted-foreground">Receive email when a new donor signs up.</p>
                                    </div>
                                    <Switch defaultChecked />
                                </div>
                                <div className="flex items-center justify-between border-b pb-4">
                                    <div className="space-y-0.5">
                                        <Label>Blood Bank Stock Alerts</Label>
                                        <p className="text-sm text-muted-foreground">Alert when public blood banks report critical shortages.</p>
                                    </div>
                                    <Switch defaultChecked />
                                </div>
                                <div className="flex items-center justify-between">
                                    <div className="space-y-0.5">
                                        <Label>Daily Summary Report</Label>
                                        <p className="text-sm text-muted-foreground">Receive a daily digest of activity.</p>
                                    </div>
                                    <Switch />
                                </div>
                            </div>
                        </CardContent>
                    </Card>
                </TabsContent>
            </Tabs>

            <div className="flex justify-end">
                <Button onClick={handleSave} className="w-[150px]">
                    <Save className="w-4 h-4 mr-2" /> Save Changes
                </Button>
            </div>
        </div>
    );
};

export default AdminSettings;
