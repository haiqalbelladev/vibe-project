import bcrypt from "bcryptjs";
import "dotenv/config";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../app/generated/prisma/client";

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL!,
});

const prisma = new PrismaClient({ adapter });

async function main() {
  console.log("🌱 Seeding database...");

  // Roles
  const roles = [
    { code: "ADMIN", name: "Administrator" },
    { code: "REQUESTER", name: "Pemohon" },
    { code: "UNIT_HEAD", name: "Pimpinan Unit Kerja" },
    { code: "PURCHASING_HEAD", name: "Kasubag Pembelian & Gudang" },
    { code: "PURCHASING_STAFF", name: "Staff Pembelian" },
    { code: "WAREHOUSE_STAFF", name: "Staff Gudang" },
    { code: "HOUSEHOLD_HEAD", name: "Mudir Rumah Tangga" },
    { code: "FINANCE", name: "Keuangan" },
  ];

  for (const role of roles) {
    await prisma.role.upsert({
      where: { code: role.code },
      update: { name: role.name },
      create: role,
    });
  }

  // Permissions
  const permissions = [
    { code: "PR_CREATE", name: "Membuat Purchase Requisition" },
    { code: "PR_APPROVE", name: "Menyetujui Purchase Requisition" },
    { code: "PO_CREATE", name: "Membuat Purchase Order" },
    { code: "GRN_CREATE", name: "Membuat Goods Receipt" },
    { code: "GOODS_ISSUE_CREATE", name: "Membuat Barang Keluar" },
    { code: "STOCK_OPNAME_CREATE", name: "Membuat Stock Opname" },
    { code: "STOCK_OPNAME_APPROVE", name: "Menyetujui Stock Opname" },
    { code: "CASH_TRANSACTION_CREATE", name: "Membuat Transaksi Cash" },
    { code: "PAYMENT_REQUEST_CREATE", name: "Membuat Permohonan Pembayaran" },
    { code: "PAYMENT_CREATE", name: "Membuat Pembayaran" },
    { code: "MASTER_DATA_MANAGE", name: "Mengelola Master Data" },
    { code: "REPORT_VIEW", name: "Melihat Laporan" },
  ];

  for (const permission of permissions) {
    await prisma.permission.upsert({
      where: { code: permission.code },
      update: { name: permission.name },
      create: permission,
    });
  }

  // Organizational Units
  const units = [
    { code: "DAPUR", name: "Dapur" },
    { code: "KLINIK", name: "Klinik" },
    { code: "LAUNDRY", name: "Laundry" },
    { code: "PSP", name: "PSP" },
    { code: "TEKNISI", name: "Teknisi" },
    { code: "SECURITY", name: "Security" },
    { code: "PEMBELIAN", name: "Pembelian" },
    { code: "GUDANG", name: "Gudang" },
    { code: "YAYASAN", name: "Yayasan" },
    { code: "KEUANGAN", name: "Keuangan" },
    { code: "HUMAS", name: "Humas" },
    { code: "PESANTREN", name: "Pesantren" },
    { code: "MA", name: "MA" },
    { code: "MTS", name: "MTs" },
    { code: "KEPENGASUHAN", name: "Kepengasuhan" },
    { code: "RUMAH_TANGGA", name: "Rumah Tangga" },
  ];

  for (const unit of units) {
    await prisma.organizationalUnit.upsert({
      where: { code: unit.code },
      update: { name: unit.name },
      create: unit,
    });
  }

  // Item Categories
  const categories = [
    "Lainnya / ATK",
    "Bahan Kain",
    "Bahan Kemasan",
    "Bahan Pokok",
    "Bangunan",
    "Buku",
    "Bumbu & Rempah",
    "Frozen Food",
    "Kebersihan",
    "Kelistrikan",
    "Makanan & Minuman",
    "Meubelair",
    "Minyak & Santan",
  ];

  for (const [index, name] of categories.entries()) {
    await prisma.itemCategory.upsert({
      where: { code: `CAT-${String(index + 1).padStart(3, "0")}` },
      update: { name },
      create: {
        code: `CAT-${String(index + 1).padStart(3, "0")}`,
        name,
      },
    });
  }

  // Units of Measure
  const uoms = [
    { code: "PCS", name: "Pcs" },
    { code: "UNIT", name: "Unit" },
    { code: "KG", name: "Kilogram" },
    { code: "GRAM", name: "Gram" },
    { code: "LITER", name: "Liter" },
    { code: "ML", name: "Mililiter" },
    { code: "METER", name: "Meter" },
    { code: "BOX", name: "Box" },
    { code: "PACK", name: "Pack" },
    { code: "BOTOL", name: "Botol" },
    { code: "DUS", name: "Dus" },
    { code: "SAK", name: "Sak" },
    { code: "LEMBAR", name: "Lembar" },
  ];

  for (const uom of uoms) {
    await prisma.unitOfMeasure.upsert({
      where: { code: uom.code },
      update: { name: uom.name },
      create: uom,
    });
  }

  // Warehouses
  const warehouses = [
    {
      code: "GD-UTAMA",
      name: "Gudang Utama",
      type: "MAIN",
    },
  ];

  for (const warehouse of warehouses) {
    await prisma.warehouse.upsert({
      where: { code: warehouse.code },
      update: { name: warehouse.name, type: warehouse.type },
      create: warehouse,
    });
  }
    // Admin User
  const adminPasswordHash = await bcrypt.hash(
    "Ciko101113*",
    12,
  );

  const adminUser = await prisma.user.upsert({
    where: {
      email: "admin@vibe-project.local",
    },
    update: {
      name: "Administrator",
      passwordHash: adminPasswordHash,
      isActive: true,
    },
    create: {
      name: "Administrator",
      email: "admin@vibe-project.local",
      passwordHash: adminPasswordHash,
      isActive: true,
    },
  });

  const adminRole = await prisma.role.findUnique({
    where: {
      code: "ADMIN",
    },
  });

  if (!adminRole) {
    throw new Error("Role ADMIN tidak ditemukan.");
  }

  await prisma.userRole.upsert({
    where: {
      userId_roleId: {
        userId: adminUser.id,
        roleId: adminRole.id,
      },
    },
    update: {},
    create: {
      userId: adminUser.id,
      roleId: adminRole.id,
    },
  });
  console.log("✅ Seed tahap pertama selesai.");
}

main()
  .catch((error) => {
    console.error("❌ Seed gagal:", error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });