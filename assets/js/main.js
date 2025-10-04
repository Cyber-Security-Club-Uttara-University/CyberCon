// ==========================================
// CYBERCON 2025 - Google Sheets Integration
// ==========================================

// Google Sheets Configuration
const GOOGLE_SHEETS_CONFIG = {
    // Replace with your Google Apps Script Web App URL
    // Full URL should look like: https://script.google.com/macros/s/AKfycbxxx.../exec
    scriptUrl: 'https://script.google.com/macros/s/AKfycbwJBx6ij-a-F8uZaYvZTT3QQQK6S8K6NHK42MJtMETFfDZRJPEVTtRsL73WcuIpJHk3jw/exec',
    
    // Ticket prices
    ticketPrices: {
        student: 500,
        professional: 1500,
        group: 400
    }
};

// Initialize AOS (Animate On Scroll)
AOS.init({
    duration: 800,
    offset: 100,
    once: true,
    easing: 'ease-out'
});

// ==========================================
// Preloader
// ==========================================
window.addEventListener('load', () => {
    const preloader = document.getElementById('preloader');
    setTimeout(() => {
        preloader.classList.add('hidden');
    }, 1500);
});

// ==========================================
// Navigation
// ==========================================
const navbar = document.getElementById('navbar');
const hamburger = document.getElementById('hamburger');
const navMenu = document.getElementById('navMenu');
const navLinks = document.querySelectorAll('.nav-link');

// Sticky navbar on scroll
window.addEventListener('scroll', () => {
    if (window.scrollY > 100) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
    
    // Update active nav link
    updateActiveNav();
});

// Mobile menu toggle
hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// Close menu when clicking nav link
navLinks.forEach(link => {
    link.addEventListener('click', () => {
        hamburger.classList.remove('active');
        navMenu.classList.remove('active');
    });
});

// Update active navigation link based on scroll
function updateActiveNav() {
    const sections = document.querySelectorAll('section[id]');
    const scrollY = window.scrollY;
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop - 100;
        const sectionHeight = section.offsetHeight;
        const sectionId = section.getAttribute('id');
        
        if (scrollY >= sectionTop && scrollY < sectionTop + sectionHeight) {
            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === `#${sectionId}`) {
                    link.classList.add('active');
                }
            });
        }
    });
}

// ==========================================
// Counter Animation
// ==========================================
function animateCounter(element) {
    const target = parseInt(element.getAttribute('data-target'));
    const duration = 2000;
    const increment = target / (duration / 16);
    let current = 0;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target + '+';
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current);
        }
    }, 16);
}

// Trigger counter animation when section is visible
const observeCounters = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const counters = entry.target.querySelectorAll('.stat-number');
            counters.forEach(counter => {
                if (!counter.classList.contains('animated')) {
                    animateCounter(counter);
                    counter.classList.add('animated');
                }
            });
            observeCounters.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

const heroSection = document.querySelector('.hero');
if (heroSection) {
    observeCounters.observe(heroSection);
}

// ==========================================
// Particle Animation
// ==========================================
function createParticles() {
    const particlesContainer = document.getElementById('particles');
    if (!particlesContainer) return;
    
    const particleCount = 50;
    
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        
        const size = Math.random() * 3 + 1;
        const left = Math.random() * 100;
        const delay = Math.random() * 20;
        const duration = Math.random() * 20 + 20;
        
        particle.style.cssText = `
            position: absolute;
            width: ${size}px;
            height: ${size}px;
            background: rgba(59, 130, 246, 0.5);
            border-radius: 50%;
            left: ${left}%;
            bottom: -10px;
            animation: floatParticle ${duration}s linear ${delay}s infinite;
        `;
        
        particlesContainer.appendChild(particle);
    }
}

// Add particle animation CSS
const style = document.createElement('style');
style.innerHTML = `
    @keyframes floatParticle {
        0% {
            transform: translateY(0) translateX(0);
            opacity: 0;
        }
        10% {
            opacity: 1;
        }
        90% {
            opacity: 1;
        }
        100% {
            transform: translateY(-100vh) translateX(${Math.random() * 200 - 100}px);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);
createParticles();

// ==========================================
// Ticket Modal
// ==========================================
const ticketModal = document.getElementById('ticketModal');
const modalClose = document.querySelector('.modal-close');
let selectedTicket = '';

function openTicketModal(ticketType) {
    selectedTicket = ticketType;
    const modalTitle = document.getElementById('modalTicketType');
    const totalAmount = document.getElementById('totalAmount');
    
    modalTitle.textContent = ticketType.charAt(0).toUpperCase() + ticketType.slice(1);
    totalAmount.textContent = `৳${GOOGLE_SHEETS_CONFIG.ticketPrices[ticketType]}`;
    
    ticketModal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeTicketModal() {
    ticketModal.classList.remove('active');
    document.body.style.overflow = 'auto';
}

// Close modal when clicking outside
ticketModal.addEventListener('click', (e) => {
    if (e.target === ticketModal) {
        closeTicketModal();
    }
});

// Close modal with Escape key
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && ticketModal.classList.contains('active')) {
        closeTicketModal();
    }
});

// ==========================================
// Google Sheets Integration - Create Ticket
// ==========================================
const ticketForm = document.getElementById('ticketForm');

ticketForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = new FormData(ticketForm);
    const data = {
        action: 'createTicket',
        ticketType: selectedTicket,
        name: formData.get('name'),
        email: formData.get('email'),
        phone: formData.get('phone'),
        organization: formData.get('organization'),
        tshirtSize: formData.get('size'),
        paymentMethod: formData.get('payment'),
        amount: GOOGLE_SHEETS_CONFIG.ticketPrices[selectedTicket],
        timestamp: new Date().toISOString()
    };
    
    // Validate Script URL
    if (GOOGLE_SHEETS_CONFIG.scriptUrl === 'YOUR_GOOGLE_APPS_SCRIPT_URL_HERE') {
        alert('⚠️ Please configure Google Apps Script URL!\n\nSee GOOGLE_SHEETS_SETUP.md for instructions.');
        return;
    }
    
    // Show loading state
    const submitBtn = ticketForm.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Ticket...';
    submitBtn.disabled = true;
    
    try {
        // Send data to Google Sheets via Apps Script
        const response = await fetch(GOOGLE_SHEETS_CONFIG.scriptUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        // Parse the response
        const result = await response.json();
        
        if (result.success) {
            // Show success message with actual ticket ID from server
            showTicketSuccess({
                ticketId: result.ticketId,
                name: data.name,
                email: data.email,
                type: data.ticketType,
                amount: data.amount,
                paymentMethod: data.paymentMethod
            });
            
            // Reset form
            ticketForm.reset();
            closeTicketModal();
        } else {
            throw new Error(result.message || 'Failed to create ticket');
        }
        
    } catch (error) {
        console.error('Error creating ticket:', error);
        alert('❌ Error creating ticket. Please try again.\n\n' + error.message);
    } finally {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
});

// ==========================================
// Google Sheets Integration - Verify Ticket
// ==========================================
const verifyForm = document.getElementById('verifyForm');

if (verifyForm) {
    verifyForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const ticketId = document.getElementById('verifyTicketId').value.trim().toUpperCase();
        const resultDiv = document.getElementById('verifyResult');
        const submitBtn = verifyForm.querySelector('button[type="submit"]');
        
        if (!ticketId) {
            showVerifyResult('❌ Please enter a ticket ID', 'error');
            return;
        }
        
        // Validate Script URL
        if (GOOGLE_SHEETS_CONFIG.scriptUrl === 'YOUR_GOOGLE_APPS_SCRIPT_URL_HERE') {
            showVerifyResult('⚠️ Please configure Google Apps Script URL!<br>See GOOGLE_SHEETS_SETUP.md for instructions.', 'error');
            return;
        }
        
        // Show loading state
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Verifying...';
        submitBtn.disabled = true;
        
        try {
            // Fetch ticket from Google Sheets
            const response = await fetch(`${GOOGLE_SHEETS_CONFIG.scriptUrl}?action=verifyTicket&ticketId=${ticketId}`);
            const result = await response.json();
            
            if (result.success && result.ticket) {
                const ticket = result.ticket;
                showVerifyResult(`
                    <div class="verify-success">
                        <i class="fas fa-check-circle" style="font-size: 48px; color: #10b981; margin-bottom: 20px;"></i>
                        <h3 style="color: #10b981; margin-bottom: 20px;">✓ Valid Ticket</h3>
                        <div class="ticket-info" style="text-align: left; background: #f0fdf4; padding: 20px; border-radius: 8px; border-left: 4px solid #10b981;">
                            <p><strong>Ticket ID:</strong> ${ticket.ticketId}</p>
                            <p><strong>Name:</strong> ${ticket.name}</p>
                            <p><strong>Email:</strong> ${ticket.email}</p>
                            <p><strong>Type:</strong> ${ticket.ticketType.charAt(0).toUpperCase() + ticket.ticketType.slice(1)} Pass</p>
                            <p><strong>Organization:</strong> ${ticket.organization}</p>
                            <p><strong>Price:</strong> ৳${ticket.amount}</p>
                            <p><strong>Status:</strong> <span style="color: ${ticket.status === 'Active' ? '#10b981' : '#ef4444'};">${ticket.status}</span></p>
                            <p><strong>Payment:</strong> ${ticket.paymentMethod}</p>
                            <p><strong>Registration Date:</strong> ${new Date(ticket.timestamp).toLocaleDateString('en-GB')}</p>
                            <p style="margin-top: 15px; padding: 10px; background: white; border-radius: 6px; color: #059669;">
                                <strong>📌 ${ticket.status === 'Active' ? 'Valid ticket - Ready for event!' : 'Please check ticket status'}</strong>
                            </p>
                        </div>
                    </div>
                `, 'success');
            } else {
                showVerifyResult(`
                    <div class="verify-error">
                        <i class="fas fa-times-circle" style="font-size: 48px; color: #ef4444; margin-bottom: 20px;"></i>
                        <h3 style="color: #ef4444; margin-bottom: 20px;">Invalid Ticket</h3>
                        <div style="background: #fef2f2; padding: 20px; border-radius: 8px; border-left: 4px solid #ef4444;">
                            <p style="color: #991b1b;">${result.message || 'Ticket not found or invalid.'}</p>
                        </div>
                    </div>
                `, 'error');
            }
        } catch (error) {
            showVerifyResult(`
                <div class="verify-error">
                    <i class="fas fa-exclamation-circle" style="font-size: 48px; color: #f59e0b; margin-bottom: 20px;"></i>
                    <h3 style="color: #f59e0b; margin-bottom: 20px;">Verification Error</h3>
                    <div style="background: #fffbeb; padding: 20px; border-radius: 8px; border-left: 4px solid #f59e0b;">
                        <p style="color: #92400e;">⚠️ Unable to verify ticket. Please check your connection and try again.</p>
                        <p style="font-size: 0.9em; color: #78350f; margin-top: 10px;">Error: ${error.message}</p>
                        <p style="margin-top: 15px; font-size: 0.85em; color: #92400e;">
                            💡 Make sure Google Apps Script is properly deployed and accessible.
                        </p>
                    </div>
                </div>
            `, 'error');
            console.error('Verification Error:', error);
        } finally {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }
        
        verifyForm.reset();
    });
}

// ==========================================
// Helper Functions
// ==========================================

// Generate Ticket ID
function generateTicketId() {
    const prefix = 'CC2025';
    const random = Math.floor(Math.random() * 900000) + 100000;
    return `${prefix}-${random}`;
}

// Show Ticket Success Message
function showTicketSuccess(ticket) {
    const message = `
🎉 Ticket Registered Successfully!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ TICKET INFORMATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Ticket ID: ${ticket.ticketId}
👤 Name: ${ticket.name}
📧 Email: ${ticket.email}
🎫 Type: ${ticket.type.toUpperCase()}
💰 Amount: ৳${ticket.amount}
💳 Payment: ${ticket.paymentMethod}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. ✉️ Check your email for confirmation
2. 💳 Complete payment using ${ticket.paymentMethod}
3. 📱 Save your Ticket ID for verification
4. ✓ Your ticket is saved in our system

📌 You can verify your ticket anytime using the Ticket ID above!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━

See you at CyberCon 2025! 🚀
    `;
    
    alert(message);
}

// Show Verify Result
function showVerifyResult(html, type) {
    const resultDiv = document.getElementById('verifyResult');
    resultDiv.innerHTML = html;
    resultDiv.style.display = 'block';
    resultDiv.className = `verify-result ${type}`;
    
    // Scroll to result
    resultDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

// ==========================================
// Newsletter Form
// ==========================================
const newsletterForm = document.getElementById('newsletterForm');

if (newsletterForm) {
    newsletterForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const email = document.getElementById('newsletterEmail').value;
        const submitBtn = newsletterForm.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
        submitBtn.disabled = true;
        
        // Send to Google Sheets
        try {
            if (GOOGLE_SHEETS_CONFIG.scriptUrl !== 'YOUR_GOOGLE_APPS_SCRIPT_URL_HERE') {
                const response = await fetch(GOOGLE_SHEETS_CONFIG.scriptUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'newsletter',
                        email: email,
                        timestamp: new Date().toISOString()
                    })
                });
                
                const result = await response.json();
                if (!result.success) {
                    console.error('Newsletter subscription failed:', result.message);
                }
            }
            
            alert(`✅ Thank you for subscribing!\n\nYou'll receive updates at: ${email}`);
            newsletterForm.reset();
        } catch (error) {
            console.error('Newsletter error:', error);
            alert('Subscribed! You will receive updates soon.');
            newsletterForm.reset();
        } finally {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }
    });
}

// ==========================================
// Smooth Scrolling
// ==========================================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// ==========================================
// Console Message
// ==========================================
console.log(`
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🛡️ CYBERCON 2025 🛡️
    Cyber Security Conference
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Data Storage: Google Sheets
🔧 No Backend Required!

Made with ❤️ by Cyber Security Club
Uttara University
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
`);
