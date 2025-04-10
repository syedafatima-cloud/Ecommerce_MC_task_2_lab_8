import 'package:flutter/material.dart';

void main() {
  
  runApp(const MyApp());
}

// Global state management (in a real app, would use Provider, Riverpod, or Bloc)
class CheckoutState {
  static final CheckoutState _instance = CheckoutState._internal();
  factory CheckoutState() => _instance;
  CheckoutState._internal();

  // User progress tracking
  bool hasEnteredCart = false;
  bool hasEnteredShipping = false;
  bool hasSelectedPayment = false;
  bool hasReviewedOrder = false;

  // Order data
  final List<CartItem> cartItems = [
    CartItem(
      id: 1, 
      name: 'Premium Headphones', 
      price: 129.99, 
      quantity: 1, 
      imageUrl: 'https://www.bing.com/images/search?view=detailV2&ccid=AnzGOg02&id=054E2FA53F42D6E1BBBE521000E833A5D056A44E&thid=OIP.AnzGOg02C_WcB3kD17Pl8QHaJM&mediaurl=https%3a%2f%2fwww.androidheadlines.com%2fwp-content%2fuploads%2f2016%2f07%2fAudio-Technica-ATH-MSR7.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.027cc63a0d360bf59c077903d7b3e5f1%3frik%3dTqRW0KUz6AAQUg%26pid%3dImgRaw%26r%3d0&exph=1500&expw=1208&q=headphones&simid=608049159809139030&FORM=IRPRST&ck=DF9707628FA01131B83EDD86EA97419F&selectedIndex=7&itb=0'
    ),
    CartItem(
      id: 2, 
      name: 'Wireless Keyboard', 
      price: 89.99, 
      quantity: 1, 
      imageUrl: 'https://www.bing.com/images/search?view=detailV2&ccid=TRgoMdv%2b&id=8445067610333EA66BCBF6D28809B51BAF721293&thid=OIP.TRgoMdv-vu0jR8DEx7fTdgHaHa&mediaurl=https%3a%2f%2fwww.lifewire.com%2fthmb%2fnwimf-0lM1HekZrJoUUXEtoDLqg%3d%2f1500x1500%2ffilters%3afill(auto%2c1)%2fLogitech-K780-Multi-Device-Wireless-Keyboard-HeroSquare-5b254b7347b8464a9d68953517a05673.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.4d182831dbfebeed2347c0c4c7b7d376%3frik%3dkxJyrxu1CYjS9g%26pid%3dImgRaw%26r%3d0&exph=1500&expw=1500&q=wireless+keyboard&simid=608053914326665418&FORM=IRPRST&ck=0ADD2F02C2894444AFE07859E86B0CAE&selectedIndex=2&itb=0'
    ),
    CartItem(
      id: 3, 
      name: 'USB-C Cable (3m)', 
      price: 19.99, 
      quantity: 2, 
      imageUrl: 'https://www.bing.com/images/search?view=detailV2&ccid=f2t8R3Bm&id=030196BB28E44217B2C3409F84C9C48FD4B006FA&thid=OIP.f2t8R3BmXC_C52AdmNAcfAHaHa&mediaurl=https%3a%2f%2fm.media-amazon.com%2fimages%2fI%2f71s7KTwNHWL._SL1500_.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.7f6b7c4770665c2fc2e7601d98d01c7c%3frik%3d%252bgaw1I%252fEyYSfQA%26pid%3dImgRaw%26r%3d0&exph=1500&expw=1500&q=usb+c+cable&simid=608002701075164762&FORM=IRPRST&ck=C3F318EA8431668B2F897BDD110D88F2&selectedIndex=1&itb=0'
    ),
  ];
  
  ShippingAddress? selectedAddress;
  List<ShippingAddress> savedAddresses = [
    ShippingAddress(
      id: 1,
      name: 'John Doe',
      street: '123 Main Street',
      city: 'New York',
      state: 'NY',
      zipCode: '10001',
      country: 'United States',
      isDefault: true,
    ),
    ShippingAddress(
      id: 2,
      name: 'John Doe',
      street: '456 Park Avenue',
      city: 'Los Angeles',
      state: 'CA',
      zipCode: '90001',
      country: 'United States',
      isDefault: false,
    ),
  ];
  
  ShippingMethod? selectedShippingMethod;
  List<ShippingMethod> availableShippingMethods = [
    ShippingMethod(
      id: 1,
      name: 'Standard Shipping',
      price: 5.99,
      estimatedDelivery: '3-5 business days',
    ),
    ShippingMethod(
      id: 2,
      name: 'Express Shipping',
      price: 12.99,
      estimatedDelivery: '1-2 business days',
    ),
    ShippingMethod(
      id: 3,
      name: 'Next Day Delivery',
      price: 19.99,
      estimatedDelivery: 'Next business day',
    ),
  ];
  
  PaymentMethod? selectedPaymentMethod;
  List<PaymentMethod> savedPaymentMethods = [
    PaymentMethod(
      id: 1,
      type: PaymentType.creditCard,
      lastFour: '4242',
      expiryDate: '05/28',
      cardHolder: 'John Doe',
      isDefault: true,
    ),
    PaymentMethod(
      id: 2,
      type: PaymentType.paypal,
      email: 'john.doe@example.com',
      isDefault: false,
    ),
  ];
  
  // Reset checkout process
  void resetCheckout() {
    hasEnteredCart = false;
    hasEnteredShipping = false;
    hasSelectedPayment = false;
    hasReviewedOrder = false;
    selectedAddress = null;
    selectedShippingMethod = null;
    selectedPaymentMethod = null;
  }
  
  // Calculate order totals
  double get subtotal => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get shippingCost => selectedShippingMethod?.price ?? 0;
  double get tax => subtotal * 0.08; // 8% tax rate
  double get total => subtotal + shippingCost + tax;
}

// Models
class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  
  CartItem({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.quantity, 
    required this.imageUrl
  });
}

class ShippingAddress {
  final int id;
  final String name;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isDefault;
  
  ShippingAddress({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.isDefault,
  });
}

class ShippingMethod {
  final int id;
  final String name;
  final double price;
  final String estimatedDelivery;
  
  ShippingMethod({
    required this.id,
    required this.name,
    required this.price,
    required this.estimatedDelivery,
  });
}

enum PaymentType { creditCard, paypal, applePay, googlePay }

class PaymentMethod {
  final int id;
  final PaymentType type;
  final String? lastFour;
  final String? expiryDate;
  final String? cardHolder;
  final String? email;
  final bool isDefault;
  
  PaymentMethod({
    required this.id,
    required this.type,
    this.lastFour,
    this.expiryDate,
    this.cardHolder,
    this.email,
    required this.isDefault,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Checkout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.indigo),
            foregroundColor: Colors.indigo,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.indigo,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Route guards implementation
        final checkoutState = CheckoutState();
        
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const CartPage());
          case '/shipping':
            checkoutState.hasEnteredCart = true;
            return MaterialPageRoute(builder: (_) => const ShippingPage());
          case '/payment':
            if (!checkoutState.hasEnteredShipping) {
              return MaterialPageRoute(builder: (_) => const CartPage());
            }
            return MaterialPageRoute(builder: (_) => const PaymentPage());
          case '/review':
            if (!checkoutState.hasSelectedPayment) {
              return MaterialPageRoute(builder: (_) => const PaymentPage());
            }
            return MaterialPageRoute(builder: (_) => const ReviewPage());
          case '/confirmation':
            if (!checkoutState.hasReviewedOrder) {
              return MaterialPageRoute(builder: (_) => const ReviewPage());
            }
            return MaterialPageRoute(builder: (_) => const ConfirmationPage());
          // Nested routes
          case '/shipping/address':
            return MaterialPageRoute(builder: (_) => const AddressSelectionPage());
          case '/shipping/method':
            return MaterialPageRoute(builder: (_) => const ShippingMethodPage());
          case '/payment/method':
            return MaterialPageRoute(builder: (_) => const PaymentMethodPage());
          case '/payment/details':
            return MaterialPageRoute(builder: (_) => const PaymentDetailsPage());
          default:
            return MaterialPageRoute(builder: (_) => const CartPage());
        }
      },
    );
  }
}

// Common UI components
class CheckoutProgressBar extends StatelessWidget {
  final int currentStep;

  const CheckoutProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStep(1, 'Cart', currentStep >= 1),
          _buildDivider(currentStep >= 2),
          _buildStep(2, 'Shipping', currentStep >= 2),
          _buildDivider(currentStep >= 3),
          _buildStep(3, 'Payment', currentStep >= 3),
          _buildDivider(currentStep >= 4),
          _buildStep(4, 'Review', currentStep >= 4),
          _buildDivider(currentStep >= 5),
          _buildStep(5, 'Complete', currentStep >= 5),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.indigo : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.indigo : Colors.grey.shade600,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isActive) {
    return Container(
      width: 20,
      height: 2,
      color: isActive ? Colors.indigo : Colors.grey.shade300,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final bool isDetailed;

  const OrderSummaryCard({super.key, this.isDetailed = false});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (isDetailed)
              Column(
                children: [
                  ...state.cartItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Qty: ${item.quantity}'),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                  const Divider(),
                ],
              ),
            _buildSummaryRow('Subtotal', '\$${state.subtotal.toStringAsFixed(2)}'),
            if (state.selectedShippingMethod != null)
              _buildSummaryRow('Shipping', '\$${state.shippingCost.toStringAsFixed(2)}'),
            _buildSummaryRow('Tax', '\$${state.tax.toStringAsFixed(2)}'),
            const Divider(),
            _buildSummaryRow(
              'Total', 
              '\$${state.total.toStringAsFixed(2)}',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Main checkout flow pages
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: Column(
        children: [
          const CheckoutProgressBar(currentStep: 1),
          Expanded(
            child: state.cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                          // In a real app, we would notify listeners here
                                        }
                                      },
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        item.quantity++;
                                        // In a real app, we would notify listeners here
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const OrderSummaryCard(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shipping');
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Proceed to Checkout'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Shipping')),
      body: Column(
        children: [
          const CheckoutProgressBar(currentStep: 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Shipping Address'),
                  if (state.selectedAddress != null)
                    _buildSelectedAddress(state.selectedAddress!)
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/shipping/address');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Select Address'),
                      ),
                    ),
                  
                  const SectionTitle(title: 'Shipping Method'),
                  if (state.selectedShippingMethod != null)
                    _buildSelectedShippingMethod(state.selectedShippingMethod!)
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          if (state.selectedAddress != null) {
                            Navigator.pushNamed(context, '/shipping/method');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a shipping address first'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.local_shipping_outlined),
                        label: const Text('Select Shipping Method'),
                      ),
                    ),
                  
                  // Order summary
                  const OrderSummaryCard(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Cart'),
                ),
                ElevatedButton(
                  onPressed: state.selectedAddress != null && 
                             state.selectedShippingMethod != null
                      ? () {
                          state.hasEnteredShipping = true;
                          Navigator.pushNamed(context, '/payment');
                        }
                      : null,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Continue to Payment'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedAddress(ShippingAddress address) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    address.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Change'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/shipping/address');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(address.street),
              Text('${address.city}, ${address.state} ${address.zipCode}'),
              Text(address.country),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedShippingMethod(ShippingMethod method) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    method.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Change'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/shipping/method');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Estimated delivery: ${method.estimatedDelivery}'),
              const SizedBox(height: 4),
              Text(
                '\$${method.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Select Shipping Address')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.savedAddresses.length,
              itemBuilder: (context, index) {
                final address = state.savedAddresses[index];
                final isSelected = state.selectedAddress?.id == address.id;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Card(
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.indigo.shade50 : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isSelected
                          ? const BorderSide(color: Colors.indigo, width: 2)
                          : BorderSide.none,
                    ),
                    child: InkWell(
                      onTap: () {
                        state.selectedAddress = address;
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: address.id,
                              groupValue: state.selectedAddress?.id,
                              onChanged: (value) {
                                state.selectedAddress = address;
                                Navigator.pop(context);
                              },
                              activeColor: Colors.indigo,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        address.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (address.isDefault)
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.indigo.shade100,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Default',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.indigo,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(address.street),
                                  Text('${address.city}, ${address.state} ${address.zipCode}'),
                                  Text(address.country),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton.icon(
              onPressed: () {
                // In a real app, this would navigate to an address form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Add new address functionality would go here'),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Address'),
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingMethodPage extends StatelessWidget {
  const ShippingMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Select Shipping Method')),
      body: ListView.builder(
        itemCount: state.availableShippingMethods.length,
        itemBuilder: (context, index) {
          final method = state.availableShippingMethods[index];
          final isSelected = state.selectedShippingMethod?.id == method.id;
          
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Card(
              elevation: isSelected ? 4 : 1,
              color: isSelected ? Colors.indigo.shade50 : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isSelected
                    ? const BorderSide(color: Colors.indigo, width: 2)
                    : BorderSide.none,
              ),
              child: InkWell(
                onTap: () {
                  state.selectedShippingMethod = method;
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: method.id,
                        groupValue: state.selectedShippingMethod?.id,
                        onChanged: (value) {
                          state.selectedShippingMethod = method;
                          Navigator.pop(context);
                        },
                        activeColor: Colors.indigo,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Estimated delivery: ${method.estimatedDelivery}'),
                          ],
                        ),
                      ),
                      Text(
                        '\$${method.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    // Route guard - ensure shipping is completed
    if (!state.hasEnteredShipping) {
      Future.microtask(() => Navigator.pushNamed(context, '/shipping'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Column(
        children: [
          const CheckoutProgressBar(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Payment Method'),
                  if (state.selectedPaymentMethod != null)
                    _buildSelectedPaymentMethod(state.selectedPaymentMethod!)
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment/method');
                        },
                        icon: const Icon(Icons.payment),
                        label: const Text('Select Payment Method'),
                      ),
                    ),
                  
                  // Billing address section
                  const SectionTitle(title: 'Billing Address'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: true, // In a real app, this would be a state variable
                          onChanged: (value) {
                            // Toggle billing address same as shipping
                          },
                          activeColor: Colors.indigo,
                        ),
                        const Text('Same as shipping address'),
                      ],
                    ),
                  ),
                  
                  // Order summary
                  const OrderSummaryCard(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Shipping'),
                ),
                ElevatedButton(
                  onPressed: state.selectedPaymentMethod != null
                      ? () {
                          state.hasSelectedPayment = true;
                          Navigator.pushNamed(context, '/review');
                        }
                      : null,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Review Order'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPaymentMethod(PaymentMethod method) {
    IconData icon;
    String displayText;
    
    switch (method.type) {
      case PaymentType.creditCard:
        icon = Icons.credit_card;
        displayText = 'Card ending in ${method.lastFour}';
        break;
      case PaymentType.paypal:
        icon = Icons.account_balance_wallet;
        displayText = method.email ?? 'PayPal';
        break;
      case PaymentType.applePay:
        icon = Icons.apple;
        displayText = 'Apple Pay';
        break;
      case PaymentType.googlePay:
       // icon = Icons.google;
        displayText = 'Google Pay';
        break;
    }
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
             // Icon(icon, size: 32, color: Colors.indigo),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (method.type == PaymentType.creditCard && method.expiryDate != null)
                      Text('Expires ${method.expiryDate}'),
                    if (method.type == PaymentType.creditCard && method.cardHolder != null)
                      Text(method.cardHolder!),
                  ],
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Change'),
                onPressed: () {
                  Navigator.pushNamed(context, '/payment/method');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Select Payment Method')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.savedPaymentMethods.length,
              itemBuilder: (context, index) {
                final method = state.savedPaymentMethods[index];
                final isSelected = state.selectedPaymentMethod?.id == method.id;
                
                IconData icon;
                String title;
                String? subtitle;
                
                switch (method.type) {
                  case PaymentType.creditCard:
                    icon = Icons.credit_card;
                    title = 'Card ending in ${method.lastFour}';
                    subtitle = 'Expires ${method.expiryDate}';
                    break;
                  case PaymentType.paypal:
                    icon = Icons.account_balance_wallet;
                    title = 'PayPal';
                    subtitle = method.email;
                    break;
                  case PaymentType.applePay:
                    icon = Icons.apple;
                    title = 'Apple Pay';
                    subtitle = null;
                    break;
                  case PaymentType.googlePay:
                   // icon = Icons.google;
                    title = 'Google Pay';
                    subtitle = null;
                    break;
                }
                
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Card(
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.indigo.shade50 : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isSelected
                          ? const BorderSide(color: Colors.indigo, width: 2)
                          : BorderSide.none,
                    ),
                    child: InkWell(
                      onTap: () {
                        state.selectedPaymentMethod = method;
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: method.id,
                              groupValue: state.selectedPaymentMethod?.id,
                              onChanged: (value) {
                                state.selectedPaymentMethod = method;
                                Navigator.pop(context);
                              },
                              activeColor: Colors.indigo,
                            ),
                            //Icon(icon, size: 32, color: Colors.indigo),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (method.isDefault)
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.indigo.shade100,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Default',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.indigo,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (subtitle != null)
                                    Text(subtitle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment/details');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Card'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    // In a real app, this would navigate to PayPal auth
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PayPal integration would go here'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_balance_wallet),
                  label: const Text('Link PayPal Account'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment Method')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Card Information'),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cardholder Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Billing Address'),
            Row(
              children: [
                Checkbox(
                  value: true, // In a real app, this would be a state variable
                  onChanged: (value) {
                    // Toggle billing address same as shipping
                  },
                  activeColor: Colors.indigo,
                ),
                const Text('Same as shipping address'),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save Card Information'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    // Route guard - ensure payment is selected
    if (!state.hasSelectedPayment) {
      Future.microtask(() => Navigator.pushNamed(context, '/payment'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    return Scaffold(
      appBar: AppBar(title: const Text('Order Review')),
      body: Column(
        children: [
          const CheckoutProgressBar(currentStep: 4),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order items
                  const SectionTitle(title: 'Order Items'),
                  ...state.cartItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Qty: ${item.quantity}'),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                  
                  const Divider(),
                  
                  // Shipping information
                  const SectionTitle(title: 'Shipping Information'),
                  if (state.selectedAddress != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.selectedAddress!.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit, size: 16),
                                    label: const Text('Change'),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/shipping');
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(state.selectedAddress!.street),
                              Text('${state.selectedAddress!.city}, ${state.selectedAddress!.state} ${state.selectedAddress!.zipCode}'),
                              Text(state.selectedAddress!.country),
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
                              if (state.selectedShippingMethod != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping Method: ${state.selectedShippingMethod!.name}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('\$${state.selectedShippingMethod!.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                              if (state.selectedShippingMethod != null)
                                Text('Estimated delivery: ${state.selectedShippingMethod!.estimatedDelivery}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Payment information
                  const SectionTitle(title: 'Payment Information'),
                  if (state.selectedPaymentMethod != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                state.selectedPaymentMethod!.type == PaymentType.creditCard
                                    ? Icons.credit_card
                                    : Icons.account_balance_wallet,
                                size: 32,
                                color: Colors.indigo,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.selectedPaymentMethod!.type == PaymentType.creditCard
                                          ? 'Card ending in ${state.selectedPaymentMethod!.lastFour}'
                                          : 'PayPal - ${state.selectedPaymentMethod!.email}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (state.selectedPaymentMethod!.type == PaymentType.creditCard &&
                                        state.selectedPaymentMethod!.expiryDate != null)
                                      Text('Expires ${state.selectedPaymentMethod!.expiryDate}'),
                                  ],
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text('Change'),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/payment');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Order summary with detailed breakdown
                  const OrderSummaryCard(isDetailed: true),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Payment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    state.hasReviewedOrder = true;
                    Navigator.pushNamed(context, '/confirmation');
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Place Order'),
                      SizedBox(width: 8),
                      Icon(Icons.check_circle_outline),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = CheckoutState();
    
    // Route guard - ensure order was reviewed
    if (!state.hasReviewedOrder) {
      Future.microtask(() => Navigator.pushNamed(context, '/review'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    // Generate a random order number
    final orderNumber = DateTime.now().millisecondsSinceEpoch.toString().substring(5);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Column(
        children: [
          const CheckoutProgressBar(currentStep: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Thank You for Your Order!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Order #$orderNumber',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We\'ve sent a confirmation email to ${state.selectedPaymentMethod?.email ?? 'your email address'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildSummaryRow('Date', DateTime.now().toString().substring(0, 10)),
                            _buildSummaryRow('Items', '${state.cartItems.length} item(s)'),
                            _buildSummaryRow('Total', '\$${state.total.toStringAsFixed(2)}'),
                            const SizedBox(height: 16),
                            const Text(
                              'Shipping Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (state.selectedAddress != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.selectedAddress!.name),
                                  Text(state.selectedAddress!.street),
                                  Text('${state.selectedAddress!.city}, ${state.selectedAddress!.state} ${state.selectedAddress!.zipCode}'),
                                  Text(state.selectedAddress!.country),
                                ],
                              ),
                            const SizedBox(height: 16),
                            if (state.selectedShippingMethod != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Method: ${state.selectedShippingMethod!.name}',
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text('Estimated delivery: ${state.selectedShippingMethod!.estimatedDelivery}'),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // In a real app, this would navigate to order tracking
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Track Order functionality would go here'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.local_shipping_outlined),
                          label: const Text('Track Order'),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Reset the checkout state and go back to home
                            state.resetCheckout();
                            Navigator.pushNamedAndRemoveUntil(
                              context, 
                              '/', 
                              (route) => false
                            );
                          },
                          icon: const Icon(Icons.home_outlined),
                          label: const Text('Continue Shopping'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}