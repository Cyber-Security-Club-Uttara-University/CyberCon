# Diagnose Google Sheets Data Storage Issue

$webAppUrl = "https://script.google.com/macros/s/AKfycbxnhTDa9eZ0ffAc8v62diHOWRihpGyhgeVF1Mrmo7i5SR04qF6VOk2FfCexh1hS5n5gFg/exec"
$sheetId = "1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU"
$sheetUrl = "https://docs.google.com/spreadsheets/d/$sheetId/edit"

Write-Host "`n╔════════════════════════════════════════════════════╗" -ForegroundColor Red
Write-Host "║  🚨 GOOGLE SHEETS DATA STORAGE DIAGNOSTIC 🚨    ║" -ForegroundColor Red
Write-Host "╚════════════════════════════════════════════════════╝`n" -ForegroundColor Red

# Step 1: Check if Sheet URL is accessible
Write-Host "Step 1: Checking Google Sheet Accessibility" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────`n" -ForegroundColor Gray

Write-Host "  Sheet ID: $sheetId" -ForegroundColor Gray
Write-Host "  Sheet URL: $sheetUrl`n" -ForegroundColor Gray

$openNow = Read-Host "  Open Google Sheet now to verify it exists? (Y/N)"
if ($openNow -eq "Y" -or $openNow -eq "y") {
    Start-Process $sheetUrl
    Write-Host "`n  ✓ Sheet opened in browser" -ForegroundColor Green
    Write-Host "`n  Please check:" -ForegroundColor Yellow
    Write-Host "  1. Does the sheet exist and open properly?" -ForegroundColor White
    Write-Host "  2. Do you have EDIT permissions?" -ForegroundColor White
    Write-Host "  3. Is there a 'Tickets' tab?" -ForegroundColor White
    Write-Host "  4. Are there any rows of data?`n" -ForegroundColor White
    
    $hasAccess = Read-Host "  Do you have EDIT access to this sheet? (Y/N)"
    
    if ($hasAccess -ne "Y" -and $hasAccess -ne "y") {
        Write-Host "`n  ❌ PROBLEM FOUND: No edit access to sheet!" -ForegroundColor Red
        Write-Host "  SOLUTION: Open the sheet and check sharing settings" -ForegroundColor Yellow
        Write-Host "  The Apps Script needs EDIT access to write data`n" -ForegroundColor Yellow
        exit
    }
}

# Step 2: Test if Apps Script can respond
Write-Host "`nStep 2: Testing Apps Script Connection" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────`n" -ForegroundColor Gray

try {
    Write-Host "  Testing GET request..." -ForegroundColor Gray
    $testResponse = Invoke-RestMethod -Uri "$webAppUrl`?action=verifyTicket&ticketId=TEST" -Method GET -ErrorAction Stop
    
    Write-Host "  ✓ Apps Script is responding!" -ForegroundColor Green
    Write-Host "  Response: $($testResponse | ConvertTo-Json -Compress)`n" -ForegroundColor DarkGray
    
} catch {
    Write-Host "  ❌ PROBLEM FOUND: Apps Script not responding!" -ForegroundColor Red
    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "`n  SOLUTION:" -ForegroundColor Yellow
    Write-Host "  1. Open Apps Script (Extensions → Apps Script from sheet)" -ForegroundColor White
    Write-Host "  2. Check if Code.gs is deployed as Web App" -ForegroundColor White
    Write-Host "  3. Deploy → Manage deployments → Check status`n" -ForegroundColor White
    exit
}

# Step 3: Test creating a ticket
Write-Host "Step 3: Testing Ticket Creation" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────`n" -ForegroundColor Gray

$randomNum = Get-Random -Maximum 9999
$testData = @{
    action = "createTicket"
    ticketType = "student"
    name = "DIAGNOSTIC TEST $randomNum"
    email = "diagnostic$randomNum@test.com"
    phone = "+8801712345678"
    organization = "Test Organization"
    tshirtSize = "L"
    paymentMethod = "bkash"
    amount = 500
    timestamp = (Get-Date).ToUniversalTime().ToString("o")
} | ConvertTo-Json

Write-Host "  Creating test ticket with name: DIAGNOSTIC TEST $randomNum" -ForegroundColor Cyan
Write-Host "  (This makes it easy to find in the sheet)`n" -ForegroundColor Gray

try {
    Write-Host "  Sending POST request..." -ForegroundColor Gray
    
    $response = Invoke-RestMethod -Uri $webAppUrl -Method POST -Body $testData -ContentType "application/json" -ErrorAction Stop
    
    Write-Host "  ✓ Request successful!" -ForegroundColor Green
    Write-Host "  Response: $($response | ConvertTo-Json)`n" -ForegroundColor DarkGray
    
    if ($response.success) {
        Write-Host "  ✅ TICKET CREATED!" -ForegroundColor Green
        Write-Host "  Ticket ID: $($response.ticketId)`n" -ForegroundColor Cyan
        
        Write-Host "  NOW CHECK YOUR GOOGLE SHEET:" -ForegroundColor Yellow
        Write-Host "  1. Look for the 'Tickets' tab" -ForegroundColor White
        Write-Host "  2. Find row with name: DIAGNOSTIC TEST $randomNum" -ForegroundColor White
        Write-Host "  3. Ticket ID should be: $($response.ticketId)`n" -ForegroundColor White
        
    } else {
        Write-Host "  ⚠️  Response indicates failure" -ForegroundColor Red
        Write-Host "  Message: $($response.message)`n" -ForegroundColor Red
    }
    
} catch {
    Write-Host "  ❌ PROBLEM: Request failed!" -ForegroundColor Red
    Write-Host "  Error: $($_.Exception.Message)`n" -ForegroundColor Red
}

# Step 4: Manual verification
Write-Host "Step 4: Manual Verification" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────`n" -ForegroundColor Gray

Write-Host "  Opening Google Sheet for manual check..." -ForegroundColor Gray
Start-Process $sheetUrl
Start-Sleep -Seconds 2

Write-Host "`n  Look for:" -ForegroundColor Yellow
Write-Host "  • Tab named 'Tickets'" -ForegroundColor White
Write-Host "  • Row with 'DIAGNOSTIC TEST $randomNum'" -ForegroundColor White
Write-Host "  • Check if data matches what we sent`n" -ForegroundColor White

$dataFound = Read-Host "  Did you find the test data in the sheet? (Y/N)"

if ($dataFound -eq "Y" -or $dataFound -eq "y") {
    Write-Host "`n  ✅ SUCCESS! Data is being stored!" -ForegroundColor Green
    Write-Host "  Your ticket system IS working!`n" -ForegroundColor Green
    
    Write-Host "  If you're not seeing data from the website:" -ForegroundColor Yellow
    Write-Host "  1. Clear browser cache (Ctrl+Shift+Delete)" -ForegroundColor White
    Write-Host "  2. Hard refresh the page (Ctrl+F5)" -ForegroundColor White
    Write-Host "  3. Check browser console for errors (F12)`n" -ForegroundColor White
    
} else {
    Write-Host "`n  ❌ PROBLEM FOUND: Data not appearing in sheet!" -ForegroundColor Red
    Write-Host "`n  Possible issues:" -ForegroundColor Yellow
    Write-Host "  1. Wrong Spreadsheet ID in Code.gs" -ForegroundColor White
    Write-Host "  2. Apps Script not authorized" -ForegroundColor White
    Write-Host "  3. Deployment using wrong Google account`n" -ForegroundColor White
    
    Write-Host "  CRITICAL CHECKS:" -ForegroundColor Red
    Write-Host "  ────────────────────────────────────────────────`n" -ForegroundColor Red
    
    Write-Host "  Check 1: Verify Spreadsheet ID" -ForegroundColor Yellow
    Write-Host "  Current ID in Code.gs: $sheetId" -ForegroundColor Gray
    Write-Host "  Sheet URL bar shows: [Check the /d/XXXXXXX/ part]`n" -ForegroundColor Gray
    
    Write-Host "  Check 2: Apps Script Authorization" -ForegroundColor Yellow
    Write-Host "  1. Open Apps Script editor" -ForegroundColor White
    Write-Host "  2. Run any function manually" -ForegroundColor White
    Write-Host "  3. Click 'Review permissions'" -ForegroundColor White
    Write-Host "  4. Authorize with YOUR Google account`n" -ForegroundColor White
    
    Write-Host "  Check 3: Deployment Settings" -ForegroundColor Yellow
    Write-Host "  1. Apps Script → Deploy → Manage deployments" -ForegroundColor White
    Write-Host "  2. Execute as: Should be YOUR email" -ForegroundColor White
    Write-Host "  3. Who has access: Should be 'Anyone'" -ForegroundColor White
    Write-Host "  4. If wrong, delete and create new deployment`n" -ForegroundColor White
}

# Step 5: Check Apps Script Execution Logs
Write-Host "`nStep 5: Check Apps Script Execution Logs" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────`n" -ForegroundColor Gray

Write-Host "  To see detailed logs:" -ForegroundColor Gray
Write-Host "  1. Open Apps Script editor (Extensions → Apps Script)" -ForegroundColor White
Write-Host "  2. Click 'Executions' (left sidebar, clock icon)" -ForegroundColor White
Write-Host "  3. Look for recent 'createTicket' executions" -ForegroundColor White
Write-Host "  4. Check if they succeeded or failed`n" -ForegroundColor White

$openAppsScript = Read-Host "  Open Apps Script to check execution logs? (Y/N)"
if ($openAppsScript -eq "Y" -or $openAppsScript -eq "y") {
    $appsScriptUrl = "https://script.google.com/home/projects/1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU/executions"
    Start-Process $appsScriptUrl
    Write-Host "  ✓ Apps Script opened`n" -ForegroundColor Green
}

# Summary
Write-Host "`n╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           DIAGNOSTIC SUMMARY                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

Write-Host "  Files to check:" -ForegroundColor Yellow
Write-Host "  • Google Sheet: $sheetUrl" -ForegroundColor White
Write-Host "  • Apps Script: Extensions → Apps Script (from sheet)" -ForegroundColor White
Write-Host "  • Execution Logs: View → Executions (in Apps Script)`n" -ForegroundColor White

Write-Host "  Common Solutions:" -ForegroundColor Yellow
Write-Host "  1. Redeploy Apps Script with correct settings" -ForegroundColor White
Write-Host "  2. Authorize the script with your Google account" -ForegroundColor White
Write-Host "  3. Verify Spreadsheet ID matches in Code.gs" -ForegroundColor White
Write-Host "  4. Check you have edit access to the sheet`n" -ForegroundColor White

Write-Host "  Need more help? Check:" -ForegroundColor Yellow
Write-Host "  • TROUBLESHOOTING.md" -ForegroundColor White
Write-Host "  • HOW_TO_TEST_CODE_GS.md" -ForegroundColor White
Write-Host "  • GOOGLE_SHEETS_SETUP.md`n" -ForegroundColor White

Write-Host "╚════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
