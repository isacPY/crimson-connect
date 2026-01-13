import { Button } from "@/components/ui/button";
import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import { toast } from "sonner";
import bloodLinkLogo from "@/assets/bloodlink-logo.png";

const Login = () => {
    const navigate = useNavigate();
    const [isLoading, setIsLoading] = useState(false);

    const handleLogin = (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);

        // Simulate login delay
        setTimeout(() => {
            setIsLoading(false);
            toast.success("Welcome back!", {
                description: "You have successfully logged in.",
            });
            navigate("/");
        }, 1500);
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-slate-50 p-4">
            <Card className="w-full max-w-md shadow-lg">
                <CardHeader className="space-y-1 text-center">
                    <div className="flex justify-center mb-4">
                        <img
                            src={bloodLinkLogo}
                            alt="BloodLink Logo"
                            className="w-12 h-12 rounded-xl object-contain"
                        />
                    </div>
                    <CardTitle className="text-2xl font-bold">Welcome back</CardTitle>
                    <CardDescription>
                        Enter your credentials to access your account
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <form onSubmit={handleLogin} className="space-y-4">
                        <div className="space-y-2">
                            <Label htmlFor="email">Email</Label>
                            <Input
                                id="email"
                                type="email"
                                placeholder="john@example.com"
                                required
                            />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="password">Password</Label>
                            <Input
                                id="password"
                                type="password"
                                required
                            />
                        </div>
                        <Button className="w-full bg-primary hover:bg-primary/90" type="submit" disabled={isLoading}>
                            {isLoading ? "Signing in..." : "Sign In"}
                        </Button>
                    </form>
                </CardContent>
                <CardFooter className="flex flex-col gap-4 text-center text-sm text-muted-foreground">
                    <div>
                        <Link to="/auth/forgot-password" className="hover:text-primary transition-colors">
                            Forgot your password?
                        </Link>
                    </div>
                    <div>
                        Don't have an account?{" "}
                        <Link to="/auth/signup" className="text-primary font-medium hover:underline">
                            Sign up
                        </Link>
                    </div>
                </CardFooter>
            </Card>
            {/* Background decoration */}
            <div className="fixed inset-0 -z-10 h-full w-full bg-white bg-[linear-gradient(to_right,#8080800a_1px,transparent_1px),linear-gradient(to_bottom,#8080800a_1px,transparent_1px)] bg-[size:14px_24px]">
                <div className="absolute left-0 right-0 top-0 -z-10 m-auto h-[310px] w-[310px] rounded-full bg-primary/20 opacity-20 blur-[100px]"></div>
            </div>
        </div>
    );
};

export default Login;
