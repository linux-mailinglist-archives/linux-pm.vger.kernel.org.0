Return-Path: <linux-pm+bounces-25516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E4A8B096
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2197A17FB76
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822023497B;
	Wed, 16 Apr 2025 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSGEEN+T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8692343B5
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785627; cv=none; b=HnDHLoQ14O6IG7zHAY+T7yupspl6MQkFwhCvA3g6pcmPnGNy3MYIhx2rnTnCgmL2/FhaQ0KZbe3c37scFDJ/yFGo8B+K61rqeAT751f25reahVlyrPyXKqEqvF1tSr3riEuWseHt8d8maIyjl1X0xwbpZ5UndfarrRIEDTuF5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785627; c=relaxed/simple;
	bh=I1t7iU9jhwvLXBuU8hfiaosgzTZnx2xZVO9nWUc6iC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUxeESx8GjLQE9S+H/XUelzkA+FGNuogWSou0UOd9dbvvhrFyCtsXzsaiULapHDMuJdDBt4r9wdS/gQSCchXzEG6SFTYfQD/9dCGLB5g/+GSgwYFf7MYC3XXG6r9DBWDo1SkHYyG0p3JAC3dVOThlSmcbFosm7t9n+7EJaqfZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uSGEEN+T; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ae727e87c26so4379033a12.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785623; x=1745390423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f8927gH4OXWVNjPTvv3LzcJ2zClxOXj6x0cZ+ChIL0=;
        b=uSGEEN+TsE3vTW9kBm/ZyxYarct5rou+SYBJiNFs40Ay0GhxmHpojJVj5FJvpmV3w3
         GLH55aJDA598pNDLtkIRZA/QgNj7OFQu8qzoA1Qjc4nvbSnBRkWI40+oe+GOMpxhUQBH
         xdPvdjyYdyX7eFzyW6hkkPr3D4UIAZvE4xyu1Dv1/eopnCPb5mvF+Od1RPXhEnx/JcLT
         2qLozOV65M0nkAH4gl2wsj/MCqg+NnB+UX4+7cTBCOD++XNvH0+exNU1Q3s2o7aigK2X
         a9gEDDIVTBZ9zmSYBt+fNHZL/RLHeQErW3j8SJ6xpGwjQoO2cpOjq7xrZQwJ7Aga8C3y
         zZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785623; x=1745390423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1f8927gH4OXWVNjPTvv3LzcJ2zClxOXj6x0cZ+ChIL0=;
        b=XX2063S/vu8tTFgaF0HTuPh7hvB7yF4pSRAwm2yehICzEEAkIvTXWJxbb1BIbFl7K4
         mtons/jHBNh0nwNaaDjVPX9MlBk7rr6YCuM+Q5uKiNml7wVQeXjOND+qaHLwqZhx5a85
         tNtsCrrVLgK+Lgk1KvLJoMbMQbv3tLMEm+S1YJaSIihxd0HbVWstYr/iNGHtUd44DpHW
         UjUlqdE9R4uNaFyUmAaea8Op1NkrwfGO2Spod7Oz/joUXHHeIdsqtZjanmr93YLJCQQD
         JxNVz9+6/gQGXqYJxQLuGcUJnWLEVqh4OE+6ZRWDWGQno62glgZGYGlr+7xsFFbNGw89
         MAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOo4cevBDv45IjD8DKCXwcO1wxFrxl8YLk/SHyA0EKitTlZE9BNEHND2XleGuQFirM217/CMgfjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqV+IRAisSe/1C0PbQakIS5ouRgQ4kVs4FGlT4yDaKKAi7U7f6
	dbxc+zrq05wwDCJ2QnDFBQji35XSzDLvTZ5g5d+Y2VvhG3CYL4gAY8S5vr60DLU=
X-Gm-Gg: ASbGncurSYPo2b5X0NIoriFto3nszNaHYj3a1dbfK1Saob3j7EZsXh46F4Bhh/7gxbW
	+RobfBpsRTM5RkYDqEY0wGuz8QZQD4eRRmkgt0fosnDo63bNK5EUbyfb0bZQzONfudqA4KV568Z
	t2U/fCF6GHGRNSOtIcFN/SqheqOSiAHPwPxig/QXGJNOGNZLyCFRTsrtJTK56OtzduX6rQNZmlb
	4+bXSqm68cqgs4cg8PGkstUklGP0NduETMBA1mxk2FicC/2CVsYw9wXtRracq/+2PgkP7u/LHrq
	LgpM7TsmwNU2quPNxPJhyaNxGc3kkWUUSGuR+Af+YA==
X-Google-Smtp-Source: AGHT+IE5rdw3FqJb3eH2eqckhW2GScLx0laJ//RkuqA0Y3UNttepQcIgCsE41Shc841uEd672M84gw==
X-Received: by 2002:a17:90b:520a:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-3086416f4dbmr1024536a91.29.1744785622846;
        Tue, 15 Apr 2025 23:40:22 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6894sm6396445ad.215.2025.04.15.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:22 -0700 (PDT)
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
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: [PATCH V10 08/15] rust: opp: Add initial abstractions for OPP framework
Date: Wed, 16 Apr 2025 12:09:25 +0530
Message-Id: <18bf0ffd9c0ea525d28235378fc15dbe4d496d97.1744783509.git.viresh.kumar@linaro.org>
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

Introduce initial Rust abstractions for the Operating Performance Points
(OPP) framework. This includes bindings for `struct dev_pm_opp` and
`struct dev_pm_opp_data`, laying the groundwork for further OPP
integration.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 299 ++++++++++++++++++++++++++++++++
 4 files changed, 303 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 475abf72869c..931e418f89ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18165,6 +18165,7 @@ F:	Documentation/devicetree/bindings/opp/
 F:	Documentation/power/opp.rst
 F:	drivers/opp/
 F:	include/linux/pm_opp.h
+F:	rust/kernel/opp.rs
 
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ac92c67d2c38..529f22891e0b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index db372f806875..11d333c8c673 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -68,6 +68,8 @@
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
index 000000000000..ec4f67c8aab4
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides rust abstractions for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
+//!
+//! Reference: <https://docs.kernel.org/power/opp.html>
+
+use crate::{
+    clk::Hertz,
+    device::Device,
+    error::{code::*, to_result, Result},
+    ffi::c_ulong,
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+use core::ptr;
+
+/// The voltage unit.
+///
+/// Represents voltage in microvolts, wrapping a [`c_ulong`] value.
+///
+/// ## Examples
+///
+/// ```
+/// use kernel::opp::MicroVolt;
+///
+/// let raw = 90500;
+/// let volt = MicroVolt(raw);
+///
+/// assert_eq!(usize::from(volt), raw);
+/// assert_eq!(volt, MicroVolt(raw));
+/// ```
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct MicroVolt(pub c_ulong);
+
+impl From<MicroVolt> for c_ulong {
+    #[inline]
+    fn from(volt: MicroVolt) -> Self {
+        volt.0
+    }
+}
+
+/// The power unit.
+///
+/// Represents power in microwatts, wrapping a [`c_ulong`] value.
+///
+/// ## Examples
+///
+/// ```
+/// use kernel::opp::MicroWatt;
+///
+/// let raw = 1000000;
+/// let power = MicroWatt(raw);
+///
+/// assert_eq!(usize::from(power), raw);
+/// assert_eq!(power, MicroWatt(raw));
+/// ```
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct MicroWatt(pub c_ulong);
+
+impl From<MicroWatt> for c_ulong {
+    #[inline]
+    fn from(power: MicroWatt) -> Self {
+        power.0
+    }
+}
+
+/// Handle for a dynamically created [`OPP`].
+///
+/// The associated [`OPP`] is automatically removed when the [`Token`] is dropped.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create an [`OPP`] dynamically.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::{Data, MicroVolt, Token};
+/// use kernel::types::ARef;
+///
+/// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
+///     let data = Data::new(freq, volt, level, false);
+///
+///     // OPP is removed once token goes out of scope.
+///     data.add_opp(dev)
+/// }
+/// ```
+pub struct Token {
+    dev: ARef<Device>,
+    freq: Hertz,
+}
+
+impl Token {
+    /// Dynamically adds an [`OPP`] and returns a [`Token`] that removes it on drop.
+    fn new(dev: &ARef<Device>, mut data: Data) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
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
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(self.dev.as_raw(), self.freq.into()) };
+    }
+}
+
+/// OPP data.
+///
+/// Rust abstraction for the C `struct dev_pm_opp_data`, used to define operating performance
+/// points (OPPs) dynamically.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create an [`OPP`] with [`Data`].
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::{Data, MicroVolt, Token};
+/// use kernel::types::ARef;
+///
+/// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
+///     let data = Data::new(freq, volt, level, false);
+///
+///     // OPP is removed once token goes out of scope.
+///     data.add_opp(dev)
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates a new instance of [`Data`].
+    ///
+    /// This can be used to define a dynamic OPP to be added to a device.
+    pub fn new(freq: Hertz, volt: MicroVolt, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq: freq.into(),
+            u_volt: volt.into(),
+            level,
+        })
+    }
+
+    /// Adds an [`OPP`] dynamically.
+    ///
+    /// Returns a [`Token`] that ensures the OPP is automatically removed
+    /// when it goes out of scope.
+    #[inline]
+    pub fn add_opp(self, dev: &ARef<Device>) -> Result<Token> {
+        Token::new(dev, self)
+    }
+
+    // Returns the frequency associated with this OPP data.
+    #[inline]
+    fn freq(&self) -> Hertz {
+        Hertz(self.0.freq)
+    }
+}
+
+/// A reference-counted Operating performance point (OPP).
+///
+/// Rust abstraction for the C `struct dev_pm_opp`.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the [`OPP`].
+///
+/// Instances of this type are reference-counted. The reference count is incremented by the
+/// `dev_pm_opp_get` function and decremented by `dev_pm_opp_put`. The Rust type `ARef<OPP>`
+/// represents a pointer that owns a reference count on the [`OPP`].
+///
+/// A reference to the [`OPP`], &[`OPP`], isn't refcounted by the Rust code.
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: It is okay to send the ownership of [`OPP`] across thread boundaries.
+unsafe impl Send for OPP {}
+
+// SAFETY: It is okay to access [`OPP`] through shared references from other threads because we're
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
+    /// The refcount is incremented by the C code and will be decremented by `dec_ref` when the
+    /// [`ARef`] object is dropped.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and the refcount of the [`OPP`] is incremented.
+    /// The caller must also ensure that it doesn't explicitly drop the refcount of the [`OPP`], as
+    /// the returned [`ARef`] object takes over the refcount increment on the underlying object and
+    /// the same will be dropped along with it.
+    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        //
+        // INVARIANT: The reference-count is decremented when [`OPP`] goes out of scope.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// The refcount is not updated by the Rust API unless the returned reference is converted to
+    /// an [`ARef`] object.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the duration of `'a`.
+    #[inline]
+    pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because [`OPP`] is `repr(transparent)`.
+        Ok(unsafe { &*ptr.cast() })
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Returns the frequency of an [`OPP`].
+    pub fn freq(&self, index: Option<u32>) -> Hertz {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        Hertz(unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_raw(), index) })
+    }
+
+    /// Returns the voltage of an [`OPP`].
+    #[inline]
+    pub fn voltage(&self) -> MicroVolt {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        MicroVolt(unsafe { bindings::dev_pm_opp_get_voltage(self.as_raw()) })
+    }
+
+    /// Returns the level of an [`OPP`].
+    #[inline]
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_raw()) }
+    }
+
+    /// Returns the power of an [`OPP`].
+    #[inline]
+    pub fn power(&self) -> MicroWatt {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        MicroWatt(unsafe { bindings::dev_pm_opp_get_power(self.as_raw()) })
+    }
+
+    /// Returns the required pstate of an [`OPP`].
+    #[inline]
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_raw(), index) }
+    }
+
+    /// Returns true if the [`OPP`] is turbo.
+    #[inline]
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
+    }
+}
-- 
2.31.1.272.g89b43f80a514


