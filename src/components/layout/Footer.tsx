import { Mail, Phone, MapPin, Facebook, Twitter, Instagram, Linkedin } from "lucide-react";
import { Link } from "react-router-dom";
import bloodLinkLogo from "@/assets/bloodlink-logo.png";

const Footer = () => {
  return (
    <footer className="bg-card border-t border-border">
      <div className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12">
          {/* Brand */}
          <div className="space-y-4">
            <a href="/" className="flex items-center gap-2">
              <img
                src={bloodLinkLogo}
                alt="BloodLink Logo"
                className="w-10 h-10 rounded-xl object-contain"
              />
              <span className="text-xl font-bold">
                Blood<span className="text-primary">Link</span>
              </span>
            </a>
            <p className="text-muted-foreground text-sm leading-relaxed">
              Connecting donors with those in need. Every drop counts in saving lives.
            </p>
            <div className="flex items-center gap-4 pt-2">
              <a href="#" className="w-9 h-9 rounded-lg bg-secondary flex items-center justify-center hover:bg-primary transition-colors duration-200">
                <Facebook className="w-4 h-4" />
              </a>
              <a href="#" className="w-9 h-9 rounded-lg bg-secondary flex items-center justify-center hover:bg-primary transition-colors duration-200">
                <Twitter className="w-4 h-4" />
              </a>
              <a href="#" className="w-9 h-9 rounded-lg bg-secondary flex items-center justify-center hover:bg-primary transition-colors duration-200">
                <Instagram className="w-4 h-4" />
              </a>
              <a href="#" className="w-9 h-9 rounded-lg bg-secondary flex items-center justify-center hover:bg-primary transition-colors duration-200">
                <Linkedin className="w-4 h-4" />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="font-semibold mb-4">Quick Links</h4>
            <ul className="space-y-3">
              <li>
                <Link to="/donors" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Find Donors
                </Link>
              </li>
              <li>
                <Link to="/request-blood" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Request Blood
                </Link>
              </li>
              <li>
                <Link to="/banks" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Blood Banks
                </Link>
              </li>
              <li>
                <Link to="/donate" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Donate Blood
                </Link>
              </li>
              <li>
                <Link to="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  FAQs
                </Link>
              </li>
            </ul>
          </div>

          {/* Resources */}
          <div>
            <h4 className="font-semibold mb-4">Resources</h4>
            <ul className="space-y-3">
              <li>
                <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Eligibility Guide
                </a>
              </li>
              <li>
                <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Blood Type Chart
                </a>
              </li>
              <li>
                <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Health Tips
                </a>
              </li>
              <li>
                <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Success Stories
                </a>
              </li>
              <li>
                <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
                  Blog
                </a>
              </li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h4 className="font-semibold mb-4">Contact Us</h4>
            <ul className="space-y-3">
              <li className="flex items-center gap-3 text-muted-foreground text-sm">
                <Phone className="w-4 h-4 text-primary" />
                <span>+1 (800) 555-LINK</span>
              </li>
              <li className="flex items-center gap-3 text-muted-foreground text-sm">
                <Mail className="w-4 h-4 text-primary" />
                <span>contact@bloodlink.org</span>
              </li>
              <li className="flex items-start gap-3 text-muted-foreground text-sm">
                <MapPin className="w-4 h-4 text-primary mt-0.5" />
                <span>123 Medical Center Drive<br />Health City, HC 12345</span>
              </li>
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="border-t border-border mt-12 pt-8 flex flex-col md:flex-row items-center justify-between gap-4">
          <p className="text-muted-foreground text-sm">
            © 2024 BloodLink. All rights reserved.
          </p>
          <div className="flex items-center gap-6">
            <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
              Privacy Policy
            </a>
            <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
              Terms of Service
            </a>
            <a href="#" className="text-muted-foreground hover:text-primary transition-colors text-sm">
              Cookie Policy
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
