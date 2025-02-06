Return-Path: <linux-pm+bounces-21457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A6A2A475
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9305F3A3F11
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6B22DF9F;
	Thu,  6 Feb 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o42qFJG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59422DF8F
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834155; cv=none; b=bgx05FVPA/18e7GBokReir45y5DPB4OVR9pCWUwHkCT5k+8a+nsaC8+xniIekrn5cqYf3vdkJ8C6sGVMF5oBmH5U0X9rZl9SJz4EitFahjv1SxDL7cEQr1ZuuTtHhrCzay8A+N7XjryHoDslIvXrQT0bmETxsHlZ9Gu9LKjpmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834155; c=relaxed/simple;
	bh=MHUCeyWGdx4+O3tnwVilY3SO1wVVguCwKtOWnA285dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abTuM/XKJs8OXNOCIVeQet/EXhx+7E4mMW4QaHpb/nZKIw7JyaVRxVF+iW+CJRarbpBUOgpQbEbvLjOVFXhaCRzyTPlGmRH/a8dYCFKbIGNz1Vl9zIKHQAA5OvWqqODM/EpkUU0+kHBydijLX1yoUsR1BBNUbHvCHtqTxLBtPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o42qFJG6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9bd7c480eso1223443a91.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834153; x=1739438953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVs26K7IXsmnaOMuPyO8w7b9kowAGAQ924n9Jrfg/D0=;
        b=o42qFJG6IeOO+/its2C7fFn34N1uoc3D2vfglSSmlHbkOiJfwBw9ncik9C0/CzAazY
         axzbpqxFevsWvSLAFSlxa5qd0xGaU6ds+rmAEKO5LTdmwdmCVyLLpjf/J0qIGj+n0x9+
         BB6AlQ21KGMiccn89K3dIEu5i8cljCGyONXVisCuv5nBBkxymLUxMGmW7UMYxxQTBbrY
         mvUzEGSN1PU7/+PE8CD6Gi3uRimsAvdNe1RyutkyeAnrORvmmn/TqWsAJFoitORlPVf3
         nVqhmZaForxUY8xjr4peswh/grWR1TRa1ceQBgHwOde82fXMpZuJhvBMbCqfqzgCjc04
         Z1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834153; x=1739438953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVs26K7IXsmnaOMuPyO8w7b9kowAGAQ924n9Jrfg/D0=;
        b=Wor0TZAw1Pn9suUAuzwnOeLOZl7973D/FC+OWWBN60wjxSOvMn9oF4Aj2PqHU6vguT
         Dj9EqIkmVt1JBQU91d0cg+7FZ7uFwr9uijsl7q0rFmIlOsyOHAteivnJc7J4aT/xWvrH
         5TXL0DTeMgiwApNrTJY0Sz531B64WUbkFni1ZT2P394p6IlEcMdXlYMrTojkdjcFYN7l
         HT46tiCo6jkfeXJOziDQ0gFAhfjzeqxE48uh+AX03pl0IBIy91S8jyqgMs9N1m6lx/AG
         vtXstC/SN3BCfpjFui3uOX3DE1bItEt7CRX5HhGJXZBDimKDHwP4584YQ9orkCyo9/+4
         jn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCggwzcZSGn3cDZlCCpiJYMNBYGsK7BhlmHSI6VsVvTyaKpZ14yWWfJi7Y84sb2wUIHoteGsL84Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eN0xr1XUo8m/8ToMhQ45qC4zIhr6TMAzjLrLnVWhGsruEMV1
	170S4dkTCVCb04RIDU2FGlJIFmHDe8rOXcyu8FZV7N0xHwIQmwUju3BMRDXtEq0=
X-Gm-Gg: ASbGncsRIRA5owCGcpKfgVreJAAJuuDCACcgkkpaVwjtBK591VsovWOxvRTCCSEPWOm
	/T47DS1GblwsZVeFYISYg2L12Hk5pCVhFU/a5DTDW5I/x/WZfXVh9dN7LTSBbhihRgF09ChkiUD
	wLDVZGlZxruuBv/Or0ZtzWDA/HM1nuALyoUtD71esuaQEy0QMSnPV5T0E0DATqCklvlfBwXn79f
	Un9ZBF6hc4lxTVYbAxmH69xe8M0hx6vNgPePxioaa/jkKmu+pE8GSA+eRaODg+OzzlSNRwnLsjn
	szqkiwq4LR8rHIaAuw==
X-Google-Smtp-Source: AGHT+IGnyPwyaOO7/lgpcYGVnoHbX60CW7ZMAJ7F4lxcsN/sc25hvQOSIHnC4nQu7UJd993EFWvnJQ==
X-Received: by 2002:a17:90b:5109:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2f9e080f2femr9401731a91.28.1738834152989;
        Thu, 06 Feb 2025 01:29:12 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a1848asm889701a91.12.2025.02.06.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:12 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
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
Subject: [PATCH V8 05/14] rust: Add bindings for cpumask
Date: Thu,  6 Feb 2025 14:58:26 +0530
Message-Id: <f1f96961c1d32f73d9316fd297c1b184fa73d9b5.1738832118.git.viresh.kumar@linaro.org>
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

This patch adds basic Rust bindings for struct cpumask.

These will be used by Rust based cpufreq / OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS            |   1 +
 rust/kernel/cpumask.rs | 138 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 140 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1bf2ebd77..ff4511914e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4022,6 +4022,7 @@ F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
 F:	rust/helpers/cpumask.c
+F:	rust/kernel/cpumask.rs
 F:	tools/include/linux/bitfield.h
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/bits.h
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..b0be8c75a2c2
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{bindings, error::Result, prelude::ENOMEM};
+
+#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+use crate::prelude::{KBox, GFP_KERNEL};
+
+#[cfg(CONFIG_CPUMASK_OFFSTACK)]
+use core::ptr;
+
+/// A simple implementation of `struct cpumask` from the C code.
+pub struct Cpumask {
+    ptr: *mut bindings::cpumask,
+    owned: bool,
+}
+
+impl Cpumask {
+    /// Creates empty cpumask.
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    pub fn new() -> Result<Self> {
+        let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        if !unsafe { bindings::zalloc_cpumask_var(&mut ptr, bindings::GFP_KERNEL) } {
+            return Err(ENOMEM);
+        }
+
+        Ok(Self { ptr, owned: true })
+    }
+
+    /// Creates empty cpumask.
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    pub fn new() -> Result<Self> {
+        let ptr = KBox::into_raw(KBox::new([bindings::cpumask::default(); 1], GFP_KERNEL)?);
+
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        if !unsafe { bindings::zalloc_cpumask_var(ptr, bindings::GFP_KERNEL) } {
+            return Err(ENOMEM);
+        }
+
+        Ok(Self {
+            ptr: ptr as *mut _,
+            owned: true,
+        })
+    }
+
+    /// Creates a new abstraction instance of an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    pub unsafe fn get_cpumask(ptr: &mut *mut bindings::cpumask) -> Self {
+        Self {
+            ptr: *ptr,
+            owned: false,
+        }
+    }
+
+    /// Creates a new abstraction instance of an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    pub unsafe fn get_cpumask(ptr: &mut bindings::cpumask_var_t) -> Self {
+        Self {
+            ptr: ptr as *mut _,
+            owned: false,
+        }
+    }
+
+    /// Obtain the raw `struct cpumask *`.
+    pub fn as_raw(&mut self) -> *mut bindings::cpumask {
+        self.ptr
+    }
+
+    /// Sets CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.ptr) };
+    }
+
+    /// Clears CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_clear_cpu()` for any CPU.
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.ptr) };
+    }
+
+    /// Sets all CPUs in the cpumask.
+    pub fn set_all(&mut self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.ptr) };
+    }
+
+    /// Gets weight of a cpumask.
+    pub fn weight(&self) -> u32 {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_weight()`.
+        unsafe { bindings::cpumask_weight(self.ptr) }
+    }
+
+    /// Copies cpumask.
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_copy()`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.ptr) };
+    }
+}
+
+impl Drop for Cpumask {
+    fn drop(&mut self) {
+        if self.owned {
+            // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe
+            // to call `free_cpumask_var()`.
+            unsafe { bindings::free_cpumask_var(self.ptr) }
+
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: The pointer was earlier initialized from the result of `KBox::into_raw()`.
+            unsafe {
+                drop(KBox::from_raw(self.ptr))
+            };
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 415c500212dd..ccbf7fa087a0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,7 @@
 #[doc(hidden)]
 pub mod build_assert;
 pub mod cpu;
+pub mod cpumask;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


