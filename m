Return-Path: <linux-pm+bounces-8756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84B8FFEFF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6EB1C210B2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442AB15E5A3;
	Fri,  7 Jun 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diG8Q5cH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7515DBCE
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751578; cv=none; b=WXMZWFUvOtpdjCmgdDTyRW1vjun4s6w8UTwNPNBo21ECs8X5sJ/han7DEbS8KUKXAGMvuxCWTmE02wch+d0R9wnRmyD6rrYdFiO9u9utGeW4/Jx/t7AfMmeC84jzU/0nK2jd2gvF0Tz43X6WmD7bRJsJ0Hzq97aoj2LWXGhucNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751578; c=relaxed/simple;
	bh=SP0zF/qQV6su2Bz7tEn1mT4rgqW43S1jdltO3YIwopc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MU4zWm0tWH8OX3SLSo+QTqig9b7l/v+FUBYr7Et0Oo7+UEz9+lBJ+SZ6JbdjtxWLRAESMitu9CoIw6ZAgolWiT7CYx2zyHGyyODy1jeutdWU5uOnjT2Gh1Vtv4kxNhpCNceOejrdStEiyg+oSAKdMcipCg4tJEX6tsWbGdI+HZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=diG8Q5cH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6ab88dfaeso16772655ad.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751576; x=1718356376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts4ZPCWdX1WWZnRhg2kN6M+wqUEnt4/e2UDw6VFJ03s=;
        b=diG8Q5cHBNOTeBiAsas9EL2SXoP2vtSUQtwxTs/e4F/F2ZXnUb+/nyIahGUGeZyZBR
         h+cv4eyDNNZIDgooVG8d/IV+9h0VuqMUIXyHt/tvQbHwQKYml568ctipqOJPDOeYQYT2
         IhtIcBU5V42ZOGpFWy7tqGjO90okR38er68h+ckvt+KecaAzXYlXWLParP3GiYQ01cJ+
         bIqM/paOl1Hvx83ghzoWuz92HXzWYxry2Z9U5kgVQOmuoOjmKLnz/BEUQc3NMp7tCCQX
         Wh5eTVCSE1m1OepAqDMSRlcrnDcJSbbR441DQU3430x492XUxFkFalz4cTUWCmJQJ3eH
         ZS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751576; x=1718356376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts4ZPCWdX1WWZnRhg2kN6M+wqUEnt4/e2UDw6VFJ03s=;
        b=ONzvSxnD265jUnl0OljgZavpGIsMfaf/3MMLolDZFVwsxTVE1ES7vmE5GyKHrIcDYg
         Qn/rg6wupXF3gM4DjIjpi5F0WrWbQICXUNBZq88NrJhswji6K6XTdiDP+h3of6/JlqFN
         Rp+2aj/rgEHxp6tHXw+SMEzlwbxbiANBRO/f36bhfw3uzLPCTyn4KKiC+NmAtEE5xlIt
         zX1FkGJZpxqnRs1gzb3RXlTTtuFqPIAlBRZIKoakcU23vryd+j8DneWRvNSharR4wHB/
         mDSUE7WLB/c8PjKBfl9cBcSgBrYPxgkYPb45yPv/Fectggy+14ozqo2BG0Yd0fjDjfS+
         IzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXale4D2ikP4f1U1FGaK1Ke4q8R2HbdRWHyPxzHxVjAi+1NyGVTfGj8PwL8ePq+BbNxQONIffxasPQ34C1xr3rpF4l1bu1+LDg=
X-Gm-Message-State: AOJu0YyXbSF7hnqYLmfspGVRJNdyft59m2lGhIIkyOlmWRDaOsWw/F5G
	4K2OHP7er7CaNDm9ArD+JrCLXdyjZHIeVA3+QJ+z6oD2wvmpOVdX70NQahW4sQQ=
X-Google-Smtp-Source: AGHT+IHkC0n5uOshvr23SahV4wBl7RrvtZwAy1q+4IdGgmbX6iinrkTMIb0M362jY/hpVtfiJVAL4w==
X-Received: by 2002:a17:902:da89:b0:1f6:7e02:7ab8 with SMTP id d9443c01a7336-1f6d03e70ddmr21788485ad.68.1717751575441;
        Fri, 07 Jun 2024 02:12:55 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7603bdsm29922285ad.50.2024.06.07.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:54 -0700 (PDT)
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
Subject: [RFC PATCH V2 5/8] rust: Extend cpufreq bindings for policy and driver ops
Date: Fri,  7 Jun 2024 14:42:20 +0530
Message-Id: <d6c55a922d00e9b8c575141bef2a6a072215a9bc.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs | 335 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 333 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 51a4a9bd8d3c..d5679272e40b 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -7,15 +7,20 @@
 //! C header: [`include/linux/cpufreq.h`](../../../../../../include/linux/cpufreq.h)
 
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
 
@@ -249,3 +254,329 @@ pub fn data(&self, index: usize) -> Result<u32> {
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
+    pub unsafe fn from_ptr(ptr: *mut bindings::cpufreq_policy) -> Self {
+        Self {
+            ptr,
+            put_cpu: false,
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`. The `cpus`
+            // pointer is guaranteed to be valid by the C code.
+            cpumask: unsafe { cpumask::Cpumask::new((*ptr).cpus) },
+        }
+    }
+
+    fn from_cpu(cpu: u32) -> Result<Self> {
+        // SAFETY: It is safe to call `cpufreq_cpu_get()` for any CPU.
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu) })?;
+
+        // SAFETY: The pointer is guaranteed to be valid by the C code.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        policy.put_cpu = true;
+        Ok(policy)
+    }
+
+    /// Raw pointer to the underlying cpufreq policy.
+    pub fn as_ptr(&self) -> *mut bindings::cpufreq_policy {
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
+        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_ptr()) })
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
+        unsafe { bindings::cpufreq_register_em_with_opp(self.as_ptr()) };
+    }
+
+    /// Gets raw pointer to cpufreq policy's CPUs mask.
+    pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
+        &mut self.cpumask
+    }
+
+    /// Sets CPUs mask for a cpufreq policy.
+    ///
+    /// Update the `cpus` mask with a single CPU.
+    pub fn set_cpus(&mut self, cpu: u32) -> &mut Self {
+        // SAFETY: The `cpus` pointer is guaranteed to be valid for the lifetime of `self`. And it
+        // is safe to call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.cpus().as_mut_ptr()) };
+        self
+    }
+
+    /// Sets CPUs mask for a cpufreq policy.
+    ///
+    /// Update the `cpus` mask with a single CPU if `cpu` is set to `Some(cpu)`, else sets all
+    /// CPUs.
+    pub fn set_all_cpus(&mut self) -> &mut Self {
+        // SAFETY: The `cpus` pointer is guaranteed to be valid for the lifetime of `self`. And it
+        // is safe to call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.cpus().as_mut_ptr()) };
+        self
+    }
+
+    /// Sets clock for a cpufreq policy.
+    pub fn set_clk(&mut self, dev: ARef<Device>, name: Option<&CStr>) -> Result<clk::Clk> {
+        let clk = clk::Clk::new(dev, name)?;
+        self.as_mut_ref().clk = clk.as_ptr();
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
+        if self.as_ref().freq_table == ptr::null_mut() {
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
+        self.as_mut_ref().freq_table = table.as_ptr();
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
+            unsafe { bindings::cpufreq_cpu_put(self.as_ptr()) };
+        }
+    }
+}
+
+/// Operations to be implemented by a cpufreq driver.
+#[vtable]
+pub trait DriverOps {
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


