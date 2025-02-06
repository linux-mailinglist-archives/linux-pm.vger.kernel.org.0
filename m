Return-Path: <linux-pm+bounces-21462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4FA2A47E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B5D1609F6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37922F39D;
	Thu,  6 Feb 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+hIGgs5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EB22F390
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834175; cv=none; b=Im1qBD4S7mRe4HsO7+Sqhf/f3KQVTbEvZMJ83xv5YktCZmZOUVxZ1fG8VqajY6P+GUK5P+dsSGVrEcN1cn1pqmI5sgYUJU5Q0xgzmBTGIFZyCpo02Q+R8ColbJFYTswjvxEpz5U5LeiUQOE/aEoiB45f60dGjVBeWG8J4ULOaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834175; c=relaxed/simple;
	bh=tnICjcIhVFFy17Cq4G+BHstf/G1WFVbXzocDK31tTZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGbaAajeIyka5G+inCLQth00K4GGXxLcy0otWycfPPVSOcQGWRhm6amirdVBpukSLT0IrC1R4WxUfxNrl4Lz4aEGqGzu/P+27A9Rx7ffhV2sx+BeSUoJlAeH9l6KrAcO1m4eZmEZSNKzvsqvDz8vdyH4G6PWFZ9TAjsWAoDULIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+hIGgs5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so1207340a91.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834172; x=1739438972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssve9dmZgI6qS1KPS1tMtwF1lG6DTg964KCzf8z+2OY=;
        b=y+hIGgs5xX+L7rZHUvsInfj2z9m7DybqhCwxTMaF+1lW5jaFxf0kMtdaucru1YBzi5
         FL9tzPDESeL3dA3fE3SEENf9aCWRB1a5OodfZban85mun2hu6xWWICzagzUUTeVKQQ4S
         JZP1SnnSPAbMnkk0tPf9n060hHxamGV15plwVZzG3kaUO3L+VP9FkegbDRzVcqM+Qd+p
         HotlUhe46yeFHCmoGA+EtMGHB/uX2sD4srgEqcoua2DC7H6cBjkHsQ/pvqhbaFChVhM1
         i66wxU+G13rfxhV0SiLmGOQC40bvUjIbGu2CZrMuIktgixnseiOoWnEL4RC9wGJ2e0St
         iymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834172; x=1739438972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssve9dmZgI6qS1KPS1tMtwF1lG6DTg964KCzf8z+2OY=;
        b=A12+CKwTJueRsxttUAoaziakwprOAlUH5A1Kn5IP3Heu/9gc3XDC4Te7FkfrUJ86gX
         vPEf/v/h4TUuN7WVpsgBnDwVUdFxrKMzd9jsTxB8an3+q/D54x9QMKwZt2YpxsqIl38g
         BDjv3t56WuwGQS+OJgsCj9kSySMBwZr+79FrB9mO7NlGubtG/9YeRY+IJqhck99DqMET
         PUAWYGbZEEULQ0SOLvG/sDwcx4QI+3TT2h3tacXZGBBrL8c8Hzw/o89ipUDSJG4rLbmn
         +7YmNH2yioJVWSeRquKG7ZrTfJwEANK5QKm08DzaXGsaHJ/Ieoq9cA9/9bPSayyjJb00
         6roQ==
X-Gm-Message-State: AOJu0YxkLQ0kbAMir6bjHZDawhmPy16jAw8aIOdk3gwqQJbMEPH4WM8R
	cZwBETT7KFG2HPWkr4u3QoPn54RFTW4HyHdrcLUNG/ozdeWUnQlvrzhDTwXpSog=
X-Gm-Gg: ASbGncuXhnQKr7soq5ceZB3NMNtnMr/lnKPwKoSuKigsQogU26Pw7WtzS6QAFnnInys
	jzumQsa9UUHnZMjQ6CzPAO95HBr6MABhteZI9FvsLlS3CHivXPgMaRfjYe3q4KKoxwXFIheHQl0
	JU1sHGkYXDTzo6GhUHDnv2E+yPZ2yGNlMtZd+ttRsy6MKnseWirKGhW7ORqLsYv7aT2EC5Bc86X
	hdFR2IlkK/6id/KYI5Xb6V5RtJkfANza53y1eyQAysy9YhF28WSr0GU2TKrLBxncaPrQ9c/gBfA
	0LFcq6SIsghglG1ltg==
X-Google-Smtp-Source: AGHT+IHmkA9y1OofEwZ0TlDzuR/nVNF/oPVAK27Xb6GbzCKrWlWgxuFLMMtmHljRUa/MOaRJPGT9iA==
X-Received: by 2002:a05:6a00:2908:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-7303513ac4amr10286481b3a.14.1738834172363;
        Thu, 06 Feb 2025 01:29:32 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad26c5sm854293b3a.46.2025.02.06.01.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:31 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
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
Subject: [PATCH V8 10/14] rust: Add initial bindings for cpufreq framework
Date: Thu,  6 Feb 2025 14:58:31 +0530
Message-Id: <4dd915bf503b77166b134e4b3dfeed389b1a5bcf.1738832119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds initial Rust bindings for the cpufreq core. This adds
basic bindings for cpufreq flags, relations and cpufreq table.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/cpufreq.c          |  10 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpufreq.rs          | 228 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 243 insertions(+)
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index cda0d2b74e29..f0270ceb82d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6024,6 +6024,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7f851d5907af..68bf1bc5bae8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
new file mode 100644
index 000000000000..7c1343c4d65e
--- /dev/null
+++ b/rust/helpers/cpufreq.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpufreq.h>
+
+#ifdef CONFIG_CPU_FREQ
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index de2341cfd917..32d0462219e5 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cpufreq.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..4546a70c7063
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU frequency scaling.
+//!
+//! This module provides bindings for interacting with the cpufreq subsystem.
+//!
+//! C header: [`include/linux/cpufreq.h`](srctree/include/linux/cpufreq.h)
+
+use crate::{
+    bindings,
+    error::{code::*, to_result, Result},
+    prelude::*,
+};
+
+use core::{
+    pin::Pin,
+};
+
+/// Default transition latency value.
+pub const ETERNAL_LATENCY: u32 = bindings::CPUFREQ_ETERNAL as u32;
+
+/// Container for cpufreq driver flags.
+pub mod flags {
+    use crate::bindings;
+
+    /// Set by drivers that need to update internal upper and lower boundaries along with the
+    /// target frequency and so the core and governors should also invoke the driver if the target
+    /// frequency does not change, but the policy min or max may have changed.
+    pub const NEED_UPDATE_LIMITS: u16 = bindings::CPUFREQ_NEED_UPDATE_LIMITS as _;
+
+    /// Set by drivers for platforms where loops_per_jiffy or other kernel "constants" aren't
+    /// affected by frequency transitions.
+    pub const CONST_LOOPS: u16 = bindings::CPUFREQ_CONST_LOOPS as _;
+
+    /// Set by drivers that want the core to automatically register the cpufreq driver as a thermal
+    /// cooling device.
+    pub const IS_COOLING_DEV: u16 = bindings::CPUFREQ_IS_COOLING_DEV as _;
+
+    /// Set by drivers for platforms that have multiple clock-domains, i.e. supporting multiple
+    /// policies. With this sysfs directories of governor would be created in cpu/cpuN/cpufreq/
+    /// directory and so they can use the same governor with different tunables for different
+    /// clusters.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = bindings::CPUFREQ_HAVE_GOVERNOR_PER_POLICY as _;
+
+    /// Set by drivers which do POSTCHANGE notifications from outside of their ->target() routine.
+    pub const ASYNC_NOTIFICATION: u16 = bindings::CPUFREQ_ASYNC_NOTIFICATION as _;
+
+    /// Set by drivers that want cpufreq core to check if CPU is running at a frequency present in
+    /// freq-table exposed by the driver. For these drivers if CPU is found running at an out of
+    /// table freq, the cpufreq core will try to change the frequency to a value from the table.
+    /// And if that fails, it will stop further boot process by issuing a BUG_ON().
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = bindings::CPUFREQ_NEED_INITIAL_FREQ_CHECK as _;
+
+    /// Set by drivers to disallow use of governors with "dynamic_switching" flag set.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = bindings::CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING as _;
+}
+
+/// CPU frequency selection relations. Each value contains a `bool` argument which corresponds to
+/// the Relation being efficient.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum Relation {
+    /// Select the lowest frequency at or above target.
+    Low(bool),
+    /// Select the highest frequency below or at target.
+    High(bool),
+    /// Select the closest frequency to the target.
+    Close(bool),
+}
+
+impl Relation {
+    // Converts from a value compatible with the C code.
+    fn new(val: u32) -> Result<Self> {
+        let efficient = val & bindings::CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !bindings::CPUFREQ_RELATION_E {
+            bindings::CPUFREQ_RELATION_L => Self::Low(efficient),
+            bindings::CPUFREQ_RELATION_H => Self::High(efficient),
+            bindings::CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+
+    /// Converts to a value compatible with the C code.
+    pub fn val(&self) -> u32 {
+        let (mut val, e) = match self {
+            Self::Low(e) => (bindings::CPUFREQ_RELATION_L, e),
+            Self::High(e) => (bindings::CPUFREQ_RELATION_H, e),
+            Self::Close(e) => (bindings::CPUFREQ_RELATION_C, e),
+        };
+
+        if *e {
+            val |= bindings::CPUFREQ_RELATION_E;
+        }
+
+        val
+    }
+}
+
+/// Equivalent to `struct cpufreq_policy_data` in the C code.
+#[repr(transparent)]
+pub struct PolicyData(*mut bindings::cpufreq_policy_data);
+
+impl PolicyData {
+    /// Creates new instance of [`PolicyData`].
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    pub unsafe fn from_raw_policy_data(ptr: *mut bindings::cpufreq_policy_data) -> Self {
+        Self(ptr)
+    }
+
+    /// Returns the raw pointer to the C structure.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
+        self.0
+    }
+
+    /// Provides a wrapper to the generic verify routine.
+    pub fn generic_verify(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+    }
+}
+
+/// Builder for the `struct cpufreq_frequency_table` in the C code.
+#[repr(transparent)]
+#[derive(Default)]
+pub struct TableBuilder {
+    entries: KVec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates new instance of [`TableBuilder`].
+    pub fn new() -> Self {
+        Self {
+            entries: KVec::new(),
+        }
+    }
+
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, frequency: u32, flags: u32, driver_data: u32) -> Result<()> {
+        // Adds new entry to the end of the vector.
+        Ok(self.entries.push(
+            bindings::cpufreq_frequency_table {
+                flags,
+                driver_data,
+                frequency,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    /// Creates [`Table`] from [`TableBuilder`].
+    pub fn into_table(mut self) -> Result<Table> {
+        // Add last entry to the table.
+        self.add(bindings::CPUFREQ_TABLE_END as u32, 0, 0)?;
+        Table::from_builder(self.entries)
+    }
+}
+
+/// A simple implementation of the cpufreq table, equivalent to the `struct
+/// cpufreq_frequency_table` in the C code.
+pub struct Table {
+    #[allow(dead_code)]
+    // Dynamically created table.
+    entries: Option<Pin<KVec<bindings::cpufreq_frequency_table>>>,
+
+    // Pointer to the statically or dynamically created table.
+    ptr: *mut bindings::cpufreq_frequency_table,
+}
+
+impl Table {
+    /// Creates new instance of [`Table`] from [`TableBuilder`].
+    fn from_builder(entries: KVec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        if entries.is_empty() {
+            return Err(EINVAL);
+        }
+
+        // Pin the entries to memory, since we are passing its pointer to the C code.
+        let mut entries = Pin::new(entries);
+
+        // The pointer is valid until the table gets dropped.
+        let ptr = entries.as_mut_ptr();
+
+        Ok(Self {
+            entries: Some(entries),
+            ptr,
+        })
+    }
+
+    /// Creates new instance of [`Table`] from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null for the lifetime of the [`Table`].
+    pub unsafe fn from_raw(ptr: *mut bindings::cpufreq_frequency_table) -> Self {
+        Self { entries: None, ptr }
+    }
+
+    /// Returns raw pointer to the `struct cpufreq_frequency_table` compatible with the C code.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_frequency_table {
+        self.ptr
+    }
+
+    /// Returns `frequency` at index in the [`Table`].
+    pub fn freq(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).frequency })
+    }
+
+    /// Returns `flags` at index in the [`Table`].
+    pub fn flags(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).flags })
+    }
+
+    /// Returns `data` at index in the [`Table`].
+    pub fn data(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).driver_data })
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8956f78a2805..2a42e21d57f2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,8 @@
 #[cfg(CONFIG_COMMON_CLK)]
 pub mod clk;
 pub mod cpu;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


