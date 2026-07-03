# Software Requirements Specification (SRS)

## Part 02C: Menu & Catalog Management

**Module:** Merchant Module (Part 03)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Menu & Catalog Management module defines the comprehensive capabilities for merchants to create, organize, maintain, and optimize their product catalog on the **[Platform Name]** platform. This encompasses everything from basic menu item creation through complex modifier hierarchies, bulk operations, inventory tracking, and multi-store catalog synchronization.

The menu is the merchant's primary digital storefront. The quality, completeness, and accuracy of the catalog directly impact customer conversion, average order value, and overall platform satisfaction. A well-designed catalog management system reduces merchant operational overhead, minimizes errors, and ensures customers always see accurate, up-to-date product information.

### Objectives

- Enable intuitive and efficient menu creation and maintenance
- Support complex product customization (modifiers, add-ons, options)
- Provide bulk operations for large catalogs (chains, grocery, retail)
- Enable real-time inventory management and availability tracking
- Support multi-store catalog synchronization
- Ensure catalog data consistency across customer-facing channels
- Provide import/export capabilities for seamless data migration
- Enable promotional pricing and time-based offers

---

## Chapter 2 – Menu Structure

### MER-039 Menu Hierarchy

The menu follows a structured hierarchy to enable logical organization and efficient management:

```
Store
  └── Categories
        └── Items
              └── Modifier Groups
                    └── Modifier Options
```

| Level | Entity | Description |
| :--- | :--- | :--- |
| **Level 1** | Store | Top-level merchant location |
| **Level 2** | Category | Logical grouping of items (e.g., "Appetizers", "Mains") |
| **Level 3** | Item | Individual sellable product |
| **Level 4** | Modifier Group | Group of related options (e.g., "Choose Your Sauce") |
| **Level 5** | Modifier Option | Individual choice within a group (e.g., "Spicy Mayo") |

### MER-040 Category Attributes

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `category_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `category_name` | String | Yes | Display name (e.g., "Pizzas") |
| `category_description` | Text | No | Description (e.g., "Hand-tossed stone-baked pizzas") |
| `category_image` | URL | No | Category thumbnail image |
| `display_order` | Integer | Yes | Sorting order within menu |
| `is_available` | Boolean | Yes | Category availability toggle |
| `display_on_website` | Boolean | Yes | Show/hide on web/mobile |
| `parent_category_id` | UUID | No | For sub-categories |
| `is_featured` | Boolean | Default false | Featured category on homepage |
| `slug` | String | Unique | URL-friendly identifier |

### MER-041 Item Attributes

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `item_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `category_id` | UUID | Yes | Parent category |
| `item_name` | String | Yes | Product display name |
| `item_description` | Text | No | Detailed description (ingredients, preparation) |
| `item_short_description` | String | No | Brief description (for listing views) |
| `price` | Decimal | Yes | Current selling price |
| `compare_at_price` | Decimal | No | Original price (for discount display) |
| `cost_price` | Decimal | No | Merchant cost (for analytics) |
| `item_image` | URL | No | Primary product image |
| `item_images` | Array | No | Gallery of product images |
| `sku` | String | No | Stock keeping unit (inventory) |
| `barcode` | String | No | Barcode/UPC (if applicable) |
| `weight` | Decimal | No | Product weight (for shipping) |
| `preparation_time` | Integer | No | Prep time override (minutes) |
| `is_available` | Boolean | Yes | Item availability toggle |
| `is_featured` | Boolean | Default false | Featured item flag |
| `is_best_seller` | Boolean | Default false | Best seller badge |
| `is_new` | Boolean | Default false | New item badge |
| `dietary_tags` | Array | No | VEGAN/VEGETARIAN/GLUTEN_FREE/HALAL/KOSHER/ORGANIC |
| `allergen_tags` | Array | No | NUTS/DAIRY/EGGS/SOY/SHELLFISH/WHEAT |
| `portion_size` | String | No | Serving size information |
| `calories` | Integer | No | Calorie count |
| `nutrition_facts` | JSONB | No | Structured nutrition information |
| `tags` | Array | No | Custom tags for search/filtering |
| `slug` | String | Unique | URL-friendly identifier |
| `sort_order` | Integer | Yes | Display order within category |
| `min_order_quantity` | Integer | Default 1 | Minimum quantity per order |
| `max_order_quantity` | Integer | No | Maximum quantity per order |
| `allow_zero_price` | Boolean | Default false | Allow free items (promotions) |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |
| `last_ordered_at` | Timestamp | No | Last order timestamp (analytics) |

---

## Chapter 3 – Modifier Management

### MER-042 Modifier Group Types

| Type | Description | Example |
| :--- | :--- | :--- |
| **Single Select (Radio)** | Customer must choose exactly one option. | Size: Small/Medium/Large |
| **Multi-Select (Checkbox)** | Customer can choose any combination. | Extras: Cheese, Bacon, Guac |
| **Quantity Selector** | Customer specifies quantity of a modifier. | Extra Sauce: 1/2/3 servings |
| **Free Text** | Customer types specific instruction. | Special instructions: "No onions" |

### MER-043 Modifier Group Attributes

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `modifier_group_id` | UUID | Yes | Unique identifier |
| `item_id` | UUID | Yes | Associated menu item |
| `group_name` | String | Yes | Display name (e.g., "Choose Your Size") |
| `group_type` | Enum | Yes | SINGLE/MULTI/QUANTITY/TEXT |
| `min_selections` | Integer | Default 0 | Minimum selections required |
| `max_selections` | Integer | No | Maximum selections allowed |
| `is_required` | Boolean | Default false | Customer must make selection |
| `display_order` | Integer | Yes | Display order on item |
| `is_available` | Boolean | Yes | Group availability toggle |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-044 Modifier Option Attributes

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `modifier_option_id` | UUID | Yes | Unique identifier |
| `modifier_group_id` | UUID | Yes | Associated modifier group |
| `option_name` | String | Yes | Display name |
| `price_adjustment` | Decimal | Default 0 | Additional cost (can be negative for discounts) |
| `weight_adjustment` | Decimal | No | Weight change (for shipping) |
| `prep_time_adjustment` | Integer | No | Prep time impact (minutes) |
| `calorie_adjustment` | Integer | No | Calorie impact |
| `is_available` | Boolean | Yes | Option availability toggle |
| `is_default` | Boolean | Default false | Default selection (if applicable) |
| `display_order` | Integer | Yes | Display order within group |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-045 Nested Modifiers (Advanced)

For complex products, modifiers may be nested within modifier groups.

| Scenario | Example |
| :--- | :--- |
| **Pizza Customization** | Choose Size (Small/Medium/Large) → Choose Crust (Thin/Thick/Stuffed) → Choose Sauce (Tomato/BBQ/Pesto) → Choose Toppings (Pepperoni/Mushrooms/Onions) |

**Technical Implication:** Modifier groups can reference other modifier groups, creating dependency trees. The system must validate compatibility (e.g., "Stuffed Crust" only available on Large pizzas).

---

## Chapter 4 – Bulk Operations

### MER-046 Bulk Item Management

| Operation | Description | Priority |
| :--- | :--- | :--- |
| **Bulk Add** | Add multiple items at once via CSV/Excel import. | **Required** |
| **Bulk Update** | Update attributes for multiple items. | **Required** |
| **Bulk Delete** | Delete multiple items (with confirmation). | **Required** |
| **Bulk Availability** | Toggle availability for multiple items. | **Required** |
| **Bulk Price Update** | Update prices for multiple items (percentage or fixed). | **Required** |
| **Bulk Category Move** | Move multiple items to a different category. | **Required** |
| **Bulk Tag** | Add/remove tags for multiple items. | **Medium** |
| **Bulk Image Upload** | Upload images for multiple items. | **Medium** |

### MER-047 Import/Export Specifications

| Attribute | Specification |
| :--- | :--- |
| **Supported Formats** | CSV, Excel (.xlsx), JSON |
| **File Size Limit** | 50 MB per import |
| **Max Rows** | 10,000 items per import |
| **Required Columns** | Item Name, Category, Price |
| **Optional Columns** | Description, Images (URLs), Dietary Tags, Availability |
| **Validation** | Pre-import validation with error reporting |
| **Mapping** | Custom column mapping supported |
| **Preview** | Preview import before execution |
| **History** | Import/export history maintained |
| **Export Formats** | CSV, Excel, JSON, XML |

### MER-048 Bulk Import Workflow

1.  Merchant downloads template (CSV/Excel).
2.  Merchant populates data in template.
3.  Merchant uploads file.
4.  System validates file format and data.
5.  System displays validation errors (if any).
6.  Merchant fixes errors and re-uploads.
7.  System previews the import with sample data.
8.  Merchant confirms import.
9.  System processes import asynchronously.
10. Merchant receives email notification on completion.
11. Import status visible in dashboard.

### MER-049 Bulk Import Error Handling

| Error Type | Handling |
| :--- | :--- |
| **Format Error** | File rejected; error details provided. |
| **Invalid Data** | Row rejected with reason; remaining rows processed. |
| **Duplicate SKU** | Warning displayed; merchant chooses skip/overwrite. |
| **Missing Required Fields** | Row rejected; error reported. |
| **Category Not Found** | Row rejected; merchant can create category in advance. |
| **Price Validation** | Row rejected if price invalid. |

---

## Chapter 5 – Inventory Management

### MER-050 Inventory Tracking

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Inventory Tracking** | Track stock levels for menu items. | **Required** |
| **Real-Time Updates** | Inventory updates in real-time as orders are placed. | **Required** |
| **Low Stock Alerts** | Alert when inventory falls below threshold. | **Required** |
| **Out-of-Stock Auto-Disable** | Auto-hide items when inventory reaches zero. | **Required** |
| **Inventory Replenishment** | Manual or automated inventory updates. | **Required** |
| **Inventory History** | Track inventory changes over time. | **Medium** |
| **Supplier Integration** | Connect to supplier systems for auto-replenishment. | **Future** |
| **Batch/Lot Tracking** | Track batches for perishable items. | **Future** |

### MER-051 Inventory Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `inventory_id` | UUID | Yes | Unique identifier |
| `item_id` | UUID | Yes | Associated menu item |
| `store_id` | UUID | Yes | Associated store |
| `current_stock` | Integer | Yes | Current inventory level |
| `minimum_stock` | Integer | Yes | Minimum threshold for alerts |
| `maximum_stock` | Integer | No | Maximum capacity |
| `reorder_point` | Integer | Yes | Stock level triggering reorder |
| `reorder_quantity` | Integer | Yes | Quantity to reorder |
| `unit_type` | String | Yes | EACH/KG/LB/GRAM/METER/LITER |
| `last_updated` | Timestamp | Yes | Last inventory update timestamp |
| `updated_by` | UUID | No | User who updated inventory |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-052 Inventory Adjustment Types

| Adjustment Type | Description | Impact |
| :--- | :--- | :--- |
| **Manual Adjustment** | Merchant manually updates inventory. | +/- |
| **Order Deduction** | Auto-deduct when order is placed. | - |
| **Order Reversal** | Auto-add when order is cancelled/refunded. | + |
| **Supplier Delivery** | Inventory received from supplier. | + |
| **Waste/Expiration** | Items wasted or expired. | - |
| **Transfer** | Transfer between stores (multi-store). | +/- |
| **Cycle Count** | Physical inventory correction. | +/- |

### MER-053 Inventory Business Rules

| Rule | Description |
| :--- | :--- |
| **Real-Time Deduction** | Inventory deducted immediately upon order confirmation. |
| **Availability Check** | Items with zero inventory are marked unavailable. |
| **Hold Reservation** | Inventory reserved at confirmation, released if order cancelled. |
| **Batch Processing** | Multiple inventory updates processed in batch for efficiency. |
| **Audit Trail** | All inventory changes logged for audit. |
| **Per-Store Inventory** | Inventory tracked per store (not across chain). |

---

## Chapter 6 – Menu Scheduling

### MER-054 Time-Based Availability

| Schedule Type | Description | Priority |
| :--- | :--- | :--- |
| **Item Availability Schedule** | Specific items available only at certain times. | **Required** |
| **Category Availability** | Categories available at specific times. | **Medium** |
| **Menu Rotations** | Different menus for breakfast, lunch, dinner. | **Required** |
| **Day-Specific Menus** | Different menus on different days. | **Required** |
| **Holiday/Hours** | Special hours/menus for holidays. | **Medium** |

### MER-055 Menu Scheduling Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `schedule_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `reference_type` | String | Yes | ITEM/CATEGORY/GLOBAL |
| `reference_id` | UUID | Yes | ID of item or category |
| `day_of_week` | Array | Yes | Days applicable |
| `start_time` | Time | Yes | Start time (HH:MM) |
| `end_time` | Time | Yes | End time (HH:MM) |
| `is_recurring` | Boolean | Yes | Recurring weekly schedule |
| `start_date` | Date | No | Specific start date (for events) |
| `end_date` | Date | No | Specific end date (for events) |
| `menu_type` | String | No | BREAKFAST/LUNCH/DINNER/LATE_NIGHT |
| `is_active` | Boolean | Yes | Schedule active status |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-056 Menu Rotation Example

| Time Period | Menu Items |
| :--- | :--- |
| **Breakfast (6:00 AM - 11:00 AM)** | Breakfast sandwiches, coffee, pastries |
| **Lunch (11:00 AM - 4:00 PM)** | Sandwiches, salads, soups |
| **Dinner (4:00 PM - 10:00 PM)** | Full dinner menu, appetizers, mains, desserts |
| **Late Night (10:00 PM - 2:00 AM)** | Limited late-night menu |

---

## Chapter 7 – Multi-Store Catalog Management

### MER-057 Chain Management Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Central Catalog** | Master catalog for all stores. | **Required** |
| **Store Overrides** | Store-specific price/availability overrides. | **Required** |
| **Bulk Copy** | Copy menu from one store to another. | **Required** |
| **Template Management** | Save menu as template for new stores. | **Required** |
| **Centralized Updates** | Update all stores simultaneously. | **Required** |
| **Store-Specific Items** | Items available only at specific stores. | **Required** |
| **Hierarchical Pricing** | Global → Regional → Store pricing. | **Medium** |

### MER-058 Store Override Rules

| Rule | Description |
| :--- | :--- |
| **Override Hierarchy** | Store override > Regional override > Global default. |
| **Override Scope** | Price, availability, description, prep time, modifiers. |
| **Override Tracking** | All overrides logged for audit. |
| **Override Revert** | Ability to revert to global/regional values. |
| **Override Bulk Operations** | Apply overrides to multiple stores simultaneously. |

---

## Chapter 8 – Catalog Integration

### MER-059 POS/ERP Integration

| Integration | Description | Priority |
| :--- | :--- | :--- |
| **Real-Time Sync** | Automatic menu/inventory synchronization. | **Required** |
| **Bidirectional Sync** | Changes in POS reflected in platform and vice versa. | **Required** |
| **Conflict Resolution** | Handle conflicts when changes occur in both systems. | **Required** |
| **Offline Sync** | Synchronize when connectivity is restored. | **Required** |
| **Menu Mapping** | Map platform menu items to POS SKUs. | **Required** |
| **Multi-POS Support** | Support multiple POS systems per store. | **Medium** |

### MER-060 Integration Sync Rules

| Sync Type | Direction | Frequency |
| :--- | :--- | :--- |
| **Menu Structure** | Bidirectional | On-change + Daily |
| **Item Details** | Bidirectional | On-change + Daily |
| **Modifiers** | Bidirectional | On-change + Daily |
| **Pricing** | Bidirectional | On-change + Daily |
| **Inventory** | Bidirectional | Real-time (when possible) |
| **Availability** | Bidirectional | On-change + Daily |
| **Order Sync** | Platform → POS | Real-time |

---

## Chapter 9 – Catalog Discovery & Search

### MER-061 Catalog SEO & Discoverability

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Item Tags** | Keywords for search optimization. | **Required** |
| **Category Tags** | Keywords for category discoverability. | **Required** |
| **Item Descriptions** | Rich descriptions for SEO. | **Required** |
| **Item Images** | Image alt text for accessibility/SEO. | **Medium** |
| **Meta Titles/Descriptions** | SEO metadata. | **Medium** |
| **Featured Items** | Boost visibility. | **High** |
| **Popular/Search Rank** | Rank items based on popularity. | **Medium** |

### MER-062 Customer-Facing Catalog View

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Real-Time Availability** | Only show available items to customers. | **Required** |
| **Stock Indicators** | Show "In Stock" or "Low Stock" badges. | **Required** |
| **Price Display** | Show current price with any discounts. | **Required** |
| **Item Images** | High-quality product images. | **Required** |
| **Dietary Tags** | Show dietary tags (Vegan, Halal, etc.). | **Required** |
| **Allergen Warnings** | Show allergen information. | **Required** |
| **Popularity Badges** | "Best Seller", "Popular" badges. | **Required** |
| **Category Navigation** | Easy browsing by category. | **Required** |
| **Search Integration** | Search within merchant menu. | **Required** |
| **Modifier Preview** | Show available customizations. | **Required** |

---

## Chapter 10 – Database Tables

### menu_items

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `item_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `category_id` | UUID | FOREIGN KEY (menu_categories.category_id) | Parent category |
| `item_name` | VARCHAR(255) | NOT NULL | Product display name |
| `item_description` | TEXT | | Detailed description |
| `item_short_description` | VARCHAR(255) | | Brief description |
| `price` | DECIMAL(12, 2) | NOT NULL | Current selling price |
| `compare_at_price` | DECIMAL(12, 2) | | Original price (for discounts) |
| `cost_price` | DECIMAL(12, 2) | | Merchant cost |
| `primary_image` | VARCHAR(500) | | Primary product image URL |
| `gallery_images` | TEXT[] | | Gallery image URLs |
| `sku` | VARCHAR(100) | | Stock keeping unit |
| `barcode` | VARCHAR(50) | | Barcode/UPC |
| `weight` | DECIMAL(10, 2) | | Product weight |
| `preparation_time` | INTEGER | | Prep time override (minutes) |
| `is_available` | BOOLEAN | DEFAULT TRUE | Availability toggle |
| `is_featured` | BOOLEAN | DEFAULT FALSE | Featured item flag |
| `is_best_seller` | BOOLEAN | DEFAULT FALSE | Best seller badge |
| `is_new` | BOOLEAN | DEFAULT FALSE | New item badge |
| `dietary_tags` | TEXT[] | | VEGAN/VEGETARIAN/GLUTEN_FREE/HALAL |
| `allergen_tags` | TEXT[] | | NUTS/DAIRY/EGGS/SOY/SHELLFISH/WHEAT |
| `portion_size` | VARCHAR(50) | | Serving size |
| `calories` | INTEGER | | Calorie count |
| `nutrition_facts` | JSONB | | Structured nutrition information |
| `tags` | TEXT[] | | Custom search tags |
| `slug` | VARCHAR(255) | UNIQUE | URL-friendly identifier |
| `sort_order` | INTEGER | DEFAULT 0 | Display order |
| `min_order_quantity` | INTEGER | DEFAULT 1 | Minimum quantity |
| `max_order_quantity` | INTEGER | | Maximum quantity |
| `allow_zero_price` | BOOLEAN | DEFAULT FALSE | Allow free items |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |
| `last_ordered_at` | TIMESTAMP | | Last order timestamp |

### menu_categories

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `category_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `category_name` | VARCHAR(100) | NOT NULL | Display name |
| `category_description` | TEXT | | Category description |
| `category_image` | VARCHAR(500) | | Category image URL |
| `display_order` | INTEGER | DEFAULT 0 | Sorting order |
| `is_available` | BOOLEAN | DEFAULT TRUE | Availability toggle |
| `display_on_website` | BOOLEAN | DEFAULT TRUE | Show/hide on web/mobile |
| `parent_category_id` | UUID | FOREIGN KEY (menu_categories.category_id) | Parent category (sub-categories) |
| `is_featured` | BOOLEAN | DEFAULT FALSE | Featured category |
| `slug` | VARCHAR(255) | UNIQUE | URL-friendly identifier |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### modifier_groups

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `modifier_group_id` | UUID | PRIMARY KEY | Unique identifier |
| `item_id` | UUID | FOREIGN KEY (menu_items.item_id) | Associated menu item |
| `group_name` | VARCHAR(100) | NOT NULL | Display name |
| `group_type` | VARCHAR(20) | NOT NULL | SINGLE/MULTI/QUANTITY/TEXT |
| `min_selections` | INTEGER | DEFAULT 0 | Minimum selections required |
| `max_selections` | INTEGER | | Maximum selections allowed |
| `is_required` | BOOLEAN | DEFAULT FALSE | Required selection |
| `display_order` | INTEGER | DEFAULT 0 | Display order |
| `is_available` | BOOLEAN | DEFAULT TRUE | Availability toggle |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### modifier_options

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `modifier_option_id` | UUID | PRIMARY KEY | Unique identifier |
| `modifier_group_id` | UUID | FOREIGN KEY (modifier_groups.modifier_group_id) | Associated group |
| `option_name` | VARCHAR(100) | NOT NULL | Display name |
| `price_adjustment` | DECIMAL(12, 2) | DEFAULT 0 | Price change |
| `weight_adjustment` | DECIMAL(10, 2) | | Weight change |
| `prep_time_adjustment` | INTEGER | | Prep time impact (minutes) |
| `calorie_adjustment` | INTEGER | | Calorie impact |
| `is_available` | BOOLEAN | DEFAULT TRUE | Availability toggle |
| `is_default` | BOOLEAN | DEFAULT FALSE | Default selection |
| `display_order` | INTEGER | DEFAULT 0 | Display order |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### inventory_items

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `inventory_id` | UUID | PRIMARY KEY | Unique identifier |
| `item_id` | UUID | FOREIGN KEY (menu_items.item_id) | Associated menu item |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `current_stock` | INTEGER | DEFAULT 0 | Current inventory level |
| `minimum_stock` | INTEGER | DEFAULT 0 | Minimum threshold |
| `maximum_stock` | INTEGER | | Maximum capacity |
| `reorder_point` | INTEGER | DEFAULT 0 | Reorder trigger level |
| `reorder_quantity` | INTEGER | DEFAULT 0 | Quantity to reorder |
| `unit_type` | VARCHAR(20) | DEFAULT 'EACH' | EACH/KG/LB/GRAM/METER/LITER |
| `last_updated` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |
| `updated_by` | UUID | | User who updated |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### inventory_transactions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `transaction_id` | UUID | PRIMARY KEY | Unique identifier |
| `inventory_id` | UUID | FOREIGN KEY (inventory_items.inventory_id) | Associated inventory |
| `transaction_type` | VARCHAR(20) | NOT NULL | ORDER/ADJUSTMENT/SUPPLIER/WASTE/TRANSFER/CYCLE_COUNT |
| `quantity_change` | INTEGER | NOT NULL | Change in quantity (+/-) |
| `quantity_before` | INTEGER | NOT NULL | Quantity before transaction |
| `quantity_after` | INTEGER | NOT NULL | Quantity after transaction |
| `reference_id` | UUID | | Order ID or transfer ID |
| `reason` | TEXT | | Reason for adjustment |
| `performed_by` | UUID | | User who performed adjustment |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Transaction timestamp |

### menu_schedules

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `schedule_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `reference_type` | VARCHAR(20) | NOT NULL | ITEM/CATEGORY/GLOBAL |
| `reference_id` | UUID | | ID of item or category |
| `day_of_week` | INTEGER[] | NOT NULL | Days applicable (0-6) |
| `start_time` | TIME | NOT NULL | Start time (HH:MM) |
| `end_time` | TIME | NOT NULL | End time (HH:MM) |
| `is_recurring` | BOOLEAN | DEFAULT TRUE | Recurring weekly schedule |
| `start_date` | DATE | | Specific start date |
| `end_date` | DATE | | Specific end date |
| `menu_type` | VARCHAR(20) | | BREAKFAST/LUNCH/DINNER/LATE_NIGHT |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### bulk_import_jobs

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `job_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `job_type` | VARCHAR(20) | NOT NULL | IMPORT/EXPORT |
| `file_name` | VARCHAR(255) | NOT NULL | Original filename |
| `file_url` | VARCHAR(500) | NOT NULL | Stored file URL |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/PROCESSING/COMPLETED/FAILED |
| `total_rows` | INTEGER | | Total rows processed |
| `success_rows` | INTEGER | | Successful rows |
| `error_rows` | INTEGER | | Rows with errors |
| `errors` | JSONB | | Detailed error log |
| `metadata` | JSONB | | Import configuration |
| `performed_by` | UUID | | User who performed job |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Job creation timestamp |
| `completed_at` | TIMESTAMP | | Job completion timestamp |

### chain_store_overrides

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `override_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Store with override |
| `item_id` | UUID | FOREIGN KEY (menu_items.item_id) | Menu item override |
| `price` | DECIMAL(12, 2) | | Override price |
| `is_available` | BOOLEAN | | Override availability |
| `preparation_time` | INTEGER | | Override prep time |
| `sort_order` | INTEGER | | Override display order |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 11 – REST APIs

### Category APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}/menu/categories` | List categories |
| `POST` | `/api/v1/merchant/stores/{id}/menu/categories` | Create category |
| `GET` | `/api/v1/merchant/stores/{id}/menu/categories/{id}` | Get category |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/categories/{id}` | Update category |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/categories/{id}` | Delete category |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/categories/reorder` | Reorder categories |

### Item APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}/menu/items` | List items |
| `POST` | `/api/v1/merchant/stores/{id}/menu/items` | Create item |
| `GET` | `/api/v1/merchant/stores/{id}/menu/items/{id}` | Get item |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/{id}` | Update item |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/items/{id}` | Delete item |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/{id}/availability` | Toggle item availability |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/bulk-availability` | Bulk toggle availability |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/bulk-price` | Bulk price update |

### Modifier APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers` | List modifier groups |
| `POST` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers` | Create modifier group |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Update modifier group |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Delete modifier group |
| `GET` | `/api/v1/merchant/stores/{id}/menu/modifiers/{id}/options` | List modifier options |
| `POST` | `/api/v1/merchant/stores/{id}/menu/modifiers/{id}/options` | Create modifier option |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/modifiers/{id}/options/{id}` | Update modifier option |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/modifiers/{id}/options/{id}` | Delete modifier option |

### Inventory APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}/inventory` | List inventory |
| `GET` | `/api/v1/merchant/stores/{id}/inventory/{item_id}` | Get inventory for item |
| `PUT` | `/api/v1/merchant/stores/{id}/inventory/{item_id}` | Update inventory |
| `POST` | `/api/v1/merchant/stores/{id}/inventory/adjust` | Adjust inventory |
| `GET` | `/api/v1/merchant/stores/{id}/inventory/history` | Get inventory history |
| `GET` | `/api/v1/merchant/stores/{id}/inventory/alerts` | Get low stock alerts |

### Bulk Operations APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/v1/merchant/stores/{id}/menu/import` | Import menu |
| `GET` | `/api/v1/merchant/stores/{id}/menu/export` | Export menu |
| `GET` | `/api/v1/merchant/stores/{id}/menu/import/status` | Get import status |
| `POST` | `/api/v1/merchant/stores/{id}/menu/import/template` | Download import template |

### Schedule APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}/schedule` | Get store schedule |
| `POST` | `/api/v1/merchant/stores/{id}/schedule` | Create schedule |
| `PUT` | `/api/v1/merchant/stores/{id}/schedule/{id}` | Update schedule |
| `DELETE` | `/api/v1/merchant/stores/{id}/schedule/{id}` | Delete schedule |

---

## Chapter 12 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-CAT-001** | Category names must be unique within a store. | **High** |
| **BR-CAT-002** | Item names must be unique within a store. | **High** |
| **BR-CAT-003** | Items cannot be assigned to inactive categories. | **High** |
| **BR-CAT-004** | Price must be >= 0 (minimum price is 0). | **High** |
| **BR-CAT-005** | SKU must be unique within a store (if provided). | **Medium** |
| **BR-CAT-006** | Modifier price adjustments can be negative (discounts) but cannot make item price negative. | **High** |
| **BR-CAT-007** | Single-select modifier groups require at least one option. | **High** |
| **BR-CAT-008** | Items cannot be deleted if they have pending orders. | **High** |
| **BR-CAT-009** | Category deletion cascades to items (with confirmation). | **High** |
| **BR-CAT-010** | Inventory cannot go negative. | **High** |
| **BR-CAT-011** | Schedule start_time must be before end_time. | **High** |
| **BR-CAT-012** | Bulk import max rows limited to 10,000 per file. | **Medium** |
| **BR-CAT-013** | Item images must be < 5MB and supported formats (JPG, PNG, WEBP). | **High** |

---

## Chapter 13 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-CAT-001** | Merchant creates a new category. | **High** |
| **TEST-CAT-002** | Merchant updates category name and description. | **High** |
| **TEST-CAT-003** | Merchant reorders categories (drag-and-drop). | **High** |
| **TEST-CAT-004** | Merchant deletes category (with item cascade confirmation). | **High** |
| **TEST-CAT-005** | Merchant creates a new menu item with all attributes. | **High** |
| **TEST-CAT-006** | Merchant updates item name, description, and price. | **High** |
| **TEST-CAT-007** | Merchant toggles item availability. | **High** |
| **TEST-CAT-008** | Merchant deletes an item. | **High** |
| **TEST-CAT-009** | Merchant uploads item image (validation: size, format). | **High** |
| **TEST-CAT-010** | Merchant creates a modifier group (single-select). | **High** |
| **TEST-CAT-011** | Merchant creates a modifier group (multi-select). | **High** |
| **TEST-CAT-012** | Merchant adds modifier options to a group. | **High** |
| **TEST-CAT-013** | Merchant sets price adjustment on modifier option. | **High** |
| **TEST-CAT-014** | Merchant deletes modifier group. | **High** |
| **TEST-CAT-015** | Merchant imports menu via CSV (valid file). | **High** |
| **TEST-CAT-016** | Merchant imports menu with errors (partial success with errors). | **High** |
| **TEST-CAT-017** | Merchant exports menu to CSV/Excel. | **High** |
| **TEST-CAT-018** | Merchant uses import template download. | **High** |
| **TEST-CAT-019** | Merchant tracks inventory for an item. | **High** |
| **TEST-CAT-020** | Inventory auto-deducts when order is confirmed. | **High** |
| **TEST-CAT-021** | Inventory auto-adds when order is cancelled. | **High** |
| **TEST-CAT-022** | Low stock alert triggers when inventory below threshold. | **High** |
| **TEST-CAT-023** | Item auto-disables when inventory reaches zero. | **High** |
| **TEST-CAT-024** | Merchant manually adjusts inventory. | **High** |
| **TEST-CAT-025** | Merchant creates item availability schedule. | **High** |
| **TEST-CAT-026** | Merchant creates day-specific menu schedule. | **High** |
| **TEST-CAT-027** | Customer sees only items available at current time. | **High** |
| **TEST-CAT-028** | Chain merchant copies menu from one store to another. | **High** |
| **TEST-CAT-029** | Chain merchant sets store-specific price override. | **High** |
| **TEST-CAT-030** | Modifier group validation (min/max selections). | **High** |
| **TEST-CAT-031** | Item search by name, category, tags. | **High** |
| **TEST-CAT-032** | Bulk availability toggle for multiple items. | **High** |
| **TEST-CAT-033** | Bulk price update for multiple items (percentage). | **High** |
| **TEST-CAT-034** | Bulk move items to different category. | **High** |

---

## Chapter 14 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| MER-040 | menu_categories | POST/GET/PUT/DELETE /api/v1/merchant/stores/{id}/menu/categories | TEST-CAT-001, TEST-CAT-002, TEST-CAT-003, TEST-CAT-004 |
| MER-041 | menu_items | POST/GET/PUT/DELETE /api/v1/merchant/stores/{id}/menu/items | TEST-CAT-005, TEST-CAT-006, TEST-CAT-007, TEST-CAT-008 |
| MER-041 | menu_items | PUT /api/v1/merchant/stores/{id}/menu/items/{id} | TEST-CAT-009 |
| MER-042 | modifier_groups | POST/GET/PUT/DELETE /api/v1/merchant/stores/{id}/menu/items/{id}/modifiers | TEST-CAT-010, TEST-CAT-011, TEST-CAT-012, TEST-CAT-013, TEST-CAT-014 |
| MER-046 | bulk_import_jobs | POST /api/v1/merchant/stores/{id}/menu/import | TEST-CAT-015, TEST-CAT-016, TEST-CAT-018 |
| MER-046 | bulk_import_jobs | GET /api/v1/merchant/stores/{id}/menu/export | TEST-CAT-017 |
| MER-050 | inventory_items, inventory_transactions | GET/PUT /api/v1/merchant/stores/{id}/inventory | TEST-CAT-019, TEST-CAT-020, TEST-CAT-021, TEST-CAT-024 |
| MER-050 | inventory_items | GET /api/v1/merchant/stores/{id}/inventory/alerts | TEST-CAT-022, TEST-CAT-023 |
| MER-054 | menu_schedules | POST/GET/PUT/DELETE /api/v1/merchant/stores/{id}/schedule | TEST-CAT-025, TEST-CAT-026, TEST-CAT-027 |
| MER-057 | chain_store_overrides | POST/GET/PUT/DELETE /api/v1/merchant/stores/{id}/overrides | TEST-CAT-028, TEST-CAT-029 |

---

## Chapter 15 – Summary

This document establishes the comprehensive menu and catalog management capability for the **[Platform Name]** platform. Key takeaways:

- **Structured Hierarchy:** Categories → Items → Modifier Groups → Options provides logical organization.
- **Rich Item Attributes:** Comprehensive item data including pricing, images, dietary tags, allergens, and nutrition information.
- **Flexible Modifiers:** Support for single-select, multi-select, quantity, and free-text modifiers with price adjustments.
- **Bulk Operations:** CSV/Excel import/export with validation, error handling, and large-scale catalog management.
- **Inventory Management:** Real-time inventory tracking with auto-deduction, low stock alerts, and auto-disable functionality.
- **Menu Scheduling:** Time-based availability with support for breakfast/lunch/dinner rotations and day-specific menus.
- **Multi-Store Support:** Centralized catalog management with store-specific overrides for chains and enterprises.
- **Integration Ready:** POS/ERP integration capabilities with bidirectional sync and conflict resolution.

The menu and catalog management module is the foundation of the merchant's digital presence. A well-designed catalog system ensures accurate product information, reduces operational errors, and creates a seamless customer experience from discovery to checkout.

---

**Next Document:**

`Part_02D_Merchant_Order_Management.md`

*(This builds on the catalog to define how merchants receive, process, and fulfill orders from customers.)*
