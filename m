Return-Path: <linux-pm+bounces-25510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658CA8B07E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213037AC943
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769822D4DA;
	Wed, 16 Apr 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mi0DhAl7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC722D4E6
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785602; cv=none; b=FEGHK3/u9WuMy5gj0/iJVnAY1KZ5+4ClIVsopL0n25eWk1AeOT+NbL8BqXVKs4TyEyZFsI+yFexWVydu2kHBnmtOU/EAnja0UbszKRukJtqlh7iLjSq0LObibKSSRLhh1VmU2dfNH8BNi2DpbGoWKKLqNj9ZimTefnoQDB0OpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785602; c=relaxed/simple;
	bh=6bdBeyQA7PvDMni0+v4HEV40R5KCJ3SAKrl8WzzUVVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtgCTiSx4xWsm3jxf6qeXWtccv/IniaBrHNHNHXNmq+JpgYvN4r6P6PgztXS72HdohZh6M9F8uNOIQFxIw+OD+sGaayqet8vTVPXG6ym9Nsgz1QdDtdZ+uAz+MtWsQTafnmMCh49n0nylUgp/9W1myWfmN6k6tVo+mQ/KOGUu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mi0DhAl7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso69632305ad.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785599; x=1745390399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYpmBeA7UxnY21oeYlIxfV+okNCfPfqyF8VN8X/0Ne0=;
        b=Mi0DhAl7LCmpA6886+JcUUgt2BFgqI4P64t66tCPDBIJVtHaXOqeFNdhO/2oflqKtK
         uidbcPLgR+7yQ+CgBxjjl3avZg7of1ONYAY/0dsuVZl3UeMNaZdVm6zWFly9qe4qPeAA
         +5PYkg9c7vVg5TDVuAWHydoX+Y8Oay+yNBQ+T7tLmmZhoq+/k9wEsGu1ZN03/s8+TGCW
         4VcazVR5p+zZ4Wri1vmZLWIIt8J2VBIaJCAjPEyZjI8DuXCRdsLh7i/paYvNoARVPicO
         MgBHTGcVDVWjscfRbqUtNLl/9ldnzmAFpYfLZNzoyk0MeGb5JkA7bUTPTvgWWSCwpi89
         hNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785599; x=1745390399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYpmBeA7UxnY21oeYlIxfV+okNCfPfqyF8VN8X/0Ne0=;
        b=XVrVnQz8t8KI3FpgTBCi3iYQsdoxBuhZHzBfAnpiA2+ybc4JoywxgyfzaTphY1Kz0D
         RkMI1fKbAB2ZUvmH9kJPl6ZNbDx5Rtxv9FfS97G65NSvznfyS8RBjqgOn6GS0j8xM9xt
         0CEhWzuDxuwbnS6pb5YvtaDMy9DgZTcUwJ5JT+JjqTasL++aoNnddHk+QZ0jFEadTjXn
         YagG3B+M3JVrC9IfZPAnjKxyoWzw944IPaEb+ibM/IYUqT05Uip8sQL7h6LdF+v0aCzZ
         QiTNsV2YAnK0TDpe/ioqVK/A6/85Ndogl9AvfIX3z3fVKIeEA3EIZumawNThaeRUWi0l
         cixA==
X-Gm-Message-State: AOJu0YyudZCFPmwPxIxZH5ELqzy4XSx6toQQ9yfleN9MZzKBXj1TEE1U
	9dN4NB6GuumJ3jAQIFMpqx/1MAIFbpoYb8+80xNThRnVKi6GhGmQ0WEHb2SNczk=
X-Gm-Gg: ASbGncsKEv+YTr6eAfrxFDru/PBNsD9mBtq71v4mYd+tvEkDtFDVdFlGG1f/VHiJdpQ
	vCOIe9YDyE3spOh5d1TcTOj5rAdfEhKTmm0nHt6SwtV87puwRWINHd8o7WEwKtKaMGJJ3m2cKNw
	ufpNFtpNRWvV7tCnPiz5C22SPFE3jNUlIh64iZo5pIOWKWZQQZUCm5A3DHhZ1R6gKEbdfQVjqv5
	Fe/olAZGRvHPX+P3NWE3aSJmv8uEau0P+elFkYDmkpKNMfmGbflmAXnXptglLg9fPyCGF136Cn6
	xcFCGvtV14KnvVrmqknGFPzOBADVIBpPie88/DtIkg==
X-Google-Smtp-Source: AGHT+IF7+Znv/mh7oQp9bmsmrTu5Ck/d5f/pMdRTPsL2N0g8egNebJnX1OOrb+ljUt4NujTr3M8rdA==
X-Received: by 2002:a17:902:d548:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22c358db40amr11897185ad.22.1744785599024;
        Tue, 15 Apr 2025 23:39:59 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e32dsm9646607b3a.150.2025.04.15.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:39:58 -0700 (PDT)
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
Subject: [PATCH V10 02/15] rust: cpumask: Add initial abstractions
Date: Wed, 16 Apr 2025 12:09:19 +0530
Message-Id: <4a8f23fd447897cb76ccc46d03cc30a2086a0e90.1744783509.git.viresh.kumar@linaro.org>
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


