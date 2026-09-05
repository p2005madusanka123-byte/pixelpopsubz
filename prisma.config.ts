// prisma.config.ts - Prisma v7 configuration
// Loads DATABASE_URL from .env for migrations
// The runtime client uses PrismaClient() directly, which reads from env
import "dotenv/config";
import { defineConfig } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  datasource: {
    // Use DIRECT_URL for migrations (bypasses PgBouncer pooler)
    url: process.env["DIRECT_URL"] ?? process.env["DATABASE_URL"],
  },
});
