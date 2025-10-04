# CyberCon 2025 - Quick Start with Google Sheets

## 🚀 You Have Two Options:

### Option 1: Google Sheets (Recommended - Easy & Free!)
✅ **No backend server**
✅ **No database**
✅ **FREE forever**
✅ **5-minute setup**
✅ Use `main-google-sheets.js`

### Option 2: Node.js Backend (Advanced)
⚙️ Requires MongoDB setup
⚙️ Requires Node.js server
⚙️ More complex but more powerful
⚙️ Use `main.js`

---

## 📋 Google Sheets Setup (Simple 3-Step)

### Step 1: Setup Google Apps Script
1. Create new Google Sheet: "CyberCon 2025 Tickets"
2. Extensions → Apps Script
3. Copy code from `google-sheets-script/Code.gs`
4. Update `SPREADSHEET_ID` (line 5)
5. Deploy → Web App → Copy URL

### Step 2: Update Website Config
Edit `assets/js/main-google-sheets.js`:
```javascript
// Line 8
scriptUrl: 'PASTE_YOUR_WEB_APP_URL_HERE',
```

### Step 3: Update HTML
Edit `cybercon-new.html`:
```html
<!-- Change this line near the end -->
<script src="assets/js/main-google-sheets.js"></script>
```

**Done! Open the website and test!** 🎉

---

## 📖 Full Documentation

- **GOOGLE_SHEETS_SETUP.md** - Detailed setup with screenshots
- **GOOGLE_SHEETS_SUMMARY.md** - Features and benefits
- Backend folder can be **ignored** if using Google Sheets

---

## 🎯 What You Get

✅ Ticket creation with unique IDs
✅ Email confirmations
✅ Ticket verification
✅ Data stored in Google Sheets
✅ Easy management
✅ Export to Excel anytime
✅ No hosting costs

---

**Ready? Open GOOGLE_SHEETS_SETUP.md for detailed instructions!**
