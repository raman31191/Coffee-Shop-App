# ☕ Flutter Coffee Shop App

A beautifully crafted Flutter app for a fictional coffee shop, offering a smooth shopping experience with seamless authentication, interactive product filtering, a smart cart system, and modern UI animations. Built with custom state management and inspired by a real-world UI/UX design.

<img src="https://github.com/user-attachments/assets/f005fc08-7d19-4fd9-85ca-fd6845629eda" width="300"/>

## ✨ Features  

### **1. Seamless Authentication Flow**  
- Clean **onboarding screens** with coffee-themed illustrations  
- **Login/Signup UI** with form validation  
- Persistent session using `shared_preferences` (`loggedIn` flag)  
- Protected routes for authenticated users  

### **2. Interactive Coffee Menu**  
- **Horizontal category chips** (Latte, Espresso, Cappuccino, etc.)  
- **Product grid** with high-quality images, ratings, and prices  
- **Real-time filtering** by coffee categories  
- Responsive layout for all screen sizes  

<img src="https://github.com/user-attachments/assets/ca6f38a3-3b84-4b1a-b4a1-27c081424267" width="300"/>

### **3. Product Details with Animations**  
- **Hero animations** for smooth image transitions  
- **Size selector** (S/M/L) and **quantity stepper**  
- **AnimatedSwitcher** for dynamic UI updates  
- Detailed product descriptions and reviews  

<img src="https://github.com/user-attachments/assets/831a8f04-aeb3-497f-adca-cebe1d2a8b11" width="300"/>

### **4. Smart Cart System**  
- **In-memory state persistence** during app usage  
- Optionally backed by `shared_preferences`  
- **Real-time quantity adjustment** (+/- buttons)  
- Dynamic subtotal calculation  
- One-tap checkout flow  

<img src="https://github.com/user-attachments/assets/ab72a693-2342-4b82-881e-1553c572f024" width="300"/>
<img src="https://github.com/user-attachments/assets/5d1ce5bb-63e5-40f0-bf14-1b2b1ee5e9fc" width="300"/>



### **5. Custom State Management**  
dart
class AppState with ChangeNotifier {
  // Handles: 
  // - Cart items & quantities
  // - User authentication state  
  // - Light/dark theme toggle
}

## 🎨 Figma Design Reference  
This app UI was inspired by the following Figma design:  
👉 https://www.figma.com/design/dFYPpHoAiS25yxVaOV701e/Coffee-Shop-Mobile-App-Design--Community-?node-id=0-1&p=f&t=55JmjJCPate5UY4e-0


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
