Return-Path: <linux-pm+bounces-27301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB051ABB5A0
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A83B9576
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58042673AF;
	Mon, 19 May 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0RsFeRJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFC2673A3
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638474; cv=none; b=nOpDQW/V4ODk4ndt3irkmSNUY9u/zmHiZgFrgmiGYVnw1pCbNuiY6pnTprW3+b+M3nIZ8P75Dx5T7SAPek6fMDOUi9+j+WeZeZ+3ITrGX6JcesTkb2HxvpN+D29k2cjeDKp2Mfc4AbjDr9nBVq2fkhwe1EAqcUBn4y9++YMB7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638474; c=relaxed/simple;
	bh=mmdJGfj1J92fyXHZLWhOyf340q+M42KPjIPk+rr8ZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHOmSfXlsB7fz0mag5zVpJUd8clYP7L+zCiB+FJJpSToKyrnxCsnzquA31fwhFNyB/Ig1eXkES9ZsRp87WulbzcwLhIu2pamZfB8bTP5uy+bXHi0PALuJNJ0wEHNCvPpumjWsWHahJ6iQCO6ZprYQH7szdFcZlfoQUAiG17rJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0RsFeRJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231d4679580so22971755ad.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638470; x=1748243270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3/wI85QVIhlqw2UpEhcb3+sPWDU0QZqMy/18ZqpoOk=;
        b=r0RsFeRJ51AknYUosnfC8+1IV7KQr9rjOq9NoppZYKDbMezBhllNfVaN05YUm8xAz+
         Jq5hY2lRBnMiuqiepBiX8clk+h2HU4NMVfPosgyzPR8Vrg8Bcimor052PPjEEqtIACZ9
         tH6oGb1AJ/gXP+ejPbbY5kQ8XkBARpCY2TnD5Uqv9Dh2kjb83kb8pAJ5Pce4vZKlnOgW
         vynZcqrux6sk64u/j82MmWyWpggIZ8nybpJt8qpSh7kANL1NE2AxOGpkbB6dIRUDGp9r
         VNlWMZReVCzsPT+lK2bVEDjsf/kch41AecrYrTVTSB6e11sOmvNAXEDkA5fxDVL+F1pR
         w3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638470; x=1748243270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3/wI85QVIhlqw2UpEhcb3+sPWDU0QZqMy/18ZqpoOk=;
        b=hPXWi8gd1S6Yavoe9MFmA1r2UMNzCbleWpdrPmoicYtN5ApUf4AsrQoqsYnPrabPCO
         5ionQr8z3pOXECqZwnFAP7DedVJQWI/v8QlXPjpzkqs0s6uSSvZVwMDLxnJP04+b5L5q
         Y5aOEZU19VCirG2wySNnXVkwXtaDsHFb7+zjcEsxzseAH/a7e9iG1Kcris/TfG7SwQ+b
         hNI5sUh75zpMeT8abpNaMJeBKCOEajTrfEF2MGKzqzh1wM+rJl6mpAcw+gaoVd3uuBCu
         gJgxnf++sGt7vltqBW/uJHsI4JP3tQFeO7grqAiPK1hjdoeieMdNCbs7TfyO8UW9KzSN
         4Prw==
X-Gm-Message-State: AOJu0YwdMv4a/2TUXDp3iJ22yCnE9Ki7XRaVD5h0SO6FmsBUskuPm0Is
	ZaRWBrzRAkaupvYBxcbQJYJHPIu2PpzvE6OxNKbuP/9y2TN0RFSm6HpnbblgDx3XBfM=
X-Gm-Gg: ASbGncs381I3RmUiw4E53yfWE9mAowTQH9lPHn9n9jiYoAw+xjLuGw6eUDhyHmqDsRJ
	WudE3dKjw5T4dq6tAbcB6xgsYsoqF18FRryrLZkUi3jG3YfCQ3si7vGDCh5WhRnuzfV+BvdngJi
	XKg4I0KcCbVptAuEOucLEol3iF54mbNlN/IFM6nsRUqSPN8pnjEtz25PxgP0Ap/7bGRE03YZvDt
	zFBbpo8YzpsCWsz3T2GA+qZ7K7xCwElFjlKzaRrUQPMVHJzg7pk33X8g1ayW9LZgqwaN83dtUGH
	itvEQZfKqYuoudm08gN91yN0fqnKmNYNEA+gVlwAWe0y2zMPajrl
X-Google-Smtp-Source: AGHT+IFw7FZxkI/daEY9X+IfCeDBEfiSzb6xsNooBRE42Xq9dUAbYn7PCdnIHpUVKiHdEZ4KX8VyKA==
X-Received: by 2002:a17:903:19ce:b0:224:a74:28cd with SMTP id d9443c01a7336-231d454b072mr177377655ad.31.1747638470399;
        Mon, 19 May 2025 00:07:50 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed259esm52927915ad.222.2025.05.19.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:49 -0700 (PDT)
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
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 02/15] rust: cpumask: Add initial abstractions
Date: Mon, 19 May 2025 12:37:07 +0530
Message-Id: <24d77314f3dc848dbe73e19aed87a69dde55ed0b.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
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
Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
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


