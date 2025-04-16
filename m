Return-Path: <linux-pm+bounces-25519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3AA8B09E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754153BF9E0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E723A564;
	Wed, 16 Apr 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWgHoD2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E11239594
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785638; cv=none; b=r6et+A6+eh9rT/C+5OBN/7LnlLDbHXrJctvIjx66r/sxB3gqLiBaq7i19x0B8ikVxPoKqy1QOb4gsRj5MjRUCpYgfj7fRA5nPQpiUrhnRY12hanHKMoD/vkRraJObKIf76H0JS9Dcg36nbZA1/fRI6G6r6CQiEBMyO2V5kceRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785638; c=relaxed/simple;
	bh=ziZgMQLsFplAbFdyhmmL3J7VdGL8acvZSZ5DzxK0wlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgzGIXywpxwzSMVtmQ1vRPCG8urg1Ng1lCUWa5hgy+HFDh7R52FYHNwJhYBJAOJt0QKDM3XTyzNWoVvxZbEXu2lsp4dDcJB0D6QFHBdxU9uPcoFY4oz/t4NI8KFipr1orfO/NT0psUsrx1dsuM9F3g6KZrzDe8rNYa1iuOm+NtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SWgHoD2X; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73712952e1cso6139860b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785635; x=1745390435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW1qs6atmS8GbQWfQI5DosVxmJVfV2TCrrT1uWb7BkM=;
        b=SWgHoD2Xa6Z7f28gRvXoZJlbM1O1UfIcv73uSP9L/b6z3FapP1GK5N/NDaqU76qczY
         9BDvSD80fEXH8OFCx224A9raVdF6XloMbysjLYMyfc76Oy4zjaQW6HdIZuBj74PNDauz
         AAmwcoSAXRO2B0Qf4ccEf9IJuzIoPpSSXKIyT+Lj1wRbSfLKgheakQ145o5i1nooVX8c
         KA13gaZJcnoSwlVnXg3RNM6r1MUcrpwHIk+pVRBtAl2+032rLsuIrvBhPeOzYIQU69sj
         Br85u5BLpDA33Q2OegaZB8DwE8BnxwzrhQtYbbijwnqH9OGQafwywdatpUTMq03i6R6+
         bS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785635; x=1745390435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW1qs6atmS8GbQWfQI5DosVxmJVfV2TCrrT1uWb7BkM=;
        b=BRloMzhyTbXjIG6MeLd5DprpWbukr55AG8meykOmQeG/8E5jimcslyS0OmUc4ZQTM+
         xjvkWch7OE0rnd2oolmd2zrzlhYyiK7PnvDeSrYsq/aZGROs/lUbEAGY3uPs+esl1ldh
         jV3SiczgWY0cQZJlGn9VuzXgWleOeZTZ3EGaWH24zYmOFka+Jn+D99c9v9+2/9VvsWNM
         C/Za0VYcUYaEq0LZTZEQdxoUkgmXtjRuKDdwYONAMz9g4b2ocir63m/0zFylHFC3iay9
         WjjL+P9cpLKHcoVCzhD7Wc7NF2zkWoVwqaQi6ycDzX2vnuvZQ868U40u1wJYrqJUAjPP
         zGzg==
X-Gm-Message-State: AOJu0YygAz/wte3wqVWlrwtzYzd9LKmwf+MXbq5mTycSt/1SjkzBP4Zs
	X/Cu5zGc0cNdk7UCOItl8PDV61c8d7YftEDtMzHac4tSeGGHkMOv5ksyxrB2IC4=
X-Gm-Gg: ASbGncsCAidTtVoEA3X5fJPJEYcYddBQ7ypY3hJkFJUguC7J46pRYWhh0Janp8WSCWk
	rkzQLe3UDAV2GYiMPvXJf7CKkk3kx8iSE1kMO9BXvGvk9FG5QdnBstcc/iUML0/p0gKJgunlHLs
	6PYhcZZLk6gchbNKBvyIrMcj1aE4Q/oVH978dEySgS914rN90wiIcyLpN1O8y3sfva86a3PEMv7
	UKsXKtpVm2pP2i+NshALYpZ9CQwOoHBAJfGspwwPcfCGZ//Pd+aIMHfxfff1ITDRC30WjICm3Hz
	Ba+u5iJNmXT8lu6Tw938eNTDLMzU2BeFMV91VwvsWQ==
X-Google-Smtp-Source: AGHT+IGivDluYSNRbYVAREJ0mxGQVA4d18wcvk2K0U1bpJcwJQn6cow74PXYi6k7LWWUakBsB3u0kA==
X-Received: by 2002:a05:6a21:9183:b0:1f5:9098:e42e with SMTP id adf61e73a8af0-203b3e4fe98mr929777637.7.1744785635125;
        Tue, 15 Apr 2025 23:40:35 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198958sm9647372b3a.30.2025.04.15.23.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:34 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 11/15] rust: cpufreq: Add initial abstractions for cpufreq framework
Date: Wed, 16 Apr 2025 12:09:28 +0530
Message-Id: <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce initial Rust abstractions for the cpufreq core. This includes
basic representations for cpufreq flags, relation types, and the cpufreq
table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/cpufreq.c          |  10 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpufreq.rs          | 348 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 363 insertions(+)
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 931e418f89ed..aa56eacbda71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6142,6 +6142,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 529f22891e0b..7c1d78f68076 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
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
index ae595c9cd91b..df1fcfb3adf3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "clk.c"
+#include "cpufreq.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..d9face425d47
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU frequency scaling.
+//!
+//! This module provides rust abstractions for interacting with the cpufreq subsystem.
+//!
+//! C header: [`include/linux/cpufreq.h`](srctree/include/linux/cpufreq.h)
+//!
+//! Reference: <https://docs.kernel.org/admin-guide/pm/cpufreq.html>
+
+use crate::{
+    error::{code::*, to_result, Result},
+    ffi::c_ulong,
+    prelude::*,
+};
+
+use core::{
+    pin::Pin,
+};
+
+/// Default transition latency value in nanoseconds.
+pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+
+/// CPU frequency driver flags.
+pub mod flags {
+    /// Driver needs to update internal limits even if frequency remains unchanged.
+    pub const NEED_UPDATE_LIMITS: u16 = 1 << 0;
+
+    /// Platform where constants like `loops_per_jiffy` are unaffected by frequency changes.
+    pub const CONST_LOOPS: u16 = 1 << 1;
+
+    /// Register driver as a thermal cooling device automatically.
+    pub const IS_COOLING_DEV: u16 = 1 << 2;
+
+    /// Supports multiple clock domains with per-policy governors in `cpu/cpuN/cpufreq/`.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = 1 << 3;
+
+    /// Allows post-change notifications outside of the `target()` routine.
+    pub const ASYNC_NOTIFICATION: u16 = 1 << 4;
+
+    /// Ensure CPU starts at a valid frequency from the driver's freq-table.
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = 1 << 5;
+
+    /// Disallow governors with `dynamic_switching` capability.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = 1 << 6;
+}
+
+// Relations from the C code.
+const CPUFREQ_RELATION_L: u32 = 0;
+const CPUFREQ_RELATION_H: u32 = 1;
+const CPUFREQ_RELATION_C: u32 = 2;
+
+// Can be used with any of the above values.
+const CPUFREQ_RELATION_E: u32 = 1 << 2;
+
+/// CPU frequency selection relations.
+///
+/// CPU frequency selection relations, each optionally marked as "efficient".
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
+    // Construct from a C-compatible `u32` value.
+    fn new(val: u32) -> Result<Self> {
+        let efficient = val & CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !CPUFREQ_RELATION_E {
+            CPUFREQ_RELATION_L => Self::Low(efficient),
+            CPUFREQ_RELATION_H => Self::High(efficient),
+            CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+}
+
+impl From<Relation> for u32 {
+    // Convert to a C-compatible `u32` value.
+    fn from(rel: Relation) -> Self {
+        let (mut val, efficient) = match rel {
+            Relation::Low(e) => (CPUFREQ_RELATION_L, e),
+            Relation::High(e) => (CPUFREQ_RELATION_H, e),
+            Relation::Close(e) => (CPUFREQ_RELATION_C, e),
+        };
+
+        if efficient {
+            val |= CPUFREQ_RELATION_E;
+        }
+
+        val
+    }
+}
+
+/// Policy data.
+///
+/// Rust abstraction for the C `struct cpufreq_policy_data`.
+///
+/// # Invariants
+///
+/// A [`PolicyData`] instance always corresponds to a valid C `struct cpufreq_policy_data`.
+///
+/// The callers must ensure that the `struct cpufreq_policy_data` is valid for access and remains
+/// valid for the lifetime of the returned reference.
+#[repr(transparent)]
+pub struct PolicyData(Opaque<bindings::cpufreq_policy_data>);
+
+impl PolicyData {
+    /// Creates a mutable reference to an existing `struct cpufreq_policy_data` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpufreq_policy_data) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Returns a raw pointer to the underlying C `cpufreq_policy_data`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    /// Wrapper for `cpufreq_generic_frequency_table_verify`.
+    #[inline]
+    pub fn generic_verify(&self) -> Result<()> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+    }
+}
+
+/// CPU frequency table.
+///
+/// Rust abstraction for the C `struct cpufreq_frequency_table`.
+///
+/// # Invariants
+///
+/// A [`Table`] instance always corresponds to a valid C `struct cpufreq_frequency_table`.
+///
+/// The callers must ensure that the `struct cpufreq_frequency_table` is valid for access and
+/// remains valid for the lifetime of the returned reference.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to read a frequency value from [`Table`].
+///
+/// ```
+/// use kernel::cpufreq::Policy;
+///
+/// fn show_freq(policy: &Policy) {
+///     let table = policy.freq_table().unwrap();
+///
+///     // SAFETY: The index values passed are correct.
+///     unsafe {
+///         pr_info!("The frequency at index 0 is: {:?}\n", table.freq(0).unwrap());
+///         pr_info!("The flags at index 0 is: {}\n", table.flags(0));
+///         pr_info!("The data at index 0 is: {}\n", table.data(0));
+///     }
+/// }
+/// ```
+#[allow(dead_code)]
+#[repr(transparent)]
+pub struct Table(Opaque<bindings::cpufreq_frequency_table>);
+
+impl Table {
+    /// Creates a reference to an existing C `struct cpufreq_frequency_table` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpufreq_frequency_table) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the raw mutable pointer to the C `struct cpufreq_frequency_table`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_frequency_table {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    /// Returns frequency at `index` in the [`Table`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `index` corresponds to a valid table entry.
+    #[inline]
+    pub unsafe fn freq(&self, index: usize) -> Result<Hertz> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by the safety requirements of the function.
+        Ok(Hertz::from_khz(unsafe {
+            (*self.as_raw().add(index)).frequency.try_into()?
+        }))
+    }
+
+    /// Returns flags at `index` in the [`Table`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `index` corresponds to a valid table entry.
+    #[inline]
+    pub unsafe fn flags(&self, index: usize) -> u32 {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by the safety requirements of the function.
+        unsafe { (*self.as_raw().add(index)).flags }
+    }
+
+    /// Returns data at `index` in the [`Table`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `index` corresponds to a valid table entry.
+    #[inline]
+    pub unsafe fn data(&self, index: usize) -> u32 {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by the safety requirements of the function.
+        unsafe { (*self.as_raw().add(index)).driver_data }
+    }
+}
+
+/// CPU frequency table owned and pinned in memory, created from a [`TableBuilder`].
+pub struct TableBox {
+    #[allow(dead_code)]
+    entries: Pin<KVec<bindings::cpufreq_frequency_table>>,
+}
+
+impl TableBox {
+    /// Constructs a new [`TableBox`] from a [`KVec`] of entries.
+    ///
+    /// # Errors
+    ///
+    /// Returns `EINVAL` if the entries list is empty.
+    #[inline]
+    fn new(entries: KVec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        if entries.is_empty() {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            // Pin the entries to memory, since we are passing its pointer to the C code.
+            entries: Pin::new(entries),
+        })
+    }
+
+    /// Returns a raw pointer to the underlying C `cpufreq_frequency_table`.
+    #[inline]
+    fn as_raw(&self) -> *const bindings::cpufreq_frequency_table {
+        // The pointer is valid until the table gets dropped.
+        self.entries.as_ptr()
+    }
+}
+
+impl Deref for TableBox {
+    type Target = Table;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns TableBox, it is safe to deref.
+        unsafe { Self::Target::from_raw(self.as_raw()) }
+    }
+}
+
+/// CPU frequency table builder.
+///
+/// This is used by the CPU frequency drivers to build a frequency table dynamically.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create a CPU frequency table.
+///
+/// ```
+/// use kernel::cpufreq::TableBuilder;
+/// use kernel::clk::Hertz;
+///
+/// let mut builder = TableBuilder::new();
+///
+/// // Adds few entries to the table.
+/// builder.add(Hertz::from_mhz(700), 0, 1).unwrap();
+/// builder.add(Hertz::from_mhz(800), 2, 3).unwrap();
+/// builder.add(Hertz::from_mhz(900), 4, 5).unwrap();
+/// builder.add(Hertz::from_ghz(1), 6, 7).unwrap();
+///
+/// let table = builder.to_table().unwrap();
+///
+/// // SAFETY: The index values passed are correct.
+/// unsafe {
+///     assert_eq!(table.freq(0), Ok(Hertz::from_mhz(700)));
+///     assert_eq!(table.flags(0), 0);
+///     assert_eq!(table.data(0), 1);
+///
+///     assert_eq!(table.freq(2), Ok(Hertz::from_mhz(900)));
+///     assert_eq!(table.flags(2), 4);
+///     assert_eq!(table.data(2), 5);
+/// }
+/// ```
+#[derive(Default)]
+#[repr(transparent)]
+pub struct TableBuilder {
+    entries: KVec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates a new instance of [`TableBuilder`].
+    #[inline]
+    pub fn new() -> Self {
+        Self {
+            entries: KVec::new(),
+        }
+    }
+
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result<()> {
+        // Adds the new entry at the end of the vector.
+        Ok(self.entries.push(
+            bindings::cpufreq_frequency_table {
+                flags,
+                driver_data,
+                frequency: freq.as_khz() as u32,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    /// Consumes the [`TableBuilder`] and returns [`TableBox`].
+    pub fn to_table(mut self) -> Result<TableBox> {
+        // Add last entry to the table.
+        self.add(Hertz(c_ulong::MAX), 0, 0)?;
+
+        TableBox::new(self.entries)
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 11d333c8c673..871fcdc09b35 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,8 @@
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


