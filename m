Return-Path: <linux-pm+bounces-25775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D3A94CEB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B873AE58B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73F20FAB2;
	Mon, 21 Apr 2025 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjHaxDtZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30E20F098
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220174; cv=none; b=sFAk/V7/xp/rosilZA5Zjy0YlE3ukUZRh/ABJ5tS1/dZayrON9HYW7MZNwKVq/ZZDsPKd4U1m+ev5b0FfYP3d8kVlSR8tHHz/haiT2fsaccOj2UBzKxTGJMfwkgmnOGqrGKbmUMhlWoyTlQFu2RIvAPHIiXWMclEEySAoKQSO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220174; c=relaxed/simple;
	bh=6bdBeyQA7PvDMni0+v4HEV40R5KCJ3SAKrl8WzzUVVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utKftpz4+xws1Xjnm+WouzoWXEgUBrShSLedQnHIPxrcTGKmaq+1qK7F5T2KtHnBd8Q1cHWuaTE1E3mOTl4bN8wKuKcwDeb/HH9BtqgERUtiGRQbAhd4POAzEn+HCEW7bflgb41B1zHubgimWOGGvPA6FU+ooZNYtGuoT4gcGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjHaxDtZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33e5013aso41476835ad.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220172; x=1745824972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYpmBeA7UxnY21oeYlIxfV+okNCfPfqyF8VN8X/0Ne0=;
        b=TjHaxDtZNjCA62TPnrlRd0CW6W8XZN1sD8GmimcoutNFHWLkLxG1SNJkLQRPKuSHFL
         o+Hw0VlhiRtBtKhWjeykn01GVlIAIDYBtRSe5eUssm35awfi7GZcnUw+rbAHIjCPmUcu
         SE2vxmry6dHqrrxaYpiD2yqYyid0lteShE7Ttl+MZKgia0zfIXqHODSJScueyI+i+m2n
         7pH37D0b6upw6Qdbc1E+wIuoU/NhRcvayP0jUclVUE7/h8tBmrsxXOFp3X6N1PqDEjO+
         NxyG2y/PePuUQ/twFwCGj3/egW1YLYC8tmYzBytkJ1zYhG5w+2lEgN+Npw1J/7ic4qnI
         CECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220172; x=1745824972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYpmBeA7UxnY21oeYlIxfV+okNCfPfqyF8VN8X/0Ne0=;
        b=Cd3R2Pe/RFAHHBcSXEgl2BdTKDPUlr5wwbXPPSuFZwWf7axdhDTxic5O0cdS9cnEWQ
         GBQTUXvklgsZ7qjD7V+Udw3XukWMEVI2Mga3I2H5jZJGoXEcRMFC/Fl4eLMli8B0wNl8
         GbR4268F7Y/fejBVafZ93KrGNs1b5yIRXOpV2aDAG2WTMzAwP8axmX1rE+vx5w72iMh7
         b5GdUPb0FvHcAQ+xtteJQ3XIBsLM7PpNjVuNCKD1/KK2OxR2g4TOjl1whMPLg0D4KyhD
         E3PhHD2BXpS0yd4FF8ssURRSexxwxtqw5uWxQxHTSDkxDdOPW8gnZYHLREci8q7OYNJQ
         IR/w==
X-Gm-Message-State: AOJu0YxkyLpfx93AxBMyGJiJGLG7yebgZHOLevsErRPK6FeFlTxzxjzz
	Fml+d1LyeJMnnlBXT6xY8yY2X7IJFyT0vD9wl3i04UyPR+CNCRX128GWC2oykRw=
X-Gm-Gg: ASbGnctsvA17dqPdk5VtQcieLPB5wymXOxtS/ZCAS1mXhJmDmfPCSf2YPAR0UXSrjaX
	QMtenb3vZ0q1M596Kp5F7NQnTlgEgESD1G+i4V7Qi4RY3go0lbDP9Mg/JrCFlqLwZKL/YU6QYvx
	xtqvEUI+T1UAtbzEvS7/JY11ID8roNP5SA1H5RSqiQAJzSu19FvjQGCmFyTLkDqbgMxjqlqIYIL
	5Chv3TkoNDDxJnZ0bDTXrl9METDzAZRF2oi2UZuNTAcJJjLU9wpHw2HztLflh3T5e9/T0mn+UcF
	Zvhzo3WA2vPsisibYu3G+wGJ6YAbxY1eG+CQLNnGCTGtVrXKKdMt
X-Google-Smtp-Source: AGHT+IFgHdhMJfK4QGzdQrrlcnlF6l1kzsZgx4KMtOxNf9FpUUpVRDonqnuL7JYZDvqFFnKoz+ql/Q==
X-Received: by 2002:a17:902:f682:b0:224:912:153 with SMTP id d9443c01a7336-22c53573d25mr174757935ad.5.1745220171548;
        Mon, 21 Apr 2025 00:22:51 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb5349sm59226245ad.157.2025.04.21.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:22:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 02/15] rust: cpumask: Add initial abstractions
Date: Mon, 21 Apr 2025 12:52:09 +0530
Message-Id: <4a8f23fd447897cb76ccc46d03cc30a2086a0e90.1745218975.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial Rust abstractions for struct cpumask, covering a subset of
its APIs. Additional APIs can be added as needed.

These abstractions will be used in upcoming Rust support for cpufreq and
OPP frameworks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpumask.rs | 330 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 331 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..c90bfac9346a
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU Mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{
+    alloc::{AllocError, Flags},
+    prelude::*,
+    types::Opaque,
+};
+
+#[cfg(CONFIG_CPUMASK_OFFSTACK)]
+use core::ptr::{self, NonNull};
+
+#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+use core::mem::MaybeUninit;
+
+use core::ops::{Deref, DerefMut};
+
+/// A CPU Mask.
+///
+/// Rust abstraction for the C `struct cpumask`.
+///
+/// # Invariants
+///
+/// A [`Cpumask`] instance always corresponds to a valid C `struct cpumask`.
+///
+/// The callers must ensure that the `struct cpumask` is valid for access and
+/// remains valid for the lifetime of the returned reference.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to update a [`Cpumask`].
+///
+/// ```
+/// use kernel::bindings;
+/// use kernel::cpumask::Cpumask;
+///
+/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) {
+///     // SAFETY: The `ptr` is valid for writing and remains valid for the lifetime of the
+///     // returned reference.
+///     let mask = unsafe { Cpumask::as_mut_ref(ptr) };
+///
+///     mask.set(set_cpu);
+///     mask.clear(clear_cpu);
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Cpumask(Opaque<bindings::cpumask>);
+
+impl Cpumask {
+    /// Creates a mutable reference to an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Creates a reference to an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct cpumask` pointer.
+    pub fn as_raw(&self) -> *mut bindings::cpumask {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    /// Set `cpu` in the cpumask.
+    ///
+    /// ATTENTION: Contrary to C, this Rust `set()` method is non-atomic.
+    /// This mismatches kernel naming convention and corresponds to the C
+    /// function `__cpumask_set_cpu()`.
+    #[inline]
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
+        unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Clear `cpu` in the cpumask.
+    ///
+    /// ATTENTION: Contrary to C, this Rust `clear()` method is non-atomic.
+    /// This mismatches kernel naming convention and corresponds to the C
+    /// function `__cpumask_clear_cpu()`.
+    #[inline]
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
+        // `__cpumask_clear_cpu`.
+        unsafe { bindings::__cpumask_clear_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Test `cpu` in the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_test_cpu` API.
+    #[inline]
+    pub fn test(&self, cpu: i32) -> bool {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_test_cpu`.
+        unsafe { bindings::cpumask_test_cpu(cpu, self.as_raw()) }
+    }
+
+    /// Set all CPUs in the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_setall` API.
+    #[inline]
+    pub fn setall(&mut self) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_setall`.
+        unsafe { bindings::cpumask_setall(self.as_raw()) };
+    }
+
+    /// Checks if cpumask is empty.
+    ///
+    /// Equivalent to the kernel's `cpumask_empty` API.
+    #[inline]
+    pub fn empty(&self) -> bool {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_empty`.
+        unsafe { bindings::cpumask_empty(self.as_raw()) }
+    }
+
+    /// Checks if cpumask is full.
+    ///
+    /// Equivalent to the kernel's `cpumask_full` API.
+    #[inline]
+    pub fn full(&self) -> bool {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_full`.
+        unsafe { bindings::cpumask_full(self.as_raw()) }
+    }
+
+    /// Get weight of the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_weight` API.
+    #[inline]
+    pub fn weight(&self) -> u32 {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_weight`.
+        unsafe { bindings::cpumask_weight(self.as_raw()) }
+    }
+
+    /// Copy cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_copy` API.
+    #[inline]
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: By the type invariant, `Self::as_raw` is a valid argument to `cpumask_copy`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.as_raw()) };
+    }
+}
+
+/// A CPU Mask pointer.
+///
+/// Rust abstraction for the C `struct cpumask_var_t`.
+///
+/// # Invariants
+///
+/// A [`CpumaskVar`] instance always corresponds to a valid C `struct cpumask_var_t`.
+///
+/// The callers must ensure that the `struct cpumask_var_t` is valid for access and remains valid
+/// for the lifetime of [`CpumaskVar`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create and update a [`CpumaskVar`].
+///
+/// ```
+/// use kernel::cpumask::CpumaskVar;
+///
+/// let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
+///
+/// assert!(mask.empty());
+/// mask.set(2);
+/// assert!(mask.test(2));
+/// mask.set(3);
+/// assert!(mask.test(3));
+/// assert_eq!(mask.weight(), 2);
+///
+/// let mask2 = CpumaskVar::try_clone(&mask).unwrap();
+/// assert!(mask2.test(2));
+/// assert!(mask2.test(3));
+/// assert_eq!(mask2.weight(), 2);
+/// ```
+pub struct CpumaskVar {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    ptr: NonNull<Cpumask>,
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    mask: Cpumask,
+}
+
+impl CpumaskVar {
+    /// Creates a zero-initialized instance of the [`CpumaskVar`].
+    pub fn new_zero(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
+                //
+                // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
+                // scope.
+                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: FFI type is valid to be zero-initialized.
+            //
+            // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of scope.
+            mask: unsafe { core::mem::zeroed() },
+        })
+    }
+
+    /// Creates an instance of the [`CpumaskVar`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the returned [`CpumaskVar`] is properly initialized before
+    /// getting used.
+    pub unsafe fn new(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
+                //
+                // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
+                // scope.
+                unsafe { bindings::alloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: Guaranteed by the safety requirements of the function.
+            //
+            // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of scope.
+            mask: unsafe { MaybeUninit::uninit().assume_init() },
+        })
+    }
+
+    /// Creates a mutable reference to an existing `struct cpumask_var_t` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Creates a reference to an existing `struct cpumask_var_t` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Clones cpumask.
+    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {
+        // SAFETY: The returned cpumask_var is initialized right after this call.
+        let mut cpumask_var = unsafe { Self::new(GFP_KERNEL) }?;
+
+        cpumask.copy(&mut cpumask_var);
+        Ok(cpumask_var)
+    }
+}
+
+// Make [`CpumaskVar`] behave like a pointer to [`Cpumask`].
+impl Deref for CpumaskVar {
+    type Target = Cpumask;
+
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns CpumaskVar, so it is safe to deref the cpumask.
+        unsafe { &*self.ptr.as_ptr() }
+    }
+
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn deref(&self) -> &Self::Target {
+        &self.mask
+    }
+}
+
+impl DerefMut for CpumaskVar {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn deref_mut(&mut self) -> &mut Cpumask {
+        // SAFETY: The caller owns CpumaskVar, so it is safe to deref the cpumask.
+        unsafe { self.ptr.as_mut() }
+    }
+
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn deref_mut(&mut self) -> &mut Cpumask {
+        &mut self.mask
+    }
+}
+
+impl Drop for CpumaskVar {
+    fn drop(&mut self) {
+        #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `free_cpumask_var`.
+        unsafe {
+            bindings::free_cpumask_var(self.as_raw())
+        };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..75f78f6bfaa6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpumask;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


