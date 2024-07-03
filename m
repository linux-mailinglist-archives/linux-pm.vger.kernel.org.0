Return-Path: <linux-pm+bounces-10487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF009254A3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80FCB23E36
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6A13A3E6;
	Wed,  3 Jul 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfKnOTO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF6139CE2
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991854; cv=none; b=RGxToW8hPj262P2Jcs0RTb6NWNxT2Kzk9RCpEpcLoTeLVM3A/KUQvS6UvA+ZcrdP8MfvFMSqekWHnjQxC5+0BWIRw7jZERFJhoUhV3x4il8FUBiRC+fQxHIVbmdMKf05Flx1pPVdmETkcJMjhaSQqlMMNPabNiTH0sZqPRG56Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991854; c=relaxed/simple;
	bh=Ry5ibUlGOjuRP6QvsldHpSuFq0kMZRtgp6jIb3SypxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3bu+qbsdz+Gj9gg/5p2TKldx9C6nQM4nP3tbDq9R4epikeLACDgJCxgPyjTD51TeLStDSq4Tcyd6A0rx9RDC+spXgBAicEa40KBpSmeoug9eCV6jKMVyNYgcvV4e9/RbNsxOhRKQdJJXuYaVZMjoT9lbe1k4fUys79eGZgNlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfKnOTO5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fab03d2eecso38916945ad.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991850; x=1720596650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHpIISlSVfTAjLcZ1fNW1LpaL0AQTAK7185sDuskwgc=;
        b=xfKnOTO5Q96/7bMDGYmgaDTueWCZhVVJro0UAKEyVAuV5/OWUQXmBohwz7+Qw3irwi
         kfXX5Q8ilbvFaa15EBKZIfZFUHgdLyaCo2+x9tF0zAAgSakCTYtxAgmi4udNdFNY0paH
         ss2pDq1mM3LsLDQe4G+BUz/gJTA5JipYLWh4lCqJK6y6ZhFS7QiL7lt37k11z5oSOjJg
         bBw7XyHamE49nxGmpaa+D/E7VuPRVSKG6SIFrUSNfZcPrK5N3IYX59Ub++M7fg1H52UE
         tGx+hBvmcq3lD1p2GqNsYmf+XXgXuwrnMZbKEX8yYu+EO//RlGmL+dm8QOfqNJNgEeBb
         MUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991850; x=1720596650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHpIISlSVfTAjLcZ1fNW1LpaL0AQTAK7185sDuskwgc=;
        b=V+TAEioMACzX3vuo0MQ5+tvKC+R4KJMltMie0lhgybwUvP+j8AaQaYlvi1dW8RYACe
         BGg0bUGN0TbCvHuPjSQ+XmP4bkTPIX1ncCxgwcej5+4+5DAjIIAFbLU47ryqUMkgfpoW
         v+9FhixbeDtBu0120lqR0b8DJrOiSxs2FNh/OUTXA4VFtrDFYtL00XhD/GHh1CU1pxja
         lVY9kYLwaDzBxESt84I31XJJAG2IcIJIz3R7CDp4Lw8R3ybgoAEARmNyDb2ppdZNWs3l
         MtK6/cyby+BdXR6HJ3WrHv3HFX0DJsAvohIYD5E2eT3EGSxX2RzRrvlSvS468Ql1IalE
         LGTw==
X-Forwarded-Encrypted: i=1; AJvYcCW/s0lZzKZqJRa7keuP7UShifmeTUl8fYXaBZc6qg1SD6r9eoZNkQgZx4arbSOOyosHAZwsjoYdrxDrJCL1XGE1CWSPS6y9LMo=
X-Gm-Message-State: AOJu0YxlrbquNuFnASQun24NmvvhWyqBzN61TZvPJXxGlZ7LTVzMl6BM
	CxoD0UFvhS5vQnVqoGiqSUwa4qElQa+SqN6HNSfdNw7pVCMxcUy4JO8faPT7prA=
X-Google-Smtp-Source: AGHT+IGgFDNGeL0cDxsT3fOJ+hMGBICA7Mlv8WciKFBlOfUyYdFL7iziAbowRvxDLSQdjALbjEhhYQ==
X-Received: by 2002:a17:903:41cd:b0:1fa:fc69:7a81 with SMTP id d9443c01a7336-1fafc697b4fmr26521665ad.29.1719991850337;
        Wed, 03 Jul 2024 00:30:50 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1537688sm96145705ad.141.2024.07.03.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:30:49 -0700 (PDT)
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
Subject: [RFC PATCH V3 2/8] rust: Extend OPP bindings for the OPP table
Date: Wed,  3 Jul 2024 12:44:27 +0530
Message-Id: <1cc9665b614b7de2fbe9b5ab9689b43e5c99bae5.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1719990273.git.viresh.kumar@linaro.org>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This extends OPP bindings with the bindings for the `struct opp_table`.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 382 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 381 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index b26e39a74635..4b31f99acc67 100644
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
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
+/// particular, the ARef instance owns an increment on underlying object’s reference count.
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: ARef<Device>,
+    em: bool,
+    of: bool,
+    cpumask: Option<Cpumask>,
+}
+
+// SAFETY: The fields of `Table` are safe to be used from any thread.
+unsafe impl Send for Table {}
+
+// SAFETY: The fields of `Table` are safe to be referenced from any thread.
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
+        // requirements. Refcount of the OPP table is incremented as well.
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
+        // requirements. Refcount of the OPP table is incremented as well.
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
+        // requirements. We took the reference from `from_of` earlier, it is safe to drop the same
+        // now.
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
+        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
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
+        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
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
+        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
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
 /// # Invariants
-- 
2.31.1.272.g89b43f80a514


