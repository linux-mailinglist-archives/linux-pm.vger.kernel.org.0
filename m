Return-Path: <linux-pm+bounces-8752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D08FFEF5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A9728804D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF715B97D;
	Fri,  7 Jun 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaBX6CNc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285115B961
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751562; cv=none; b=IsIVRlQXQWza/ecnuCI+4ViOt4V6Vx1DbuE8/s+gjwlc1FbNFJTPrm8feEF3Vlz4fuWHekombhAfjy+EpHZ92Gf08KOmid/sgERVNqaG0gjtq9PIo9scsw1pwVYfyiQSHeYUD8Gxy6kHhs8L3f/YMwT1BfSJ2oN5sJ+IA0E45xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751562; c=relaxed/simple;
	bh=d/ZQBZeD9xk0ytQ718aCkWrWOqvnzxpaUv5bwXMwhBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4MDilSQV4m1Fj8L0Yzx9KdtqULK3Nue7IUJgxZuA5Hpx1MPk0kwcuONRcl13NkP1BC+PuUv9/qtLiDssSL9zVU5u5qYEPNK1D/YfAO+spUqTdeGpUs0lGuX4OzTILhOIM7ibmfKzcCx4ZE/gULaH64zs7/dyUl4TnKllBAmik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaBX6CNc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso100790a91.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751560; x=1718356360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81AbJqMkmQOP0jsaSqrYKPdMCvuKMPB+xVHhmCmRbgI=;
        b=ZaBX6CNcBcY0KPhhdlN+l1/DiDGbDivJeAPrRCJUQTEu8AMTxcbOvKhbj5B4lbr/Y4
         LjM/z8U44PN9waFxp/Wb0sBROpoNql9+/03DqWSAXqZr7fQAUKuMm3TB+shk8eaq2xTv
         aVaAHuHx1SuEmX2KqIQ5jOb82DHEbVNDYsL3F11SkfjcIrlvU3qNiigQaJDywE2nGzS0
         EUQyYugYduli+QJt2O66zokDupPwCcs4wuO0IzS7y+I6IuQZeZ0rJ3qSA3VcXIMf8fGP
         P4SoI5/ShLbFKuFMiP8hmxnABGO1iXHnXBm1+zjZ9vxzbeOUS0vbgKDHqkk5W5hdlJM7
         0qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751560; x=1718356360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81AbJqMkmQOP0jsaSqrYKPdMCvuKMPB+xVHhmCmRbgI=;
        b=lZ5VhHDY/wIiMpsHKNduxMBzkpPugQ6jMyuWZQP5ODLuXxB4IW5YJv6Id+ppRjcILI
         vfD5pORZqY75kXoe3zQB+z2ZXBc6nI7fKHD9esZLaQuE7zsGY10ZlB2aKzNiATtVk6Fo
         3R2KqvB+Qyk3GoNBEsag26gOSLOX1JQvhVll7qnxguRzdktZuawj1j1g6NxCiBx4tRx7
         ZcmuLcbKlvcsffQS3SXwixQNfhfKSi74v6RVOoA3LltZPgRpljqooZN6vsgyRePj8cgB
         QFNSfzPbioZ5OHSRNppu1q5iMagvmiyDUW1g28mxIktQGY/tt8++aRZrpiWdk+1OoTdK
         Wy1A==
X-Forwarded-Encrypted: i=1; AJvYcCVYavIhQYbElI9oNf0ouX2sa9xgcKGB/eK5IIUfaUGsH9hi3OpFuoWD9cyTrjwH3CE288OM83cOz4gSTSCqYSXpmD2mwAR25VI=
X-Gm-Message-State: AOJu0YxVGDfNc1FcN63klJRWZJ9Ev3RjNTNoQ0Han02NoEV9CEs+OCcm
	eK8dHS/GYfgN2O9qgdoMF5eKvlR59aKDMn5ZWlEaKCjRy5vDP9e/2ppRtyXBUeo=
X-Google-Smtp-Source: AGHT+IGYKaptS6TuBb0EmDLduSvhUdAswh47VT1GJuTH6RZ3r7CwkR3CdDPkuPrN06B2IG4IMwaJBQ==
X-Received: by 2002:a17:90b:f8c:b0:2bd:7935:a14e with SMTP id 98e67ed59e1d1-2c2bcc633e6mr1750465a91.30.1717751560035;
        Fri, 07 Jun 2024 02:12:40 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c494a51sm3139924a91.48.2024.06.07.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:39 -0700 (PDT)
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
Subject: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
Date: Fri,  7 Jun 2024 14:42:16 +0530
Message-Id: <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds initial Rust bindings for the Operating performance
points (OPP) core. This adds bindings for `struct dev_pm_opp` and
`struct dev_pm_opp_data` to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 156 ++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 39853214806d..0465b03828b8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c5b21251ccba..82b527c76017 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod platform;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..9e5cf0412ed5
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{code::*, to_result, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+use core::ptr;
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
+/// particular, the ARef instance owns an increment on underlying object’s reference count.
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
+unsafe impl Send for OPP {}
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
+// thread.
+unsafe impl Sync for OPP {}
+
+// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
+unsafe impl AlwaysRefCounted for OPP {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl OPP {
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_ptr_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        //
+        // INVARIANT: The refcount is already incremented by the C API that returned the pointer,
+        // and we pass ownership of the refcount to the new `ARef<OPP>`.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_ptr(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let opp = unsafe { Self::from_ptr_owned(ptr) }?;
+
+        // Take an extra reference to the OPP since the caller didn't take it.
+        opp.inc_ref();
+
+        Ok(opp)
+    }
+
+    fn as_mut_ptr(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Adds an OPP dynamically.
+    pub fn add(dev: ARef<Device>, mut data: Data) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })
+    }
+
+    /// Removes a dynamically added OPP.
+    pub fn remove(dev: ARef<Device>, freq: u64) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(dev.as_raw(), freq) };
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> u64 {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_mut_ptr(), index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.as_mut_ptr()) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_mut_ptr()) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.as_mut_ptr()) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_mut_ptr(), index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_mut_ptr()) }
+    }
+}
-- 
2.31.1.272.g89b43f80a514


