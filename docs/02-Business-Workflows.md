# Business Workflows — Project 01

## Workflow 01 — Purchase Requisition
Requester submits an online PR. One PR may contain many items. Unit Leader approves/rejects per item. Kasubag Pembelian & Gudang routes approved items to Warehouse Staff or Purchasing Staff. Requester receives the result through WhatsApp and a secure official PR link.

## Workflow 02 — Warehouse Outbound
Warehouse checks and prepares goods. Outbound may be partial. Stock decreases only when outbound is posted. Posting atomically updates stock, ledger, fulfillment, BAST and audit data; WhatsApp is sent after commit.

## Workflow 03 — PO and Receiving
Purchasing selects supplier and price. The system creates supplier-grouped PO documents. No extra approval is required at this PO stage. `Selesaikan PO` moves the PO to receiving; it does not increase stock. Warehouse posts GRN.

Receiving types:
- STOCK
- CROSS_DOCK
- DIRECT_DELIVERY

Only accepted STOCK quantity enters managed inventory.

## Workflow 04 — Stock Opname
1. Warehouse creates snapshot.
2. Physical count is recorded.
3. Every discrepancy has a mandatory reason.
4. Staff submits.
5. Kasubag reviews.
6. Mudir gives final approval.
7. System posts adjustment.
8. Finance/Accounting acknowledges where required.
9. BA Stock Opname is finalized.

States:
DRAFT → SUBMITTED → UNDER_REVIEW → RETURNED → KASUBAG_APPROVED → MUDIR_APPROVED → POSTED → ACKNOWLEDGED → COMPLETED

## Workflow 05 — Cash
Staff Purchasing enters physical cash receipt and prepares LPJ. Approval: Kasubag → Mudir → Finance. LPJ links to budget disbursement and shows budget amount, spending, and LEBIH/KURANG.

## Workflow 06 — Tempo
Warehouse Staff enters supplier invoice/payment request. Approval: Kasubag → Mudir → Finance. Finance executes payment and may send payment proof through WhatsApp.

## Inventory Integrity
- GRN received = accepted + rejected.
- Accepted <= received.
- Damage requires a note/reason.
- Posted transactions are immutable.
- Stock changes through ledger-backed transactions.
- Average cost changes only through valid posted receiving/adjustment rules.
