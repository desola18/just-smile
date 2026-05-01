from flask import Flask, render_template, request, redirect

app = Flask(__name__)

# Simplified list of packages
PACKAGES = [
    {"id": 1, "name": "Basic Smile", "price": "5,000", "desc": "Perfect for a small surprise."},
    {"id": 2, "name": "Mega Smile", "price": "15,000", "desc": "The ultimate celebration box."},
]

@app.route('/')
def home():
    return render_template('index.html', packages=PACKAGES)

@app.route('/order/<int:pkg_id>')
def order(pkg_id):
    # This is where you'd integrate a payment link like Paystack or Flutterwave
    # For now, it redirects to the order form
    return redirect("https://forms.gle/YourFormLinkHere") 

if __name__ == '__main__':
    app.run(debug=True)