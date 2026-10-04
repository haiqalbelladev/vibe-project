# Document Specification — Project 01

## 1. Fixed Organization Header
The following header must not be changed:

YAYASAN HIDAYATUS SUNNAH
PESANTREN ISLAM AL IRSYAD TENGARAN 2
Jl. Jombol No.094, RT.002/RW.006, Dawuan, Kec. Dawuan,
Kabupaten Majalengka, Jawa Barat 45453
E-mail: admin@pesantrenalirsyad2.org
Web: www.pesantrenalirsyad2.org

The existing ISO-style control DNA remains:
FORMULIR / No. Dok / Revisi / Title / Tanggal / Halaman.

## 2. Existing Forms
FR-SPG-01 PR
FR-SPG-02 PO
FR-SPG-03 BAST
FR-SPG-04 GRN
FR-SPG-05 Permohonan Pembayaran Tagihan
FR-SPG-06 LPJ Pembelian Tunai (Cash)

## 3. New Stock Opname Forms
FR-SPG-07 — FORMULIR STOCK OPNAME — `SO/YYYY/NNNNNN`
FR-SPG-08 — BERITA ACARA STOCK OPNAME — `BA-SO/YYYY/NNNNNN`

### FR-SPG-07 — Formulir Stock Opname
Purpose: record physical counting and discrepancies before approval.

Sections:
1. No. Dokumen, Tanggal Opname, Gudang, Periode/Referensi, Petugas.
2. Table: No, Kode Sistem, Nama Barang, Satuan, Stok Sistem, Hasil Hitung Fisik, Selisih, Kondisi, Alasan Selisih, Catatan.
3. Summary of items checked, matching items, plus differences and minus differences.
4. Sign-off: Pelaksana and Pemeriksa according to workflow.

Every discrepancy must have a reason.

### FR-SPG-08 — Berita Acara Stock Opname
Purpose: formally record the approved result and become the documentary basis for adjustment.

Sections:
1. No. BA, Tanggal, Referensi Stock Opname, Gudang.
2. Statement describing the physical count and comparison with system records.
3. Summary of results.
4. Adjustment recap: Kode Sistem, Nama Barang, Stok Sistem, Fisik, Selisih, Reason, Adjustment Status.
5. Declaration that the system posts adjustment only after required approval.
6. Signatures: Pelaksana, Pemeriksa, Pemutus, and Finance/Accounting acknowledgement where applicable.

The BA itself does not directly change stock; the system posts the ledger adjustment after final approval.

## 4. PMS
PMS = **Procurement Management System**, the legacy application name. It is not the name of the new application.

## 5. Transaction Numbering
Standard: `TYPE/YYYY/NNNNNN`.

Examples:
`PR/2026/000001`
`PO/2026/000001`
`GRN/2026/000001`
`BAST/2026/000001`
`SO/2026/000001`
`BA-SO/2026/000001`
`LPJ/2026/000001`
`PPG/2026/000001`

Requirements: readable, searchable, traceable, unique per type/year, system-generated, and separate from form-control codes.

## 6. Revision
Existing forms remain Revision 0 unless formally revised. New FR-SPG-07 and FR-SPG-08 start at Revision 0.
