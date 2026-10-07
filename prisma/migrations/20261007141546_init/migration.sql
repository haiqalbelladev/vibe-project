-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "whatsapp" TEXT,
    "passwordHash" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_roles" (
    "userId" UUID NOT NULL,
    "roleId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_roles_pkey" PRIMARY KEY ("userId","roleId")
);

-- CreateTable
CREATE TABLE "role_permissions" (
    "roleId" UUID NOT NULL,
    "permissionId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("roleId","permissionId")
);

-- CreateTable
CREATE TABLE "organizational_units" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "parentId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "organizational_units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_organizational_units" (
    "userId" UUID NOT NULL,
    "organizationalUnitId" UUID NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_organizational_units_pkey" PRIMARY KEY ("userId","organizationalUnitId")
);

-- CreateTable
CREATE TABLE "item_categories" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "item_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "units_of_measure" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "units_of_measure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "items" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "categoryId" UUID NOT NULL,
    "uomId" UUID NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "item_aliases" (
    "id" UUID NOT NULL,
    "itemId" UUID NOT NULL,
    "alias" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "item_aliases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "suppliers" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "contactName" TEXT,
    "phone" TEXT,
    "whatsapp" TEXT,
    "email" TEXT,
    "address" TEXT,
    "taxNumber" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "suppliers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_bank_accounts" (
    "id" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "bankName" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "accountName" TEXT NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_bank_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_evaluations" (
    "id" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "evaluatorId" UUID NOT NULL,
    "evaluationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "periodStart" TIMESTAMP(3),
    "periodEnd" TIMESTAMP(3),
    "responsivenessScore" INTEGER,
    "serviceScore" INTEGER,
    "communicationScore" INTEGER,
    "problemResolutionScore" INTEGER,
    "professionalismScore" INTEGER,
    "overallScore" DECIMAL(5,2),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_evaluations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_follow_ups" (
    "id" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "evaluationId" UUID,
    "issue" TEXT NOT NULL,
    "evidence" TEXT,
    "correctiveAction" TEXT NOT NULL,
    "targetDate" TIMESTAMP(3),
    "picId" UUID NOT NULL,
    "status" TEXT NOT NULL,
    "result" TEXT,
    "decision" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_follow_ups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_performance_periods" (
    "id" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "poCount" INTEGER NOT NULL DEFAULT 0,
    "grnCount" INTEGER NOT NULL DEFAULT 0,
    "orderedQuantity" DECIMAL(18,4) NOT NULL DEFAULT 0,
    "receivedQuantity" DECIMAL(18,4) NOT NULL DEFAULT 0,
    "rejectedQuantity" DECIMAL(18,4) NOT NULL DEFAULT 0,
    "onTimeRate" DECIMAL(5,2),
    "quantityFulfillmentRate" DECIMAL(5,2),
    "qualityRate" DECIMAL(5,2),
    "automaticScore" DECIMAL(5,2),
    "manualScore" DECIMAL(5,2),
    "overallScore" DECIMAL(5,2),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_performance_periods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "warehouses" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "inventoryManaged" BOOLEAN NOT NULL DEFAULT true,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "warehouses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_warehouse_scopes" (
    "userId" UUID NOT NULL,
    "warehouseId" UUID NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_warehouse_scopes_pkey" PRIMARY KEY ("userId","warehouseId")
);

-- CreateTable
CREATE TABLE "stock_classifications" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_classifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventories" (
    "id" UUID NOT NULL,
    "itemId" UUID NOT NULL,
    "warehouseId" UUID NOT NULL,
    "stockClassificationId" UUID NOT NULL,
    "quantity" DECIMAL(18,4) NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "inventories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_ledger" (
    "id" UUID NOT NULL,
    "inventoryId" UUID NOT NULL,
    "goodsIssueItemId" UUID,
    "goodsReceiptItemId" UUID,
    "movementType" TEXT NOT NULL,
    "quantity" DECIMAL(18,4) NOT NULL,
    "quantityAfter" DECIMAL(18,4) NOT NULL,
    "unitCost" DECIMAL(18,4),
    "totalCost" DECIMAL(18,4),
    "referenceType" TEXT,
    "referenceId" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inventory_ledger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_requests" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "requesterId" UUID NOT NULL,
    "organizationalUnitId" UUID NOT NULL,
    "purpose" TEXT NOT NULL,
    "requestedDeliveryAt" TIMESTAMP(3),
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "purchase_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_request_items" (
    "id" UUID NOT NULL,
    "purchaseRequestId" UUID NOT NULL,
    "itemId" UUID NOT NULL,
    "uomId" UUID NOT NULL,
    "specification" TEXT,
    "quantity" DECIMAL(18,4) NOT NULL,
    "approvedQuantity" DECIMAL(18,4),
    "approvalStatus" TEXT NOT NULL,
    "approvalNote" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "purchase_request_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_request_approvals" (
    "id" UUID NOT NULL,
    "purchaseRequestItemId" UUID NOT NULL,
    "approverId" UUID NOT NULL,
    "decision" TEXT NOT NULL,
    "note" TEXT,
    "approvedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "purchase_request_approvals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_request_item_routings" (
    "id" UUID NOT NULL,
    "purchaseRequestItemId" UUID NOT NULL,
    "routedById" UUID NOT NULL,
    "destinationType" TEXT NOT NULL,
    "notes" TEXT,
    "routedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "purchase_request_item_routings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_orders" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "supplierId" UUID NOT NULL,
    "createdById" UUID NOT NULL,
    "orderDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "purchase_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchase_order_items" (
    "id" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "purchaseRequestItemId" UUID NOT NULL,
    "quantity" DECIMAL(18,4) NOT NULL,
    "unitPrice" DECIMAL(18,4) NOT NULL,
    "totalPrice" DECIMAL(18,4) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "purchase_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods_receipts" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "warehouseId" UUID NOT NULL,
    "receivedById" UUID NOT NULL,
    "receiptDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL,
    "receivingType" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "goods_receipts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods_receipt_items" (
    "id" UUID NOT NULL,
    "goodsReceiptId" UUID NOT NULL,
    "purchaseOrderItemId" UUID NOT NULL,
    "quantityReceived" DECIMAL(18,4) NOT NULL,
    "quantityAccepted" DECIMAL(18,4) NOT NULL,
    "quantityRejected" DECIMAL(18,4) NOT NULL,
    "condition" TEXT NOT NULL,
    "discrepancyReason" TEXT,
    "damageNote" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "goods_receipt_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods_issues" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "purchaseRequestId" UUID NOT NULL,
    "warehouseId" UUID NOT NULL,
    "issuedById" UUID NOT NULL,
    "issueDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "goods_issues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods_issue_items" (
    "id" UUID NOT NULL,
    "goodsIssueId" UUID NOT NULL,
    "purchaseRequestItemId" UUID NOT NULL,
    "inventoryId" UUID NOT NULL,
    "quantityIssued" DECIMAL(18,4) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "goods_issue_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_opnames" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "warehouseId" UUID NOT NULL,
    "createdById" UUID NOT NULL,
    "opnameDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_opnames_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_opname_items" (
    "id" UUID NOT NULL,
    "stockOpnameId" UUID NOT NULL,
    "inventoryId" UUID NOT NULL,
    "inventoryLedgerEntryId" UUID,
    "systemQuantity" DECIMAL(18,4) NOT NULL,
    "physicalQuantity" DECIMAL(18,4) NOT NULL,
    "discrepancyReason" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_opname_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_opname_approvals" (
    "id" UUID NOT NULL,
    "stockOpnameId" UUID NOT NULL,
    "approverId" UUID NOT NULL,
    "action" TEXT NOT NULL,
    "note" TEXT,
    "approvedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stock_opname_approvals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "budgets" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "organizationalUnitId" UUID NOT NULL,
    "budgetYear" INTEGER NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "budgets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "budget_disbursements" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "budgetId" UUID NOT NULL,
    "disbursementDate" TIMESTAMP(3) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "budget_disbursements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cash_transactions" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "budgetDisbursementId" UUID NOT NULL,
    "createdById" UUID NOT NULL,
    "cashReportId" UUID,
    "transactionDate" TIMESTAMP(3) NOT NULL,
    "supplierName" TEXT,
    "description" TEXT NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "receiptNumber" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cash_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cash_transaction_approvals" (
    "id" UUID NOT NULL,
    "cashTransactionId" UUID NOT NULL,
    "approverId" UUID NOT NULL,
    "action" TEXT NOT NULL,
    "note" TEXT,
    "approvedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cash_transaction_approvals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cash_reports" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "budgetDisbursementId" UUID NOT NULL,
    "createdById" UUID NOT NULL,
    "reportDate" TIMESTAMP(3) NOT NULL,
    "totalAmount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cash_reports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_invoices" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "supplierId" UUID NOT NULL,
    "createdById" UUID NOT NULL,
    "invoiceDate" TIMESTAMP(3) NOT NULL,
    "dueDate" TIMESTAMP(3),
    "amount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "invoiceNumber" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_invoices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier_invoice_purchase_orders" (
    "id" UUID NOT NULL,
    "supplierInvoiceId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "allocatedAmount" DECIMAL(18,2),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_invoice_purchase_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_requests" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "createdById" UUID NOT NULL,
    "requestDate" TIMESTAMP(3) NOT NULL,
    "requestedAmount" DECIMAL(18,2) NOT NULL,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_request_items" (
    "id" UUID NOT NULL,
    "paymentRequestId" UUID NOT NULL,
    "supplierInvoiceId" UUID NOT NULL,
    "requestedAmount" DECIMAL(18,2) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_request_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_request_approvals" (
    "id" UUID NOT NULL,
    "paymentRequestId" UUID NOT NULL,
    "approverId" UUID NOT NULL,
    "action" TEXT NOT NULL,
    "note" TEXT,
    "approvedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payment_request_approvals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "createdById" UUID NOT NULL,
    "paymentDate" TIMESTAMP(3) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "paymentMethod" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "referenceNumber" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_items" (
    "id" UUID NOT NULL,
    "paymentId" UUID NOT NULL,
    "supplierInvoiceId" UUID NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_proofs" (
    "id" UUID NOT NULL,
    "paymentId" UUID NOT NULL,
    "fileName" TEXT NOT NULL,
    "storageKey" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "fileSize" INTEGER NOT NULL,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payment_proofs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" UUID NOT NULL,
    "userId" UUID,
    "action" TEXT NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" UUID,
    "oldData" JSONB,
    "newData" JSONB,
    "metadata" JSONB,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "password_reset_tokens" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "usedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "password_reset_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_templates" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "documentType" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "document_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_template_revisions" (
    "id" UUID NOT NULL,
    "documentTemplateId" UUID NOT NULL,
    "revisionNumber" INTEGER NOT NULL,
    "title" TEXT,
    "contentSchema" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "document_template_revisions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents" (
    "id" UUID NOT NULL,
    "documentTemplateId" UUID NOT NULL,
    "documentTemplateRevisionId" UUID NOT NULL,
    "documentType" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "referenceType" TEXT,
    "referenceId" UUID,
    "issuedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_snapshots" (
    "id" UUID NOT NULL,
    "documentId" UUID NOT NULL,
    "version" INTEGER NOT NULL,
    "content" JSONB NOT NULL,
    "contentHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_snapshots_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_files" (
    "id" UUID NOT NULL,
    "documentId" UUID NOT NULL,
    "snapshotId" UUID,
    "fileName" TEXT NOT NULL,
    "storageKey" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "fileSize" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_signatures" (
    "id" UUID NOT NULL,
    "documentId" UUID NOT NULL,
    "snapshotId" UUID NOT NULL,
    "signerId" UUID NOT NULL,
    "signerRole" TEXT NOT NULL,
    "signedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "signatureStatus" TEXT NOT NULL,
    "snapshotHash" TEXT NOT NULL,
    "verificationTokenHash" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_signatures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "qr_verifications" (
    "id" UUID NOT NULL,
    "documentId" UUID NOT NULL,
    "snapshotId" UUID NOT NULL,
    "signatureId" UUID,
    "tokenHash" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "verifiedAt" TIMESTAMP(3),
    "verificationCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "qr_verifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" UUID NOT NULL,
    "userId" UUID,
    "channel" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "recipient" TEXT NOT NULL,
    "subject" TEXT,
    "message" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "provider" TEXT,
    "providerMessageId" TEXT,
    "attemptCount" INTEGER NOT NULL DEFAULT 0,
    "lastAttemptAt" TIMESTAMP(3),
    "sentAt" TIMESTAMP(3),
    "errorCode" TEXT,
    "errorMessage" TEXT,
    "referenceType" TEXT,
    "referenceId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notification_attempts" (
    "id" UUID NOT NULL,
    "notificationId" UUID NOT NULL,
    "attemptNumber" INTEGER NOT NULL,
    "provider" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "providerMessageId" TEXT,
    "attemptedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "responseCode" TEXT,
    "responseBody" JSONB,
    "errorCode" TEXT,
    "errorMessage" TEXT,

    CONSTRAINT "notification_attempts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notification_queue" (
    "id" UUID NOT NULL,
    "notificationId" UUID NOT NULL,
    "status" TEXT NOT NULL,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "availableAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processingStartedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "lockedUntil" TIMESTAMP(3),
    "workerId" TEXT,
    "lastErrorCode" TEXT,
    "lastErrorMessage" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notification_queue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "external_access_tokens" (
    "id" UUID NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "purpose" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "referenceType" TEXT NOT NULL,
    "referenceId" UUID,
    "expiresAt" TIMESTAMP(3),
    "usedAt" TIMESTAMP(3),
    "lastAccessedAt" TIMESTAMP(3),
    "accessCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "external_access_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daily_operational_sessions" (
    "id" UUID NOT NULL,
    "operationalDate" DATE NOT NULL,
    "status" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startedById" UUID NOT NULL,
    "endedAt" TIMESTAMP(3),
    "endedById" UUID,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "daily_operational_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_isActive_idx" ON "users"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "roles_code_key" ON "roles"("code");

-- CreateIndex
CREATE INDEX "roles_isActive_idx" ON "roles"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_code_key" ON "permissions"("code");

-- CreateIndex
CREATE INDEX "permissions_isActive_idx" ON "permissions"("isActive");

-- CreateIndex
CREATE INDEX "user_roles_roleId_idx" ON "user_roles"("roleId");

-- CreateIndex
CREATE INDEX "role_permissions_permissionId_idx" ON "role_permissions"("permissionId");

-- CreateIndex
CREATE UNIQUE INDEX "organizational_units_code_key" ON "organizational_units"("code");

-- CreateIndex
CREATE INDEX "organizational_units_parentId_idx" ON "organizational_units"("parentId");

-- CreateIndex
CREATE INDEX "organizational_units_isActive_idx" ON "organizational_units"("isActive");

-- CreateIndex
CREATE INDEX "user_organizational_units_organizationalUnitId_idx" ON "user_organizational_units"("organizationalUnitId");

-- CreateIndex
CREATE UNIQUE INDEX "item_categories_code_key" ON "item_categories"("code");

-- CreateIndex
CREATE INDEX "item_categories_isActive_idx" ON "item_categories"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "units_of_measure_code_key" ON "units_of_measure"("code");

-- CreateIndex
CREATE INDEX "units_of_measure_isActive_idx" ON "units_of_measure"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "items_code_key" ON "items"("code");

-- CreateIndex
CREATE INDEX "items_categoryId_idx" ON "items"("categoryId");

-- CreateIndex
CREATE INDEX "items_uomId_idx" ON "items"("uomId");

-- CreateIndex
CREATE INDEX "items_isActive_idx" ON "items"("isActive");

-- CreateIndex
CREATE INDEX "item_aliases_alias_idx" ON "item_aliases"("alias");

-- CreateIndex
CREATE INDEX "item_aliases_isActive_idx" ON "item_aliases"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "item_aliases_itemId_alias_key" ON "item_aliases"("itemId", "alias");

-- CreateIndex
CREATE UNIQUE INDEX "suppliers_code_key" ON "suppliers"("code");

-- CreateIndex
CREATE INDEX "suppliers_name_idx" ON "suppliers"("name");

-- CreateIndex
CREATE INDEX "suppliers_isActive_idx" ON "suppliers"("isActive");

-- CreateIndex
CREATE INDEX "supplier_bank_accounts_supplierId_idx" ON "supplier_bank_accounts"("supplierId");

-- CreateIndex
CREATE INDEX "supplier_bank_accounts_isActive_idx" ON "supplier_bank_accounts"("isActive");

-- CreateIndex
CREATE INDEX "supplier_evaluations_supplierId_idx" ON "supplier_evaluations"("supplierId");

-- CreateIndex
CREATE INDEX "supplier_evaluations_evaluatorId_idx" ON "supplier_evaluations"("evaluatorId");

-- CreateIndex
CREATE INDEX "supplier_evaluations_evaluationDate_idx" ON "supplier_evaluations"("evaluationDate");

-- CreateIndex
CREATE INDEX "supplier_evaluations_periodStart_periodEnd_idx" ON "supplier_evaluations"("periodStart", "periodEnd");

-- CreateIndex
CREATE INDEX "supplier_follow_ups_supplierId_idx" ON "supplier_follow_ups"("supplierId");

-- CreateIndex
CREATE INDEX "supplier_follow_ups_evaluationId_idx" ON "supplier_follow_ups"("evaluationId");

-- CreateIndex
CREATE INDEX "supplier_follow_ups_picId_idx" ON "supplier_follow_ups"("picId");

-- CreateIndex
CREATE INDEX "supplier_follow_ups_status_idx" ON "supplier_follow_ups"("status");

-- CreateIndex
CREATE INDEX "supplier_follow_ups_targetDate_idx" ON "supplier_follow_ups"("targetDate");

-- CreateIndex
CREATE INDEX "supplier_performance_periods_supplierId_idx" ON "supplier_performance_periods"("supplierId");

-- CreateIndex
CREATE INDEX "supplier_performance_periods_periodStart_periodEnd_idx" ON "supplier_performance_periods"("periodStart", "periodEnd");

-- CreateIndex
CREATE INDEX "supplier_performance_periods_overallScore_idx" ON "supplier_performance_periods"("overallScore");

-- CreateIndex
CREATE UNIQUE INDEX "supplier_performance_periods_supplierId_periodStart_periodE_key" ON "supplier_performance_periods"("supplierId", "periodStart", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "warehouses_code_key" ON "warehouses"("code");

-- CreateIndex
CREATE INDEX "warehouses_type_idx" ON "warehouses"("type");

-- CreateIndex
CREATE INDEX "warehouses_isActive_idx" ON "warehouses"("isActive");

-- CreateIndex
CREATE INDEX "user_warehouse_scopes_warehouseId_idx" ON "user_warehouse_scopes"("warehouseId");

-- CreateIndex
CREATE UNIQUE INDEX "stock_classifications_code_key" ON "stock_classifications"("code");

-- CreateIndex
CREATE INDEX "stock_classifications_isActive_idx" ON "stock_classifications"("isActive");

-- CreateIndex
CREATE INDEX "inventories_warehouseId_idx" ON "inventories"("warehouseId");

-- CreateIndex
CREATE INDEX "inventories_stockClassificationId_idx" ON "inventories"("stockClassificationId");

-- CreateIndex
CREATE UNIQUE INDEX "inventories_itemId_warehouseId_stockClassificationId_key" ON "inventories"("itemId", "warehouseId", "stockClassificationId");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_ledger_goodsIssueItemId_key" ON "inventory_ledger"("goodsIssueItemId");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_ledger_goodsReceiptItemId_key" ON "inventory_ledger"("goodsReceiptItemId");

-- CreateIndex
CREATE INDEX "inventory_ledger_inventoryId_createdAt_idx" ON "inventory_ledger"("inventoryId", "createdAt");

-- CreateIndex
CREATE INDEX "inventory_ledger_movementType_idx" ON "inventory_ledger"("movementType");

-- CreateIndex
CREATE INDEX "inventory_ledger_referenceType_referenceId_idx" ON "inventory_ledger"("referenceType", "referenceId");

-- CreateIndex
CREATE UNIQUE INDEX "purchase_requests_number_key" ON "purchase_requests"("number");

-- CreateIndex
CREATE INDEX "purchase_requests_requesterId_idx" ON "purchase_requests"("requesterId");

-- CreateIndex
CREATE INDEX "purchase_requests_organizationalUnitId_idx" ON "purchase_requests"("organizationalUnitId");

-- CreateIndex
CREATE INDEX "purchase_requests_status_idx" ON "purchase_requests"("status");

-- CreateIndex
CREATE INDEX "purchase_requests_createdAt_idx" ON "purchase_requests"("createdAt");

-- CreateIndex
CREATE INDEX "purchase_request_items_purchaseRequestId_idx" ON "purchase_request_items"("purchaseRequestId");

-- CreateIndex
CREATE INDEX "purchase_request_items_itemId_idx" ON "purchase_request_items"("itemId");

-- CreateIndex
CREATE INDEX "purchase_request_items_uomId_idx" ON "purchase_request_items"("uomId");

-- CreateIndex
CREATE INDEX "purchase_request_items_approvalStatus_idx" ON "purchase_request_items"("approvalStatus");

-- CreateIndex
CREATE INDEX "purchase_request_approvals_purchaseRequestItemId_idx" ON "purchase_request_approvals"("purchaseRequestItemId");

-- CreateIndex
CREATE INDEX "purchase_request_approvals_approverId_idx" ON "purchase_request_approvals"("approverId");

-- CreateIndex
CREATE INDEX "purchase_request_approvals_decision_idx" ON "purchase_request_approvals"("decision");

-- CreateIndex
CREATE INDEX "purchase_request_approvals_approvedAt_idx" ON "purchase_request_approvals"("approvedAt");

-- CreateIndex
CREATE UNIQUE INDEX "purchase_request_item_routings_purchaseRequestItemId_key" ON "purchase_request_item_routings"("purchaseRequestItemId");

-- CreateIndex
CREATE INDEX "purchase_request_item_routings_routedById_idx" ON "purchase_request_item_routings"("routedById");

-- CreateIndex
CREATE INDEX "purchase_request_item_routings_destinationType_idx" ON "purchase_request_item_routings"("destinationType");

-- CreateIndex
CREATE INDEX "purchase_request_item_routings_routedAt_idx" ON "purchase_request_item_routings"("routedAt");

-- CreateIndex
CREATE UNIQUE INDEX "purchase_orders_number_key" ON "purchase_orders"("number");

-- CreateIndex
CREATE INDEX "purchase_orders_supplierId_idx" ON "purchase_orders"("supplierId");

-- CreateIndex
CREATE INDEX "purchase_orders_createdById_idx" ON "purchase_orders"("createdById");

-- CreateIndex
CREATE INDEX "purchase_orders_status_idx" ON "purchase_orders"("status");

-- CreateIndex
CREATE INDEX "purchase_orders_orderDate_idx" ON "purchase_orders"("orderDate");

-- CreateIndex
CREATE INDEX "purchase_order_items_purchaseOrderId_idx" ON "purchase_order_items"("purchaseOrderId");

-- CreateIndex
CREATE INDEX "purchase_order_items_purchaseRequestItemId_idx" ON "purchase_order_items"("purchaseRequestItemId");

-- CreateIndex
CREATE UNIQUE INDEX "goods_receipts_number_key" ON "goods_receipts"("number");

-- CreateIndex
CREATE INDEX "goods_receipts_purchaseOrderId_idx" ON "goods_receipts"("purchaseOrderId");

-- CreateIndex
CREATE INDEX "goods_receipts_warehouseId_idx" ON "goods_receipts"("warehouseId");

-- CreateIndex
CREATE INDEX "goods_receipts_receivedById_idx" ON "goods_receipts"("receivedById");

-- CreateIndex
CREATE INDEX "goods_receipts_status_idx" ON "goods_receipts"("status");

-- CreateIndex
CREATE INDEX "goods_receipts_receiptDate_idx" ON "goods_receipts"("receiptDate");

-- CreateIndex
CREATE INDEX "goods_receipts_receivingType_idx" ON "goods_receipts"("receivingType");

-- CreateIndex
CREATE INDEX "goods_receipt_items_goodsReceiptId_idx" ON "goods_receipt_items"("goodsReceiptId");

-- CreateIndex
CREATE INDEX "goods_receipt_items_purchaseOrderItemId_idx" ON "goods_receipt_items"("purchaseOrderItemId");

-- CreateIndex
CREATE INDEX "goods_receipt_items_condition_idx" ON "goods_receipt_items"("condition");

-- CreateIndex
CREATE UNIQUE INDEX "goods_issues_number_key" ON "goods_issues"("number");

-- CreateIndex
CREATE INDEX "goods_issues_purchaseRequestId_idx" ON "goods_issues"("purchaseRequestId");

-- CreateIndex
CREATE INDEX "goods_issues_warehouseId_idx" ON "goods_issues"("warehouseId");

-- CreateIndex
CREATE INDEX "goods_issues_issuedById_idx" ON "goods_issues"("issuedById");

-- CreateIndex
CREATE INDEX "goods_issues_status_idx" ON "goods_issues"("status");

-- CreateIndex
CREATE INDEX "goods_issues_issueDate_idx" ON "goods_issues"("issueDate");

-- CreateIndex
CREATE INDEX "goods_issue_items_goodsIssueId_idx" ON "goods_issue_items"("goodsIssueId");

-- CreateIndex
CREATE INDEX "goods_issue_items_purchaseRequestItemId_idx" ON "goods_issue_items"("purchaseRequestItemId");

-- CreateIndex
CREATE INDEX "goods_issue_items_inventoryId_idx" ON "goods_issue_items"("inventoryId");

-- CreateIndex
CREATE UNIQUE INDEX "stock_opnames_number_key" ON "stock_opnames"("number");

-- CreateIndex
CREATE INDEX "stock_opnames_warehouseId_idx" ON "stock_opnames"("warehouseId");

-- CreateIndex
CREATE INDEX "stock_opnames_createdById_idx" ON "stock_opnames"("createdById");

-- CreateIndex
CREATE INDEX "stock_opnames_status_idx" ON "stock_opnames"("status");

-- CreateIndex
CREATE INDEX "stock_opnames_opnameDate_idx" ON "stock_opnames"("opnameDate");

-- CreateIndex
CREATE UNIQUE INDEX "stock_opname_items_inventoryLedgerEntryId_key" ON "stock_opname_items"("inventoryLedgerEntryId");

-- CreateIndex
CREATE INDEX "stock_opname_items_stockOpnameId_idx" ON "stock_opname_items"("stockOpnameId");

-- CreateIndex
CREATE INDEX "stock_opname_items_inventoryId_idx" ON "stock_opname_items"("inventoryId");

-- CreateIndex
CREATE UNIQUE INDEX "stock_opname_items_stockOpnameId_inventoryId_key" ON "stock_opname_items"("stockOpnameId", "inventoryId");

-- CreateIndex
CREATE INDEX "stock_opname_approvals_stockOpnameId_idx" ON "stock_opname_approvals"("stockOpnameId");

-- CreateIndex
CREATE INDEX "stock_opname_approvals_approverId_idx" ON "stock_opname_approvals"("approverId");

-- CreateIndex
CREATE INDEX "stock_opname_approvals_action_idx" ON "stock_opname_approvals"("action");

-- CreateIndex
CREATE INDEX "stock_opname_approvals_approvedAt_idx" ON "stock_opname_approvals"("approvedAt");

-- CreateIndex
CREATE UNIQUE INDEX "budgets_number_key" ON "budgets"("number");

-- CreateIndex
CREATE INDEX "budgets_organizationalUnitId_idx" ON "budgets"("organizationalUnitId");

-- CreateIndex
CREATE INDEX "budgets_budgetYear_idx" ON "budgets"("budgetYear");

-- CreateIndex
CREATE INDEX "budgets_status_idx" ON "budgets"("status");

-- CreateIndex
CREATE UNIQUE INDEX "budget_disbursements_number_key" ON "budget_disbursements"("number");

-- CreateIndex
CREATE INDEX "budget_disbursements_budgetId_idx" ON "budget_disbursements"("budgetId");

-- CreateIndex
CREATE INDEX "budget_disbursements_disbursementDate_idx" ON "budget_disbursements"("disbursementDate");

-- CreateIndex
CREATE INDEX "budget_disbursements_status_idx" ON "budget_disbursements"("status");

-- CreateIndex
CREATE UNIQUE INDEX "cash_transactions_number_key" ON "cash_transactions"("number");

-- CreateIndex
CREATE INDEX "cash_transactions_budgetDisbursementId_idx" ON "cash_transactions"("budgetDisbursementId");

-- CreateIndex
CREATE INDEX "cash_transactions_createdById_idx" ON "cash_transactions"("createdById");

-- CreateIndex
CREATE INDEX "cash_transactions_transactionDate_idx" ON "cash_transactions"("transactionDate");

-- CreateIndex
CREATE INDEX "cash_transactions_status_idx" ON "cash_transactions"("status");

-- CreateIndex
CREATE INDEX "cash_transactions_cashReportId_idx" ON "cash_transactions"("cashReportId");

-- CreateIndex
CREATE INDEX "cash_transaction_approvals_cashTransactionId_idx" ON "cash_transaction_approvals"("cashTransactionId");

-- CreateIndex
CREATE INDEX "cash_transaction_approvals_approverId_idx" ON "cash_transaction_approvals"("approverId");

-- CreateIndex
CREATE INDEX "cash_transaction_approvals_action_idx" ON "cash_transaction_approvals"("action");

-- CreateIndex
CREATE INDEX "cash_transaction_approvals_approvedAt_idx" ON "cash_transaction_approvals"("approvedAt");

-- CreateIndex
CREATE UNIQUE INDEX "cash_reports_number_key" ON "cash_reports"("number");

-- CreateIndex
CREATE INDEX "cash_reports_budgetDisbursementId_idx" ON "cash_reports"("budgetDisbursementId");

-- CreateIndex
CREATE INDEX "cash_reports_createdById_idx" ON "cash_reports"("createdById");

-- CreateIndex
CREATE INDEX "cash_reports_reportDate_idx" ON "cash_reports"("reportDate");

-- CreateIndex
CREATE INDEX "cash_reports_status_idx" ON "cash_reports"("status");

-- CreateIndex
CREATE UNIQUE INDEX "supplier_invoices_number_key" ON "supplier_invoices"("number");

-- CreateIndex
CREATE INDEX "supplier_invoices_supplierId_idx" ON "supplier_invoices"("supplierId");

-- CreateIndex
CREATE INDEX "supplier_invoices_createdById_idx" ON "supplier_invoices"("createdById");

-- CreateIndex
CREATE INDEX "supplier_invoices_invoiceDate_idx" ON "supplier_invoices"("invoiceDate");

-- CreateIndex
CREATE INDEX "supplier_invoices_dueDate_idx" ON "supplier_invoices"("dueDate");

-- CreateIndex
CREATE INDEX "supplier_invoices_status_idx" ON "supplier_invoices"("status");

-- CreateIndex
CREATE INDEX "supplier_invoice_purchase_orders_purchaseOrderId_idx" ON "supplier_invoice_purchase_orders"("purchaseOrderId");

-- CreateIndex
CREATE UNIQUE INDEX "supplier_invoice_purchase_orders_supplierInvoiceId_purchase_key" ON "supplier_invoice_purchase_orders"("supplierInvoiceId", "purchaseOrderId");

-- CreateIndex
CREATE UNIQUE INDEX "payment_requests_number_key" ON "payment_requests"("number");

-- CreateIndex
CREATE INDEX "payment_requests_createdById_idx" ON "payment_requests"("createdById");

-- CreateIndex
CREATE INDEX "payment_requests_requestDate_idx" ON "payment_requests"("requestDate");

-- CreateIndex
CREATE INDEX "payment_requests_status_idx" ON "payment_requests"("status");

-- CreateIndex
CREATE INDEX "payment_request_items_supplierInvoiceId_idx" ON "payment_request_items"("supplierInvoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "payment_request_items_paymentRequestId_supplierInvoiceId_key" ON "payment_request_items"("paymentRequestId", "supplierInvoiceId");

-- CreateIndex
CREATE INDEX "payment_request_approvals_paymentRequestId_idx" ON "payment_request_approvals"("paymentRequestId");

-- CreateIndex
CREATE INDEX "payment_request_approvals_approverId_idx" ON "payment_request_approvals"("approverId");

-- CreateIndex
CREATE INDEX "payment_request_approvals_action_idx" ON "payment_request_approvals"("action");

-- CreateIndex
CREATE INDEX "payment_request_approvals_approvedAt_idx" ON "payment_request_approvals"("approvedAt");

-- CreateIndex
CREATE UNIQUE INDEX "payments_number_key" ON "payments"("number");

-- CreateIndex
CREATE INDEX "payments_createdById_idx" ON "payments"("createdById");

-- CreateIndex
CREATE INDEX "payments_paymentDate_idx" ON "payments"("paymentDate");

-- CreateIndex
CREATE INDEX "payments_paymentMethod_idx" ON "payments"("paymentMethod");

-- CreateIndex
CREATE INDEX "payments_status_idx" ON "payments"("status");

-- CreateIndex
CREATE INDEX "payment_items_supplierInvoiceId_idx" ON "payment_items"("supplierInvoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "payment_items_paymentId_supplierInvoiceId_key" ON "payment_items"("paymentId", "supplierInvoiceId");

-- CreateIndex
CREATE INDEX "payment_proofs_paymentId_idx" ON "payment_proofs"("paymentId");

-- CreateIndex
CREATE INDEX "payment_proofs_uploadedAt_idx" ON "payment_proofs"("uploadedAt");

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "audit_logs"("action");

-- CreateIndex
CREATE INDEX "audit_logs_entityType_entityId_idx" ON "audit_logs"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "audit_logs_createdAt_idx" ON "audit_logs"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "password_reset_tokens_tokenHash_key" ON "password_reset_tokens"("tokenHash");

-- CreateIndex
CREATE INDEX "password_reset_tokens_userId_idx" ON "password_reset_tokens"("userId");

-- CreateIndex
CREATE INDEX "password_reset_tokens_expiresAt_idx" ON "password_reset_tokens"("expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "document_templates_code_key" ON "document_templates"("code");

-- CreateIndex
CREATE INDEX "document_templates_documentType_idx" ON "document_templates"("documentType");

-- CreateIndex
CREATE INDEX "document_templates_isActive_idx" ON "document_templates"("isActive");

-- CreateIndex
CREATE INDEX "document_template_revisions_documentTemplateId_idx" ON "document_template_revisions"("documentTemplateId");

-- CreateIndex
CREATE INDEX "document_template_revisions_isActive_idx" ON "document_template_revisions"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "document_template_revisions_documentTemplateId_revisionNumb_key" ON "document_template_revisions"("documentTemplateId", "revisionNumber");

-- CreateIndex
CREATE UNIQUE INDEX "documents_number_key" ON "documents"("number");

-- CreateIndex
CREATE INDEX "documents_documentTemplateId_idx" ON "documents"("documentTemplateId");

-- CreateIndex
CREATE INDEX "documents_documentTemplateRevisionId_idx" ON "documents"("documentTemplateRevisionId");

-- CreateIndex
CREATE INDEX "documents_documentType_idx" ON "documents"("documentType");

-- CreateIndex
CREATE INDEX "documents_status_idx" ON "documents"("status");

-- CreateIndex
CREATE INDEX "documents_issuedAt_idx" ON "documents"("issuedAt");

-- CreateIndex
CREATE INDEX "documents_referenceType_referenceId_idx" ON "documents"("referenceType", "referenceId");

-- CreateIndex
CREATE INDEX "document_snapshots_documentId_idx" ON "document_snapshots"("documentId");

-- CreateIndex
CREATE INDEX "document_snapshots_contentHash_idx" ON "document_snapshots"("contentHash");

-- CreateIndex
CREATE UNIQUE INDEX "document_snapshots_documentId_version_key" ON "document_snapshots"("documentId", "version");

-- CreateIndex
CREATE INDEX "document_files_documentId_idx" ON "document_files"("documentId");

-- CreateIndex
CREATE INDEX "document_files_snapshotId_idx" ON "document_files"("snapshotId");

-- CreateIndex
CREATE UNIQUE INDEX "document_signatures_verificationTokenHash_key" ON "document_signatures"("verificationTokenHash");

-- CreateIndex
CREATE INDEX "document_signatures_documentId_idx" ON "document_signatures"("documentId");

-- CreateIndex
CREATE INDEX "document_signatures_snapshotId_idx" ON "document_signatures"("snapshotId");

-- CreateIndex
CREATE INDEX "document_signatures_signerId_idx" ON "document_signatures"("signerId");

-- CreateIndex
CREATE INDEX "document_signatures_signedAt_idx" ON "document_signatures"("signedAt");

-- CreateIndex
CREATE INDEX "document_signatures_signatureStatus_idx" ON "document_signatures"("signatureStatus");

-- CreateIndex
CREATE UNIQUE INDEX "qr_verifications_tokenHash_key" ON "qr_verifications"("tokenHash");

-- CreateIndex
CREATE INDEX "qr_verifications_documentId_idx" ON "qr_verifications"("documentId");

-- CreateIndex
CREATE INDEX "qr_verifications_snapshotId_idx" ON "qr_verifications"("snapshotId");

-- CreateIndex
CREATE INDEX "qr_verifications_signatureId_idx" ON "qr_verifications"("signatureId");

-- CreateIndex
CREATE INDEX "qr_verifications_status_idx" ON "qr_verifications"("status");

-- CreateIndex
CREATE INDEX "qr_verifications_expiresAt_idx" ON "qr_verifications"("expiresAt");

-- CreateIndex
CREATE INDEX "notifications_userId_idx" ON "notifications"("userId");

-- CreateIndex
CREATE INDEX "notifications_channel_idx" ON "notifications"("channel");

-- CreateIndex
CREATE INDEX "notifications_type_idx" ON "notifications"("type");

-- CreateIndex
CREATE INDEX "notifications_status_idx" ON "notifications"("status");

-- CreateIndex
CREATE INDEX "notifications_provider_idx" ON "notifications"("provider");

-- CreateIndex
CREATE INDEX "notifications_referenceType_referenceId_idx" ON "notifications"("referenceType", "referenceId");

-- CreateIndex
CREATE INDEX "notifications_createdAt_idx" ON "notifications"("createdAt");

-- CreateIndex
CREATE INDEX "notification_attempts_notificationId_idx" ON "notification_attempts"("notificationId");

-- CreateIndex
CREATE INDEX "notification_attempts_provider_idx" ON "notification_attempts"("provider");

-- CreateIndex
CREATE INDEX "notification_attempts_status_idx" ON "notification_attempts"("status");

-- CreateIndex
CREATE INDEX "notification_attempts_attemptedAt_idx" ON "notification_attempts"("attemptedAt");

-- CreateIndex
CREATE UNIQUE INDEX "notification_attempts_notificationId_attemptNumber_key" ON "notification_attempts"("notificationId", "attemptNumber");

-- CreateIndex
CREATE UNIQUE INDEX "notification_queue_notificationId_key" ON "notification_queue"("notificationId");

-- CreateIndex
CREATE INDEX "notification_queue_status_availableAt_idx" ON "notification_queue"("status", "availableAt");

-- CreateIndex
CREATE INDEX "notification_queue_priority_availableAt_idx" ON "notification_queue"("priority", "availableAt");

-- CreateIndex
CREATE INDEX "notification_queue_lockedUntil_idx" ON "notification_queue"("lockedUntil");

-- CreateIndex
CREATE INDEX "notification_queue_createdAt_idx" ON "notification_queue"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "external_access_tokens_tokenHash_key" ON "external_access_tokens"("tokenHash");

-- CreateIndex
CREATE INDEX "external_access_tokens_purpose_idx" ON "external_access_tokens"("purpose");

-- CreateIndex
CREATE INDEX "external_access_tokens_status_idx" ON "external_access_tokens"("status");

-- CreateIndex
CREATE INDEX "external_access_tokens_referenceType_referenceId_idx" ON "external_access_tokens"("referenceType", "referenceId");

-- CreateIndex
CREATE INDEX "external_access_tokens_expiresAt_idx" ON "external_access_tokens"("expiresAt");

-- CreateIndex
CREATE INDEX "external_access_tokens_lastAccessedAt_idx" ON "external_access_tokens"("lastAccessedAt");

-- CreateIndex
CREATE INDEX "daily_operational_sessions_status_idx" ON "daily_operational_sessions"("status");

-- CreateIndex
CREATE INDEX "daily_operational_sessions_startedById_idx" ON "daily_operational_sessions"("startedById");

-- CreateIndex
CREATE INDEX "daily_operational_sessions_endedById_idx" ON "daily_operational_sessions"("endedById");

-- CreateIndex
CREATE UNIQUE INDEX "daily_operational_sessions_operationalDate_key" ON "daily_operational_sessions"("operationalDate");

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organizational_units" ADD CONSTRAINT "organizational_units_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "organizational_units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_organizational_units" ADD CONSTRAINT "user_organizational_units_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_organizational_units" ADD CONSTRAINT "user_organizational_units_organizationalUnitId_fkey" FOREIGN KEY ("organizationalUnitId") REFERENCES "organizational_units"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "item_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_uomId_fkey" FOREIGN KEY ("uomId") REFERENCES "units_of_measure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_aliases" ADD CONSTRAINT "item_aliases_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_bank_accounts" ADD CONSTRAINT "supplier_bank_accounts_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_evaluations" ADD CONSTRAINT "supplier_evaluations_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_evaluations" ADD CONSTRAINT "supplier_evaluations_evaluatorId_fkey" FOREIGN KEY ("evaluatorId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_follow_ups" ADD CONSTRAINT "supplier_follow_ups_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_follow_ups" ADD CONSTRAINT "supplier_follow_ups_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "supplier_evaluations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_follow_ups" ADD CONSTRAINT "supplier_follow_ups_picId_fkey" FOREIGN KEY ("picId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_performance_periods" ADD CONSTRAINT "supplier_performance_periods_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_warehouse_scopes" ADD CONSTRAINT "user_warehouse_scopes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_warehouse_scopes" ADD CONSTRAINT "user_warehouse_scopes_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_stockClassificationId_fkey" FOREIGN KEY ("stockClassificationId") REFERENCES "stock_classifications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_ledger" ADD CONSTRAINT "inventory_ledger_inventoryId_fkey" FOREIGN KEY ("inventoryId") REFERENCES "inventories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_ledger" ADD CONSTRAINT "inventory_ledger_goodsReceiptItemId_fkey" FOREIGN KEY ("goodsReceiptItemId") REFERENCES "goods_receipt_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_ledger" ADD CONSTRAINT "inventory_ledger_goodsIssueItemId_fkey" FOREIGN KEY ("goodsIssueItemId") REFERENCES "goods_issue_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_requests" ADD CONSTRAINT "purchase_requests_requesterId_fkey" FOREIGN KEY ("requesterId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_requests" ADD CONSTRAINT "purchase_requests_organizationalUnitId_fkey" FOREIGN KEY ("organizationalUnitId") REFERENCES "organizational_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_items" ADD CONSTRAINT "purchase_request_items_purchaseRequestId_fkey" FOREIGN KEY ("purchaseRequestId") REFERENCES "purchase_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_items" ADD CONSTRAINT "purchase_request_items_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_items" ADD CONSTRAINT "purchase_request_items_uomId_fkey" FOREIGN KEY ("uomId") REFERENCES "units_of_measure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_approvals" ADD CONSTRAINT "purchase_request_approvals_purchaseRequestItemId_fkey" FOREIGN KEY ("purchaseRequestItemId") REFERENCES "purchase_request_items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_approvals" ADD CONSTRAINT "purchase_request_approvals_approverId_fkey" FOREIGN KEY ("approverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_item_routings" ADD CONSTRAINT "purchase_request_item_routings_purchaseRequestItemId_fkey" FOREIGN KEY ("purchaseRequestItemId") REFERENCES "purchase_request_items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_request_item_routings" ADD CONSTRAINT "purchase_request_item_routings_routedById_fkey" FOREIGN KEY ("routedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_order_items" ADD CONSTRAINT "purchase_order_items_purchaseOrderId_fkey" FOREIGN KEY ("purchaseOrderId") REFERENCES "purchase_orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchase_order_items" ADD CONSTRAINT "purchase_order_items_purchaseRequestItemId_fkey" FOREIGN KEY ("purchaseRequestItemId") REFERENCES "purchase_request_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_receipts" ADD CONSTRAINT "goods_receipts_purchaseOrderId_fkey" FOREIGN KEY ("purchaseOrderId") REFERENCES "purchase_orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_receipts" ADD CONSTRAINT "goods_receipts_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_receipts" ADD CONSTRAINT "goods_receipts_receivedById_fkey" FOREIGN KEY ("receivedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_receipt_items" ADD CONSTRAINT "goods_receipt_items_goodsReceiptId_fkey" FOREIGN KEY ("goodsReceiptId") REFERENCES "goods_receipts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_receipt_items" ADD CONSTRAINT "goods_receipt_items_purchaseOrderItemId_fkey" FOREIGN KEY ("purchaseOrderItemId") REFERENCES "purchase_order_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issues" ADD CONSTRAINT "goods_issues_purchaseRequestId_fkey" FOREIGN KEY ("purchaseRequestId") REFERENCES "purchase_requests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issues" ADD CONSTRAINT "goods_issues_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issues" ADD CONSTRAINT "goods_issues_issuedById_fkey" FOREIGN KEY ("issuedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issue_items" ADD CONSTRAINT "goods_issue_items_goodsIssueId_fkey" FOREIGN KEY ("goodsIssueId") REFERENCES "goods_issues"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issue_items" ADD CONSTRAINT "goods_issue_items_purchaseRequestItemId_fkey" FOREIGN KEY ("purchaseRequestItemId") REFERENCES "purchase_request_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods_issue_items" ADD CONSTRAINT "goods_issue_items_inventoryId_fkey" FOREIGN KEY ("inventoryId") REFERENCES "inventories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opnames" ADD CONSTRAINT "stock_opnames_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opnames" ADD CONSTRAINT "stock_opnames_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opname_items" ADD CONSTRAINT "stock_opname_items_stockOpnameId_fkey" FOREIGN KEY ("stockOpnameId") REFERENCES "stock_opnames"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opname_items" ADD CONSTRAINT "stock_opname_items_inventoryId_fkey" FOREIGN KEY ("inventoryId") REFERENCES "inventories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opname_items" ADD CONSTRAINT "stock_opname_items_inventoryLedgerEntryId_fkey" FOREIGN KEY ("inventoryLedgerEntryId") REFERENCES "inventory_ledger"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opname_approvals" ADD CONSTRAINT "stock_opname_approvals_stockOpnameId_fkey" FOREIGN KEY ("stockOpnameId") REFERENCES "stock_opnames"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_opname_approvals" ADD CONSTRAINT "stock_opname_approvals_approverId_fkey" FOREIGN KEY ("approverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "budgets" ADD CONSTRAINT "budgets_organizationalUnitId_fkey" FOREIGN KEY ("organizationalUnitId") REFERENCES "organizational_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "budget_disbursements" ADD CONSTRAINT "budget_disbursements_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "budgets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_transactions" ADD CONSTRAINT "cash_transactions_budgetDisbursementId_fkey" FOREIGN KEY ("budgetDisbursementId") REFERENCES "budget_disbursements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_transactions" ADD CONSTRAINT "cash_transactions_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_transactions" ADD CONSTRAINT "cash_transactions_cashReportId_fkey" FOREIGN KEY ("cashReportId") REFERENCES "cash_reports"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_transaction_approvals" ADD CONSTRAINT "cash_transaction_approvals_cashTransactionId_fkey" FOREIGN KEY ("cashTransactionId") REFERENCES "cash_transactions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_transaction_approvals" ADD CONSTRAINT "cash_transaction_approvals_approverId_fkey" FOREIGN KEY ("approverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_reports" ADD CONSTRAINT "cash_reports_budgetDisbursementId_fkey" FOREIGN KEY ("budgetDisbursementId") REFERENCES "budget_disbursements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_reports" ADD CONSTRAINT "cash_reports_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_invoices" ADD CONSTRAINT "supplier_invoices_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_invoices" ADD CONSTRAINT "supplier_invoices_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_invoice_purchase_orders" ADD CONSTRAINT "supplier_invoice_purchase_orders_supplierInvoiceId_fkey" FOREIGN KEY ("supplierInvoiceId") REFERENCES "supplier_invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supplier_invoice_purchase_orders" ADD CONSTRAINT "supplier_invoice_purchase_orders_purchaseOrderId_fkey" FOREIGN KEY ("purchaseOrderId") REFERENCES "purchase_orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_requests" ADD CONSTRAINT "payment_requests_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_request_items" ADD CONSTRAINT "payment_request_items_paymentRequestId_fkey" FOREIGN KEY ("paymentRequestId") REFERENCES "payment_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_request_items" ADD CONSTRAINT "payment_request_items_supplierInvoiceId_fkey" FOREIGN KEY ("supplierInvoiceId") REFERENCES "supplier_invoices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_request_approvals" ADD CONSTRAINT "payment_request_approvals_paymentRequestId_fkey" FOREIGN KEY ("paymentRequestId") REFERENCES "payment_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_request_approvals" ADD CONSTRAINT "payment_request_approvals_approverId_fkey" FOREIGN KEY ("approverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_items" ADD CONSTRAINT "payment_items_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "payments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_items" ADD CONSTRAINT "payment_items_supplierInvoiceId_fkey" FOREIGN KEY ("supplierInvoiceId") REFERENCES "supplier_invoices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_proofs" ADD CONSTRAINT "payment_proofs_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "payments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "password_reset_tokens" ADD CONSTRAINT "password_reset_tokens_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_template_revisions" ADD CONSTRAINT "document_template_revisions_documentTemplateId_fkey" FOREIGN KEY ("documentTemplateId") REFERENCES "document_templates"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_documentTemplateId_fkey" FOREIGN KEY ("documentTemplateId") REFERENCES "document_templates"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_documentTemplateRevisionId_fkey" FOREIGN KEY ("documentTemplateRevisionId") REFERENCES "document_template_revisions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_snapshots" ADD CONSTRAINT "document_snapshots_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_files" ADD CONSTRAINT "document_files_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_files" ADD CONSTRAINT "document_files_snapshotId_fkey" FOREIGN KEY ("snapshotId") REFERENCES "document_snapshots"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_signatures" ADD CONSTRAINT "document_signatures_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_signatures" ADD CONSTRAINT "document_signatures_snapshotId_fkey" FOREIGN KEY ("snapshotId") REFERENCES "document_snapshots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_signatures" ADD CONSTRAINT "document_signatures_signerId_fkey" FOREIGN KEY ("signerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "qr_verifications" ADD CONSTRAINT "qr_verifications_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "qr_verifications" ADD CONSTRAINT "qr_verifications_snapshotId_fkey" FOREIGN KEY ("snapshotId") REFERENCES "document_snapshots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "qr_verifications" ADD CONSTRAINT "qr_verifications_signatureId_fkey" FOREIGN KEY ("signatureId") REFERENCES "document_signatures"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notification_attempts" ADD CONSTRAINT "notification_attempts_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "notifications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notification_queue" ADD CONSTRAINT "notification_queue_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "notifications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_operational_sessions" ADD CONSTRAINT "daily_operational_sessions_startedById_fkey" FOREIGN KEY ("startedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_operational_sessions" ADD CONSTRAINT "daily_operational_sessions_endedById_fkey" FOREIGN KEY ("endedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
