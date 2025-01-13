Return-Path: <linux-pm+bounces-20316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C23A0B5A0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD583A953B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9A1CAA97;
	Mon, 13 Jan 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCNjr59k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07641CAA76
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767462; cv=none; b=izUIk7As1EYGX8yaVtdcTy53SzUAVh68PsJWFDuDe1lF9PoGhTSyyVFMFOeL2xVBU3JBrWFZKULY1ehf5DEVqO04FO4xtCphx2LJ5AIc9gshLkdNHY6myzgoz7tvvQ19s9qSKDHGgQQGL7gRPg8pMUQL2n4Kqh1/WH/FbFKynxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767462; c=relaxed/simple;
	bh=6eUufuO+qr8rw3xAmaRGavy2ljguk2nZVG/nqhHwfEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCDywAHaZPhA/TxhjefhVDrympHLaXnR1yNqw+MpCp90LDnJKAg73pZU1D9PzwwD0HqLr14Q7w8hGDAfcIuXpfkLyGGpV3GFhUWTXWtZO/29L0VKxZo7BpiFetQqoH/dJcMMcM6Hozexl9qpnhbvdTy1BlGB2HJ9pPtaHWcnrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCNjr59k; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162c0f6a39so90534615ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767460; x=1737372260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwXoOBJkAjU4c4qfx40sQTPK06Msu4Zsat+nENe15cc=;
        b=pCNjr59ktGo2fiYlADUyd99VP569LacaopQXOHQdVd8wmEnjjVJ9MzYznCwgLTrvyY
         L4v8vgV8nr1Ufl8VtfF0Wt9kug+KFUwCP4BF5vt//whOnRy4M1fcBhmrgj9MGZZVvlR0
         M9l8SylecZk5OrAtEx+65BdUT2RgB1ib8N7czCXftCQKmAQEmAoj6DvDQ7wgbGEZWLl1
         HMn6B/ooea2tYPYl7X0QpxWCyQnz6VR5aN8G2w7M3trMcZN6sxZSxI8qnRMAiMqsSCHi
         P9cjCVcDT27c5ACwUu4mzsdaaXTk6WXypGwe7VVwOAjEM1cd2m+S/BYziGvaK/zgqZdU
         GONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767460; x=1737372260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwXoOBJkAjU4c4qfx40sQTPK06Msu4Zsat+nENe15cc=;
        b=UEK5XkysThyDcTfnFTj9XP/miVk7ofTWOExvKthVeN00LCNyC7IXNq/BWxEhnBCMaA
         X/2Gnw6CuX+CetIaayo3DnpkQb/i43SpdjI4i5jAjdsZpk/IiUGvuwFpIx8IC/9eEf8l
         nXVG1dw8pArQchza2979KyUvX2kZqchVbRiQrngSF7D8Z/KSw1eWmHWQCxbuO+xxPp5a
         2oXcuchnBVTJ2Ze+rxGZi/lo4+7KSsOSJ0yKJdUXUcMD0meiJYDF6+kRM2bHMpl5sT5+
         FEL+TI9lmJepE9fPrrCJpRtVVOM4shp8q2XwDf48BPl/UmXRZYIHA1HrR5ftS21pXCHP
         dORQ==
X-Gm-Message-State: AOJu0YwoGlfZCzQM4DGhIhzeXX1JmnyQ7fSSdzLfrF1KdmX9JFJdGWFV
	QaWmeeIjjd2h+4wsxnSolR2Tn2yv2F5lDXwmo33XOw7tjWLBTdQ+p9cy/t6lKy4=
X-Gm-Gg: ASbGnctAQ+hRwykOjWlCbKKWzz0McbNSJhbj5DYGLQe51AEadz7GxrvKpOPDMdQSava
	N71ZDGYMdw9Q/E9vlJrJ5PhLdwzUpA+BBnnl9Yrmyo2GoMLvkbNBGqovtW5cBmM3FGms9wAkyNV
	deiwV4T4aYE4vGv1EAjmG9O507rNf2tdflYAMyF04m9Td5K8Iycxfig+aD+pFVPyNxpOs4pnIar
	IgcwJAkQBeg5zyNPA0dll0a3FhmtuWs30ImBmkQzBhV3TL+/KWetw65vxY=
X-Google-Smtp-Source: AGHT+IF1jBDNlhS9BCy1e75qQA8jc0azS1BNJz+YKP3r8+t+nCxIjTXNNHlirZyqycQgyWPxMknT9g==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1e8b1623c35mr18366709637.15.1736767460050;
        Mon, 13 Jan 2025 03:24:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065c3b4sm5688313b3a.112.2025.01.13.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:19 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 12/16] rust: Extend cpufreq bindings for policy and driver ops
Date: Mon, 13 Jan 2025 16:53:07 +0530
Message-Id: <20f7ea798034674e5be08bd6d92c7d686d93df06.1736766672.git.viresh.kumar@linaro.org>
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

This extends the cpufreq bindings with bindings for cpufreq policy and
driver operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 357 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 355 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 3dfdf5ccb9b8..8468e12ef1f5 100644
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
 
@@ -229,3 +234,351 @@ pub fn data(&self, index: usize) -> Result<u32> {
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
+            cpumask: unsafe { cpumask::Cpumask::get_cpumask((*ptr).cpus) },
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
+                unsafe { <T as ForeignOwnable>::from_foreign(self.as_ref().driver_data) }
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
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+            // relinquish it now.
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


