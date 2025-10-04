// Google Apps Script for CyberCon 2025 Ticket System
// Deploy this as a Web App in Google Apps Script

// Configuration
const SPREADSHEET_ID = '1r58LMmLIOfKJ_Psz5xhKNOD7G_W5XGeha-LEV2SV7vU'; // Your Google Sheet ID
const SHEET_NAME_TICKETS = 'Tickets';
const SHEET_NAME_NEWSLETTER = 'Newsletter';

// Main function to handle requests
function doGet(e) {
  try {
    const action = e.parameter.action;
    const ticketId = e.parameter.ticketId;
    
    if (action === 'verifyTicket' && ticketId) {
      return verifyTicket(ticketId);
    }
    
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: 'Invalid request'
    })).setMimeType(ContentService.MimeType.JSON);
    
  } catch (error) {
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: error.toString()
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

function doPost(e) {
  try {
    // Log raw request for debugging
    Logger.log('doPost called');
    Logger.log('POST data: ' + e.postData.contents);
    
    const data = JSON.parse(e.postData.contents);
    Logger.log('Parsed data: ' + JSON.stringify(data));
    
    const action = data.action;
    Logger.log('Action: ' + action);
    
    if (action === 'createTicket') {
      return createTicket(data);
    } else if (action === 'newsletter') {
      return addNewsletter(data);
    }
    
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: 'Invalid action'
    })).setMimeType(ContentService.MimeType.JSON);
    
  } catch (error) {
    Logger.log('Error in doPost: ' + error.toString());
    Logger.log('Error stack: ' + error.stack);
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: error.toString()
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

// Create new ticket
function createTicket(data) {
  try {
    // Log received data for debugging
    Logger.log('createTicket called with data: ' + JSON.stringify(data));
    
    // Validate data
    if (!data) {
      throw new Error('No data received');
    }
    
    const ss = SpreadsheetApp.openById(SPREADSHEET_ID);
    let sheet = ss.getSheetByName(SHEET_NAME_TICKETS);
    
    // Create sheet if it doesn't exist
    if (!sheet) {
      Logger.log('Creating new Tickets sheet');
      sheet = ss.insertSheet(SHEET_NAME_TICKETS);
      // Add headers
      sheet.appendRow([
        'Ticket ID',
        'Timestamp',
        'Name',
        'Email',
        'Phone',
        'Organization',
        'Ticket Type',
        'T-Shirt Size',
        'Payment Method',
        'Amount',
        'Status',
        'Check-in Time'
      ]);
      
      // Format header row
      const headerRange = sheet.getRange(1, 1, 1, 12);
      headerRange.setFontWeight('bold');
      headerRange.setBackground('#3b82f6');
      headerRange.setFontColor('#ffffff');
    }
    
    // Generate unique ticket ID
    const ticketId = generateTicketId();
    Logger.log('Generated ticket ID: ' + ticketId);
    
    // Use current date if timestamp is missing or invalid
    const timestamp = data.timestamp ? new Date(data.timestamp) : new Date();
    
    // Add new row with default values for missing fields
    sheet.appendRow([
      ticketId,
      timestamp,
      data.name || 'N/A',
      data.email || 'N/A',
      data.phone || 'N/A',
      data.organization || 'N/A',
      data.ticketType || 'student',
      data.tshirtSize || 'M',
      data.paymentMethod || 'N/A',
      data.amount || 0,
      'Active',
      '' // Check-in time (empty initially)
    ]);
    
    Logger.log('Ticket added to sheet successfully');
    
    // Send email notification (optional)
    sendTicketEmail(data.email, data.name, ticketId, data.ticketType, data.amount);
    
    return ContentService.createTextOutput(JSON.stringify({
      success: true,
      ticketId: ticketId,
      message: 'Ticket created successfully'
    })).setMimeType(ContentService.MimeType.JSON);
    
  } catch (error) {
    Logger.log('Error creating ticket: ' + error.toString());
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: error.toString()
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

// Verify ticket
function verifyTicket(ticketId) {
  try {
    const ss = SpreadsheetApp.openById(SPREADSHEET_ID);
    const sheet = ss.getSheetByName(SHEET_NAME_TICKETS);
    
    if (!sheet) {
      return ContentService.createTextOutput(JSON.stringify({
        success: false,
        message: 'No tickets found'
      })).setMimeType(ContentService.MimeType.JSON);
    }
    
    // Get all data
    const data = sheet.getDataRange().getValues();
    
    // Find ticket (skip header row)
    for (let i = 1; i < data.length; i++) {
      if (data[i][0] === ticketId) {
        const ticket = {
          ticketId: data[i][0],
          timestamp: data[i][1],
          name: data[i][2],
          email: data[i][3],
          phone: data[i][4],
          organization: data[i][5],
          ticketType: data[i][6],
          tshirtSize: data[i][7],
          paymentMethod: data[i][8],
          amount: data[i][9],
          status: data[i][10],
          checkInTime: data[i][11]
        };
        
        return ContentService.createTextOutput(JSON.stringify({
          success: true,
          ticket: ticket
        })).setMimeType(ContentService.MimeType.JSON);
      }
    }
    
    // Ticket not found
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: 'Ticket not found'
    })).setMimeType(ContentService.MimeType.JSON);
    
  } catch (error) {
    Logger.log('Error verifying ticket: ' + error.toString());
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: error.toString()
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

// Add newsletter subscriber
function addNewsletter(data) {
  try {
    const ss = SpreadsheetApp.openById(SPREADSHEET_ID);
    let sheet = ss.getSheetByName(SHEET_NAME_NEWSLETTER);
    
    // Create sheet if it doesn't exist
    if (!sheet) {
      sheet = ss.insertSheet(SHEET_NAME_NEWSLETTER);
      sheet.appendRow(['Email', 'Timestamp']);
      
      // Format header
      const headerRange = sheet.getRange(1, 1, 1, 2);
      headerRange.setFontWeight('bold');
      headerRange.setBackground('#8b5cf6');
      headerRange.setFontColor('#ffffff');
    }
    
    // Add subscriber
    sheet.appendRow([
      data.email,
      new Date(data.timestamp)
    ]);
    
    return ContentService.createTextOutput(JSON.stringify({
      success: true,
      message: 'Newsletter subscription added'
    })).setMimeType(ContentService.MimeType.JSON);
    
  } catch (error) {
    Logger.log('Error adding newsletter: ' + error.toString());
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: error.toString()
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

// Generate unique ticket ID
function generateTicketId() {
  const prefix = 'CC2025';
  const random = Math.floor(Math.random() * 900000) + 100000;
  return prefix + '-' + random;
}

// Send ticket email
function sendTicketEmail(email, name, ticketId, ticketType, amount) {
  try {
    const subject = 'Your CyberCon 2025 Ticket - ' + ticketId;
    const body = `
Dear ${name},

Thank you for registering for CyberCon 2025!

Your Ticket Details:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Ticket ID: ${ticketId}
Type: ${ticketType.charAt(0).toUpperCase() + ticketType.slice(1)} Pass
Amount: ৳${amount}

Event Details:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Date: December 15-16, 2025
Venue: Uttara University Campus
Time: 9:00 AM - 6:00 PM

Important Instructions:
1. Save this Ticket ID for verification
2. Complete payment using your selected method
3. Bring a government-issued ID to the event
4. You can verify your ticket anytime at our website

Need help? Contact us at info@cybercon2025.com

See you at the event!

Best regards,
CyberCon 2025 Team
Cyber Security Club, Uttara University
    `;
    
    MailApp.sendEmail(email, subject, body);
    Logger.log('Email sent to: ' + email);
    
  } catch (error) {
    Logger.log('Error sending email: ' + error.toString());
  }
}

// Check-in ticket (for event organizers)
function checkInTicket(ticketId) {
  try {
    const ss = SpreadsheetApp.openById(SPREADSHEET_ID);
    const sheet = ss.getSheetByName(SHEET_NAME_TICKETS);
    
    if (!sheet) {
      return { success: false, message: 'No tickets found' };
    }
    
    const data = sheet.getDataRange().getValues();
    
    // Find and update ticket
    for (let i = 1; i < data.length; i++) {
      if (data[i][0] === ticketId) {
        if (data[i][11]) { // Already checked in
          return {
            success: false,
            message: 'Ticket already checked in at ' + data[i][11]
          };
        }
        
        // Update check-in time
        sheet.getRange(i + 1, 12).setValue(new Date());
        
        return {
          success: true,
          message: 'Check-in successful',
          name: data[i][2]
        };
      }
    }
    
    return { success: false, message: 'Ticket not found' };
    
  } catch (error) {
    Logger.log('Error checking in: ' + error.toString());
    return { success: false, message: error.toString() };
  }
}

// Get statistics (for admin dashboard)
function getStats() {
  try {
    const ss = SpreadsheetApp.openById(SPREADSHEET_ID);
    const sheet = ss.getSheetByName(SHEET_NAME_TICKETS);
    
    if (!sheet) {
      return { total: 0, byType: {}, byStatus: {} };
    }
    
    const data = sheet.getDataRange().getValues();
    const stats = {
      total: data.length - 1, // Exclude header
      byType: { student: 0, professional: 0, group: 0 },
      byStatus: { Active: 0, Used: 0, Cancelled: 0 },
      totalRevenue: 0
    };
    
    for (let i = 1; i < data.length; i++) {
      const type = data[i][6];
      const status = data[i][10];
      const amount = data[i][9];
      
      stats.byType[type] = (stats.byType[type] || 0) + 1;
      stats.byStatus[status] = (stats.byStatus[status] || 0) + 1;
      stats.totalRevenue += parseFloat(amount) || 0;
    }
    
    return stats;
    
  } catch (error) {
    Logger.log('Error getting stats: ' + error.toString());
    return { error: error.toString() };
  }
}
