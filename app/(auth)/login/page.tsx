"use client";

import Image from "next/image";
import { signIn } from "next-auth/react";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function LoginPage() {
  const router = useRouter();

  const [showPassword, setShowPassword] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();

    setIsLoading(true);
    setError("");

    const result = await signIn("credentials", {
      email,
      password,
      redirect: false,
    });

    setIsLoading(false);

    if (result?.error) {
      setError("Email atau password salah.");
      return;
    }

    router.push("/dashboard");
    router.refresh();
  }

  return (
    <main className="min-h-screen bg-background">
      <div className="grid min-h-screen lg:grid-cols-[40%_60%]">
        {/* ==================== LOGIN PANEL ==================== */}
        <section className="relative flex min-h-screen flex-col justify-center overflow-hidden bg-background px-6 py-10 sm:px-10 lg:px-14">
          {/* Decorative background */}
          <div className="pointer-events-none absolute -bottom-16 -left-16 h-40 w-40 rounded-full bg-accent/15" />
          <div className="pointer-events-none absolute bottom-8 left-8 h-20 w-20 rounded-full bg-secondary/10" />

          <div className="relative mx-auto w-full max-w-xl animate-in fade-in slide-in-from-bottom-4 duration-700">
            {/* Logo */}
            <div className="mb-8 flex items-center gap-4">
              <Image
                src="/images/Logo_Yayasan.png"
                alt="Logo Yayasan"
                width={110}
                height={80}
                className="h-16 w-auto object-contain transition-transform duration-300 hover:scale-105"
                priority
              />

              <div className="h-10 w-px bg-border" />

              <Image
                src="/images/Logo_Pesantren.png"
                alt="Logo Pesantren"
                width={110}
                height={80}
                className="h-16 w-auto object-contain transition-transform duration-300 hover:scale-105"
                priority
              />
            </div>

            {/* Heading */}
            <div className="mb-8">
              <h1 className="whitespace-nowrap text-2xl font-bold tracking-tight text-foreground">
                Procurement Management System
              </h1>
            </div>

            {/* Login Form */}
            <form onSubmit={handleSubmit} className="space-y-5">
              {/* Email */}
              <div className="space-y-2">
                <label
                  htmlFor="email"
                  className="text-sm font-semibold text-foreground"
                >
                  Email / Username
                </label>

                <input
                  id="email"
                  name="email"
                  type="text"
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  autoComplete="username"
                  placeholder="nama@lembaga.org"
                  className="h-12 w-full rounded-xl border border-border bg-card px-4 text-sm text-foreground outline-none transition-all duration-200 placeholder:text-muted-foreground focus:border-primary focus:ring-4 focus:ring-primary/10"
                />
              </div>

              {/* Password */}
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <label
                    htmlFor="password"
                    className="text-sm font-semibold text-foreground"
                  >
                    Password
                  </label>

                  <a
                    href="/forgot-password"
                    className="text-sm font-semibold text-primary transition-colors hover:text-secondary"
                  >
                    Lupa Password?
                  </a>
                </div>

                <div className="relative">
                  <input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    autoComplete="current-password"
                    placeholder="Masukkan password"
                    className="h-12 w-full rounded-xl border border-border bg-card px-4 pr-12 text-sm text-foreground outline-none transition-all duration-200 placeholder:text-muted-foreground focus:border-primary focus:ring-4 focus:ring-primary/10"
                  />

                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    aria-label={
                      showPassword
                        ? "Sembunyikan password"
                        : "Tampilkan password"
                    }
                    className="absolute right-0 top-0 flex h-12 w-12 items-center justify-center text-muted-foreground transition-colors hover:text-primary"
                  >
                    {showPassword ? (
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                        className="h-5 w-5"
                      >
                        <path d="M3 3l18 18" />
                        <path d="M10.6 10.6a2 2 0 0 0 2.8 2.8" />
                        <path d="M9.9 4.2A10.8 10.8 0 0 1 12 4c7 0 10 8 10 8a18.3 18.3 0 0 1-3.1 4.4" />
                        <path d="M6.6 6.6C3.9 8.5 2 12 2 12s3 8 10 8a10.7 10.7 0 0 0 3.1-.5" />
                      </svg>
                    ) : (
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                        className="h-5 w-5"
                      >
                        <path d="M2 12s3-8 10-8 10 8 10 8-3 8-10 8S2 12 2 12Z" />
                        <circle cx="12" cy="12" r="3" />
                      </svg>
                    )}
                  </button>
                </div>
              </div>
              {error && (
                <p className="text-sm font-medium text-destructive">{error}</p>
              )}
              {/* Login Button */}
              <button
                type="submit"
                className="group mt-3 flex h-12 w-full items-center justify-center gap-3 rounded-xl bg-primary text-sm font-semibold text-primary-foreground shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-primary/90 hover:shadow-lg hover:shadow-primary/20 active:translate-y-0"
              >
                {isLoading ? "Memproses..." : "Login"}
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  className="h-5 w-5 transition-transform duration-300 group-hover:translate-x-1"
                >
                  <path d="M5 12h14" />
                  <path d="m13 6 6 6-6 6" />
                </svg>
              </button>
            </form>
          </div>

          {/* Footer */}
          <div className="relative mt-10 text-center text-xs text-muted-foreground">
            © 2026 Yayasan Hidayatus Sunnah.
            <br />
            PIAT 2 Majalengka
          </div>
        </section>

        {/* ==================== HERO PANEL ==================== */}
        <section className="relative hidden min-h-screen overflow-hidden lg:block">
          {/* Mosque image */}
          <Image
            src="/images/masjid-assalam-baru-2-1024x769.jpg"
            alt="Masjid lembaga"
            fill
            priority
            className="object-cover transition-transform duration-1000 hover:scale-105"
          />

          {/* Green overlay */}
          <div className="absolute inset-0 bg-linear-to-t from-[#064b2a]/95 via-[#08703d]/45 to-[#08703d]/10" />

          {/* Decorative circles */}
          <div className="absolute -right-32 -top-32 h-96 w-96 rounded-full bg-primary/30 blur-sm" />
          <div className="absolute -bottom-32 -left-20 h-80 w-80 rounded-full bg-secondary/30 blur-sm" />

          {/* Hero content */}
          <div className="absolute inset-x-0 bottom-0 p-12 xl:p-16">
            <div className="max-w-xl animate-in fade-in slide-in-from-bottom-6 duration-1000">
              <div className="mb-5 flex items-start gap-5">
                <div className="mt-1 h-20 w-1 shrink-0 rounded-full bg-[#F1CA35]" />

                <h2 className="text-3xl font-bold leading-tight text-white xl:text-4xl">
                  Bersama Mewujudkan
                  <br />
                  <span className="text-[#F1CA35]">
                    Pengelolaan yang Lebih Baik
                  </span>
                </h2>
              </div>

              <p className="mt-5 max-w-lg text-base leading-relaxed text-white/80">
                Untuk mendukung operasional lembaga yang efektif, efisien dan
                transparan.
              </p>
            </div>
          </div>
        </section>
      </div>
    </main>
  );
}
