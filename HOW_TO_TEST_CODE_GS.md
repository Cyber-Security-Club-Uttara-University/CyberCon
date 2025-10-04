# How to Test Google Apps Script (Code.gs)

## 🧪 Complete Testing Guide

---

## Method 1: Test Directly in Apps Script Editor (Recommended)

### Step 1: Open Apps Script
1. Open your Google Sheet: "CyberCon 2025 Tickets"
2. Click **Extensions** → **Apps Script**

### Step 2: Test Individual Functions

#### Test Ticket Creation
1. In Apps Script editor, add this test function at the bottom:

```javascript
// Test function for ticket creation
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
  Logger.log('Result: ' + result.getContent());
}
```

2. Click **Run** → Select `testCreateTicket`
3. **First time:** Click "Review permissions" → Choose your account → Allow
4. Check **Execution log** (View → Executions)
5. Check your **Google Sheet** for new ticket entry

#### Test Ticket Verification
```javascript
// Test function for ticket verification
function testVerifyTicket() {
  // Replace with an actual ticket ID from your sheet
  const ticketId = 'CC2025-123456';
  
  const result = verifyTicket(ticketId);
  Logger.log('Verification Result: ' + result.getContent());
}
```

#### Test Get Stats
```javascript
// Test function for statistics
function testGetStats() {
  const stats = getStats();
  Logger.log('Statistics: ' + JSON.stringify(stats));
}
```

### Step 3: View Results
- Click **View** → **Logs** (or press `Ctrl+Enter`)
- See execution results in the logs

---

## Method 2: Test the Web App URL

### Step 1: Get Your Web App URL
1. In Apps Script: **Deploy** → **Manage deployments**
2. Copy the **Web app URL**
3. Should look like: `https://script.google.com/macros/s/AKfycbxxx.../exec`

### Step 2: Test in Browser

#### Test Health Check (GET request)
Paste in browser:
```
YOUR_WEB_APP_URL?action=verifyTicket&ticketId=CC2025-123456
```

Example:
```
https://script.google.com/macros/s/AKfycbzDN9keQYHGDsFaY82VNKMJjE1Cu_6r6E7LhOdjP-lO/exec?action=verifyTicket&ticketId=CC2025-123456
```

**Expected:** JSON response with ticket data or "Ticket not found"

### Step 3: Test with PowerShell

#### Test Ticket Creation (POST)
```powershell
$webAppUrl = "YOUR_WEB_APP_URL_HERE"

$body = @{
    action = "createTicket"
    ticketType = "student"
    name = "Test User"
    email = "test@example.com"
    phone = "+8801712345678"
    organization = "Test University"
    tshirtSize = "L"
    paymentMethod = "bkash"
    amount = 500
    timestamp = (Get-Date).ToUniversalTime().ToString("o")
} | ConvertTo-Json

Invoke-RestMethod -Uri $webAppUrl -Method POST -Body $body -ContentType "application/json"
```

#### Test Ticket Verification (GET)
```powershell
$webAppUrl = "YOUR_WEB_APP_URL_HERE"
$ticketId = "CC2025-123456"

Invoke-RestMethod -Uri "$webAppUrl?action=verifyTicket&ticketId=$ticketId"
```

---

## Method 3: Test from Your Website

### Step 1: Update Configuration
Make sure `assets/js/main.js` has the correct URL:
```javascript
scriptUrl: 'https://script.google.com/macros/s/AKfycbzDN9keQYHGDsFaY82VNKMJjE1Cu_6r6E7LhOdjP-lO/exec',
```

### Step 2: Open Website
1. Open `cybercon-new.html` in browser
2. Open browser console (F12)

### Step 3: Test Ticket Creation
1. Click "Get Ticket" on any ticket type
2. Fill out the form with test data:
   - Name: Test User
   - Email: test@example.com
   - Phone: +8801712345678
   - Organization: Test Org
3. Submit the form
4. Check browser console for errors
5. Check Google Sheet for new entry

### Step 4: Test Ticket Verification
1. Go to "Verify Ticket" section
2. Enter a ticket ID from Google Sheet
3. Click "Verify Ticket"
4. Should show ticket details

---

## Method 4: Check Apps Script Execution Logs

### View Execution History
1. In Apps Script: **View** → **Executions**
2. See all function executions
3. Click any execution to see:
   - Status (Success/Error)
   - Execution time
   - Logs
   - Error messages (if any)

### Filter Logs
- Filter by status: Success, Failed
- Filter by function name
- Filter by date range

---

## 🔍 Debugging Tips

### Check if Script is Deployed
1. Apps Script → **Deploy** → **Manage deployments**
2. Should see active deployment
3. Status should be "Active"

### Common Issues & Fixes

#### Issue 1: "Script function not found"
**Solution:**
- Make sure you saved the script (Ctrl+S)
- Redeploy: Deploy → New deployment

#### Issue 2: "Authorization required"
**Solution:**
- Run test function in editor
- Click "Review permissions"
- Authorize the script

#### Issue 3: "SPREADSHEET_ID not found"
**Solution:**
1. Get your Sheet ID from URL:
   ```
   https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit
   ```
2. Update line 5 in Code.gs:
   ```javascript
   const SPREADSHEET_ID = 'YOUR_ACTUAL_SHEET_ID';
   ```

#### Issue 4: "Ticket not appearing in sheet"
**Solution:**
- Check Execution logs for errors
- Verify SPREADSHEET_ID is correct
- Check sheet name matches (should be "Tickets")

#### Issue 5: "CORS error" in browser
**Solution:**
- This is normal with `mode: 'no-cors'`
- Data still saves, just can't read response
- Check Google Sheet to verify

---

## ✅ Verification Checklist

Test each feature:

- [ ] Create ticket via Apps Script test function
- [ ] Check ticket appears in Google Sheet
- [ ] Verify ticket ID is generated (CC2025-XXXXXX)
- [ ] Test verification with GET request
- [ ] Test from website form
- [ ] Check email notification sent
- [ ] Verify newsletter subscription works
- [ ] Test with different ticket types
- [ ] Check stats function

---

## 📊 Expected Results

### Successful Ticket Creation:
```json
{
  "success": true,
  "ticketId": "CC2025-456789",
  "message": "Ticket created successfully"
}
```

### Successful Verification:
```json
{
  "success": true,
  "ticket": {
    "ticketId": "CC2025-456789",
    "name": "Test User",
    "email": "test@example.com",
    "ticketType": "student",
    "status": "Active",
    ...
  }
}
```

### Failed Verification:
```json
{
  "success": false,
  "message": "Ticket not found"
}
```

---

## 🎯 Quick Test Script

Save this as `test-apps-script.ps1`:

```powershell
# Quick test script for Google Apps Script
$webAppUrl = "https://script.google.com/macros/s/AKfycbzDN9keQYHGDsFaY82VNKMJjE1Cu_6r6E7LhOdjP-lO/exec"

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "   Testing Google Apps Script" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

# Test 1: Create Ticket
Write-Host "Test 1: Creating ticket..." -ForegroundColor Yellow

$body = @{
    action = "createTicket"
    ticketType = "student"
    name = "Test User $(Get-Random)"
    email = "test$(Get-Random)@example.com"
    phone = "+8801712345678"
    organization = "Test University"
    tshirtSize = "L"
    paymentMethod = "bkash"
    amount = 500
    timestamp = (Get-Date).ToUniversalTime().ToString("o")
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $webAppUrl -Method POST -Body $body -ContentType "application/json" -ErrorAction Stop
    Write-Host "✅ Ticket created successfully!" -ForegroundColor Green
    Write-Host ($response | ConvertTo-Json -Depth 3)
} catch {
    Write-Host "❌ Error creating ticket: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "   ✅ Test Complete!" -ForegroundColor Green
Write-Host "   Check your Google Sheet for data" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan
```

Run with:
```powershell
.\test-apps-script.ps1
```

---

## 📧 Email Testing

### Check Email Logs
1. Apps Script → **View** → **Executions**
2. Look for `sendTicketEmail` function
3. Check if it executed successfully

### Email Quota
- **Free Gmail:** 100 emails/day
- Check quota: Apps Script → **View** → **Executions**

### Test Email Function
```javascript
function testEmail() {
  sendTicketEmail(
    'your-email@gmail.com',
    'Test User',
    'CC2025-123456',
    'student',
    500
  );
  Logger.log('Email sent!');
}
```

---

## 🎉 Success Indicators

You'll know it's working when:

1. ✅ **Google Sheet** shows new ticket row
2. ✅ **Email** arrives with ticket details
3. ✅ **Verification** returns ticket data
4. ✅ **Browser console** shows no errors
5. ✅ **Execution logs** show success

---

## 🆘 Need Help?

### Check These:
1. Apps Script execution logs
2. Browser console (F12)
3. Google Sheet for data
4. Email inbox/spam

### Still Not Working?
- Redeploy the Apps Script
- Clear browser cache
- Check SPREADSHEET_ID
- Verify deployment settings

---

**Good luck testing! 🚀**
