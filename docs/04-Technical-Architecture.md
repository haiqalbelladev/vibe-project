# Technical Architecture — Project 01

## Architecture
Modular monolith.

UI → Action/Route Handler → Application Service → Domain Rules → Repository → Prisma → PostgreSQL

## Stack
Next.js, TypeScript, Tailwind CSS, shadcn/ui, Prisma, PostgreSQL, Auth.js, PDF generation abstraction, storage abstraction, WhatsApp service abstraction, Git/GitHub.

Docker and Redis are not initially required.

## Modules
auth, organization, master-data, procurement, warehouse, inventory, finance, notification, document, audit, reporting.

## Database Principles
PostgreSQL is the source of truth. Use `prisma.$transaction` for atomic business operations. Inventory is ledger-based. Posted transactions are immutable.

## Document Engine
transaction → validation → commit → snapshot → number → template/revision → PDF → storage → generated document → notification

Fixed organization header is retained exactly.

## Numbering
`TYPE/YYYY/NNNNNN`

Document control number remains separate, e.g. `FR-SPG-04`.

## WhatsApp
Use a provider abstraction. Development uses a mock provider; production targets Fonnte. Credentials are environment variables. Notifications are asynchronous after successful commit.

## External Tokens
Use random secure tokens stored in hashed form with scope and expiry.

## Environment
DATABASE_URL, AUTH_SECRET, FONNTE_TOKEN, FONNTE_BASE_URL, APP_URL, FILE_STORAGE_PROVIDER, FILE_STORAGE_PATH.

## Testing
Unit, integration, E2E, business workflow, security and regression tests.
