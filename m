Return-Path: <linux-pm+bounces-25235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E44A85AE6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB326445CB3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AF529CB54;
	Fri, 11 Apr 2025 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUN77Zi/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151B29CB4C
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369179; cv=none; b=mf+RoBFiQuZkYOHu208IA7bdWhGnThmAlwsZDAWPGlUn5k4O10mAg+5HnDSZNsVky72I1JgEdYQ/BqRFuUg7UMUKeFuf2kLJCkP+mHLZePSzwBGP7UhSzmgrvCjG0PdcyXDlIuvqE3lt+iDjKfqubpJi90Q8CmTxXS00wTuds90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369179; c=relaxed/simple;
	bh=vlmpgN/zBHIjh2H4c5Ov7dFKqyGVQmpGI3Gd4+3j0tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQWomkmpHMzKY49qDBsRHLU5oGvJuok/Be/dqCCRRdqpP6RJb++6XTj3b1RsmBt9Rs+NZrwbWkTJBfofLTfWZoGeutDJUR7hIagtry+P9YaHVyDVogmiL3HUUfFDPnTrCwI8itoEKGg+CaXHGNGpylCQgDgGo3wDWgWaFc4Fp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUN77Zi/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso19125435ad.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369176; x=1744973976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cztfZQqPxjnqWofE/ChubMPUhatuVM9yTjrRAQzZqY=;
        b=wUN77Zi/lnLV+KsMX+ulND8m3392RbwtxH1oN8OHPlxL+CcXmz6cqmQCy2oO3y/dqK
         epYOH6MVn8B6VjWTMsUyD7zp+4hOfxOMMXq7yQuLmgf7knXf7j0/ACzVBXLRo7fupRYD
         6if5qltqiJpmrnJB9aJ5dUmIUkOY62bZ7VFYJn2WKKaog1eGupy+zMshfTrcjOHC7xLn
         FnJ6dndxmhe0kP29FMkNBkoBfjqkhIvkFl0o5+FKoi0jwsSL7aRlOLtI1aW9tmNPz3eP
         RXp0DQMjiZTdtyYmsYde0EVgMunXdFY0a/BJTA46j4rKG0mByq486tcDDrvGnEb926tJ
         vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369176; x=1744973976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cztfZQqPxjnqWofE/ChubMPUhatuVM9yTjrRAQzZqY=;
        b=uRp9deNLTk1jpLQrSUKXlMYhisY6VvfcfCMjU/yvUOd8zkZkI+zIBhyGNQ2J+vdr8N
         MPIR6F2nBvdVDCRUFGdvR8euYDdaNjubnSvCIATJFwxyC1irhXKibz17anRwIGBESD9N
         7S6tgiZhEVLvGdgwtvxCu2zGqepdWz9Ucp3yd3MBcWss0+oLIKE59q2U1DJ/RBFicLsL
         vi7eAWKUPitMyncu4i8Uykq11CQ+SgjMAAEVvEyuPvjwT1VHQus6FEq5wgz2TIrNDF15
         qNEggsw5uI/xclifiwIOpfkVfQVfMrERKyDrbWgXhOif52WvIKUU4cM4HASc6l/iFE4m
         qKTg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ2zIEA/31xCH5IILm3v97GT1PtrGsE5XaltUOh5OhmgY8rYNdRGZQRPctMYaQlUejYCQLMN76A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4I/rYaACd0WY2ru4KsybQSUj7Vejry94ky0E5xsqR0iSku7p
	Aowz1gSnaclzgg9O0iNo7bnFxWJnXxP2TssIsfzVzIltJTHQUl2ihY8JNpQoH4M=
X-Gm-Gg: ASbGncvcSDTDpPyPbKrPxBsQs8afUB5Pq554IH2ZO0gaZUZyCeJGB139bQ+mbMt0qLa
	8NdwNxo22s10I03h6n9FQnCFYocLs8irn8zC6ZzfkInWwNVkjvTDLKXmim35AB2dUVEugc24Nqo
	YBOxrfiZXCLNDzMrxfbrrU9DBzzAUOpzFKtO2N2xQcRelhbNasTdKin0qPXQnOI22c04Ny5KnBa
	fwBvItYkMKKK19SuLZxlbQVgBHwPk7enXtvsa2pXOrP0h/PV/k8uM0fi2GCqfaub21jeHKG+s4J
	UCerrL6OgP0xzyUfZGpgI+4ywaVsJMfocRzE4kEpNQ==
X-Google-Smtp-Source: AGHT+IFmqnaQpraw9B1lIV1L99oKIJ0I/09pqj887rKhPture77c5UATtCkIfntkMSUO5kQbKWzIZQ==
X-Received: by 2002:a17:902:d512:b0:224:721:cc with SMTP id d9443c01a7336-22bea4ab7eemr28839375ad.13.1744369176304;
        Fri, 11 Apr 2025 03:59:36 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cbee8bsm46104895ad.208.2025.04.11.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:35 -0700 (PDT)
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
Subject: [PATCH V9 10/17] rust: opp: Add initial abstractions for OPP framework
Date: Fri, 11 Apr 2025 16:25:09 +0530
Message-Id: <18d082f870b9c0c615fc57b49269c0418dab2ed8.1744366571.git.viresh.kumar@linaro.org>
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

Introduce initial Rust abstractions for the Operating Performance Points
(OPP) framework. This includes bindings for `struct dev_pm_opp` and
`struct dev_pm_opp_data`, laying the groundwork for further OPP
integration.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 300 ++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+)
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
index 000000000000..e4780b41664f
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,300 @@
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
+    bindings,
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


