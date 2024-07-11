Return-Path: <linux-pm+bounces-10962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263092E075
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA62F2817B5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2F14BF90;
	Thu, 11 Jul 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmbM0NZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160114B941
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681110; cv=none; b=udpvCQKNYehgsbgnyYLQYyeNAQ2ZN2fN79xS17wki0LUrPq/x1Ojrlfg6T8W537jas135XRIFmDxuZJVBYv3JmxE/EenPtMY94O3IMMAMgovoeq/tHE3oaicE/eC2lXeB6dmFsKoYXJpm6aelYe/ZPn1XUqqm0cfbOX13oOOkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681110; c=relaxed/simple;
	bh=JrIqdLXOKsgLnmkFZ98ZZ7V7b3MO61ztZBHVJHMyFBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxrOTJF2w78zZwd7Wb03pCVB2gow/7ceCYQpNXgOsd6tHCwTOQwMoF03a8QFjvTt/k+eqtkYQcmYn6BFaDpOA4qzyBrlFNZH4aIt4ZKi4jNa0CMSe1sVQ3nNYJOL2+1YX3vrFt/EBl0q1MG1WvKbI/X5VnfRdizFiqQ3MQhgbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmbM0NZU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7611b6a617cso375218a12.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720681108; x=1721285908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiAYeNUaYtfs4MtrCjwt6UV709MtWKglHtY8sLRknhk=;
        b=xmbM0NZUFwLqBXjpqYZ1Z+QUBZTFU9z/nXv5W0xqxQgVYptcY9Wz1UoF7C6QBd0Bip
         Dlg3A9OjLfSWhBLTRJ8Ivt+5SnaFD+0bILYPet/2K8WmPUhTnAFjPp8CnN31CXxwdvNX
         e8SAX24c9SMzUSps9SA+T4E4qIyuvaOB3k7UrKpBJrdqzhM2v/hc85aXNYSQCUPtITg9
         vmf44tNwmHSwmebCerS+3LHBgzMpXDYcwef0PSh4b0Geiz5Y1Cp0QtjkQziPzKJu+LXY
         wTGPEvlMit1q43JuFpLk50clvIDsOQgLn/7581DVBYnhx0YP4fcWTTofhu790+r7lnaZ
         MFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681108; x=1721285908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiAYeNUaYtfs4MtrCjwt6UV709MtWKglHtY8sLRknhk=;
        b=c+j0bHxA51AoXJGCY/meSe8dCcgpU+/Qnq9rY5uHim83xOedWjimhQVuSLK7+GlSGM
         gJtUEBN/3FtR+EqGCyKT5BySrv1nRi9xVt4MXF1D1jYUjQWyztnYjPyswJx+sa7mhxNq
         F/5hil26nQMNvFomXYeeNhz2q71XP26sDZs5HNCrCFKxUTdmSC9Ebok4ZznIMsXhUALf
         m+4i6FItz8XZhSu9DxIIsSx5QwjM+U5GEiLAaVR2qQyWQqUERFaeZgsnKdBZm6RlX7Wk
         BpUqajFuyMyXlriYt+MjIz8uE7c2TAwkY6eEW5ujW31tHYMf2hfiQtWcfWlRobEgvrJ9
         hCMw==
X-Forwarded-Encrypted: i=1; AJvYcCU90TGeGEVJqymBIcZslzwOAyDRg2JcBz5ZRzoeaeAp6cotmB2RsSubUbanuUli/TcsS64rX3YsOiiRctFBmSBpes1UkXd5nrA=
X-Gm-Message-State: AOJu0Ywy6MJUSWgl9pies+yLNF7GwVqKLMORk8JA/doV51UEwR63zlfW
	O/t0PMIpfTVYz4vLbfYlksz89Us/+8PtaseCSFQ/ROLKh2HCrmw78Y9OYIPT1aQ=
X-Google-Smtp-Source: AGHT+IGyIRYjO/gSAliNDMNBXwcTDvV2dox339uL39zwuoaE2IC1RCwYO7LuDSAzZotCrQ844Oy7og==
X-Received: by 2002:a05:6a20:7347:b0:1c0:ee1a:da2d with SMTP id adf61e73a8af0-1c2984cd9demr9242278637.41.1720681108145;
        Wed, 10 Jul 2024 23:58:28 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a98395csm13003570a91.29.2024.07.10.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:58:27 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
Subject: [PATCH V4 5/8] rust: Extend cpufreq bindings for policy and driver ops
Date: Thu, 11 Jul 2024 12:27:47 +0530
Message-Id: <69353708ff40bf46f0609447187aeb180f00aeb8.1720680252.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720680252.git.viresh.kumar@linaro.org>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
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
index 0751ad9459e2..d58bb0bbaad4 100644
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


