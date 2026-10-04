# PRD — Project 01

## Product
Procurement & Warehouse Management System

## Problem
The existing PMS (Procurement Management System) uses Google Apps Script and Google Spreadsheet. High transaction volume has made it heavy and less suitable for continued growth.

## Goal
Build a robust online procurement and warehouse system using a transactional relational database and modular architecture, with a free-first approach where practical.

## Core Scope
- Purchase Requisition and approval
- Purchase Order and supplier communication
- Warehouse inbound/GRN
- Warehouse outbound/BAST
- Inventory ledger and stock card
- Stock opname
- Cash and tempo transactions
- LPJ and payment request
- Payment proof
- WhatsApp notification
- Reporting and dashboards
- RBAC and permissions

## Key Rules
- One PR may contain many items.
- Approval is item-level and may be partial.
- PR snapshots are immutable after submission.
- PO completion does not increase stock.
- GRN is the official receiving transaction.
- Only accepted STOCK receiving increases managed stock.
- CROSS_DOCK and DIRECT_DELIVERY do not create normal warehouse stock.
- Every stock opname discrepancy requires a reason.
- No stock opname adjustment before final approval.
- Inventory uses a ledger and average-cost valuation.
- Posted transactions are immutable; corrections use reversal/revision.
- External links use scoped secure tokens.
- WhatsApp notifications occur asynchronously after successful database commit.
