import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { User, Droplet, Clock, MapPin, Edit, History } from "lucide-react";

const Profile = () => {
    // Mock User Data
    const user = {
        name: "John Doe",
        email: "john.doe@example.com",
        role: "Donor",
        bloodGroup: "O+",
        location: "New York, NY",
        joined: "January 2024",
        donations: 3,
        lastDonation: "15th March 2024"
    };

    return (
        <div className="min-h-screen bg-slate-50">
            <Header />
            <main className="container mx-auto px-4 py-24">
                <div className="max-w-4xl mx-auto space-y-6 animate-fade-up">
                    {/* Header Card */}
                    <Card className="overflow-hidden">
                        <div className="h-32 bg-gradient-to-r from-red-500 to-red-600"></div>
                        <CardContent className="relative pt-0 pb-8">
                            <div className="flex flex-col md:flex-row items-start md:items-end -mt-12 mb-4 px-4 gap-4">
                                <Avatar className="w-24 h-24 border-4 border-white shadow-lg">
                                    <AvatarImage src="https://github.com/shadcn.png" />
                                    <AvatarFallback>JD</AvatarFallback>
                                </Avatar>
                                <div className="flex-1 space-y-1 mb-2">
                                    <h1 className="text-2xl font-bold">{user.name}</h1>
                                    <div className="flex items-center text-muted-foreground text-sm gap-2">
                                        <MapPin className="w-4 h-4" /> {user.location} • Joined {user.joined}
                                    </div>
                                </div>
                                <div className="flex gap-2 mb-2 w-full md:w-auto">
                                    <Button variant="outline" size="sm" className="w-full md:w-auto">
                                        <Edit className="w-4 h-4 mr-2" /> Edit Profile
                                    </Button>
                                </div>
                            </div>
                        </CardContent>
                    </Card>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                        {/* Sidebar Info */}
                        <Card className="h-fit">
                            <CardHeader>
                                <CardTitle className="text-lg">Personal Details</CardTitle>
                            </CardHeader>
                            <CardContent className="space-y-4">
                                <div className="flex justify-between border-b pb-2">
                                    <span className="text-muted-foreground flex items-center gap-2"><Droplet className="w-4 h-4" /> Blood Group</span>
                                    <Badge variant="secondary" className="font-bold text-lg">{user.bloodGroup}</Badge>
                                </div>
                                <div className="flex justify-between border-b pb-2">
                                    <span className="text-muted-foreground flex items-center gap-2"><User className="w-4 h-4" /> Role</span>
                                    <span className="font-medium">{user.role}</span>
                                </div>
                                <div className="flex justify-between border-b pb-2">
                                    <span className="text-muted-foreground flex items-center gap-2"><Clock className="w-4 h-4" /> Last Donation</span>
                                    <span className="font-medium">{user.lastDonation}</span>
                                </div>
                            </CardContent>
                        </Card>

                        {/* Main Content */}
                        <div className="md:col-span-2">
                            <Tabs defaultValue="history">
                                <TabsList className="w-full justify-start border-b rounded-none h-auto p-0 bg-transparent">
                                    <TabsTrigger value="history" className="rounded-none border-b-2 border-transparent data-[state=active]:border-primary data-[state=active]:bg-transparent px-6 py-2">Donation History</TabsTrigger>
                                    <TabsTrigger value="requests" className="rounded-none border-b-2 border-transparent data-[state=active]:border-primary data-[state=active]:bg-transparent px-6 py-2">My Requests</TabsTrigger>
                                </TabsList>
                                <TabsContent value="history" className="mt-6 space-y-4">
                                    {[1, 2, 3].map((i) => (
                                        <Card key={i}>
                                            <CardHeader className="py-4">
                                                <div className="flex justify-between items-center">
                                                    <div className="flex items-center gap-3">
                                                        <div className="p-2 bg-green-100 text-green-700 rounded-full">
                                                            <History className="w-5 h-5" />
                                                        </div>
                                                        <div>
                                                            <CardTitle className="text-base">Donation at City Hospital</CardTitle>
                                                            <CardDescription>15th March 2024</CardDescription>
                                                        </div>
                                                    </div>
                                                    <Badge className="bg-green-600">Completed</Badge>
                                                </div>
                                            </CardHeader>
                                        </Card>
                                    ))}
                                </TabsContent>
                            </Tabs>
                        </div>
                    </div>
                </div>
            </main>
            <Footer />
        </div>
    );
};

export default Profile;
