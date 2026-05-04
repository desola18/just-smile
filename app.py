from flask import Flask, render_template  # Added render_template here

# 1. Initialize the app FIRST
app = Flask(__name__)

# 2. Define your data
PACKAGES = [
    {"name": "Standard", "price": "10,000"},
    {"name": "Premium", "price": "20,000"}
]

SEASONAL_DEALS = [
    {"name": "Father's Day Special", "price": "12,000", "desc": "A custom mug and treat box for Dad.", "active": True},
    {"name": "Democracy Day Deal", "price": "8,500", "desc": "Celebrate with a festive delivery!", "active": False}
]

# 3. Define your ONE home route
@app.route('/')
def home():
    # Only show deals that are marked as 'active'
    active_deals = [d for d in SEASONAL_DEALS if d['active']]
    # This sends your data to the index.html file in your /templates folder
    return render_template('index.html', packages=PACKAGES, deals=active_deals)

if __name__ == "__main__":
    app.run()