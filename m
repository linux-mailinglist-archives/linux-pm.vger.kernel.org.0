Return-Path: <linux-pm+bounces-8758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 935558FFF05
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17D4B244B1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F015EFA1;
	Fri,  7 Jun 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UijrZEoU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08915ECDF
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751585; cv=none; b=hg3z4sxL3W6yWbIBAefhFHIcxDn7fe0YMRkAsACI6WFLgIXvSCvhtwCTcRBD/VHrPyWvr02sLka/w/LBwJvGlD7tgog/3z+JTRkCURCWLyVtlyPB13vsL15jGxiK9d1pYfIJ90o2Izq5xu2Ph0TOi9uGWzfXCLQRSRSoUN0UzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751585; c=relaxed/simple;
	bh=Y+dnDpoPgLDQbxi2D26tM1HhdBJGHB5DyqDp5BgM3qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZzlXzw/UOU3aOGRMw4+wiVbRbfJf6HoLneIKpf7J8OkOq0ZvWg4O1dLyg+d58RNb739ruAxJ7tFJvFpBYruoS1ksJwoJp80DIjpA/sGUEi82NxHgrLWBeaKFhYXB8PZ6GgGf04Sro6QIQMxJCiujWKYvhcGCcn5vu2vySe8Ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UijrZEoU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70249faa853so1589967b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751583; x=1718356383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCjoSclVWZT0iDBq8VFLkZOWwHf6tFEcHjugFV93b9U=;
        b=UijrZEoU5H2jKL+3r85xZOL8CZZlKZ3iHSAjm3NlzVBPUD6ODH0IVGld654yG/jER9
         4a5GV7BB8q7s3UIoG0VEr+2M38kb8GM/7b4nC16r3tKdQJ+1VJ5yRoYgxfOY5VbIdkan
         85RIERByXSas46utrRwy8zmPTqCSV5cwV7RAFYGbEBG3LarzmI3tdL4H5fxPWFQHubPc
         jJMEk4Tlfz1hVKjQ5WJNSlN+xg5m7YPQRTtzcPByC1cmyeS/3alKBa5RXQ21oW8b3Ofz
         oqzqBTjayUf6EQCG6nSHi/7YfiYotyOaEUv3KEY55r679jvpFpsDhQ+uM50yXMaK7uLW
         8wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751583; x=1718356383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCjoSclVWZT0iDBq8VFLkZOWwHf6tFEcHjugFV93b9U=;
        b=eeJY6Tp7lzorcyvR/eVAVKurCtBzthcDylMupV+GI0nNd/rb/+4gkUb+TRErf8ifP6
         beBBTYhHAEX6No8Uoiv//geWVBzWHy8nIbGq2zuiEqev54UmiJXHwOc29U/xyNu4jC3J
         odj6/6FpvF/Ih4+kMyN/60NJt+LHzgOQFvZfeTMDXP27xgfN7Us9rOK8+9h70tOb+6uO
         mz4Xip8YfCRd8U4qvyf1PF3TZBiWwCMGPcv8etULrxHAPP5zkFgDT0QkrEpPldoF66Rt
         mmvffFz9EeoduPF/aa4jzpE/er6qllQ4wLumQ2QT0yhxaWr4Us8TuC18QjIHKAS/l3t0
         FjLw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IjYSc0Too6aMWYGaFaMJaWRwUQYNTg85xwSsZJRei1CgiTpVP9wipwJhZumMIsQpbSkKxpJ4mKiUqjkKGQ9923Su5nP25PU=
X-Gm-Message-State: AOJu0Yy58a+Gaaws0xNKDdJCG5jUm1raKbHzL4qh1zJITyqHk4Mf+Ae6
	qzeJKKBFixDc1dzOKEI1QVNfbeAjsWmDJry9AL+xnhxqA8TBV9yMjOLi7IOjfig=
X-Google-Smtp-Source: AGHT+IEynFUinI3X2Ts6k+rw9ZruxT15CQaIWnniA8Pyq/ymZo56xbDZgdazaXXsdaS1AQtNJabJEw==
X-Received: by 2002:a05:6a21:19a:b0:1b4:4370:60f with SMTP id adf61e73a8af0-1b443700773mr422429637.1.1717751582668;
        Fri, 07 Jun 2024 02:13:02 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d89a0sm29256535ad.128.2024.06.07.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:13:02 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Fri,  7 Jun 2024 14:42:22 +0530
Message-Id: <6e703e990bd1ce864927060c53025506568fd0b8.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bindings for CPUFreq core related API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index ebcb77b52558..4833848f79b1 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -15,7 +15,10 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::{ffi::c_char, marker::PhantomData, ptr};
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
 
 use macros::vtable;
 
@@ -343,6 +346,56 @@ extern "C" fn config_regulators(
     }
 }
 
+/// CPU Frequency table created from OPP entries.
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: ARef<Device>,
+    table: cpufreq::Table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates new instance of [`FreqTable`] from raw pointer.
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+        })?;
+        Ok(Self {
+            dev: table.dev.clone(),
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            table: unsafe { cpufreq::Table::from_raw(ptr) },
+        })
+    }
+
+    /// Returns reference to the underlying [`cpufreq::Table`].
+    pub fn table(&self) -> &cpufreq::Table {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_ptr()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
@@ -538,6 +591,12 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Create cpufreq table from OPP table.
+    #[cfg(CONFIG_CPU_FREQ)]
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Sets a matching OPP based on frequency.
     pub fn set_rate(&self, freq: u64) -> Result<()> {
         // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
-- 
2.31.1.272.g89b43f80a514


