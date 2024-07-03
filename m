Return-Path: <linux-pm+bounces-10490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294C59254A7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D2D1F25A49
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380813C3DD;
	Wed,  3 Jul 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8368owL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318C13A40B
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991864; cv=none; b=QxGosaFZ66MmXMga4UL8ySNq6v7EaC3YnHYKCXSKh4S52ZZf3qyn/AIcN24mRbJA8SrjryZPghA4wElunn1nF7WtGQlSIdMxG9AkU3lV17uXce34bIn481qNucK1NQho+u6GT3LQXWrFdaQ1B3yrKItwsdDxQIP+Aa0uxzMJr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991864; c=relaxed/simple;
	bh=9j6qyBbBg4q3edkEKPtiVlsYISdwynVBnSqtRMX1olk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0my0EbCXQG5tdM9++n/xanVghLyr4o42Jt644o1xTpcvKujctp3JVvszDwZrkH7UyFNjnVAU0VFdIeC45d8srcLc9Xp3Ylplt85POcgjtFQig9rVqRfP3qFGTf473raKbj/2vXxACMgntL0dtfVhmwzXfIfWHhHSH/EbENYF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z8368owL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70699b6afddso3442790b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991862; x=1720596662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OsbF0HbJd2DBfMBpHyv3X2gZOLpqgGdaCkDAOW/FBw=;
        b=z8368owLZPMWL4ht5bFWEwLTjtcrr8I5Vvy4GOZ4KReXfYe+dNlhW/h4snsABVhIQn
         /eIIgJRSwgad00fO5vrAXfAr+v74Ty3fO+iOcwuVilGLCkMZmaPDy824McTRZasqt1gD
         OgLfPVZNxOL3YpmBfi3/931INNCHR4qngIn/LBvgHyAmd5+nJKy3huePbUtdGBnFlVix
         qEilHJpOB0UfiNRD4ZRbkzqYNejrASvBYXBK9G7aZSkZ0TKp1bsjzf0cv5UOsjt9K6hz
         sREjsqq9DQlTkDY7VzC+AnM03byKsum1CpnGRJyCjYcYip0PsBDqEY3jCEwGUwrYb00Q
         MREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991862; x=1720596662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OsbF0HbJd2DBfMBpHyv3X2gZOLpqgGdaCkDAOW/FBw=;
        b=rW/0FF3zVKSJrZXGS8VyEr34rXboeEh5D37iLTbiuoa12p+SOgxjsmKfJHBZBGEL+P
         sxgligDLsxMmJcr2OZ2W3aL8g9ggWIWeiH9ORoeDr8dmlJ/pcN6NMXVMdeEfrXLQZ8LX
         4A4no34+N+xJClBYxJDNsVRJ7sZqMtvcum70AsRvlJ0DOiymdVWm3aZ6QKY/aj2UgWU9
         htAM+5S21RPDLiKPFo9WYIjVpFjz0hjyfcLsDQYvW/5sTvRj3fSb7kZ96gEl0PLDzE4X
         IBNXG1vMx7zhbv2Gv3d+iymzvQ3YlcV6zLMcO1uybKpbfUKoWNqrI1zOnEXr1hRELjHB
         ab0w==
X-Forwarded-Encrypted: i=1; AJvYcCUES1I5jBNtqtOo01RQffgJF7GWJKl0RMDyiRdubbMjqk4L+DQP18WokNp4p6Ar2FpZawDQhO7spvCAVUOaqBQG7bqL9w+no64=
X-Gm-Message-State: AOJu0Yzzs472kYJF7Vv8n0sGnthtITmEKat/9I26RyCdwJ7+FUuhsgMO
	qYyxt0zgKzPVnbpOu7VAV1JAZvU7lvhiO1cae7IHQzxqXniCph29RM805GDu6U8=
X-Google-Smtp-Source: AGHT+IFcvXpYnimq4bLKY1nGsUOONMSn0uH2w4uPRhv4O5vb8htXNiKHO9NmL2IlDWBCVmvstR0KHg==
X-Received: by 2002:a05:6a00:1909:b0:704:31ae:4fe5 with SMTP id d2e1a72fcca58-70aaaf25245mr10383163b3a.25.1719991861412;
        Wed, 03 Jul 2024 00:31:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6afb8f6asm7636982a12.42.2024.07.03.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:31:00 -0700 (PDT)
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
Subject: [RFC PATCH V3 5/8] rust: Extend cpufreq bindings for policy and driver ops
Date: Wed,  3 Jul 2024 12:44:30 +0530
Message-Id: <1edf90cbde4588c7d71cdbcdf853640cf64a71d3.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1719990273.git.viresh.kumar@linaro.org>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs | 315 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 313 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 3f3ffd9abaa2..6f9d34ebbcb0 100644
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
+    types::{ARef, ForeignOwnable},
 };
 
 use core::{
     pin::Pin,
+    ptr::self,
 };
 
+use macros::vtable;
+
 /// Default transition latency value.
 pub const ETERNAL_LATENCY: u32 = bindings::CPUFREQ_ETERNAL as u32;
 
@@ -252,3 +257,309 @@ pub fn data(&self, index: usize) -> Result<u32> {
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
+            cpumask: unsafe { cpumask::Cpumask::from_raw((*ptr).cpus) },
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
+    /// Returns the maximum frequency for a cpufreq policy.
+    pub fn max(&self) -> u32 {
+        self.as_ref().max
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
+    /// Sets transition latency for a cpufreq policy.
+    pub fn set_transition_latency(&mut self, latency: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.transition_latency = latency;
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
+            // SAFETY: The data is earlier set by us from [`set_data()`]. It is safe to take back
+            // the ownership of the data from the foreign interface.
+            let data =
+                Some(unsafe { <T as ForeignOwnable>::from_foreign(self.as_ref().driver_data) });
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
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's online callback.
+    fn online(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's offline callback.
+    fn offline(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's suspend callback.
+    fn suspend(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's resume callback.
+    fn resume(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's ready callback.
+    fn ready(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's verify callback.
+    fn verify(data: &mut PolicyData) -> Result<()>;
+
+    /// Policy's setpolicy callback.
+    fn setpolicy(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target callback.
+    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_index callback.
+    fn target_index(_policy: &mut Policy, _index: u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's fast_switch callback.
+    fn fast_switch(_policy: &mut Policy, _target_freq: u32) -> u32 {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's adjust_perf callback.
+    fn adjust_perf(_policy: &mut Policy, _min_perf: u64, _target_perf: u64, _capacity: u64) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get_intermediate callback.
+    fn get_intermediate(_policy: &mut Policy, _index: u32) -> u32 {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_intermediate callback.
+    fn target_intermediate(_policy: &mut Policy, _index: u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get callback.
+    fn get(_policy: &mut Policy) -> Result<u32> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's update_limits callback.
+    fn update_limits(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's bios_limit callback.
+    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's set_boost callback.
+    fn set_boost(_policy: &mut Policy, _state: i32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's register_em callback.
+    fn register_em(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
-- 
2.31.1.272.g89b43f80a514


