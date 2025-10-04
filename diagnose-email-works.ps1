# Critical Check: Why Email Works But No Data Saves

$sheetId = "1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU"
$sheetUrl = "https://docs.google.com/spreadsheets/d/$sheetId/edit"

Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Red
Write-Host "║  🚨 CRITICAL: Email Works But No Data Saves! 🚨   ║" -ForegroundColor Red
Write-Host "╚══════════════════════════════════════════════════════╝`n" -ForegroundColor Red

Write-Host "This is a VERY specific issue. Let's diagnose:`n" -ForegroundColor Yellow

# Open the sheet for manual inspection
Write-Host "Step 1: Manual Sheet Inspection" -ForegroundColor Cyan
Write-Host "────────────────────────────────────────────────────────`n" -ForegroundColor Gray

Write-Host "  Opening your Google Sheet..." -ForegroundColor Gray
Start-Process $sheetUrl
Start-Sleep -Seconds 3

Write-Host "`n  ❓ CRITICAL QUESTIONS:" -ForegroundColor Yellow
Write-Host "  ══════════════════════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "  Question 1: Do you see a tab named 'Tickets'?" -ForegroundColor White
Write-Host "  (Look at the bottom of the sheet for tabs)`n" -ForegroundColor Gray
$hasTab = Read-Host "  Answer (Y/N)"

if ($hasTab -ne "Y" -and $hasTab -ne "y") {
    Write-Host "`n  ❌ PROBLEM FOUND: No 'Tickets' tab!" -ForegroundColor Red
    Write-Host "  ══════════════════════════════════════════════════════`n" -ForegroundColor Red
    
    Write-Host "  This is THE issue! The Apps Script tries to:" -ForegroundColor Yellow
    Write-Host "  1. Open the sheet by ID ✓" -ForegroundColor Green
    Write-Host "  2. Find tab named 'Tickets' ✗ (doesn't exist!)" -ForegroundColor Red
    Write-Host "  3. Create it if missing... BUT there's a problem!`n" -ForegroundColor Yellow
    
    Write-Host "  🔧 SOLUTION:" -ForegroundColor Cyan
    Write-Host "  ──────────────────────────────────────────────────────`n" -ForegroundColor Gray
    
    Write-Host "  Option A - Manual Fix (FASTEST):" -ForegroundColor Green
    Write-Host "  1. In your Google Sheet, click the + at bottom left" -ForegroundColor White
    Write-Host "  2. Rename the new tab to exactly: Tickets" -ForegroundColor White
    Write-Host "  3. Add these headers in Row 1:" -ForegroundColor White
    Write-Host "     Ticket ID | Timestamp | Name | Email | Phone | Organization" -ForegroundColor Gray
    Write-Host "     Ticket Type | T-Shirt Size | Payment Method | Amount | Status | Check-in Time`n" -ForegroundColor Gray
    
    Write-Host "  Option B - Let Script Create It:" -ForegroundColor Green
    Write-Host "  The script should auto-create it, but if emails work and" -ForegroundColor White
    Write-Host "  the tab doesn't exist, it means the script is hitting an" -ForegroundColor White
    Write-Host "  error BEFORE appendRow() but AFTER the if(!sheet) check.`n" -ForegroundColor White
    
    exit
}

Write-Host "`n  Question 2: Does the 'Tickets' tab have headers?" -ForegroundColor White
Write-Host "  (Row 1 should have: Ticket ID, Timestamp, Name, etc.)`n" -ForegroundColor Gray
$hasHeaders = Read-Host "  Answer (Y/N)"

if ($hasHeaders -ne "Y" -and $hasHeaders -ne "y") {
    Write-Host "`n  ⚠️  Tab exists but no headers!" -ForegroundColor Yellow
    Write-Host "  This means the sheet creation logic ran but appendRow failed.`n" -ForegroundColor Yellow
    
    Write-Host "  🔧 Quick Fix:" -ForegroundColor Cyan
    Write-Host "  Add these headers manually in Row 1:" -ForegroundColor White
    Write-Host "  Ticket ID | Timestamp | Name | Email | Phone | Organization" -ForegroundColor Gray
    Write-Host "  Ticket Type | T-Shirt Size | Payment Method | Amount | Status | Check-in Time`n" -ForegroundColor Gray
}

Write-Host "`n  Question 3: Are there ANY rows of data (besides headers)?" -ForegroundColor White
$hasData = Read-Host "  Answer (Y/N)"

if ($hasData -eq "Y" -or $hasData -eq "y") {
    Write-Host "`n  ✅ DATA EXISTS!" -ForegroundColor Green
    Write-Host "  If you're seeing data but think it's 'not saving':" -ForegroundColor Yellow
    Write-Host "  • The page might need refreshing (F5)" -ForegroundColor White
    Write-Host "  • Data might be in a different sheet/tab" -ForegroundColor White
    Write-Host "  • You might be looking at wrong Google account`n" -ForegroundColor White
    exit
}

Write-Host "`n  Question 4: Check the Sheet ID in the URL" -ForegroundColor White
Write-Host "  Your URL should look like:" -ForegroundColor Gray
Write-Host "  https://docs.google.com/spreadsheets/d/1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU/edit" -ForegroundColor Gray
Write-Host "`n  Does the ID match exactly?" -ForegroundColor White
$idMatches = Read-Host "  Answer (Y/N)"

if ($idMatches -ne "Y" -and $idMatches -ne "y") {
    Write-Host "`n  ❌ CRITICAL ERROR: Wrong Sheet ID!" -ForegroundColor Red
    Write-Host "  ══════════════════════════════════════════════════════`n" -ForegroundColor Red
    
    Write-Host "  The Apps Script is writing to a DIFFERENT sheet!" -ForegroundColor Yellow
    Write-Host "  Data IS being saved, just in the wrong place!`n" -ForegroundColor Yellow
    
    Write-Host "  🔧 SOLUTION:" -ForegroundColor Cyan
    Write-Host "  1. Copy the ACTUAL Sheet ID from your browser URL" -ForegroundColor White
    Write-Host "  2. Update Code.gs line 5 with correct ID" -ForegroundColor White
    Write-Host "  3. Redeploy the Apps Script`n" -ForegroundColor White
    exit
}

# If we got here, the issue is more complex
Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║           ADVANCED DIAGNOSTICS NEEDED              ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta

Write-Host "  Since:" -ForegroundColor Yellow
Write-Host "  ✓ Tickets tab exists" -ForegroundColor Green
Write-Host "  ✓ Headers are there" -ForegroundColor Green
Write-Host "  ✓ Sheet ID is correct" -ForegroundColor Green
Write-Host "  ✓ Email works (so script executes)" -ForegroundColor Green
Write-Host "  ✗ But NO data rows appear`n" -ForegroundColor Red

Write-Host "  This points to a TIMING or PERMISSION issue.`n" -ForegroundColor Yellow

Write-Host "  Let's check Apps Script execution logs..." -ForegroundColor Cyan

$openLogs = Read-Host "`n  Open Apps Script execution logs? (Y/N)"

if ($openLogs -eq "Y" -or $openLogs -eq "y") {
    # Try to open Apps Script editor
    Write-Host "`n  Opening Apps Script..." -ForegroundColor Gray
    Start-Process "https://script.google.com/home"
    
    Write-Host "`n  📋 IN APPS SCRIPT:" -ForegroundColor Yellow
    Write-Host "  1. Find your 'CyberCon 2025' project" -ForegroundColor White
    Write-Host "  2. Click on it" -ForegroundColor White
    Write-Host "  3. Click 'Executions' (⏱️ clock icon on left sidebar)" -ForegroundColor White
    Write-Host "  4. Look for recent executions" -ForegroundColor White
    Write-Host "  5. Check the logs for 'Ticket added to sheet successfully'`n" -ForegroundColor White
    
    Write-Host "  What do you see in the logs?" -ForegroundColor Yellow
    Write-Host "  A) 'Ticket added to sheet successfully' appears" -ForegroundColor White
    Write-Host "  B) Error before that message" -ForegroundColor White
    Write-Host "  C) No execution logs at all" -ForegroundColor White
    Write-Host "  D) Logs show email sent but not 'Ticket added'`n" -ForegroundColor White
    
    $logResult = Read-Host "  Answer (A/B/C/D)"
    
    switch ($logResult.ToUpper()) {
        "A" {
            Write-Host "`n  🤔 VERY STRANGE!" -ForegroundColor Yellow
            Write-Host "  Logs say 'Ticket added' but you don't see it in sheet..." -ForegroundColor White
            Write-Host "`n  Possible causes:" -ForegroundColor Yellow
            Write-Host "  1. Writing to wrong sheet (check SPREADSHEET_ID)" -ForegroundColor White
            Write-Host "  2. Data in different tab" -ForegroundColor White
            Write-Host "  3. Sheet not refreshing (hard refresh: Ctrl+Shift+R)" -ForegroundColor White
            Write-Host "  4. appendRow() silently failing (permission issue)`n" -ForegroundColor White
        }
        "B" {
            Write-Host "`n  ❌ Error Found!" -ForegroundColor Red
            Write-Host "  The error happens BEFORE data is saved." -ForegroundColor White
            Write-Host "  But email still sends somehow...`n" -ForegroundColor Yellow
            
            Write-Host "  This means your current deployed code might be OLD." -ForegroundColor Yellow
            Write-Host "  Did you redeploy after making changes?`n" -ForegroundColor White
        }
        "C" {
            Write-Host "`n  ❌ No executions!" -ForegroundColor Red
            Write-Host "  This means the Apps Script isn't being called at all." -ForegroundColor White
            Write-Host "  But you said email works... are you sure?`n" -ForegroundColor Yellow
        }
        "D" {
            Write-Host "`n  🎯 FOUND IT!" -ForegroundColor Green
            Write-Host "  The email sends but 'Ticket added' log is missing!" -ForegroundColor White
            Write-Host "`n  This means:" -ForegroundColor Yellow
            Write-Host "  • Email function runs BEFORE appendRow()" -ForegroundColor White
            Write-Host "  • OR there's an error in appendRow() that's caught`n" -ForegroundColor White
            
            Write-Host "  🔧 SOLUTION:" -ForegroundColor Cyan
            Write-Host "  The code needs to be reordered or fixed." -ForegroundColor White
            Write-Host "  Let me check the Code.gs file order...`n" -ForegroundColor White
        }
    }
}

Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              MANUAL VERIFICATION TEST              ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

Write-Host "  Let's add a row MANUALLY to test permissions:" -ForegroundColor Yellow
Write-Host "`n  In your Google Sheet 'Tickets' tab:" -ForegroundColor White
Write-Host "  1. Click on Row 2 (first data row)" -ForegroundColor White
Write-Host "  2. Type: TEST-123 in cell A2" -ForegroundColor White
Write-Host "  3. Add today's date in B2" -ForegroundColor White
Write-Host "  4. Add some text in C2 (name column)" -ForegroundColor White
Write-Host "  5. Press Enter`n" -ForegroundColor White

$canEdit = Read-Host "  Were you able to add data manually? (Y/N)"

if ($canEdit -ne "Y" -and $canEdit -ne "y") {
    Write-Host "`n  ❌ PERMISSION ISSUE!" -ForegroundColor Red
    Write-Host "  You don't have edit access to the sheet!" -ForegroundColor White
    Write-Host "`n  The Apps Script can't write either!`n" -ForegroundColor Yellow
    
    Write-Host "  🔧 SOLUTION:" -ForegroundColor Cyan
    Write-Host "  Check sheet permissions: File → Share → Advanced" -ForegroundColor White
    Write-Host "  You need to be the OWNER or have EDIT access`n" -ForegroundColor White
} else {
    Write-Host "`n  ✓ You CAN edit the sheet manually" -ForegroundColor Green
    Write-Host "  So permissions are fine.`n" -ForegroundColor White
}

Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                  FINAL RECOMMENDATION              ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════╝`n" -ForegroundColor Green

Write-Host "  Based on the symptoms (email works, no data):" -ForegroundColor Yellow
Write-Host "`n  Most Likely Issue:" -ForegroundColor Cyan
Write-Host "  • Code.gs in editor is UPDATED" -ForegroundColor White
Write-Host "  • But DEPLOYED version is OLD (has bugs)" -ForegroundColor White
Write-Host "  • Old version sends email but crashes on appendRow()`n" -ForegroundColor White

Write-Host "  🔧 SOLUTION:" -ForegroundColor Green
Write-Host "  1. Open Apps Script editor" -ForegroundColor White
Write-Host "  2. Copy the LATEST Code.gs from your project folder" -ForegroundColor White
Write-Host "  3. Paste it in editor" -ForegroundColor White
Write-Host "  4. Save (Ctrl+S)" -ForegroundColor White
Write-Host "  5. Deploy → Manage deployments → Edit" -ForegroundColor White
Write-Host "  6. Change to 'New version'" -ForegroundColor White
Write-Host "  7. Click Deploy" -ForegroundColor White
Write-Host "  8. Test again!`n" -ForegroundColor White

Write-Host "═══════════════════════════════════════════════════════`n" -ForegroundColor Green
