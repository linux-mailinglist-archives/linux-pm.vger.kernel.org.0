Return-Path: <linux-pm+bounces-25238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB8A85B04
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC259C3337
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCD2BD5AD;
	Fri, 11 Apr 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIhmvIfA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E382BD597
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369191; cv=none; b=hDu1Hs+oWBQ4ob73ewYZT7ZxG9yw+K0IzF/I1Ng90PeFLFXMPoTSxGvE8BbDv3d2toH7Hu0B7Rsqo3uAOt31xpL5tF2UHdNmAA9bj8sKbJoUAF0asFlcFquuIhl091qQXHDO7qj92cCYiGRp3Lbe6mtCxt4xSzNdY8MFa+NM8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369191; c=relaxed/simple;
	bh=SgA2EjiLOXt6zPhknRFfdFb3bZ3ASN3rkBIwJXUb7j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CERfurhMcNxM/LmUsK5i6HqFnYcRE0yLrFJKzxgK0xs4+6bZqc60n9ccscZlgJAC7Hkm6wRuxWHuKA033i1NWYe9Ix5mxp7ffSafH1BNchqqkr0/YS4q4XqJYrgL7A0q6RqnQ0sUJ6px5wGKGQjqPpDxVAb3e3DdyldIuI64e9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIhmvIfA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c3e7b390so1660395b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369188; x=1744973988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiCk9eXA5sDbW+eWFju7laQkDVU7y1GpZogWt6fIoRE=;
        b=wIhmvIfADpU0BhY1xl42x1ogqfC7LvMJ5aDN6tdPSAc5yG+FiqGV2skKYuDCDDh/oE
         IpPQPzVJLXR4MKEzZwtvGB0RPiD7/cW+jNOtZKP6odhK5dSKbS75QPWalzrnYX8cwZ8z
         jMMpRL7kXNSSEz9lDoPutV6qxYntHjcayvNsPd2QrMiO92xqwzjs15vKey8wb8kruBxF
         VA1XRCsCYPU3Zy1dmUaMBDlfwSoBUtsQsEicaZQWZNY7J2eqQg9K9bqtPt2MKYBSBGQj
         MSORp1nSuzJmB0eLnDO9wDL2hCXNhCky0f89Xw5vSWF9HFGDXlGGm31w9WoCKXh7Nmcw
         sAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369188; x=1744973988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiCk9eXA5sDbW+eWFju7laQkDVU7y1GpZogWt6fIoRE=;
        b=GIXAcc+87eScwyvyHT6PbTRbVgPLPoLJHGZ5AMT/+WM/6rPReyYEkP2KzcTndX3xyZ
         swrf7ojT0HfRbW7IxuSu58DoC4EzC2StT42LaE6V4KLzBhEhsPJvpJ/9VA5w51kgP4/o
         IkE8u+uy6kMR2ycofBF8TiJnOHsV8y/i2noIA5u3waGw8P3CLCVCAe81hYuFRM93u64z
         HvCMz80vgsGGdS5DzL5+dwdUBoxhodn2lojVKUSZxOBNddmRLrjNWBaPZX3SK3S5NVMh
         xKyc2nNvYzbCSOVyoax5Bv1kMSufE7nOIoRNfMAnVwx9ydgb47Q42cFm+ghvHVkMVExc
         Hbmw==
X-Gm-Message-State: AOJu0Yzz3gsxsAASmlIn32cUgJCbUux2yTo59kD25tQHyUrczE+SBPBB
	7fQHxfVsloGwjpnGTL5JTu8hsuLKDTLJTbmYtF0ZQripoe7CZ9MAsjUItla9Ir0=
X-Gm-Gg: ASbGncvlQFRd5fVL+Y0gYHaRtenMYzulC+dTfRBK4SK+mGWqbdPK1yTxSzAlCG3yWPO
	62hfNUNVa5ZqMjy5A2US5DSXKljdgFIiZ1a1zFlpTnGgZuOg93fJWlklAPB/1C865YK2xo89Nfy
	qJrRWwNQ+lg7EfpJFwOZ5+msDeiqsplREUvfe2MZVD5YTZ8/ajXW8kRd4q3yXFiw8Y1zFtPUtYp
	xjxPrLJlIxEYRuSokNKCB11MA1sALGvVLQXXaVnvbkDPYepegnfxoK7+WlHqXkz8aP8Cq5oNnld
	3mK6oeisDLTl7+uVGGY7nCgvBBOTaURrMJfwMnMCBw==
X-Google-Smtp-Source: AGHT+IHB7NJWuP5C3bZG6BXNbSzjmJ2rwCfuMl9Ghv7r2LQJTr/s6JvFiveArH50OaIxUiQa4HR0nA==
X-Received: by 2002:a05:6a00:2284:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-73bd119993dmr3091351b3a.4.1744369188045;
        Fri, 11 Apr 2025 03:59:48 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e56dsm1216167b3a.135.2025.04.11.03.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:47 -0700 (PDT)
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
	Erik Schilling <erik.schilling@linaro.org>,
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
Subject: [PATCH V9 13/17] rust: cpufreq: Add initial abstractions for cpufreq framework
Date: Fri, 11 Apr 2025 16:25:12 +0530
Message-Id: <128ea2557facfc0e58ca8981798e5e72e9a5ba82.1744366571.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs          | 341 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 356 insertions(+)
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
index 000000000000..19bb616d3625
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,341 @@
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
+    bindings,
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
+    use crate::bindings;
+
+    /// Driver needs to update internal limits even if frequency remains unchanged.
+    pub const NEED_UPDATE_LIMITS: u16 = bindings::CPUFREQ_NEED_UPDATE_LIMITS as _;
+
+    /// Platform where constants like `loops_per_jiffy` are unaffected by frequency changes.
+    pub const CONST_LOOPS: u16 = bindings::CPUFREQ_CONST_LOOPS as _;
+
+    /// Register driver as a thermal cooling device automatically.
+    pub const IS_COOLING_DEV: u16 = bindings::CPUFREQ_IS_COOLING_DEV as _;
+
+    /// Supports multiple clock domains with per-policy governors in `cpu/cpuN/cpufreq/`.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = bindings::CPUFREQ_HAVE_GOVERNOR_PER_POLICY as _;
+
+    /// Allows post-change notifications outside of the `target()` routine.
+    pub const ASYNC_NOTIFICATION: u16 = bindings::CPUFREQ_ASYNC_NOTIFICATION as _;
+
+    /// Ensure CPU starts at a valid frequency from the driver's freq-table.
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = bindings::CPUFREQ_NEED_INITIAL_FREQ_CHECK as _;
+
+    /// Disallow governors with `dynamic_switching` capability.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = bindings::CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING as _;
+}
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
+        let efficient = val & bindings::CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !bindings::CPUFREQ_RELATION_E {
+            bindings::CPUFREQ_RELATION_L => Self::Low(efficient),
+            bindings::CPUFREQ_RELATION_H => Self::High(efficient),
+            bindings::CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+}
+
+impl From<Relation> for u32 {
+    // Convert to a C-compatible `u32` value.
+    fn from(rel: Relation) -> Self {
+        let (mut val, efficient) = match rel {
+            Relation::Low(e) => (bindings::CPUFREQ_RELATION_L, e),
+            Relation::High(e) => (bindings::CPUFREQ_RELATION_H, e),
+            Relation::Close(e) => (bindings::CPUFREQ_RELATION_C, e),
+        };
+
+        if efficient {
+            val |= bindings::CPUFREQ_RELATION_E;
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
+        self as *const _ as _
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
+        self as *const _ as _
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


