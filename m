Return-Path: <linux-pm+bounces-11652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F370940F5F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E88289B30
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2E19EEC2;
	Tue, 30 Jul 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDz5phVO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1F19EEAE
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335259; cv=none; b=Ait56F6dmXMxHNPphOoGv9WkAFoD/6x6Sr1/msOO2STZENEYgru4l2muOVi/m48pqKLE0Qy4qvhtSYHCa5WUH0jO4Jl9l7QG4HJdv2DGfescNkd9ongCRGk+TcKDiotyyL5zAYqHnFR/Ip1//Gwynf4arCn7cYKv0nCQSu/e71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335259; c=relaxed/simple;
	bh=i43nnzkO6YM/OZibPUqU5csESWwD7dclh97iNrzDtkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvHAP8TDY2xCs1xWG51NddrBpCtugq3TWFrky1yNjWa/2osNiI8p+mJl4Wy0dkY+DEbbUCo9XqfpdjCp77BIRvt1JoKQHpNr4E8NFzDjaQciKgww7EMKNB1gK6+8BaxBxTnAomsc9/SNXjjKE9htAaT8r4O8ZbZ9Nn6kUAytk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDz5phVO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc47abc040so25647925ad.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335257; x=1722940057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUgOwF4VOfSZwujecU4b6ilYD3YLuL6K5yX18+fiv0c=;
        b=cDz5phVOYmDGv7Xj4HQ7OsXA3ZQjps7uyr4HGlysu0PxyXFLy5j5SJS0hVZEw7qEMW
         fpkarA4iKdjOsXkG6FxH675swHIvkYJwfjDI67jXA17zbc0D8xqhy7FqoacHALIGIiQn
         7povoLgq3dhSvcnVSYO5mCdSSC0XDO4S+dAkXpvLfZTCGVXOT36ZfeSEetybFO+Lc4gf
         27/3x7apaqYENmE+6Z7S7c4JnM3eJglXj4GQi+w7Qm9LzRXjPEHDXvQ9ZTSYZRQH3l/t
         g7duZEXYuZx2EQ3dIhIkpNW+YCV1ll2EXOiBf0rH805o3QRgRn6O+hpfuo24dMcs+l8M
         byYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335257; x=1722940057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUgOwF4VOfSZwujecU4b6ilYD3YLuL6K5yX18+fiv0c=;
        b=bIzsqmEaQ3nMXiok1UTStkzXvd+N8R7FQNIUEHBoX0VNG9wZsJ2VEsxv+G0m7IbiCf
         QXbQDukUk0wHwmxFpGsaRF0VyBC67fcaQJRSK+5sOwwJmdYWunfQgGOruMl/aW9+ABtl
         6czwS4l+I7C0ok3Peg9ujBNiHwXxWFNyT6VpdkwRpWV8N8+Qp33ksHeo97wOXOkBOkqJ
         QJiBfD0DzkUCuvst9ZbOAG2jUYOMDXeR+xBRWo3bsbTGsHcpAiHjOFIYxWksdrCBk/v4
         e0OY0yp7Qb1Yt72PAxp7eMjMC055Zj6OatGj9CSd+q/6kPZwMzqz8nFoBKQ3FIADFK3g
         e7EQ==
X-Gm-Message-State: AOJu0YwxfRKjauBoyAhPGC/0pE5nidsuKU0NYzoc4M5hFZHllYtjwGSK
	Su3LMcq3LfJlWpKwEImFc1XvwSins4wAA/nEIz7nCAqxRckvwIU27szwfMWI7Nw=
X-Google-Smtp-Source: AGHT+IGyeCkI/vw09RSM/jqgLi6A8Tm2DaqJkfOD/75KWCmJVQt8yEo+MOtfYNMOulG7wxDLrNtnVA==
X-Received: by 2002:a17:903:1cf:b0:1fa:128c:4315 with SMTP id d9443c01a7336-1ff04842046mr90590795ad.44.1722335256714;
        Tue, 30 Jul 2024 03:27:36 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee6a1esm98638455ad.164.2024.07.30.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:27:36 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
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
Subject: [PATCH V5 4/8] rust: Add initial bindings for cpufreq framework
Date: Tue, 30 Jul 2024 15:57:01 +0530
Message-Id: <fdc5e328348daa94abc3e1359aba292d313d7a8d.1722334569.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1722334569.git.viresh.kumar@linaro.org>
References: <cover.1722334569.git.viresh.kumar@linaro.org>
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
 rust/helpers.c                  |  15 ++
 rust/kernel/cpufreq.rs          | 254 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 5 files changed, 273 insertions(+)
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ffcf68b5566..22cbbb792dcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5657,6 +5657,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1bf8e053c8f4..bee2b6013690 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cpufreq.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 7a15d0ebe49b..3b2850a11859 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/cpumask.h>
+#include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
@@ -357,6 +358,20 @@ void rust_helper_free_cpumask_var(cpumask_var_t mask)
 EXPORT_SYMBOL_GPL(rust_helper_free_cpumask_var);
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+unsigned int rust_helper_cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
+{
+	return cpufreq_table_len(freq_table);
+}
+EXPORT_SYMBOL_GPL(rust_helper_cpufreq_table_len);
+
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+EXPORT_SYMBOL_GPL(rust_helper_cpufreq_register_em_with_opp);
+#endif
+
 #ifndef CONFIG_OF_DYNAMIC
 struct device_node *rust_helper_of_node_get(struct device_node *node)
 {
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..0751ad9459e2
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,254 @@
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
+    entries: Vec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates new instance of [`TableBuilder`].
+    pub fn new() -> Self {
+        Self {
+            entries: Vec::new(),
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
+    entries: Option<Pin<Vec<bindings::cpufreq_frequency_table>>>,
+
+    // Pointer to the statically or dynamically created table.
+    ptr: *mut bindings::cpufreq_frequency_table,
+
+    // Number of entries in the table.
+    len: usize,
+}
+
+impl Table {
+    /// Creates new instance of [`Table`] from [`TableBuilder`].
+    fn from_builder(entries: Vec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        let len = entries.len();
+        if len == 0 {
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
+            // The last entry in table is reserved for `CPUFREQ_TABLE_END`.
+            len: len - 1,
+        })
+    }
+
+    /// Creates new instance of [`Table`] from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null for the lifetime of the [`Table`].
+    pub unsafe fn from_raw(ptr: *mut bindings::cpufreq_frequency_table) -> Self {
+        Self {
+            entries: None,
+            ptr,
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`.
+            len: unsafe { bindings::cpufreq_table_len(ptr) } as usize,
+        }
+    }
+
+    // Validate the index.
+    fn validate(&self, index: usize) -> Result<()> {
+        if index >= self.len {
+            Err(EINVAL)
+        } else {
+            Ok(())
+        }
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
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).frequency })
+    }
+
+    /// Returns `flags` at index in the [`Table`].
+    pub fn flags(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).flags })
+    }
+
+    /// Returns `data` at index in the [`Table`].
+    pub fn data(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).driver_data })
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e309d7774cbd..77348fc33803 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,8 @@
 pub mod alloc;
 mod build_assert;
 pub mod clk;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cpumask;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


