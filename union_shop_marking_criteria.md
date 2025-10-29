# Union Shop - Marking Criteria Table

## Functionality Requirements Sorted by Difficulty

| Feature | Description | Marks (%) | Reference |
|---------|-------------|-----------|-----------|
| **Basic (40%)** |
| Static Homepage | Homepage layout and widgets with static content (hardcoded data* acceptable, mobile view focus) | 5% | [Homepage](https://shop.upsu.net/) |
| Static Navbar | Top navigation bar with menu (links do not have to work at this stage, mobile view focus) | 5% | [Homepage](https://shop.upsu.net/) |
| About Us Page | Static about us page with company information (separate page from homepage) | 5% | [About Us](https://shop.upsu.net/pages/about-us) |
| Footer | Footer with dummy links and information present in at least one page | 4% | [Homepage](https://shop.upsu.net/) |
| Dummy Collections Page | Page displaying various collections of products (hardcoded data* acceptable) | 5% | [Collections](https://shop.upsu.net/collections/) |
| Dummy Collection Page | Page displaying products within one collection including dropdowns and filters (hardcoded data* acceptable, widgets do not have to function) | 5% | [Collection Example](https://shop.upsu.net/collections/autumn-favourites) |
| Dummy Product Page | Product page showing details and images with dropdowns, buttons and widgets (hardcoded data* acceptable, widgets do not have to function) | 4% | [Product Example](https://shop.upsu.net/collections/autumn-favourites/products/classic-sweatshirt-1) |
| Sale Collection | Page showing sale products with discounted prices and promotional messaging (hardcoded data* acceptable, widgets do not have to function) | 4% | [Sale Items](https://shop.upsu.net/collections/sale-items) |
| Authentication UI | Login/signup page with the relevant forms (widgets do not have to function) | 3% | [Sign In](https://shop.upsu.net/account/login) |
| **Intermediate (35%)** |
| Dynamic Collections | Collections page populated from data models or services with functioning sorting, filtering, pagination widgets | 6% | [Collections](https://shop.upsu.net/collections/) |
| Dynamic Product Listings | Product listings of a collection populated from data models or services with functioning sorting, filtering, pagination widgets | 7% | [Autumn Favourites](https://shop.upsu.net/collections/autumn-favourites) |
| Functional Product Pages | Product pages populated from data models or services with functioning dropdowns and counters (add to cart buttons do not have to work yet) | 7% | [Product Example](https://shop.upsu.net/collections/autumn-favourites/products/classic-sweatshirt-1) |
| Shopping Cart | Add items to cart, view cart page, basic cart functionality (checkout buttons should place order without real monetary transactions) | 7% | [Cart](https://shop.upsu.net/cart) |
| Print Shack Forms | [Text personalisation page](https://shop.upsu.net/products/personalise-text) with [associated about page](https://shop.upsu.net/pages/personalisation), the form must dynamically update based on selected fields | 3% | [Personalisation](https://shop.upsu.net/products/personalise-text) |
| Responsiveness* | The layout of the application should be adaptive and the application should function on desktop in addition to mobile view (no need to test it on real devices) | 5% | All pages |
| **Advanced (25%)** |
| Authentication System | Full user authentication and account management (you can implement this with other external authentications like Google, not just Shop), includes the account dashboard and all relevant functionality | 8% | [Account](https://shop.upsu.net/account) |
| Cart Management | Full cart functionality including quantity editing/removal, price calculations and persistence | 6% | [Cart](https://shop.upsu.net/cart) |
| Search System | Complete search functionality (search buttons should function on the navbar and the footer) | 4% | [Search](https://shop.upsu.net/search) |

## Additional Considerations

### Bonus Features (Not required but can earn extra credit)
- Pagination on collection pages
- Social sharing buttons
- Email newsletter signup
- Size guide functionality
- Order notes in cart
- Mobile hamburger menu
- Cart badge with item count

### Technical Implementation Notes
- Focus on functionality over visual design
- External integrations (Shopify auth, payment systems) not required
- **Basic Level**: Hardcoded data* acceptable for collections and products
- **Intermediate Level**: UI implementation focus, data can be simulated
- **Advanced Level**: Full functionality with proper data management and state handling

### Terminology
**Hardcoded data*** = Data that is written directly into your Flutter code. These are fixed values rather than data loaded from external sources like APIs, databases, or other services.

**Dummy data** = Data that is often hardcoded or (AI) generated for display or testing purposes. It's not meant to represent real-world data stored in your services.

**Responsive** = Design that adapts to different screen sizes for example different layouts on mobile and desktop targets. For the purpose of this coursework, you are primarily developing a web application on mobile view.

### Mark Distribution Summary
- **Basic (40%)**: Essential pages, navigation, static content (hardcoded data* acceptable)
- **Intermediate (35%)**: Core e-commerce UI and dynamic content from data models/services
- **Advanced (25%)**: Complete systems with full functionality and data management

**Total: 100%**