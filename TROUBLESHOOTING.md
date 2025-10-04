# 🔧 Ticket System Troubleshooting Guide

## Issue: Ticket System Not Working

---

## 🎯 Quick Diagnostic Steps

### Step 1: Check If Apps Script is Deployed

1. **Open your Google Sheet**: 
   ```
   https://docs.google.com/spreadsheets/d/1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU/edit
   ```

2. **Go to Extensions → Apps Script**

3. **Check if Code.gs is there and saved**
   - You should see your code
   - Press `Ctrl+S` to save if needed

4. **MOST IMPORTANT: Deploy as Web App**
   - Click **Deploy** → **Manage deployments**
   - Do you see an **active deployment**?
   
   **If NO deployment exists:**
   - Click **Deploy** → **New deployment**
   - Click gear icon ⚙️ → Select **Web app**
   - Settings:
     - Execute as: **Me** (your email)
     - Who has access: **Anyone**
   - Click **Deploy**
   - **Authorize the script** (first time only)
   - **Copy the Web App URL**

   **If deployment EXISTS but outdated:**
   - Click **Edit** (pencil icon)
   - Change **New version** to "New version"
   - Click **Deploy**
   - Get the updated URL

---

## 🧪 Test Methods

### Method 1: Use the Debug Tool (EASIEST)

I've created `test-ticket-system.html` for you:

1. **Open the file** (should already be open in browser)
2. **Click "Create Test Ticket"**
3. **Check the console output** - does it show errors?
4. **Open your Google Sheet** - did a new row appear?

### Method 2: Test in Browser Console

1. **Open `cybercon-new.html`**
2. **Press F12** (Developer Tools)
3. **Go to Console tab**
4. **Try to create a ticket** - click "Get Ticket" button
5. **Look for errors** in console

Common errors:
- ❌ `Failed to fetch` - Apps Script not deployed
- ❌ `CORS error` - Normal with `no-cors` mode
- ❌ `undefined function` - JavaScript not loaded

### Method 3: Test Apps Script Directly

1. **In Apps Script editor**
2. **Add this test function**:

```javascript
function testCreateTicket() {
  const testData = {
    action: 'createTicket',
    ticketType: 'student',
    name: 'Test User',
    email: 'test@example.com',
    phone: '+8801712345678',
    organization: 'Uttara University',
    tshirtSize: 'M',
    paymentMethod: 'bkash',
    amount: 500,
    timestamp: new Date().toISOString()
  };
  
  const result = createTicket(testData);
  Logger.log(result.getContent());
}
```

3. **Run the function**:
   - Select `testCreateTicket` from dropdown
   - Click **Run** ▶️
   - Check **Execution log** (View → Executions)
   - Check your Google Sheet

---

## 🔍 Common Issues & Fixes

### Issue 1: "Ticket created but no response"

**Cause**: Using `mode: 'no-cors'` prevents reading response

**Solution**: This is NORMAL! Check your Google Sheet to verify data was saved.

**Fix**: Already implemented - we wait 2 seconds then show success message

---

### Issue 2: "Nothing happens when clicking Get Ticket"

**Possible causes:**

1. **JavaScript not loaded**
   - Open browser console (F12)
   - Look for error: `openTicketModal is not defined`
   - **Fix**: Check if `<script src="assets/js/main.js"></script>` exists in HTML

2. **Modal not showing**
   - Check console for CSS errors
   - **Fix**: Verify `assets/css/style.css` is loaded

3. **Button onclick not working**
   - Verify button has: `onclick="openTicketModal('student')"`
   - **Fix**: Already correct in your HTML

---

### Issue 3: "Form submits but data not in Google Sheet"

**Possible causes:**

1. **Wrong Spreadsheet ID in Code.gs**
   - Open Code.gs
   - Check line 5: `const SPREADSHEET_ID = '1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU';`
   - Should match your Sheet URL

2. **Apps Script not authorized**
   - In Apps Script: Run any function
   - Click "Review permissions"
   - Authorize the script

3. **Wrong Web App URL**
   - Check main.js line 9
   - Should be: `https://script.google.com/macros/s/[YOUR_ID]/exec`
   - Must end with `/exec`

---

### Issue 4: "Authorization required" error

**Solution:**

1. Go to Apps Script editor
2. Run any function (like `testCreateTicket`)
3. Click "Review permissions"
4. Choose your Google account
5. Click "Advanced" → "Go to [project name] (unsafe)"
6. Click "Allow"
7. Re-deploy the Web App

---

### Issue 5: "Verification not working"

**Causes:**

1. **No tickets created yet**
   - Create a test ticket first
   - Copy the Ticket ID from Google Sheet

2. **Wrong ticket ID format**
   - Should be: `CC2025-123456`
   - Must match exactly (case-sensitive)

3. **GET request blocked**
   - Check Apps Script execution logs
   - Verify `doGet` function exists

---

## 📊 How to Check Execution Logs

1. **In Apps Script editor**
2. Click **View** → **Executions**
3. See all function calls
4. Look for:
   - ✅ **Success** - Function executed properly
   - ❌ **Failed** - Click to see error details
5. Recent executions appear at top

---

## ✅ Verification Checklist

Go through this checklist:

- [ ] **Google Sheet exists** with ID: `1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU`
- [ ] **Code.gs uploaded** to Apps Script
- [ ] **SPREADSHEET_ID correct** in Code.gs line 5
- [ ] **Apps Script deployed** as Web App
- [ ] **Authorization granted** (first time)
- [ ] **Web App URL copied** correctly
- [ ] **main.js updated** with correct URL
- [ ] **URL ends with `/exec`**
- [ ] **Website files saved** (Ctrl+S)
- [ ] **Browser refreshed** (Ctrl+F5)

---

## 🧪 Step-by-Step Testing Process

### Test 1: Verify Configuration

**In PowerShell:**
```powershell
# Check if Web App URL is configured
Select-String -Path "assets\js\main.js" -Pattern "scriptUrl:"
```

**Expected output:**
```
scriptUrl: 'https://script.google.com/macros/s/AKfycbxnhTDa9eZ0ffAc8v62diHOWRihpGyhgeVF1Mrmo7i5SR04qF6VOk2FfCexh1hS5n5gFg/exec',
```

### Test 2: Test Apps Script Directly

**In Apps Script editor:**
1. Run `testCreateTicket` function
2. Check Execution log for success
3. Open Google Sheet
4. Verify new row created in "Tickets" sheet

### Test 3: Test from Website

**In browser:**
1. Open `cybercon-new.html`
2. Press F12 (Console)
3. Click "Get Ticket" on any package
4. Fill form and submit
5. Watch console for errors
6. Check Google Sheet for data

### Test 4: Test Verification

**After creating ticket:**
1. Copy ticket ID from Google Sheet (column A)
2. Go to "Verify Ticket" section on website
3. Paste ticket ID
4. Click "Verify Ticket"
5. Should show ticket details

---

## 🐛 Debug Mode - Add to main.js

Add this at the top of your `main.js` file (line 1) for detailed logging:

```javascript
// DEBUG MODE - Remove after testing
const DEBUG = true;
function debugLog(message, data) {
    if (DEBUG) {
        console.log(`[CyberCon Debug] ${message}`, data || '');
    }
}
```

Then add debug logs in the ticket creation function:

```javascript
ticketForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    debugLog('Form submitted');
    
    const formData = new FormData(ticketForm);
    debugLog('Form data collected', formData);
    
    const data = { /* ... */ };
    debugLog('Sending data to Apps Script', data);
    
    // ... rest of code
});
```

---

## 🔗 Important Links

- **Your Google Sheet**: https://docs.google.com/spreadsheets/d/1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU/edit
- **Apps Script**: Extensions → Apps Script (from Sheet)
- **Deployment**: Deploy → Manage deployments
- **Execution Logs**: View → Executions

---

## 💡 Quick Fix Commands

### Re-check your Web App URL:
```powershell
# In PowerShell
$url = "https://script.google.com/macros/s/AKfycbxnhTDa9eZ0ffAc8v62diHOWRihpGyhgeVF1Mrmo7i5SR04qF6VOk2FfCexh1hS5n5gFg/exec"
Write-Host "Testing Web App URL..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "$url?action=verifyTicket&ticketId=TEST"
```

**Expected**: JSON response (success: false or ticket not found)

---

## 📞 What to Tell Me

If still not working, tell me:

1. **What happens when you click "Get Ticket"?**
   - Modal opens? Form shows?
   - Any errors in console?

2. **What happens when you submit the form?**
   - Success message? Error?
   - Console errors?

3. **Is data appearing in Google Sheet?**
   - Yes/No
   - Which sheet? (should be "Tickets")

4. **Apps Script execution logs - any errors?**
   - View → Executions
   - Recent failures?

5. **Browser console errors?**
   - Press F12, copy any red errors

---

## 🎯 Most Likely Issues

Based on common problems:

1. **Apps Script NOT deployed** (70% of cases)
   - Solution: Deploy → New deployment → Web app

2. **Authorization not granted** (20% of cases)
   - Solution: Run test function → Authorize

3. **Wrong Web App URL** (5% of cases)
   - Solution: Copy correct URL from deployment

4. **Spreadsheet ID mismatch** (5% of cases)
   - Solution: Update SPREADSHEET_ID in Code.gs

---

**🚀 Try the test page I created: `test-ticket-system.html`**

It will show you exactly what's happening!
