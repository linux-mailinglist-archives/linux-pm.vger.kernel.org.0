Return-Path: <linux-pm+bounces-20312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C84A0B58A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFD41684A1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9F2500B0;
	Mon, 13 Jan 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF1z3oAj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED53233D8D
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767446; cv=none; b=f7bUPauILfKH2PQ2N/jcA6JXiWwR+nPfw1wkRFLxzh5xosdQn+qBMmvovs7j4gzK0VaaSYN8BV4epPnLa68ekqeFbUzVZZRWfrcahlbes4xQBqfrU7K0Ji5Cc40+79JIKvDMMfI4uNIB2modUrC3XvTAatuYsHk0TLqtjjRUhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767446; c=relaxed/simple;
	bh=/uvDKCjlgOnsUH8C0V/hZTcfvjq6TTMwI45slAFmITI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGLbGSiB5eTxCszBX/R/HIq/jfrOd43EfvDKqCDo9h5jRez7I+oP3EWP5SC/uFiOhRZjchlDtU8KmF5DU4eVhMsGHVYNrvRhuNpXLWNMBQKzvDk62qaA2cqanth7O0b1VkH3Hd2xWc+kk0/QLfZfWpfsnNEw4Y44NQupRYLa33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QF1z3oAj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so5211232a91.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767444; x=1737372244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DT/35uJ0SGSGPotN/aFFV/d+f5sRADYEA7sMqJpaVQ=;
        b=QF1z3oAj0XoyqVhwpcx088JnPrtdqTQs/WMZLO/Ivn61R0/XhcxhBH5l8RnXMl6+Xj
         f6wn684JaHY/WDmL0mpyM/jFyaSP3qZt+f7GhHrfdX6gC5/EhDRGBqRMIN9XS44086DA
         0LjgD7e4OzB1b71uk90dwyDKYilmJjGHebmOcPZPkhz+sUJZB860uhxN9pSn++oWWsnH
         Ys65Ur+usMzq5Pl6QZDrEMX0jsreQfnBaVVtG5NijLNfb/okqvu8jaFwZddqSS9gXAG0
         483UF4Yq3KdDuBJgOfGj5WkU07kWqYsw475ISKqk7m3N5IyYGR6B54btGs8a6bpJRoX+
         aHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767444; x=1737372244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DT/35uJ0SGSGPotN/aFFV/d+f5sRADYEA7sMqJpaVQ=;
        b=gB+rYd3RPgSfbkYGHnY5sP2FlEEOtoIpvooK+2m5GbuzcgOe6pll4saSeuMltCTd16
         ZhxAMH7wV06J21nw3JkxUpuJtBQTkLwq9esXQ6X5ww/KmyMj5IS9D29sjr6TB0rXVeqU
         O3eyYXdQL0VKB8T9WKgJIGKdVTPVxKHLZzOHB3qyLUkiiEvIVcnWzV3XKLdrRaXW4+Se
         p7stOFFcs6XNne7Uf0qOlBqyvwlUFrAZyQrUExEhMY4UYzdE5I+ne/2M5EmPOz9YJkNN
         CPsLU+g0yzMTC1R80JUI9Xz+NXdLIx+TdZaWtsLmKcn5JRDVEWLi+vQHc8+o/HvmNjW7
         5rbw==
X-Forwarded-Encrypted: i=1; AJvYcCVjIJrXWlFPFi1WisbFGMtVOE3l/lWVK2aTuQew2Iguqq99FAM+8eLp2dRptgdYPEsI3ZO3l03CQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoUNQrcl+kvby0Upq+J+akZ2JVAnd4dfZrQlDFOzddygkHElF
	fPm1AXB1E0F0ifCFnuNZM/i0oMtQMsLBUEzpiZaMR5qCKgQZSwua+B/GmXUU5zQ=
X-Gm-Gg: ASbGncs71SawkELJu/JvQQ0wuepF3IhWGDW2N6zh+SMuJexgi9cehAK4LWFS6M5xlvZ
	qQJjlFT6pGo1y1Tkovk8Qsye2gwSj7hCW6S43ob+8K5LD1RYlxLE4f/6jTnsTVszzIe6YjJjpwY
	tYhfyMtx0QpUsPUG+LTePWoPvn0M4Ia1fdHHeiJ4RtdqQJErLpoJschK4rgz45c1gU+hYN+ogur
	2OcT5L8/XNELqgvLbiDGxP2ZlE83sq+Hlvvt2E95d//5btUp0+eqkBjkOM=
X-Google-Smtp-Source: AGHT+IGzJcomzKu3um0t7HxdPCLFlwOxE0siZO+gePGZ/L+Xri4khqzqUGXcTjLI5lYyDPnM+gaq7w==
X-Received: by 2002:a17:90b:50c4:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-2f548ebf4fbmr35219371a91.12.1736767443736;
        Mon, 13 Jan 2025 03:24:03 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219f0dsm51767265ad.139.2025.01.13.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:03 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 08/16] rust: Add initial bindings for OPP framework
Date: Mon, 13 Jan 2025 16:53:03 +0530
Message-Id: <5f3c7ac94e22c8bda51910360b399439c37babe2.1736766672.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736766672.git.viresh.kumar@linaro.org>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds initial Rust bindings for the Operating performance
points (OPP) core. This adds bindings for struct dev_pm_opp and
struct dev_pm_opp_data to begin with.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 189 ++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ee1c013cd6e..3f9ebca78732 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17707,6 +17707,7 @@ F:	Documentation/devicetree/bindings/opp/
 F:	Documentation/power/opp.rst
 F:	drivers/opp/
 F:	include/linux/pm_opp.h
+F:	rust/kernel/opp.rs
 
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4eadcf645df0..7f851d5907af 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5d43dc5ec9eb..d1c0f136952e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -62,6 +62,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..becb33880c92
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
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
+/// Dynamically created Operating performance point (OPP).
+pub struct Token {
+    dev: ARef<Device>,
+    freq: usize,
+}
+
+impl Token {
+    /// Adds an OPP dynamically.
+    pub fn new(dev: &ARef<Device>, mut data: Data) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })?;
+        Ok(Self {
+            dev: dev.clone(),
+            freq: data.freq(),
+        })
+    }
+}
+
+impl Drop for Token {
+    fn drop(&mut self) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(self.dev.as_raw(), self.freq) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: usize, u_volt: usize, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+
+    /// Adds an OPP dynamically. The OPP is freed once the [`Token`] gets freed.
+    pub fn add_opp(self, dev: &ARef<Device>) -> Result<Token> {
+        Token::new(dev, self)
+    }
+
+    fn freq(&self) -> usize {
+        self.0.freq
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// Wraps the kernel's `struct dev_pm_opp`.
+///
+/// The pointer to `struct dev_pm_opp` is non-null and valid for the lifetime of the `OPP`
+/// instance.
+///
+/// # Invariants
+///
+/// Instances of this type are reference-counted. The reference count is incremented by the
+/// `dev_pm_opp_get()` function and decremented by `dev_pm_opp_put`. The Rust type `ARef<OPP>`
+/// represents a pointer that owns a reference count on the OPP.
+///
+/// A reference to the `OPP`, `&OPP` isn't refcounted by the Rust code.
+
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: It's OK to send the ownership of `OPP` across thread boundaries.
+unsafe impl Send for OPP {}
+
+// SAFETY: It's OK to access `OPP` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
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
+    /// Creates an owned reference to a [`OPP`] from a valid pointer.
+    ///
+    /// The refcount is incremented by the C code and will be decremented by `dec_ref()` when the
+    /// ARef object is dropped.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and the OPP's refcount is incremented. The
+    /// caller must also ensure that it doesn't explicitly drop the refcount of the OPP, as the
+    /// returned ARef object takes over the refcount increment on the underlying object and the
+    /// same will be dropped along with it.
+    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// The refcount is not updated by the Rust API unless the returned reference is converted to
+    /// an ARef object.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the duration of 'a.
+    pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `OPP` is `repr(transparent)`.
+        Ok(unsafe { &*ptr.cast() })
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> usize {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_raw(), index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> usize {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.as_raw()) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_raw()) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> usize {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.as_raw()) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_raw(), index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
+    }
+}
-- 
2.31.1.272.g89b43f80a514


