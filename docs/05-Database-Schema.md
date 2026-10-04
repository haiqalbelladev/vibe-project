# Database Schema — Project 01

## Identity
users, roles, permissions, user_roles, role_permissions

## Organization
organizational_units, user_organizational_units

## Master
item_categories, units_of_measure, items, item_aliases, suppliers, supplier_bank_accounts, warehouses, user_warehouse_scopes, stock_classifications

## Inventory
inventories, inventory_ledger

Inventory identity: item + warehouse + stock classification.

## Procurement
purchase_requests, purchase_request_items, purchase_request_approvals, purchase_request_item_approvals, purchase_request_item_routes, purchase_orders, purchase_order_items, purchase_order_allocations, supplier_deliveries

## Warehouse
goods_receipts, goods_receipt_items, outbounds, outbound_items, stock_opnames, stock_opname_items

## Finance
budgets, budget_disbursements, cash_transactions, lpjs, lpj_items, supplier_invoices, invoice_po_allocations, payment_requests, payment_request_invoices, payment_batches, payment_allocations, payment_proofs

## System
notifications, whatsapp_messages, access_tokens, audit_logs, document_files, approval_routes, approval_route_steps, approval_assignments, document_configurations, document_templates, document_template_revisions, generated_documents, document_sequences

## Approval Seeds
PR_INTERNAL: UNIT_LEADER → PURCHASING_WAREHOUSE_HEAD → WAREHOUSE_STAFF
PR_EXTERNAL: UNIT_LEADER → PURCHASING_WAREHOUSE_HEAD → PURCHASING_STAFF
STOCK_OPNAME: PURCHASING_WAREHOUSE_HEAD → HOUSEHOLD_HEAD → ACCOUNTING_STAFF
CASH_LPJ: PURCHASING_WAREHOUSE_HEAD → HOUSEHOLD_HEAD → FINANCE_STAFF
TEMPO_PAYMENT: PURCHASING_WAREHOUSE_HEAD → HOUSEHOLD_HEAD → FINANCE_STAFF

## Stock Opname Integrity
Physical count is a snapshot. Discrepancy reason is mandatory. No adjustment before final approval. Adjustment is posted to the inventory ledger. BA references the finalized stock opname.

## General Integrity
quantity > 0 where applicable
unit_price >= 0
received = accepted + rejected
accepted <= received
approved + rejected <= requested
PO allocation <= approved PR quantity
payment allocation <= invoice outstanding
negative stock prohibited unless formally changed
related changes are atomic DB transactions

## Document Identity
`document_configurations` stores organization identity.
`document_templates` and revisions store controlled templates.
`generated_documents` stores generated document records.
`document_sequences` supports `TYPE/YYYY/NNNNNN`.
