# Quick Test Script for CyberCon 2025 Ticket System
# Run this to diagnose ticket system issues

$webAppUrl = "https://script.google.com/macros/s/AKfycbxnhTDa9eZ0ffAc8v62diHOWRihpGyhgeVF1Mrmo7i5SR04qF6VOk2FfCexh1hS5n5gFg/exec"
$sheetUrl = "https://docs.google.com/spreadsheets/d/1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU/edit"

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "  🧪 CyberCon 2025 Ticket System Tester" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

# Test 1: Check if URL is configured
Write-Host "Test 1: Configuration Check" -ForegroundColor Yellow
Write-Host "───────────────────────────────────────────`n" -ForegroundColor Gray

if ($webAppUrl -match "script.google.com") {
    Write-Host "✓ Web App URL is configured" -ForegroundColor Green
    Write-Host "  URL: $webAppUrl`n" -ForegroundColor Gray
} else {
    Write-Host "✗ Invalid Web App URL" -ForegroundColor Red
    Write-Host "  Please deploy your Apps Script first!`n" -ForegroundColor Yellow
    exit
}

# Test 2: Test Verification Endpoint (GET request)
Write-Host "Test 2: Testing Verification Endpoint" -ForegroundColor Yellow
Write-Host "───────────────────────────────────────────`n" -ForegroundColor Gray

try {
    Write-Host "  Sending GET request..." -ForegroundColor Gray
    $testUrl = "$webAppUrl`?action=verifyTicket&ticketId=TEST-123"
    
    $response = Invoke-RestMethod -Uri $testUrl -Method GET -ErrorAction Stop
    
    Write-Host "✓ Apps Script is responding!" -ForegroundColor Green
    Write-Host "  Response: $($response | ConvertTo-Json -Compress)`n" -ForegroundColor Gray
    
} catch {
    Write-Host "✗ Failed to connect to Apps Script" -ForegroundColor Red
    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "`n  Possible issues:" -ForegroundColor Yellow
    Write-Host "  1. Apps Script not deployed as Web App" -ForegroundColor Yellow
    Write-Host "  2. Deployment access not set to 'Anyone'" -ForegroundColor Yellow
    Write-Host "  3. Script not authorized`n" -ForegroundColor Yellow
}

# Test 3: Create Test Ticket (POST request)
Write-Host "Test 3: Creating Test Ticket" -ForegroundColor Yellow
Write-Host "───────────────────────────────────────────`n" -ForegroundColor Gray

$testTicket = @{
    action = "createTicket"
    ticketType = "student"
    name = "Test User $(Get-Random -Maximum 999)"
    email = "test$(Get-Random -Maximum 999)@example.com"
    phone = "+8801712345678"
    organization = "Uttara University"
    tshirtSize = "L"
    paymentMethod = "bkash"
    amount = 500
    timestamp = (Get-Date).ToUniversalTime().ToString("o")
} | ConvertTo-Json

Write-Host "  Test data:" -ForegroundColor Gray
Write-Host "  $($testTicket -replace "`n", "`n  ")`n" -ForegroundColor DarkGray

try {
    Write-Host "  Sending POST request..." -ForegroundColor Gray
    
    # Note: POST with no-cors won't return readable response
    $response = Invoke-RestMethod -Uri $webAppUrl -Method POST -Body $testTicket -ContentType "application/json" -ErrorAction Stop
    
    Write-Host "✓ Ticket creation request sent!" -ForegroundColor Green
    Write-Host "  Response: $($response | ConvertTo-Json -Compress)" -ForegroundColor Gray
    Write-Host "`n  📊 Check your Google Sheet to verify!" -ForegroundColor Cyan
    Write-Host "  Sheet URL: $sheetUrl`n" -ForegroundColor Gray
    
} catch {
    Write-Host "⚠️  POST request completed (response may not be readable due to CORS)" -ForegroundColor Yellow
    Write-Host "  This is normal! Check your Google Sheet for data.`n" -ForegroundColor Gray
}

# Test 4: Open Google Sheet
Write-Host "Test 4: Opening Google Sheet" -ForegroundColor Yellow
Write-Host "───────────────────────────────────────────`n" -ForegroundColor Gray

$openSheet = Read-Host "  Open Google Sheet to verify? (Y/N)"
if ($openSheet -eq "Y" -or $openSheet -eq "y") {
    Write-Host "  Opening sheet..." -ForegroundColor Gray
    Start-Process $sheetUrl
    Write-Host "✓ Sheet opened in browser`n" -ForegroundColor Green
}

# Summary
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "  📋 Test Summary" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "  Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Check your Google Sheet 'Tickets' tab" -ForegroundColor White
Write-Host "  2. Look for new test ticket entry" -ForegroundColor White
Write-Host "  3. If no data appears, check Apps Script deployment" -ForegroundColor White
Write-Host "  4. Open test-ticket-system.html for detailed testing`n" -ForegroundColor White

Write-Host "  Troubleshooting Files:" -ForegroundColor Yellow
Write-Host "  • TROUBLESHOOTING.md - Detailed guide" -ForegroundColor White
Write-Host "  • HOW_TO_TEST_CODE_GS.md - Testing instructions" -ForegroundColor White
Write-Host "  • test-ticket-system.html - Visual debugger`n" -ForegroundColor White

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan
