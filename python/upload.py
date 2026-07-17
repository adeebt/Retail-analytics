import pandas as pd
from sqlalchemy import create_engine

print("Reading Excel files...")

# ── Read Transaction (2 sheets) ──────────────────────────
sheet1 = pd.read_excel('Transaction.xlsx',
                        sheet_name='Sheet1',
                        dtype={
                            'Invoice'  : str,
                            'StockCode': str,
                            'Quantity' : int,
                            'Price'    : float
                        })

sheet2 = pd.read_excel('Transaction.xlsx',
                        sheet_name='Sheet2',
                        dtype={
                            'Invoice'  : str,
                            'StockCode': str,
                            'Quantity' : int,
                            'Price'    : float
                        })

invoice_items = pd.concat([sheet1, sheet2], ignore_index=True)
print("✅ Transaction  —", len(invoice_items), "rows")


# ── Read Customers ───────────────────────────────────────
customers = pd.read_excel('Customers.xlsx',
                           dtype={'CustomerID': str})
print("✅ Customers    —", len(customers), "rows")


# ── Read Products ────────────────────────────────────────
products = pd.read_excel('Products.xlsx',
                          dtype={'StockCode': str})
print("✅ Products     —", len(products), "rows")


# ── Read Invoices ────────────────────────────────────────
invoices = pd.read_excel('Invoices.xlsx',
                          dtype={
                              'Invoice'   : str,
                              'CustomerID': str
                          },
                          parse_dates=['InvoiceDate'])

# Fix column name if it has space
invoices = invoices.rename(columns={'Customer ID': 'CustomerID'})

# Fix CustomerID format (remove .0)
invoices['CustomerID'] = invoices['CustomerID'].fillna(0).astype(float).astype(int).astype(str)
invoices['CustomerID'] = invoices['CustomerID'].replace('0', None)

print("✅ Invoices     —", len(invoices), "rows")


# ── Connect to MySQL ─────────────────────────────────────
print("\nConnecting to MySQL...")
engine = create_engine(
    'mysql+pymysql://root:admin123@localhost/retail_db?charset=utf8mb4'
    #                      ↑
    #              change YourPassword to your actual MySQL password!
)
print("✅ Connected to MySQL!")


# ── Upload All 4 Tables ──────────────────────────────────
print("\nUploading tables...")

customers.to_sql(
    name='customers', con=engine,
    if_exists='replace', index=False
)
print("✅ customers uploaded    —", len(customers), "rows")

products.to_sql(
    name='products', con=engine,
    if_exists='replace', index=False
)
print("✅ products uploaded     —", len(products), "rows")

invoices.to_sql(
    name='invoices', con=engine,
    if_exists='replace', index=False
)
print("✅ invoices uploaded     —", len(invoices), "rows")

print("Uploading invoice_items... this will take 1-2 minutes")
invoice_items.to_sql(
    name='invoice_items', con=engine,
    if_exists='replace', index=False,
    chunksize=10000
)
print("✅ invoice_items uploaded —", len(invoice_items), "rows")

print("\n🎉 All tables uploaded successfully!")