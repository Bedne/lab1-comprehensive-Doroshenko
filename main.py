class Cart:
    def __init__(self):
        self.items = []

    def add_item(self, name, price, quantity=1):
        self.items.append({"name": name, "price": price, "quantity": quantity})

    def calculate_total(self, discount_percent=0):
        subtotal = sum(item["price"] * item["quantity"] for item in self.items)
        discount_amount = subtotal * (discount_percent / 100)
        total = subtotal - discount_amount
        return {"subtotal": subtotal, "discount": discount_amount, "total": total}

if __name__ == "__main__":
    cart = Cart()
    cart.add_item("Товар 1", 1000, 2)
    print(cart.calculate_total(discount_percent=10))
