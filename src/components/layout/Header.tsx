import { Menu, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { ThemeToggle } from "@/components/ThemeToggle";
import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import bloodLinkLogo from "@/assets/bloodlink-logo.png";

const Header = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const navigate = useNavigate();

  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-background/80 backdrop-blur-md border-b border-border">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16 md:h-20">
          {/* Logo */}
          <Link to="/" className="flex items-center gap-2 group">
            <img
              src={bloodLinkLogo}
              alt="BloodLink Logo"
              className="w-10 h-10 rounded-xl object-contain group-hover:scale-105 transition-transform duration-300"
            />
            <span className="text-xl font-bold text-foreground">
              Blood<span className="text-gradient">Link</span>
            </span>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-8">
            <Link to="/donors" className="text-muted-foreground hover:text-foreground transition-colors duration-200">
              Find Donors
            </Link>
            <Link to="/donate" className="text-muted-foreground hover:text-foreground transition-colors duration-200">
              Donate Blood
            </Link>
            <Link to="/request-blood" className="text-muted-foreground hover:text-foreground transition-colors duration-200">
              Request Blood
            </Link>
            <Link to="/banks" className="text-muted-foreground hover:text-foreground transition-colors duration-200">
              Blood Banks
            </Link>
          </nav>

          {/* CTA Buttons & Theme Toggle */}
          <div className="hidden md:flex items-center gap-3">
            <ThemeToggle />
            <Button variant="ghost" size="sm" onClick={() => navigate("/auth/login")}>
              Sign In
            </Button>
            <Button variant="default" size="sm" onClick={() => navigate("/get-started")}>
              Get Started
            </Button>
          </div>

          {/* Mobile Menu Button */}
          <div className="flex md:hidden items-center gap-2">
            <ThemeToggle />
            <button
              className="p-2 hover:bg-accent rounded-lg transition-colors"
              onClick={() => setIsMenuOpen(!isMenuOpen)}
            >
              {isMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>

        {/* Mobile Menu */}
        {isMenuOpen && (
          <div className="md:hidden py-4 border-t border-border animate-fade-up">
            <nav className="flex flex-col gap-4">
              <Link to="/donors" className="text-muted-foreground hover:text-foreground transition-colors py-2" onClick={() => setIsMenuOpen(false)}>
                Find Donors
              </Link>
              <Link to="/donate" className="text-muted-foreground hover:text-foreground transition-colors py-2" onClick={() => setIsMenuOpen(false)}>
                Donate Blood
              </Link>
              <Link to="/request-blood" className="text-muted-foreground hover:text-foreground transition-colors py-2" onClick={() => setIsMenuOpen(false)}>
                Request Blood
              </Link>
              <Link to="/banks" className="text-muted-foreground hover:text-foreground transition-colors py-2" onClick={() => setIsMenuOpen(false)}>
                Blood Banks
              </Link>
              <div className="flex flex-col gap-2 pt-4">
                <Button variant="ghost" className="w-full justify-center" onClick={() => { navigate("/auth/login"); setIsMenuOpen(false); }}>
                  Sign In
                </Button>
                <Button variant="default" className="w-full justify-center" onClick={() => { navigate("/get-started"); setIsMenuOpen(false); }}>
                  Get Started
                </Button>
              </div>
            </nav>
          </div>
        )}
      </div>
    </header>
  );
};

export default Header;
