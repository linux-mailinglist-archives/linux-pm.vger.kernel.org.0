Return-Path: <linux-pm+bounces-25228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E0A85AE1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56279A621D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C20D2989BF;
	Fri, 11 Apr 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcA34Pzu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31E2989B5
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369153; cv=none; b=nRLi4AgGcsy0tMSWJiB5CSePGI5nHll2WXL05hqV5+2eDm1IHmRNmZYpCLjz/iVstua8v2U9eha9F5B4R/a18JBsdhLkX8v9jwOBDX0nQS9jGSkFKPNMjQNC1pVRQxj2AAnfdeqSYbzseFag2PUMVuELqr2z4D26EKAGygTvKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369153; c=relaxed/simple;
	bh=3RKsje1PNFnVLXX/G/S0mGGvTG/fkpcBc573XS0cMC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1Nj9Y8ergtQYGEX8JnI8x7qCKyQ1QJiqePKwnhRupVNrJ2XcbEL+umxZhBFHpcYlHVmHaNfNJm9cZOflh1f5jVYdsDZfSl8YADN7Ng2g0338msLHv0qU9OMGgiXPE7wJ1hGW1eI1gQbCRuGDvzg2vwYoC+/7rIoMbBXwZit+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcA34Pzu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1996491b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369150; x=1744973950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edDXYIWfYTwXBeTDJlsnMSAARjZrtAvFKTS5hVZIGiw=;
        b=mcA34Pzurpur0DDaHADjr7IhnvD/H0ufGUH8ybJ1IoNuIJtcsslT/xhLBi3dghuvEk
         UvZ1yQkjIhqRji0BBcFKL4fRjBqr1Og9WusuPR/2RITxQrpnHAGAvdCc/b8mmgGYVFD9
         Jmtdme9ToN4BljyT+w3oxdgQjXfVYlwqtPg4HIkZlKTzlKAV5VgUzyywDLaqb9bAIq8B
         G3y12prmyDQNRK3IeWZ+ttCfRp6jiVFVgZXBHaj6zbT0gbWxkTlUm+KICFRtre/CZ34q
         dEP//J7bv/WHmzmDQXtj52adqG4KL6YvRW0EqMkWLaPORpXSZI0I+1kLAloJCYESWm/w
         iPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369150; x=1744973950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edDXYIWfYTwXBeTDJlsnMSAARjZrtAvFKTS5hVZIGiw=;
        b=mGIhw6ge37fAPHjLGTTLThKkd7wVO0v/WEsNIgkVlElqCvh6f0TalH6tHB2xbGsuHu
         iuJcXgTouuC2vDY4nWKKbvvRFv55Nq2csSVtdfoFQs38J1uAneZUf6e3Qdb0kbG0thEm
         RCOkMOyfuFkBElPR5V0NbBZm00sM7pKT0hQN9dwOvwprPcmYztN5pDZMNjPhl7Rj7ycO
         dvVdllMMNzJpOtnUAgqQfRF6zyvlwOzxPJgMKtESrb/vMQmDI3fGVlN7x86fteXK4Uax
         1Er3ChTbhntG5f270x6hg9JiNHgPJCjjamoZ99kZseAtjCzR7FmHvFogFLP0msUZkYYI
         zdGg==
X-Gm-Message-State: AOJu0YwFdqgqP0Se5caqXgu1NgD09jcsIGE3BVWI22e+epXxtqB7Qf2/
	8ZrhCgdI4qcBeOLNG16Q23XJ77FnJtggb1ZWDCYiVUKJx2rZRTYqff0snXNE0hk=
X-Gm-Gg: ASbGncv/jCKnsNOxXb9O7KUNWnAVaNWKeR5QCm30sJ4cMuBV44sR50buelZC0w01Iqd
	xNlyVtZStpP/v38Eh5UjI6JjoN1rS1j+fr9KrHRcoqkHkhhlc2L2yyRSfDw66yJve/5N4Pl57pN
	NzTQf1AKocWZXol2xOdUPM3kWz7vnoh9gOUtF3sm2bb3Qij3LQb/QhEGA0pobLxv7SBX0XLouUS
	Xf3dItcPYE+YIpb6QIwik+Fl/bxt5W/WzHR+hfiqmPa24sjxOFtJ99hUo7y66oeTDU9BuyAvGI/
	06wO4Mmg4UbHpKhEf75aKqelWWFlBG9O1UICvvmAtw==
X-Google-Smtp-Source: AGHT+IHnmO8U1SRyZKo+9xUWfLqZAtCOSfF+JiScx5mOjsMCUB5lZMSIgenh0Na/qgfbZOqoDLyYGA==
X-Received: by 2002:aa7:8890:0:b0:736:ab21:8a69 with SMTP id d2e1a72fcca58-73bd0ea93eamr2951177b3a.0.1744369150256;
        Fri, 11 Apr 2025 03:59:10 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198c00sm1234519b3a.10.2025.04.11.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:09 -0700 (PDT)
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
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 03/17] rust: cpumask: Add initial abstractions
Date: Fri, 11 Apr 2025 16:25:02 +0530
Message-Id: <9a004e3dff5321dae3b96df2817799daa699ce01.1744366571.git.viresh.kumar@linaro.org>
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

Add initial Rust abstractions for struct cpumask, covering a subset of
its APIs. Additional APIs can be added as needed.

These abstractions will be used in upcoming Rust support for cpufreq and
OPP frameworks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpumask.rs | 328 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 329 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..a9d22c1d7a5a
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU Mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
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
+/// The callers must ensure that the `struct cpumask` is valid for access and remains valid for the
+/// lifetime of the returned reference.
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
+///     let mask = unsafe { Cpumask::from_raw_mut(ptr) };
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
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
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
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct cpumask` pointer.
+    pub fn as_raw(&self) -> *mut bindings::cpumask {
+        self as *const _ as _
+    }
+
+    /// Set `cpu` in the cpumask.
+    ///
+    /// Equivalent to the kernel's `__cpumask_set_cpu` API.
+    #[inline]
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
+        unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Clear `cpu` in the cpumask.
+    ///
+    /// Equivalent to the kernel's `__cpumask_clear_cpu` API.
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
+/// let mut mask = CpumaskVar::new(GFP_KERNEL).unwrap();
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
+    /// Creates an initialized instance of the [`CpumaskVar`].
+    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
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
+    /// Creates an uninitialized instance of the [`CpumaskVar`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the returned [`CpumaskVar`] is properly initialized before
+    /// getting used.
+    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
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
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
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
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Clones cpumask.
+    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {
+        // SAFETY: The returned cpumask_box is initialized right after this call.
+        let mut cpumask_box = unsafe { Self::new_uninit(GFP_KERNEL) }?;
+
+        cpumask.copy(&mut cpumask_box);
+        Ok(cpumask_box)
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


