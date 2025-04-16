Return-Path: <linux-pm+bounces-25520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0BA8B0A1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A7A189B845
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868423BD02;
	Wed, 16 Apr 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFVXURQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4D23BCE1
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785642; cv=none; b=hShxXhoUMVt4Ilp6sAHo6dS8nn4oK0Nx4svrYI/pxXvnlYyUhTAZX/m8dohjGzS1wEnBsgpNoF4PfOt3c/GyAEyC5ULgKeKjQpVaKjaMjz1TGiVWeWLL/FioMU6N1yCUreZL78kHhErGSUVg7fqNaQPymWQnjg837Csew1UYWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785642; c=relaxed/simple;
	bh=G0pmXNLUXAb3eCePQJZ5QhL56ydxt1gjfb8YB65k1eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ju9bGY2bi70VPzKQBHeiOWXL5YnCyLuuPXdvSbQt9fGCWasPsdbJT9krY1ep7rXLllbpgzgoZNSKnx2bPE/MhBdNLzqv9sjfLhzluQHg6aOhtTcXpdWT2ImZokc+qkeoeHnqxyvT2M1YvaiStYeSW3hTZ510GKae9tMuDSiSZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFVXURQk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33ac23edso3688275ad.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785639; x=1745390439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uv8QgainGGqFWtfVNXtqhQ8aLq7TNgS+wvUJbfZwLM=;
        b=EFVXURQkdBpipKrj9UZzNgReYsPLbZrVq1w7sIfE0i7wILQt+9RqE4A2sqyCduMFEG
         amBYWLl/zRHxSk03hp3sr/1SxdG192dW5DNLAa7+murfIB+4nE+C/s0o4qcBHUAV2s8I
         z6rJCOQbmtjujwJPWVBiZS1wFjSbG6MTJCPouX5UBAgScZnR3/umsys7dyyjRVMHsqEO
         WkFHOCtMjFVlFlZ9ymXst08SZ/gpK810u0c3FV9+b3uQi/bdZta+gG0pF+Qm88aXfbSH
         R7GfKtdMeI+SdQ5oPjEv/vMIEk74vW8wP7wxnqkN3L1kYdU943ebNZBjlVNuY8YOVfcg
         R+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785639; x=1745390439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uv8QgainGGqFWtfVNXtqhQ8aLq7TNgS+wvUJbfZwLM=;
        b=pbAeYj4GTb7sE2pz9AwSjD8WYoAT6OOLwo+I9FPCdUn4QYOX/TGRioC44vkOOIUO6s
         Rws5DgOG2qHAF9N9LV3Q46BlE7nfubJMUbIdCtKTBg75o4Wt5P4uLFg7MoDhOnvX9xtZ
         2jNRzILXtqri3CPHnyo27HriKTh/t+3PTLURaIbLH7IuO+U+WiEc8Y18CNjxLuU9bdyx
         l8R4TOe0xRJ2j5VnwJXHvI6Euj3X3dmwV/f2ZMzcU53Z0MNnqO7+jK4WmQuDhcJx31px
         7FNATULKhTfbrY+LGDeD2Ubp0fypSCtkNJcMKpEON0l/DsiYSK8VnBF6P9FFtT/j6NcV
         1eNg==
X-Gm-Message-State: AOJu0YxYVpBa2VxosBjrNit2zEgET8b8ypRmyXfAjxNBOG//f/lP92fP
	p2NyPBUohKa+kicnJ9TUUXQ2i2lRLWabfPTL67YqV+3Z69UDcTSPbFAgKge9eeA=
X-Gm-Gg: ASbGncu1zclMYyKFeS/Z0fbw7dUqlX7o5FX68djkfasknVxZAOyXlf4GfynLjNhNGr8
	XlndQfDhidISIxuxV0vJklsD11AtsNALdflAoDrFGaw7smSDKU3+tous3sOGoQxpcdPfobA66OQ
	xa3DScpUeZO9y5ngA+TdQ8Ik2M88bX4rrSYqH91bveYjO3VzJNo1WdLNXR/joEJmhsUiAbcjjx2
	03nvNMWtg+y+pnaYR/Xaz9+DSVj8FM9ULy6ViEctI6748S1HKuHM+l7YgksT05VuWRV4N+3S1xk
	5+zKQTGncO6Jp8c/yZmOZgy/2ylzoQjvG8M6Ivk+ew==
X-Google-Smtp-Source: AGHT+IGHJ+14d4c94eNRvjN1xaiY12FX4RhJFywwuHYvJRpGkssRqu3ulNzKFKTVxkvjUfnSKiNxfw==
X-Received: by 2002:a17:903:238a:b0:224:2207:5130 with SMTP id d9443c01a7336-22c35983cccmr9959655ad.45.1744785639023;
        Tue, 15 Apr 2025 23:40:39 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm6463245ad.73.2025.04.15.23.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:38 -0700 (PDT)
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
Subject: [PATCH V10 12/15] rust: cpufreq: Extend abstractions for policy and driver ops
Date: Wed, 16 Apr 2025 12:09:29 +0530
Message-Id: <7a859b2da97e44a7b8e9d694bb7ffdd34e886cdc.1744783509.git.viresh.kumar@linaro.org>
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

Extend the cpufreq abstractions to include support for policy handling
and driver operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 457 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 456 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d9face425d47..fd605921add4 100644
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
 
@@ -346,3 +355,449 @@ pub fn to_table(mut self) -> Result<TableBox> {
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
+    // Returns a raw mutable pointer to the C `struct cpufreq_policy`.
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
+    // Sets the private data of the [`Policy`] using a foreign-ownable wrapper.
+    //
+    // # Errors
+    //
+    // Returns `EBUSY` if private data is already set.
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
+    // Clears and returns ownership of the private data.
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
+// CPU frequency policy created from a CPU number.
+//
+// This struct represents the CPU frequency policy obtained for a specific CPU, providing safe
+// access to the underlying `cpufreq_policy` and ensuring proper cleanup when the `PolicyCpu` is
+// dropped.
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
+    fn target_index(_policy: &mut Policy, _index: u32) -> Result<()> {
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
+    fn get_intermediate(_policy: &mut Policy, _index: u32) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Driver's `target_intermediate` callback.
+    fn target_intermediate(_policy: &mut Policy, _index: u32) -> Result<()> {
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


