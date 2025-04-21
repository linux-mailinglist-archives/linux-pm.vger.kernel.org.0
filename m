Return-Path: <linux-pm+bounces-25785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089CA94D03
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D4816B715
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3525B690;
	Mon, 21 Apr 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvgObXlN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78A25A656
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220213; cv=none; b=RqMaAcuzOGrdVPOOwl5wlEflU3U97e37Hjn2tqEuJ5NOkvw4n+fcwPkoZ9Gq9nYvgZrRbzAEnRxUOuCye4HZLFSsJSKu5aQ/ssXuI6r4mogQupyKt4PcIEuI+FGOozrSYKSo2VbxoIlTQJrQxvP5u3/HTVHjcs3HhFnR7I6JLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220213; c=relaxed/simple;
	bh=c8B0zdfOKcl3kZLvMDCl9OXUOPTxNxGJhE5CEd5zVYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfHJ6b/Tys3Pe18OJDgpM1Cnr2qtYFjrwkfbU3mpZ0gETJq6Lo9wRhlCJeJyZVUDAf3Pq2a3+SrkuCuZ3uQxdn68iDEP0mmlmuRS0BAFZe5y0kGesNMJIqUPLY4r/TYipJCBPDqrOJl30YVNpOi1VsBigW+E+Yk/ZisyVXr4BIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VvgObXlN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30572effb26so3366928a91.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220211; x=1745825011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpL6jiCJ5lYzq5wgbdxMXB6h/Nv5zlcQqf0W5EJ/Rk0=;
        b=VvgObXlNUf1tsV3K8RVAr+bsbrjw0hYqHLQOA2jJWEq8a2208pxGo7be9h1ZzrlFDk
         SJTja+7fDVdX/nxY8tdqEeZwaPPqDldhFShG2v/G9QRWJcxeiXZsC5u5E4Hfzrb2Maom
         YoXTD5PjTn97MAGo0SF+KKcSkU56S1EyKBAQbzCR0BFKbFTeSKkIeDQFRDK+rbRG0FHF
         hSzOa2o3y6tISIuqh4DGaxlmyl5o4CaPOY1quJ6Ka5GGFxfoyxvd+tM1Y0I4U5OELBI6
         AQKB7CSnOegxOvc6aXFACB96imwzI63hQfBX+6jU36cOUpbrj9yXYkQzhYl0ckGvHkGB
         aPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220211; x=1745825011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpL6jiCJ5lYzq5wgbdxMXB6h/Nv5zlcQqf0W5EJ/Rk0=;
        b=tFeJm1hV8HY4Wut8F55DGkuxLbKMfdNMVHXt/wUH5FpfXDMu3PSbQpVud2X26VJNHq
         HCbevo5F94ZXZuzOMeUQE2aZwIA6CBYvdNPdtHaJHgDuLvZeR/0hMufAxmbszrXelPwF
         ELvnnRXW6qGKNwDzgTpwNausYAqz8GkHhgMe4LFTannGHwCAIUl1lxLyUABX2aAxcq8u
         mvKOKCxCgdMNF2LmOegat8LXH3vHXGdFGbqFA90uBnd0u9otIofmkDe6pp+fewz2PeRY
         BDO7oAWK2sM3cWtXsRyqKNVgmKysxfj98oKP7PdcWJml//aj7Pxs9ijeAWHHtyUpWC/5
         1Reg==
X-Gm-Message-State: AOJu0Ywk2H+ClMYnRsljL14GO1GeZgBsDe+wRympAlv0/HzvAV5yDZkm
	5Om9/+24UvsIE92rLUQxg2jtJWAvkQ5ooMIorUhOgB2D4n1rQX0Lp+vcimxNHJc=
X-Gm-Gg: ASbGncviKmjJdLI7L5zOXGeF9BgrJBPX44WEBr9WQTQ80RhX83Y+h8V9deyPmdqBCdf
	zgRiNdKxkTfvnyZGV/G2Wh4FTi+W2j+JM5ktrrkUFm7Rxx37YxZmdFgW4Qg92IdRVJ2RFSl8pmf
	wk4uge5R62wGEPSvWBhjVgn1qwYMG5uiQCcNRgamKG3tLMVnJHQx8Lqri5D0SCZQDP7xrqozklq
	8b1JQjp1cGemz73gGCxjcB09Ufqw3F6I/5Y6sa15exvhS02k2p23MeHfr8e04W/DR+NC4x2LhUe
	0Kt/i3RV3Es9v9Oc3UljycEUo7/JSCaK2lqTzLzQBohSobgZyhql
X-Google-Smtp-Source: AGHT+IGMFli0VYy3euttDRfjCMAL4Q976zJoX2syJmV5AdZsjrJANhQGEqaD1LKm13BERvqoBFhSsQ==
X-Received: by 2002:a17:90b:548c:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-3087bb64809mr15511261a91.20.1745220210690;
        Mon, 21 Apr 2025 00:23:30 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e0febecsm5883921a91.39.2025.04.21.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:23:30 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
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
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 12/15] rust: cpufreq: Extend abstractions for policy and driver ops
Date: Mon, 21 Apr 2025 12:52:19 +0530
Message-Id: <a078133877033a9dfa6583e47f706cf082c4e999.1745218976.git.viresh.kumar@linaro.org>
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

Extend the cpufreq abstractions to include support for policy handling
and driver operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 457 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 456 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 279956c6d056..5e0bfd03fd30 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -9,15 +9,24 @@
 //! Reference: <https://docs.kernel.org/admin-guide/pm/cpufreq.html>
 
 use crate::{
-    error::{code::*, to_result, Result},
+    clk::{Clk, Hertz},
+    cpumask,
+    device::Device,
+    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::c_ulong,
     prelude::*,
+    types::ForeignOwnable,
+    types::Opaque,
 };
 
 use core::{
+    ops::{Deref, DerefMut},
     pin::Pin,
+    ptr,
 };
 
+use macros::vtable;
+
 /// Default transition latency value in nanoseconds.
 pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
 
@@ -362,3 +371,449 @@ pub fn to_table(mut self) -> Result<TableBox> {
         TableBox::new(self.entries)
     }
 }
+
+/// CPU frequency policy.
+///
+/// Rust abstraction for the C `struct cpufreq_policy`.
+///
+/// # Invariants
+///
+/// A [`Policy`] instance always corresponds to a valid C `struct cpufreq_policy`.
+///
+/// The callers must ensure that the `struct cpufreq_policy` is valid for access and remains valid
+/// for the lifetime of the returned reference.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create a CPU frequency table.
+///
+/// ```
+/// use kernel::cpufreq::{ETERNAL_LATENCY_NS, Policy};
+///
+/// fn update_policy(policy: &mut Policy) {
+///     policy
+///         .set_dvfs_possible_from_any_cpu(true)
+///         .set_fast_switch_possible(true)
+///         .set_transition_latency_ns(ETERNAL_LATENCY_NS);
+///
+///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Policy(Opaque<bindings::cpufreq_policy>);
+
+impl Policy {
+    /// Creates a reference to an existing `struct cpufreq_policy` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpufreq_policy) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Creates a mutable reference to an existing `struct cpufreq_policy` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpufreq_policy) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Returns a raw mutable pointer to the C `struct cpufreq_policy`.
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::cpufreq_policy {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    #[inline]
+    fn as_ref(&self) -> &bindings::cpufreq_policy {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        unsafe { &*self.as_raw() }
+    }
+
+    #[inline]
+    fn as_mut_ref(&mut self) -> &mut bindings::cpufreq_policy {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        unsafe { &mut *self.as_raw() }
+    }
+
+    /// Returns the primary CPU for the [`Policy`].
+    #[inline]
+    pub fn cpu(&self) -> u32 {
+        self.as_ref().cpu
+    }
+
+    /// Returns the minimum frequency for the [`Policy`].
+    #[inline]
+    pub fn min(&self) -> Hertz {
+        Hertz::from_khz(self.as_ref().min as usize)
+    }
+
+    /// Set the minimum frequency for the [`Policy`].
+    #[inline]
+    pub fn set_min(&mut self, min: Hertz) -> &mut Self {
+        self.as_mut_ref().min = min.as_khz() as u32;
+        self
+    }
+
+    /// Returns the maximum frequency for the [`Policy`].
+    #[inline]
+    pub fn max(&self) -> Hertz {
+        Hertz::from_khz(self.as_ref().max as usize)
+    }
+
+    /// Set the maximum frequency for the [`Policy`].
+    #[inline]
+    pub fn set_max(&mut self, max: Hertz) -> &mut Self {
+        self.as_mut_ref().max = max.as_khz() as u32;
+        self
+    }
+
+    /// Returns the current frequency for the [`Policy`].
+    #[inline]
+    pub fn cur(&self) -> Hertz {
+        Hertz::from_khz(self.as_ref().cur as usize)
+    }
+
+    /// Returns the suspend frequency for the [`Policy`].
+    #[inline]
+    pub fn suspend_freq(&self) -> Hertz {
+        Hertz::from_khz(self.as_ref().suspend_freq as usize)
+    }
+
+    /// Sets the suspend frequency for the [`Policy`].
+    #[inline]
+    pub fn set_suspend_freq(&mut self, freq: Hertz) -> &mut Self {
+        self.as_mut_ref().suspend_freq = freq.as_khz() as u32;
+        self
+    }
+
+    /// Provides a wrapper to the generic suspend routine.
+    #[inline]
+    pub fn generic_suspend(&mut self) -> Result<()> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
+    }
+
+    /// Provides a wrapper to the generic get routine.
+    #[inline]
+    pub fn generic_get(&self) -> Result<u32> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu()) })
+    }
+
+    /// Provides a wrapper to the register with energy model using the OPP core.
+    #[cfg(CONFIG_PM_OPP)]
+    #[inline]
+    pub fn register_em_opp(&mut self) {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        unsafe { bindings::cpufreq_register_em_with_opp(self.as_mut_ref()) };
+    }
+
+    /// Gets [`cpumask::Cpumask`] for a cpufreq [`Policy`].
+    #[inline]
+    pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
+        // SAFETY: The pointer to `cpus` is valid for writing and remains valid for the lifetime of
+        // the returned reference.
+        unsafe { cpumask::CpumaskVar::as_mut_ref(&mut self.as_mut_ref().cpus) }
+    }
+
+    /// Sets clock for the [`Policy`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must guarantee that the returned [`Clk`] is not dropped while it is getting used
+    /// by the C code.
+    pub unsafe fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<Clk> {
+        let clk = Clk::get(dev, name)?;
+        self.as_mut_ref().clk = clk.as_raw();
+        Ok(clk)
+    }
+
+    /// Allows / disallows frequency switching code to run on any CPU.
+    #[inline]
+    pub fn set_dvfs_possible_from_any_cpu(&mut self, val: bool) -> &mut Self {
+        self.as_mut_ref().dvfs_possible_from_any_cpu = val;
+        self
+    }
+
+    /// Returns if fast switching of frequencies is possible or not.
+    #[inline]
+    pub fn fast_switch_possible(&self) -> bool {
+        self.as_ref().fast_switch_possible
+    }
+
+    /// Enables / disables fast frequency switching.
+    #[inline]
+    pub fn set_fast_switch_possible(&mut self, val: bool) -> &mut Self {
+        self.as_mut_ref().fast_switch_possible = val;
+        self
+    }
+
+    /// Sets transition latency (in nanoseconds) for the [`Policy`].
+    #[inline]
+    pub fn set_transition_latency_ns(&mut self, latency_ns: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.transition_latency = latency_ns;
+        self
+    }
+
+    /// Sets cpuinfo `min_freq`.
+    #[inline]
+    pub fn set_cpuinfo_min_freq(&mut self, min_freq: Hertz) -> &mut Self {
+        self.as_mut_ref().cpuinfo.min_freq = min_freq.as_khz() as u32;
+        self
+    }
+
+    /// Sets cpuinfo `max_freq`.
+    #[inline]
+    pub fn set_cpuinfo_max_freq(&mut self, max_freq: Hertz) -> &mut Self {
+        self.as_mut_ref().cpuinfo.max_freq = max_freq.as_khz() as u32;
+        self
+    }
+
+    /// Set `transition_delay_us`, i.e. the minimum time between successive frequency change
+    /// requests.
+    #[inline]
+    pub fn set_transition_delay_us(&mut self, transition_delay_us: u32) -> &mut Self {
+        self.as_mut_ref().transition_delay_us = transition_delay_us;
+        self
+    }
+
+    /// Returns reference to the CPU frequency [`Table`] for the [`Policy`].
+    pub fn freq_table(&self) -> Result<&Table> {
+        if self.as_ref().freq_table.is_null() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The `freq_table` is guaranteed to be valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        Ok(unsafe { Table::from_raw(self.as_ref().freq_table) })
+    }
+
+    /// Sets the CPU frequency [`Table`] for the [`Policy`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must guarantee that the [`Table`] is not dropped while it is getting used by the
+    /// C code.
+    #[inline]
+    pub unsafe fn set_freq_table(&mut self, table: &Table) -> &mut Self {
+        self.as_mut_ref().freq_table = table.as_raw();
+        self
+    }
+
+    /// Returns the [`Policy`]'s private data.
+    pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set from [`set_data`].
+            Some(unsafe { T::borrow(self.as_ref().driver_data) })
+        }
+    }
+
+    /// Sets the private data of the [`Policy`] using a foreign-ownable wrapper.
+    ///
+    /// # Errors
+    ///
+    /// Returns `EBUSY` if private data is already set.
+    fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result<()> {
+        if self.as_ref().driver_data.is_null() {
+            // Transfer the ownership of the data to the foreign interface.
+            self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    /// Clears and returns ownership of the private data.
+    fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            let data = Some(
+                // SAFETY: The data is earlier set by us from [`set_data`]. It is safe to take
+                // back the ownership of the data from the foreign interface.
+                unsafe { <T as ForeignOwnable>::from_foreign(self.as_ref().driver_data) },
+            );
+            self.as_mut_ref().driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+/// CPU frequency policy created from a CPU number.
+///
+/// This struct represents the CPU frequency policy obtained for a specific CPU, providing safe
+/// access to the underlying `cpufreq_policy` and ensuring proper cleanup when the `PolicyCpu` is
+/// dropped.
+struct PolicyCpu<'a>(&'a mut Policy);
+
+impl<'a> PolicyCpu<'a> {
+    fn from_cpu(cpu: u32) -> Result<Self> {
+        // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu) })?;
+
+        Ok(Self(
+            // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
+            // the returned reference.
+            unsafe { Policy::from_raw_mut(ptr) },
+        ))
+    }
+}
+
+impl<'a> Deref for PolicyCpu<'a> {
+    type Target = Policy;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl<'a> DerefMut for PolicyCpu<'a> {
+    fn deref_mut(&mut self) -> &mut Policy {
+        self.0
+    }
+}
+
+impl<'a> Drop for PolicyCpu<'a> {
+    fn drop(&mut self) {
+        // SAFETY: The underlying pointer is guaranteed to be valid for the lifetime of `self`.
+        unsafe { bindings::cpufreq_cpu_put(self.0.as_raw()) };
+    }
+}
+
+/// CPU frequency driver.
+///
+/// Implement this trait to provide a CPU frequency driver and its callbacks.
+///
+/// Reference: <https://docs.kernel.org/cpu-freq/cpu-drivers.html>
+#[vtable]
+pub trait Driver {
+    /// Driver's name.
+    const NAME: &'static CStr;
+
+    /// Driver's flags.
+    const FLAGS: u16;
+
+    /// Boost support.
+    const BOOST_ENABLED: bool;
+
+    /// Policy specific data.
+    ///
+    /// Require that `PData` implements `ForeignOwnable`. We guarantee to never move the underlying
+    /// wrapped data structure.
+    type PData: ForeignOwnable;
+
+    /// Driver's `init` callback.
+    fn init(policy: &mut Policy) -> Result<Self::PData>;
+
+    /// Driver's `exit` callback.
+    fn exit(_policy: &mut Policy, _data: Option<Self::PData>) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `online` callback.
+    fn online(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `offline` callback.
+    fn offline(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `suspend` callback.
+    fn suspend(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `resume` callback.
+    fn resume(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `ready` callback.
+    fn ready(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `verify` callback.
+    fn verify(data: &mut PolicyData) -> Result<()>;
+
+    /// Driver's `setpolicy` callback.
+    fn setpolicy(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `target` callback.
+    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `target_index` callback.
+    fn target_index(_policy: &mut Policy, _index: TableIndex) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `fast_switch` callback.
+    fn fast_switch(_policy: &mut Policy, _target_freq: u32) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `adjust_perf` callback.
+    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize, _capacity: usize) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `get_intermediate` callback.
+    fn get_intermediate(_policy: &mut Policy, _index: TableIndex) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `target_intermediate` callback.
+    fn target_intermediate(_policy: &mut Policy, _index: TableIndex) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `get` callback.
+    fn get(_policy: &mut Policy) -> Result<u32> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `update_limits` callback.
+    fn update_limits(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `bios_limit` callback.
+    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `set_boost` callback.
+    fn set_boost(_policy: &mut Policy, _state: i32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `register_em` callback.
+    fn register_em(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
-- 
2.31.1.272.g89b43f80a514


