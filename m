Return-Path: <linux-pm+bounces-21463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B1A2A483
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96223A8B69
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157A22FACA;
	Thu,  6 Feb 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrnBv0uV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D322F3B4
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834178; cv=none; b=gquSnW1pUkLvqouTRdi0PQgryIDxiztrgCMg7oYx2ruqkFfW7poQxu1/iatir5tuGq6vJelRlBf0nDOq7gO3amyXKw3N2Hv52C6gX1h3RYPdsZpjDdwkzklOshlC81Q8c0fHUC6Z4DEK6o4i90atAVBWIwERdeLqaDZM0adxHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834178; c=relaxed/simple;
	bh=hzuNhO1Q3IkyXCT/x1RQcToG9eFKeb1mwBR+qRFJhIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i330e4YRRwCN22N6RkXn5WvKFRKoa3JNzq6FwG4qC8A4OB1zJOHuUMtFxMJ8eAet1zJNrtUh42lEU3KIex4dNLsnJgynclyzSIOL9HLHXrbzFxErt7l8ByzDy/reh7FKXgmEluCJxOj5zdk0nQLm+TDvMa9Q1PXh9FfcDqxUwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YrnBv0uV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2f09865bso12373205ad.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834176; x=1739438976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BewoLF4XXJE59tcPINPOfVWWxQlIhp/bpFbTZBnmMRo=;
        b=YrnBv0uV3Yx55AZ0z2c3aNCCjwz2vbhEYI9GyJEyLpwU7TdDTe+f1s1VR8VbVhphbI
         ZTKLRtbouMd0Oy6a02qtOg1LMqoCjyJIqMdFkG8ETjOloWLhXZZzI4k/K+TPeST+4qEz
         lwfPIIIUELVLZxSfLcYtDQ/NATLxIjrWGxhfcosO3iiwJHZAl/NTZkkN2bWE3E/JWotP
         APfWJarrCgzFMPbhoos8sKOej1osj9Cc3erZJlPQb8v9pIzsGO9M5ScqTv8zEARBM+78
         WfPXwW/R2eJAO9c3iFT6ep52sGU+oRbatoBmm9xM44tgVa+CtSsv3aC9FNB6FsT34Cxe
         VOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834176; x=1739438976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BewoLF4XXJE59tcPINPOfVWWxQlIhp/bpFbTZBnmMRo=;
        b=FTPYevqRnRhG6phHK3CQUSVfUFdyzhy8VlyrdI3K00jgiNMAnBFxU5KiwJpty5N5Ot
         S1BPPYhnyHtn5m1LWWNgA6IBTkvp+9cQANhsitdriARYX9AHtMG7agWcmkMu3/OHTVN3
         k5tHdEGO1wSS2h0PNdJf2A2NV29Qy+F6XBrJ40bwolBTxDKzagqwQnq9qLosFdFIoh4r
         Ux3c/7bqp1+70tHKiB82AdptdTYLO2tv4smnUFDvrhIkvKpsKxvzikFk2An8dmgj0II+
         wxrv9PcSoSStvlp4FyqQ9+kZTgzSxUgPvQiG9DTb6niegPgrhK9CCAJMKWAblFEL+0Ls
         dSWQ==
X-Gm-Message-State: AOJu0YxAK9jj3nwZXSg9vQVtRuEgRzZKN9dp6nbugjOAXOTwYVsFvkKR
	P582px2EnBnggjAP3X6bQ9G2ahO8HYmklBAlxSh9eGRqxnK0bPFcgHI4iOq9qmU=
X-Gm-Gg: ASbGncvMNXXaP5k4HVHeuoJHHpW+Pr8tMbOIzU5W1K7qHiEO/XRDvliw5h3lwHHmVym
	6+dU4sRYN9JZ/DGDh7v5WRkganK6KS1jNsVtYQlEVf/dBpyX9ertq6c/lIBnTcRgb0s99PT5vtu
	e4q0MvOA7aP4Dcz6B6/KNV+bgc/EY9Pyfe5NfYkOdBPb6U8gHRJHRqxZIlJxeCogU+4fxOSOrMf
	UJl+bsVusV/TLNjOZsi2RMofZooX31k6vcZKCSHzsQf2m2qFNfHIIAbf+thZiF46WEErCST39hI
	pT8uiHGkZT0i5eCkdw==
X-Google-Smtp-Source: AGHT+IHyxQAOrCYMKMTrZjWvo9bFWT1K8eOlTJFH1d5xana7tiWBgQrQ4rVBlR8ev+13dQ3LVmaKDg==
X-Received: by 2002:a05:6a21:900b:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1edf367d34bmr4946817637.12.1738834176089;
        Thu, 06 Feb 2025 01:29:36 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d350sm877632b3a.11.2025.02.06.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:35 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 11/14] rust: Extend cpufreq bindings for policy and driver ops
Date: Thu,  6 Feb 2025 14:58:32 +0530
Message-Id: <d7601797a92d7aeeba93f11f6a62de2e83969e11.1738832119.git.viresh.kumar@linaro.org>
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

This extends the cpufreq bindings with bindings for cpufreq policy and
driver operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 357 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 355 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 4546a70c7063..63ea816017c0 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -7,15 +7,20 @@
 //! C header: [`include/linux/cpufreq.h`](srctree/include/linux/cpufreq.h)
 
 use crate::{
-    bindings,
-    error::{code::*, to_result, Result},
+    bindings, clk, cpumask,
+    device::Device,
+    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
     prelude::*,
+    types::ForeignOwnable,
 };
 
 use core::{
     pin::Pin,
+    ptr::self,
 };
 
+use macros::vtable;
+
 /// Default transition latency value.
 pub const ETERNAL_LATENCY: u32 = bindings::CPUFREQ_ETERNAL as u32;
 
@@ -226,3 +231,351 @@ pub fn data(&self, index: usize) -> Result<u32> {
         Ok(unsafe { (*self.ptr.add(index)).driver_data })
     }
 }
+
+/// Equivalent to `struct cpufreq_policy` in the C code.
+pub struct Policy {
+    ptr: *mut bindings::cpufreq_policy,
+    put_cpu: bool,
+    cpumask: cpumask::Cpumask,
+}
+
+impl Policy {
+    /// Creates a new instance of [`Policy`].
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    pub unsafe fn from_raw_policy(ptr: *mut bindings::cpufreq_policy) -> Self {
+        Self {
+            ptr,
+            put_cpu: false,
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`. The `cpus`
+            // pointer is guaranteed to be valid by the C code.
+            cpumask: unsafe { cpumask::Cpumask::get_cpumask(&mut ((*ptr).cpus)) },
+        }
+    }
+
+    fn from_cpu(cpu: u32) -> Result<Self> {
+        // SAFETY: It is safe to call `cpufreq_cpu_get()` for any CPU.
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu) })?;
+
+        // SAFETY: The pointer is guaranteed to be valid by the C code.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        policy.put_cpu = true;
+        Ok(policy)
+    }
+
+    /// Raw pointer to the underlying cpufreq policy.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_policy {
+        self.ptr
+    }
+
+    fn as_ref(&self) -> &bindings::cpufreq_policy {
+        // SAFETY: By the type invariants, we know that `self` owns a reference to the pointer.
+        unsafe { &(*self.ptr) }
+    }
+    fn as_mut_ref(&mut self) -> &mut bindings::cpufreq_policy {
+        // SAFETY: By the type invariants, we know that `self` owns a reference to the pointer.
+        unsafe { &mut (*self.ptr) }
+    }
+
+    /// Returns the primary CPU for a cpufreq policy.
+    pub fn cpu(&self) -> u32 {
+        self.as_ref().cpu
+    }
+
+    /// Returns the minimum frequency for a cpufreq policy.
+    pub fn min(&self) -> u32 {
+        self.as_ref().min
+    }
+
+    /// Set the minimum frequency for a cpufreq policy.
+    pub fn set_min(&mut self, min: u32) -> &mut Self {
+        self.as_mut_ref().min = min;
+        self
+    }
+
+    /// Returns the maximum frequency for a cpufreq policy.
+    pub fn max(&self) -> u32 {
+        self.as_ref().max
+    }
+
+    /// Set the maximum frequency for a cpufreq policy.
+    pub fn set_max(&mut self, max: u32) -> &mut Self {
+        self.as_mut_ref().max = max;
+        self
+    }
+
+    /// Returns the current frequency for a cpufreq policy.
+    pub fn cur(&self) -> u32 {
+        self.as_ref().cur
+    }
+
+    /// Sets the suspend frequency for a cpufreq policy.
+    pub fn set_suspend_freq(&mut self, freq: u32) -> &mut Self {
+        self.as_mut_ref().suspend_freq = freq;
+        self
+    }
+
+    /// Returns the suspend frequency for a cpufreq policy.
+    pub fn suspend_freq(&self) -> u32 {
+        self.as_ref().suspend_freq
+    }
+
+    /// Provides a wrapper to the generic suspend routine.
+    pub fn generic_suspend(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_raw()) })
+    }
+
+    /// Provides a wrapper to the generic get routine.
+    pub fn generic_get(&self) -> Result<u32> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu()) })
+    }
+
+    /// Provides a wrapper to the register em with OPP routine.
+    pub fn register_em_opp(&self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::cpufreq_register_em_with_opp(self.as_raw()) };
+    }
+
+    /// Gets raw pointer to cpufreq policy's CPUs mask.
+    pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
+        &mut self.cpumask
+    }
+
+    /// Sets clock for a cpufreq policy.
+    pub fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<clk::Clk> {
+        let clk = clk::Clk::new(dev, name)?;
+        self.as_mut_ref().clk = clk.as_raw();
+        Ok(clk)
+    }
+
+    /// Allows frequency switching code to run on any CPU.
+    pub fn set_dvfs_possible_from_any_cpu(&mut self) -> &mut Self {
+        self.as_mut_ref().dvfs_possible_from_any_cpu = true;
+        self
+    }
+
+    /// Get fast_switch_possible value.
+    pub fn fast_switch_possible(&self) -> bool {
+        self.as_ref().fast_switch_possible
+    }
+
+    /// Enable/disable fast frequency switching.
+    pub fn set_fast_switch_possible(&mut self, val: bool) -> &mut Self {
+        self.as_mut_ref().fast_switch_possible = val;
+        self
+    }
+
+    /// Sets transition latency for a cpufreq policy.
+    pub fn set_transition_latency(&mut self, latency: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.transition_latency = latency;
+        self
+    }
+
+    /// Set cpuinfo.min_freq.
+    pub fn set_cpuinfo_min_freq(&mut self, min_freq: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.min_freq = min_freq;
+        self
+    }
+
+    /// Set cpuinfo.max_freq.
+    pub fn set_cpuinfo_max_freq(&mut self, max_freq: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.max_freq = max_freq;
+        self
+    }
+
+    /// Set transition_delay_us, i.e. time between successive freq. change requests.
+    pub fn set_transition_delay_us(&mut self, transition_delay_us: u32) -> &mut Self {
+        self.as_mut_ref().transition_delay_us = transition_delay_us;
+        self
+    }
+
+    /// Returns the cpufreq table for a cpufreq policy. The cpufreq table is recreated in a
+    /// light-weight manner from the raw pointer. The table in C code is not freed once this table
+    /// is dropped.
+    pub fn freq_table(&self) -> Result<Table> {
+        if self.as_ref().freq_table.is_null() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The `freq_table` is guaranteed to be valid.
+        Ok(unsafe { Table::from_raw(self.as_ref().freq_table) })
+    }
+
+    /// Sets the cpufreq table for a cpufreq policy.
+    ///
+    /// The cpufreq driver must guarantee that the frequency table does not get freed while it is
+    /// still being used by the C code.
+    pub fn set_freq_table(&mut self, table: &Table) -> &mut Self {
+        self.as_mut_ref().freq_table = table.as_raw();
+        self
+    }
+
+    /// Returns the data for a cpufreq policy.
+    pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from [`set_data()`].
+            Some(unsafe { T::borrow(self.as_ref().driver_data) })
+        }
+    }
+
+    // Sets the data for a cpufreq policy.
+    fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result<()> {
+        if self.as_ref().driver_data.is_null() {
+            // Pass the ownership of the data to the foreign interface.
+            self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    // Returns the data for a cpufreq policy.
+    fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            let data = Some(
+                // SAFETY: The data is earlier set by us from [`set_data()`]. It is safe to take
+                // back the ownership of the data from the foreign interface.
+                unsafe { <T as ForeignOwnable>::from_foreign(self.as_ref().driver_data) },
+            );
+            self.as_mut_ref().driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+impl Drop for Policy {
+    fn drop(&mut self) {
+        if self.put_cpu {
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+            // to relinquish it now.
+            unsafe { bindings::cpufreq_cpu_put(self.as_raw()) };
+        }
+    }
+}
+
+/// Operations to be implemented by a cpufreq driver.
+#[vtable]
+pub trait Driver {
+    /// Driver specific data.
+    ///
+    /// Corresponds to the data retrieved via the kernel's
+    /// `cpufreq_get_driver_data()` function.
+    ///
+    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
+    /// never move the underlying wrapped data structure.
+    type Data: ForeignOwnable;
+
+    /// Policy specific data.
+    ///
+    /// Require that `PData` implements `ForeignOwnable`. We guarantee to
+    /// never move the underlying wrapped data structure.
+    type PData: ForeignOwnable;
+
+    /// Policy's init callback.
+    fn init(policy: &mut Policy) -> Result<Self::PData>;
+
+    /// Policy's exit callback.
+    fn exit(_policy: &mut Policy, _data: Option<Self::PData>) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's online callback.
+    fn online(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's offline callback.
+    fn offline(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's suspend callback.
+    fn suspend(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's resume callback.
+    fn resume(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's ready callback.
+    fn ready(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's verify callback.
+    fn verify(data: &mut PolicyData) -> Result<()>;
+
+    /// Policy's setpolicy callback.
+    fn setpolicy(_policy: &mut Policy) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target callback.
+    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_index callback.
+    fn target_index(_policy: &mut Policy, _index: u32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's fast_switch callback.
+    fn fast_switch(_policy: &mut Policy, _target_freq: u32) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's adjust_perf callback.
+    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize, _capacity: usize) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get_intermediate callback.
+    fn get_intermediate(_policy: &mut Policy, _index: u32) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_intermediate callback.
+    fn target_intermediate(_policy: &mut Policy, _index: u32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get callback.
+    fn get(_policy: &mut Policy) -> Result<u32> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's update_limits callback.
+    fn update_limits(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's bios_limit callback.
+    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's set_boost callback.
+    fn set_boost(_policy: &mut Policy, _state: i32) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's register_em callback.
+    fn register_em(_policy: &mut Policy) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
-- 
2.31.1.272.g89b43f80a514


