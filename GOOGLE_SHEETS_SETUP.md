# Google Sheets Setup Guide for CyberCon 2025

## 🎯 Overview

This guide will help you set up Google Sheets as your database for the CyberCon 2025 ticket system - **NO backend server required!**

---

## 📋 Step-by-Step Setup

### Step 1: Create Google Sheet

1. Go to [Google Sheets](https://sheets.google.com)
2. Click **"+ Blank"** to create a new spreadsheet
3. Rename it to **"CyberCon 2025 Tickets"**
4. The spreadsheet will auto-create sheets for:
   - `Tickets` - All ticket registrations
   - `Newsletter` - Newsletter subscribers

---

### Step 2: Set Up Google Apps Script

1. **Open Apps Script:**
   - In your Google Sheet, click **Extensions** → **Apps Script**

2. **Delete existing code:**
   - Delete the default `function myFunction() {}` code

3. **Copy the script:**
   - Open the file: `google-sheets-script/Code.gs`
   - Copy ALL the code

4. **Paste into Apps Script:**
   - Paste the code into the Apps Script editor

5. **Update Spreadsheet ID:**
   - In your Google Sheet URL, copy the ID:
     ```
     https://docs.google.com/spreadsheets/d/SPREADSHEET_ID_HERE/edit
     ```
   - Replace `YOUR_SPREADSHEET_ID_HERE` in line 5 of the script with your actual ID

6. **Save the project:**
   - Click the **save icon** (💾) or press `Ctrl+S`
   - Name it: "CyberCon 2025 API"

---

### Step 3: Deploy as Web App

1. **Click Deploy:**
   - Click **Deploy** → **New deployment**

2. **Configure deployment:**
   - Click the **⚙️ gear icon** next to "Select type"
   - Select **"Web app"**

3. **Set permissions:**
   - **Description:** CyberCon 2025 Ticket API
   - **Execute as:** Me (your email)
   - **Who has access:** Anyone

4. **Deploy:**
   - Click **Deploy**
   - Click **Authorize access**
   - Choose your Google account
   - Click **Advanced** → **Go to CyberCon 2025 API (unsafe)**
   - Click **Allow**

5. **Copy Web App URL:**
   - After deployment, you'll see a **Web app URL**
   - Copy this URL (it looks like):
     ```
     https://script.google.com/macros/s/AKfycbxxx.../exec
     ```
   - **SAVE THIS URL** - you'll need it in the next step!

---

### Step 4: Update Website Configuration

1. **Open:** `assets/js/main-google-sheets.js`

2. **Find line 8:**
   ```javascript
   scriptUrl: 'YOUR_GOOGLE_APPS_SCRIPT_URL_HERE',
   ```

3. **Replace with your Web App URL:**
   ```javascript
   scriptUrl: 'https://script.google.com/macros/s/AKfycbxxx.../exec',
   ```

4. **Save the file**

---

### Step 5: Update HTML to Use Google Sheets Version

1. **Open:** `cybercon-new.html`

2. **Find the script tag** (near the end of the file):
   ```html
   <script src="assets/js/main.js"></script>
   ```

3. **Change to:**
   ```html
   <script src="assets/js/main-google-sheets.js"></script>
   ```

4. **Save the file**

---

### Step 6: Test Your Setup

1. **Open** `cybercon-new.html` in your browser

2. **Create a test ticket:**
   - Click "Get Ticket" on any ticket type
   - Fill out the form
   - Submit

3. **Check Google Sheet:**
   - Go to your Google Sheet
   - You should see a new row in the "Tickets" sheet with the ticket data!

4. **Test verification:**
   - Go to the "Verify Ticket" section
   - Enter the Ticket ID from Google Sheet
   - Click "Verify Ticket"
   - You should see ticket details!

---

## 📊 Google Sheet Structure

### Tickets Sheet

| Column | Description |
|--------|-------------|
| Ticket ID | Auto-generated (CC2025-XXXXXX) |
| Timestamp | Registration date/time |
| Name | Attendee name |
| Email | Email address |
| Phone | Phone number |
| Organization | University/Company |
| Ticket Type | student, professional, or group |
| T-Shirt Size | S, M, L, XL, XXL |
| Payment Method | bkash, nagad, card |
| Amount | Ticket price |
| Status | Active, Used, Cancelled |
| Check-in Time | Event check-in timestamp |

### Newsletter Sheet

| Column | Description |
|--------|-------------|
| Email | Subscriber email |
| Timestamp | Subscription date/time |

---

## 🎨 Features

### ✅ What Works:
- ✅ Create tickets (stored in Google Sheets)
- ✅ Verify tickets (fetch from Google Sheets)
- ✅ Automatic email notifications
- ✅ Newsletter subscriptions
- ✅ Unique ticket ID generation
- ✅ No backend server required!
- ✅ Free forever (Google Sheets is free)
- ✅ Easy to manage (just open Google Sheet)
- ✅ Export to Excel/CSV anytime

### 📧 Email Notifications:
The script automatically sends confirmation emails when tickets are created. Make sure:
- You're logged into the Google account
- Gmail service is enabled

---

## 🔒 Security & Privacy

### Access Control:
- **Apps Script:** Only you can edit the script
- **Web App:** Set to "Anyone" for public access (required)
- **Data:** Stored in your private Google Sheet
- **Permissions:** You control who can view/edit the sheet

### Best Practices:
1. Don't share your Spreadsheet ID publicly
2. Keep the Apps Script URL private (embed in code only)
3. Use Google Sheet sharing settings to control access
4. Regularly backup your data (File → Download)

---

## 📱 Managing Your Data

### View Tickets:
1. Open your Google Sheet
2. Click "Tickets" tab
3. See all registrations in real-time

### Search for Ticket:
1. Press `Ctrl+F` in Google Sheet
2. Search by name, email, or ticket ID

### Export Data:
1. File → Download → Microsoft Excel (.xlsx)
2. Or: CSV, PDF, etc.

### Check-in at Event:
1. Open Google Sheet on tablet/phone
2. Find ticket by ID
3. Update "Status" to "Used"
4. Add check-in time

### Filter/Sort:
- Use Google Sheets built-in filters
- Create pivot tables for analytics
- Generate charts and reports

---

## 🎯 Advanced Features

### Check-in Function:
The script includes a `checkInTicket()` function for event organizers:

```javascript
// Call this from a custom admin panel
checkInTicket('CC2025-123456');
```

### Get Statistics:
```javascript
// Get ticket stats
const stats = getStats();
console.log(stats);
// Returns: { total, byType, byStatus, totalRevenue }
```

### Create Admin Dashboard:
You can create a separate HTML page to:
- View all tickets
- Search and filter
- Check-in attendees
- View statistics

---

## 🐛 Troubleshooting

### Problem: "Please configure Google Apps Script URL"
**Solution:**
- Make sure you deployed the Apps Script as Web App
- Copy the correct Web App URL
- Update `scriptUrl` in `main-google-sheets.js`

### Problem: Ticket not appearing in Google Sheet
**Solution:**
- Check if the script is deployed (not just saved)
- Make sure "Execute as: Me" is selected
- Try redeploying the Web App
- Check Apps Script execution logs (View → Executions)

### Problem: "Authorization required" when deploying
**Solution:**
- Click "Advanced" → "Go to project (unsafe)"
- Click "Allow"
- This is normal for Apps Script projects

### Problem: Verification not working
**Solution:**
- Make sure the Web App URL is correct
- Check if "Who has access" is set to "Anyone"
- Try accessing the URL directly in browser
- Check browser console for errors (F12)

### Problem: Email not sending
**Solution:**
- Emails are sent automatically by Google
- Check spam folder
- Make sure Gmail service is enabled
- Email quota: 100 emails/day for free accounts

---

## 💡 Tips & Tricks

### 1. Real-time Collaboration:
Share the Google Sheet with your team for real-time updates.

### 2. Data Validation:
Add dropdowns in Google Sheet for consistency:
- Status: Active, Used, Cancelled
- Payment Method: bKash, Nagad, Card

### 3. Conditional Formatting:
Highlight rows based on status:
- Green = Active
- Red = Cancelled
- Blue = Used

### 4. Create Forms:
Use Google Forms for alternate registration method.

### 5. Notifications:
Set up Google Sheet notifications for new entries:
- Tools → Notification rules

---

## 📞 Support

### Common Questions:

**Q: Is this free?**
A: Yes! Google Sheets and Apps Script are completely free.

**Q: How many tickets can I store?**
A: Google Sheets supports up to 5 million cells. That's thousands of tickets!

**Q: Can I use this for paid events?**
A: Yes, but integrate actual payment gateways for real payments.

**Q: Is my data safe?**
A: Yes, it's stored in your private Google account with Google's security.

**Q: Can I customize the fields?**
A: Yes! Edit the Apps Script to add/remove fields.

---

## 🚀 Quick Reference

### Your URLs:
- **Google Sheet:** https://docs.google.com/spreadsheets/d/YOUR_ID
- **Apps Script:** https://script.google.com/home
- **Web App URL:** (Copy from deployment)

### Important Files:
- `google-sheets-script/Code.gs` - Apps Script code
- `assets/js/main-google-sheets.js` - Frontend integration
- `cybercon-new.html` - Main website

### Commands:
```javascript
// In main-google-sheets.js
GOOGLE_SHEETS_CONFIG.scriptUrl = 'YOUR_WEB_APP_URL';
```

---

## ✅ Setup Checklist

- [ ] Created Google Sheet
- [ ] Created Apps Script project
- [ ] Copied Code.gs content
- [ ] Updated SPREADSHEET_ID
- [ ] Deployed as Web App
- [ ] Authorized access
- [ ] Copied Web App URL
- [ ] Updated main-google-sheets.js
- [ ] Updated cybercon-new.html script reference
- [ ] Tested ticket creation
- [ ] Tested ticket verification
- [ ] Checked Google Sheet for data
- [ ] Ready to use! 🎉

---

**Made with ❤️ by Cyber Security Club, Uttara University**

Last Updated: January 2025
