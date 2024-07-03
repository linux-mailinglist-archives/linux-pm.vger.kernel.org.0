Return-Path: <linux-pm+bounces-10489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D69254AD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F5F288011
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14013BAE5;
	Wed,  3 Jul 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5FpYQjy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7513B5A1
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991860; cv=none; b=okYdqFAxv922K7TxN1qj/BkDIXkyffbVDYyJvNCSF/NxVntSzod9qcu31oYCAUw8SmerNpEP1JuPJJmsm59CzvLXPcrMZD88qLLZReePhUJ7EkdS7IrKveccOA3dIFg6uDEma7muBbAzg1TOOeoV2mXrSVOix8rP7EtplmA6RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991860; c=relaxed/simple;
	bh=sEPrVIxsQv+nPLQj+utb0LbIls8GsCFzDWZXPzsyT2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6O36lAqb8Z7+ZhsIfc5Pnx3il/KUPsfiB4zDU80MoLISK6OxAwabpBEvNw2uBd8wf5LjFB7w5Ivo9huKKHQh5XaJu8zHSMHlQs5X+TEZEDrxyBdb+au+O3XaomkE/E2Z5QQeFPel8jTJ1qOS2jfVwbLqCgROMBEOk9lhLgzU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5FpYQjy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so3446643b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991858; x=1720596658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4EKiOxmWoqhLcIs2aUpate87V7NdPQkU4EW5fOiOk0=;
        b=o5FpYQjyTcgPPPsGImRnIqYqfUin07HRqCtcj71sit/3IILLxU06TiGSDN+E/e1Dua
         m/Yi1Bvli8HdgzOniu/ucL7tWX0mW2ux3uy5LZoWfDV4poFWlJWjI6bzOMe+IbPLAjEa
         nfUVUK0dSNLhB8Uexfuobw42yLTixbQ8ILtLaw+JJTRLLi232LKXMdYRaUvoWX8y6lrv
         Rz1qTInzlJWWZFbangKWKM9CUWbFJsmiQAFFxiIJUhFi43qe47vpBL6yAhDTCxO7fJ8K
         QYc/6Agk7/XZjrfbRY1w/7ZaSM8FXbCo/rJoeLywnXnAyvM0Ar3pMtWldsa42By9Utgk
         P3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991858; x=1720596658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4EKiOxmWoqhLcIs2aUpate87V7NdPQkU4EW5fOiOk0=;
        b=tXy8UlnFUp4U+HHKJyvxzZzxMNdqYnEnvkIeWX/Kl+AJJYONLI8TonIU5LKke7g37X
         kQDL/99NJvyGxbVsP/8aqtChJ8lxl+c6Q3hHhjQMZ+3/LX90v/+3AMXe9edOFKMEwofg
         Ja+8I0BQLeHtk14voKkWP/EAAX5QyvcHFcYa6ffKsRhUcjXwNz8t7DdXlzr2AjagRssz
         S3QvC658pxJxnI2tLY9aqWpyRT3cyihK3AkdWTTcJFsxHycT26LLC2othVBrvEd22VX7
         b4cNHp8zdWGiJXzQlbSZkmeSXmXaOy/7TXeukYrKAj8Uv1oOq1jSUxBRBGRHUvsHZ596
         nBLg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZBoIS6g/wV3xdKtVk46VUWE+e41Mv5k9zldAoeHN2nuD7ieZNUeFvAPfMU/uXsolhDW3oVrVwxhSwyoniCpIHECT17qkKTA=
X-Gm-Message-State: AOJu0YwJPD7KE/SuyTwgmj7oqxu4HwvJqFRhuGw4qkfw3DStZHHyfrM3
	dzXMw5WYt1cK3kVemjTA2ARnR+e3Xgy6Ckq5w5u+XYr/iMudU5vynC4Mka46cUo=
X-Google-Smtp-Source: AGHT+IGvwlqxT0lkoaWXgznkLpgL2bByCTmCBI/4tNDAPoYtQy2Z5mFBhr+I+/kd20baDi4MxRe2qQ==
X-Received: by 2002:a05:6a20:a988:b0:1bd:27fd:ff56 with SMTP id adf61e73a8af0-1bef6243146mr11337288637.58.1719991857881;
        Wed, 03 Jul 2024 00:30:57 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d153bsm95963355ad.40.2024.07.03.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:30:57 -0700 (PDT)
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
Subject: [RFC PATCH V3 4/8] rust: Add initial bindings for cpufreq framework
Date: Wed,  3 Jul 2024 12:44:29 +0530
Message-Id: <eae7bad0a8ae642f7dd53acaae1dc0a1854e6c75.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1719990273.git.viresh.kumar@linaro.org>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
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
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  15 ++
 rust/kernel/cpufreq.rs          | 254 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 272 insertions(+)
 create mode 100644 rust/kernel/cpufreq.rs

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
index a1b52378867c..e1e37d57ef7d 100644
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
@@ -349,6 +350,20 @@ bool rust_helper_zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_zalloc_cpumask_var);
 
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
index 000000000000..3f3ffd9abaa2
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
+    /// Set by drivers for platforms that have multiple clock-domains, i.e.  supporting multiple
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


