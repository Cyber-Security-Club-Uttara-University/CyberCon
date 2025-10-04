# 🛡️ CyberCon 2025 - Cyber Security Conference Website# CyberCon

CybeCon25 - Cyber Security Club

![CyberCon 2025](https://img.shields.io/badge/CyberCon-2025-blue)
![Google Sheets](https://img.shields.io/badge/Database-Google%20Sheets-green)
![No Backend](https://img.shields.io/badge/Backend-Not%20Required-success)

Official website for **CyberCon 2025**, the flagship cyber security conference organized by the Cyber Security Club, Uttara University.

---

## ✨ Features

- 🎫 **Ticket Management System** - Powered by Google Sheets
- ✅ **Real-time Ticket Verification** - Instant validation
- 📧 **Email Notifications** - Automatic confirmation emails
- 💳 **Payment Integration** - bKash, Nagad, Card support
- 🎨 **Modern UI/UX** - Professional design with animations
- 📱 **Fully Responsive** - Works on all devices
- 🌙 **Dark Theme** - Eye-friendly design
- 🚀 **No Backend Required** - Google Sheets as database
- 💰 **100% FREE** - No hosting or database costs

---

## 🚀 Quick Start

### Prerequisites
- Web browser (Chrome, Firefox, Edge)
- Google Account (for Google Sheets)

### Setup (5 Minutes)

1. **Create Google Sheet**
   - Go to [Google Sheets](https://sheets.google.com)
   - Create new spreadsheet: "CyberCon 2025 Tickets"

2. **Deploy Google Apps Script**
   - In Google Sheet: Extensions → Apps Script
   - Copy code from `google-sheets-script/Code.gs`
   - Update `SPREADSHEET_ID` (line 5)
   - Deploy → New deployment → Web app
   - Copy the Web App URL

3. **Update Configuration**
   - Edit `assets/js/main.js`
   - Update line 8 with your Web App URL:
     ```javascript
     scriptUrl: 'YOUR_WEB_APP_URL_HERE',
     ```

4. **Open Website**
   - Open `cybercon-new.html` in your browser
   - Or use Live Server extension in VS Code

5. **Test**
   - Create a test ticket
   - Check Google Sheet for data
   - Verify the ticket

**Done! 🎉**

---

## 📂 Project Structure

```
CyberCon/
├── cybercon-new.html           # Main website
├── assets/
│   ├── css/
│   │   └── style.css           # Styles
│   └── js/
│       └── main.js             # Google Sheets integration
├── google-sheets-script/
│   └── Code.gs                 # Apps Script code
├── GOOGLE_SHEETS_SETUP.md      # Detailed setup guide
├── GOOGLE_SHEETS_SUMMARY.md    # Features & benefits
├── QUICK_START.md              # Quick reference
└── README.md                   # This file
```

---

## 🎯 How It Works

```
User → Website Form → Google Apps Script → Google Sheet
                          ↓
                   Email Notification
```

1. User registers on website
2. Data sent to Google Apps Script
3. Script generates unique Ticket ID
4. Saves to Google Sheet
5. Sends confirmation email
6. User can verify ticket anytime

---

## 📊 Tech Stack

- **Frontend:** HTML5, CSS3, JavaScript (ES6+)
- **Database:** Google Sheets
- **Backend:** Google Apps Script
- **Animations:** AOS (Animate On Scroll)
- **Icons:** Font Awesome
- **Fonts:** Google Fonts (Inter, Space Grotesk)

---

## 🎨 Sections

- 🏠 **Hero** - Eye-catching header with statistics
- 📖 **About** - Event information
- 🎯 **Mission, Vision & Goals** - Conference objectives
- ✨ **What to Expect** - Attendee benefits
- 🎫 **Tickets** - Registration with 3 tiers
  - Student: ৳500
  - Professional: ৳1500
  - Group: ৳400
- ✅ **Verify Ticket** - Ticket validation
- 📧 **Newsletter** - Subscribe for updates
- 📞 **Contact** - Get in touch

---

## 🔧 Configuration

### Update Google Apps Script URL

Edit `assets/js/main.js`:

```javascript
const GOOGLE_SHEETS_CONFIG = {
    scriptUrl: 'https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec',
    ticketPrices: {
        student: 500,
        professional: 1500,
        group: 400
    }
};
```

### Customize Ticket Prices

Edit the `ticketPrices` object in `main.js` to change pricing.

### Customize Colors

Edit `assets/css/style.css` CSS custom properties:

```css
:root {
    --primary: #3b82f6;     /* Blue */
    --secondary: #8b5cf6;   /* Purple */
    --accent: #06b6d4;      /* Cyan */
    --dark-bg: #0f172a;     /* Dark background */
}
```

---

## 📖 Documentation

- **[QUICK_START.md](QUICK_START.md)** - 3-step quick start guide
- **[GOOGLE_SHEETS_SETUP.md](GOOGLE_SHEETS_SETUP.md)** - Detailed setup with screenshots
- **[GOOGLE_SHEETS_SUMMARY.md](GOOGLE_SHEETS_SUMMARY.md)** - Features, benefits, and tips

---

## ✅ Features Checklist

- ✅ Ticket registration system
- ✅ Unique ticket ID generation (CC2025-XXXXXX)
- ✅ Email confirmations
- ✅ Real-time verification
- ✅ Google Sheets database
- ✅ Newsletter subscriptions
- ✅ Payment method selection
- ✅ T-shirt size selection
- ✅ Responsive design
- ✅ Smooth animations
- ✅ Mobile-friendly
- ✅ No backend required
- ✅ FREE hosting compatible

---

## 🌐 Deployment

### Option 1: Netlify (Recommended)
1. Create account at [Netlify](https://www.netlify.com)
2. Drag and drop project folder
3. Done!

### Option 2: GitHub Pages
1. Push to GitHub repository
2. Settings → Pages → Enable
3. Access at: `username.github.io/repository`

### Option 3: Vercel
1. Create account at [Vercel](https://vercel.com)
2. Import GitHub repository
3. Deploy!

**All are FREE! ✨**

---

## 🔒 Security

- ✅ Data stored in your private Google account
- ✅ SSL/HTTPS encryption
- ✅ Google's enterprise-grade security
- ✅ Only you can edit Google Sheet
- ✅ Apps Script runs under your account

---

## 📱 Browser Support

- ✅ Chrome (recommended)
- ✅ Firefox
- ✅ Safari
- ✅ Edge
- ✅ Mobile browsers

---

## 🐛 Troubleshooting

### Issue: "Please configure Google Apps Script URL"
**Solution:** Update `scriptUrl` in `assets/js/main.js` with your Web App URL.

### Issue: Ticket not saving to Google Sheet
**Solution:** 
- Check if Apps Script is deployed as Web App
- Verify `SPREADSHEET_ID` is correct
- Check Apps Script execution logs

### Issue: Verification not working
**Solution:**
- Ensure Web App is set to "Anyone" can access
- Check browser console for errors (F12)
- Verify the Web App URL is correct

For more help, see **[GOOGLE_SHEETS_SETUP.md](GOOGLE_SHEETS_SETUP.md)** troubleshooting section.

---

## 📞 Contact

- **Email:** info@cybercon2025.com
- **Organization:** Cyber Security Club, Uttara University
- **Event Date:** December 15-16, 2025
- **Venue:** Uttara University Campus

---

## 🤝 Contributing

This is a private event website. For suggestions or issues, contact the development team.

---

## 📄 License

© 2025 Cyber Security Club, Uttara University. All rights reserved.

---

## 🎓 Credits

- **Developed by:** Cyber Security Club
- **University:** Uttara University
- **Event:** CyberCon 2025

---

## 💡 Why Google Sheets?

| Feature | Google Sheets | Traditional Backend |
|---------|--------------|---------------------|
| **Cost** | FREE ✅ | $5-20/month |
| **Setup** | 5 minutes | 1-2 hours |
| **Maintenance** | None | Regular updates |
| **Scalability** | Automatic | Manual |
| **Data Access** | Google Sheets UI | Database tools |
| **Backup** | Automatic | Manual setup |
| **Team Access** | Share link | Create accounts |

**Simple. Free. Effective.** 🚀

---

## 🎉 Getting Started

1. Read **[QUICK_START.md](QUICK_START.md)** for fast setup
2. Follow **[GOOGLE_SHEETS_SETUP.md](GOOGLE_SHEETS_SETUP.md)** for detailed guide
3. Deploy Google Apps Script
4. Update configuration
5. Open website
6. Start accepting registrations!

---

**Made with ❤️ by Cyber Security Club, Uttara University**

*No backend hassle. Just pure Google Sheets magic!* ✨

---

## 📸 Screenshots

*Website features professional design with:*
- Animated hero section with particle effects
- Ticket pricing cards with hover effects
- Real-time ticket verification
- Mobile-responsive layout
- Smooth scroll animations

---

**Ready to go? Open [QUICK_START.md](QUICK_START.md) now!** 🚀
