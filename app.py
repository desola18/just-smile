# Add a new list for seasonal specials
SEASONAL_DEALS = [
    {"name": "Father's Day Special", "price": "12,000", "desc": "A custom mug and treat box for Dad.", "active": True},
    {"name": "Democracy Day Deal", "price": "8,500", "desc": "Celebrate with a festive delivery!", "active": False}
]

@app.route('/')
def home():
    # Only show deals that are marked as 'active'
    active_deals = [d for d in SEASONAL_DEALS if d['active']]
    return render_template('index.html', packages=PACKAGES, deals=active_deals)