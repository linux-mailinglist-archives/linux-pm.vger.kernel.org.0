Return-Path: <linux-pm+bounces-11650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4963940F56
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DAA1C22BCB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9E19E7CF;
	Tue, 30 Jul 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BciqrHr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233719DF98
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335251; cv=none; b=RfeOS+EvlCqSY4gmZSirrIyPtTifTrkwqaBE1S6FI2Zbn8fUuB/uFkvqMFycReJwZRBUFnifjn20COm9cGb1UUOxPdf3e4a6cw67r4I1F5PFJ3Brk1vMGmZ3G7sC2/8fWvmiPQ6KebWnyIxg5kCOBMsQNXPQuYSgcR5RRXWPz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335251; c=relaxed/simple;
	bh=YjNq75QgFeA7Yus4IxCVFfuEQI50uhXJwK9Os0w9Dag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RREAfW7y4VEx6gq4MCT4j+htaz8U4iF4eZQnXpKbpK1GPooTcaq2X8gVcybEu2bLexyyx9vfkTMHfa32JNaKqYWmkgjo0nmSmgv7PLmGmVFjGKwjYOQk0ov1H/DakM7gCfzZn+fiuVDc11wffUJCcj7fwmXipygEl+Ao4klsWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BciqrHr9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso2849471a91.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335248; x=1722940048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwz/REpE+iNc1GUN5OnD3+R/RJ6eiupzXXvcQ/qHpdo=;
        b=BciqrHr91lRzL2/pJNfdjqRGRHN3JC5rmBCu+A7Fx5ozrMn8LGgr8k+0hzbLJH6WyJ
         dR+EBe/VTQxxaG1iy6N065ETVOcWE3m1I/6GQ7CllkayUjkySFUP5fqzJ1Om/XNicaNL
         y3IEcV43c/poIUZeO2vhGI1R0uz4XmJTaDfS0QE0/90xZnLSxGsCdsY5TF3kMrmsobeQ
         UI4YcwLyc8kI6N5kWo+PLH1aFtCEXIjnI9INWCW0g6A32/X3+1j7MXIRBQrk6Jr+R/9C
         ZVtBnL7kTSnu2HyHgvxBAq4W1EHVMQbAjzvXWBsEHi4KL3lcxJPveK7khRCt/t8a7o3I
         Vpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335248; x=1722940048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwz/REpE+iNc1GUN5OnD3+R/RJ6eiupzXXvcQ/qHpdo=;
        b=jXzKByWOySXDR7kNlZJwkFyyN/lUT+65QPW+uux1lNBqcJHjxbi9b81XjJppRa9Lk7
         NaZDF49nmVnUNmDj4MdbQL/jpXJg2Qf0TlY3z07q5evarCLmRSUSFILtpEzdBBWD2172
         1yqE7/X0jsh1Mb7A/zKt99smaIE+vd6TjNNoToqb3NuM9sTexDy/V2HzEwgfafsXCjIs
         tS8E7BXijIJTpQociZxcOEW1tYflYlgFNl0w4wA4xrOk9NJnk2+uecTJuxjOMzkaNd0G
         OsXVLUimQXpyp86O2PHzF4U5saYDUfxl7lCPLp7oUV4hJljgzbmIMXkbQJrvoL9dnHfQ
         TJCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUI8kXxT58SSwj2n6vF+CQMiiFHYiXn4kKKi6bjI0UNfkgLPkk5GZtBPK4f/ZtX/zruXzvwGpH4SH+b62MM0BdsHvataAbzvQ=
X-Gm-Message-State: AOJu0YxTyaDxtQwbHfjjITLfFjssy3HGgb2en9qqQG0st8HM3Uq/QLaB
	pNE7L3mcdONAtJAF0pArj+zCfFPP1tutDgxVvHmBmKlR5VVyfwonk15Wrj9mxS4=
X-Google-Smtp-Source: AGHT+IGHg8nZg75/O6cvErBFY7boVJ447cvylF1yQqdO3h+yR6dx+9LQr6FsTewmDGh7fUQICJviYQ==
X-Received: by 2002:a17:90a:4e4c:b0:2c8:2cd1:881b with SMTP id 98e67ed59e1d1-2cfcabb451cmr2495856a91.20.1722335247705;
        Tue, 30 Jul 2024 03:27:27 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec7acdsm8543002a12.66.2024.07.30.03.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:27:27 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/8] rust: Extend OPP bindings for the OPP table
Date: Tue, 30 Jul 2024 15:56:59 +0530
Message-Id: <d893fe6c3c351463983a7192d3f832148614a774.1722334569.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1722334569.git.viresh.kumar@linaro.org>
References: <cover.1722334569.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends OPP bindings with the bindings for the `struct opp_table`.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 382 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 381 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index dec832edec9b..c3433b0d8221 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -8,8 +8,9 @@
 
 use crate::{
     bindings,
+    cpumask::Cpumask,
     device::Device,
-    error::{code::*, to_result, Result},
+    error::{code::*, from_err_ptr, to_result, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
@@ -67,6 +68,385 @@ fn freq(&self) -> u64 {
     }
 }
 
+/// OPP search types.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum SearchType {
+    /// Search for exact value.
+    Exact,
+    /// Search for highest value less than equal to value.
+    Floor,
+    /// Search for lowest value greater than equal to value.
+    Ceil,
+}
+
+/// Operating performance point (OPP) table.
+///
+/// Wraps the kernel's `struct opp_table`.
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the `Table`.
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: ARef<Device>,
+    em: bool,
+    of: bool,
+    cpumask: Option<Cpumask>,
+}
+
+// SAFETY: It is okay to send ownership of `Table` across thread boundaries.
+unsafe impl Send for Table {}
+
+// SAFETY: It's OK to access `Table` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Table {}
+
+impl Table {
+    /// Creates a new OPP table instance from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    unsafe fn from_raw_table(ptr: *mut bindings::opp_table, dev: &ARef<Device>) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpumask: None,
+        }
+    }
+
+    /// Find OPP table from device.
+    pub fn from_dev(dev: &ARef<Device>) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. Refcount of the OPP table is incremented by the C code.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpumask: None,
+        })
+    }
+
+    /// Add device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of(dev: &ARef<Device>, index: i32) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. Refcount of the OPP table is incremented by the C code.
+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.as_raw(), index) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        table.of = true;
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    fn remove_of(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. We took the reference earlier from `from_of` earlier, it is safe to drop
+        // the same now.
+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.as_raw()) };
+    }
+
+    /// Add device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of_cpumask(dev: &ARef<Device>, cpumask: &Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_ptr()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+
+        let mut mask = Cpumask::new()?;
+        cpumask.copy(&mut mask);
+        table.cpumask = Some(mask);
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    fn remove_of_cpumask(&self, cpumask: Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from `from_of_cpumask` earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_ptr()) };
+    }
+
+    /// Returns the number of OPPs in the table.
+    pub fn opp_count(&self) -> Result<u32> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u32)
+        }
+    }
+
+    /// Returns max clock latency of the OPPs in the table.
+    pub fn max_clock_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max volt latency of the OPPs in the table.
+    pub fn max_volt_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max transition latency of the OPPs in the table.
+    pub fn max_transition_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns the suspend OPP.
+    pub fn suspend_freq(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.as_raw()) }
+    }
+
+    /// Synchronizes regulators used by the OPP table.
+    pub fn sync_regulators(&self) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.as_raw()) })
+    }
+
+    /// Gets sharing CPUs.
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&mut self, cpumask: &Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_ptr())
+        })?;
+
+        if let Some(mask) = self.cpumask.as_mut() {
+            // Update the cpumask as this will be used while removing the table.
+            cpumask.copy(mask);
+        }
+
+        Ok(())
+    }
+
+    /// Gets sharing CPUs from Device tree.
+    #[cfg(CONFIG_OF)]
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.as_raw(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Updates the voltage value for an OPP.
+    pub fn adjust_voltage(
+        &self,
+        freq: u64,
+        u_volt: u64,
+        u_volt_min: u64,
+        u_volt_max: u64,
+    ) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_adjust_voltage(
+                self.dev.as_raw(),
+                freq,
+                u_volt,
+                u_volt_min,
+                u_volt_max,
+            )
+        })
+    }
+
+    /// Sets a matching OPP based on frequency.
+    pub fn set_rate(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.as_raw(), freq) })
+    }
+
+    /// Sets exact OPP.
+    pub fn set_opp(&self, opp: &OPP) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_raw()) })
+    }
+
+    /// Finds OPP based on frequency.
+    pub fn opp_from_freq(
+        &self,
+        mut freq: u64,
+        available: Option<bool>,
+        index: Option<u32>,
+        stype: SearchType,
+    ) -> Result<ARef<OPP>> {
+        let rdev = self.dev.as_raw();
+        let index = index.unwrap_or(0);
+
+        let ptr = from_err_ptr(match stype {
+            SearchType::Exact => {
+                if let Some(available) = available {
+                    // SAFETY: The requirements are satisfied by the existence of `Device` and
+                    // its safety requirements. The returned ptr will be owned by the new [`OPP`]
+                    // instance.
+                    unsafe {
+                        bindings::dev_pm_opp_find_freq_exact_indexed(rdev, freq, index, available)
+                    }
+                } else {
+                    return Err(EINVAL);
+                }
+            }
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_freq_ceil_indexed(rdev, &mut freq as *mut u64, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(rdev, &mut freq as *mut u64, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds OPP based on level.
+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
+        let rdev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(rdev, level) },
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_level_ceil(rdev, &mut level as *mut u32)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_level_floor(rdev, &mut level as *mut u32)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds OPP based on bandwidth.
+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<ARef<OPP>> {
+        let rdev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // The OPP core doesn't support this yet.
+            SearchType::Exact => return Err(EINVAL),
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_bw_ceil(rdev, &mut bw as *mut u32, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_bw_floor(rdev, &mut bw as *mut u32, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Enable the OPP.
+    pub fn enable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq) })
+    }
+
+    /// Disable the OPP.
+    pub fn disable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.as_raw(), freq) })
+    }
+
+    /// Registers with Energy model.
+    #[cfg(CONFIG_OF)]
+    pub fn of_register_em(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_register_em(self.dev.as_raw(), cpumask.as_mut_ptr())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    // Unregisters with Energy model.
+    #[cfg(CONFIG_OF)]
+    fn of_unregister_em(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.as_raw()) };
+    }
+}
+
+impl Drop for Table {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
+
+        #[cfg(CONFIG_OF)]
+        {
+            if self.em {
+                self.of_unregister_em();
+            }
+
+            if self.of {
+                self.remove_of();
+            } else if let Some(cpumask) = self.cpumask.take() {
+                self.remove_of_cpumask(cpumask);
+            }
+        }
+    }
+}
+
 /// Operating performance point (OPP).
 ///
 /// Wraps the kernel's `struct dev_pm_opp`.
-- 
2.31.1.272.g89b43f80a514


