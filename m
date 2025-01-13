Return-Path: <linux-pm+bounces-20313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFDA0B598
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD111887AFA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57628EC7A;
	Mon, 13 Jan 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aK7H+I3X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A482343B1
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767450; cv=none; b=uBPBojV+2WUdoxD2JRfvdbazDkvIehWMQRVi7lHDhO7nTnrakWLdDjErRJ0DQQ30nIgwGaBr33uOFfT7/T16Rey5QZtE2YkCWPWezhnojVz++ObbB96WhuEINu6TvqtynIxkkh5Ex4OKlTH69XgkX9NCyPDis9QQHnrZUW6xp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767450; c=relaxed/simple;
	bh=vsHZhCkGhVZ0mCcuXZBy4kwTUYm334wXEh9JY7v2xKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGJV5k/EljTaauX4LboiLkQOwGY3Jnn72G0SGfzwaNULoL4N2k2CyPcXHdFFKbYxStsWT3xP1Bv30Ge4poAAvvCATdOEwYRVkgRkcTanOaG8LMeBqPDboSIRXjtVEhVTFFa/GA9QrYsa5M+N8J1az2NnzoiVw1kRw3/RCwXa44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aK7H+I3X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163dc5155fso73997505ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767447; x=1737372247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftCsOZitCmeRyVqQ2YCyIstFqWVeJbqxa6tUfw80DGc=;
        b=aK7H+I3XSJIYjWTOhYlYUF14mytD/0g6c6C83Z1I21/HwWolexuSGPO8P2Cl0xK4kb
         12/JCKtsoMvlHK/q79HYJMIpwfj9OLKr3N4CzjKmFyvNb7YBhiUvgpTzK0pZbQqVI83L
         DSt7e++8qrLwDlPiIEW1KicX+zbXiD+7qEMaFO8tQwCYkVrxZZjmapNlsnQ3zTpd+t3G
         Hq2VNGzYAugMjNsqS4aDr7zMfsmdk9gNBtN2M6Cfz5XrGZVryDyAYuYwAbNzlSgxf3Il
         l2z17ymr5bNds2M2y3AbAMfX6Mc3GLL9Gw8H5F9tPEHmxsdkOFyl8js8MrSnvUuVWAI3
         ir0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767447; x=1737372247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftCsOZitCmeRyVqQ2YCyIstFqWVeJbqxa6tUfw80DGc=;
        b=GxiWKfmazWmZR3EJFfDhrjd9SW1Uyunpp1zqGb3Ph3ltjM2MS5zehwC71tdLd8vr6N
         D6NpnCMhYuqky0ZL2X8gYMh+eZFSPi3lQcTqy4xJgAiLeXUtFVIOVSuoiykMYqcqRc/6
         3IU/X4hEVnfs9IE7mSN+rT4ovLaHHXAxIEDCP8oHTiNL8LQBRqyREL+NIhIac9rKdz/n
         mkb0tgT8Y1U165n77MrvAy1uYvDYhiF4/MIk3PN7k9lNf2OdOitiDebOV+u+41CsO5sN
         oKSYXaKj3hHXk4tiKDBHbkYXQRb7sPJHI4gdKreVaEaMjgLQXL3PQMR3G7wkuEQRi5E+
         BX2g==
X-Forwarded-Encrypted: i=1; AJvYcCVjSlPejkfrRoQ0Ysk42L0isG6yM0MX0sh9M9Jck92cDHfFtOEmDYk9DGEmsAqjTNWQfnmc5WICLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt3Uy9BZfRHO8C0lzjFYEyXs7npq2wqLHw+8w2T0xFZ2bDL0O
	uBmxNWCM2mPEHdZqQFFg9mpwynFgIjksEC5osBagI94whdrXvUep+rEbOWet+4s=
X-Gm-Gg: ASbGncu7EOYhdZqMgYWXOPiTlNCThgM+0LU4kU2y8bDOauY4yDAxsZbNOLp2mRylRX/
	8l4+pnbvk8w3tsM35McTaLfM4JsqRKpAj5tKl1z6JTyeeTTyIIMF7aCuREF/UDqRraD9Y1UKd3i
	x5Vy2ZjiRpeTPDcfYEIfEdPb+fQa1EDIZUEDekY7/wQ1oYVVbbQ8TQf0zW5MDWrT2OEFddVmmjg
	PE7/65S/9qPEl4+OQmg6sCOEeIRj5J8PDIMUjbWmSI8muOuP44c9FnWRRA=
X-Google-Smtp-Source: AGHT+IHmleW8WQsIyr/tT0LTvcZCq3ZUva4QmBy1v6QT3fROfylP0efo3dalrM+odvmOPxjpmdrwUA==
X-Received: by 2002:a05:6a00:22c7:b0:725:c8ea:b320 with SMTP id d2e1a72fcca58-72d21feb16fmr26578518b3a.14.1736767447288;
        Mon, 13 Jan 2025 03:24:07 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658b64sm5760219b3a.109.2025.01.13.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:06 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 09/16] rust: Extend OPP bindings for the OPP table
Date: Mon, 13 Jan 2025 16:53:04 +0530
Message-Id: <6ee4476b61fba69b879b98f69668dfe0b993821a.1736766672.git.viresh.kumar@linaro.org>
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

This extends OPP bindings with the bindings for the struct opp_table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 383 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 382 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index becb33880c92..d3b98d9a554e 100644
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
 
@@ -67,6 +68,386 @@ fn freq(&self) -> usize {
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
+    pub fn from_dev(dev: &Device) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. Refcount of the OPP table is incremented by the C code.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.into(),
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
+    pub fn from_of_cpumask(dev: &Device, cpumask: &mut Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_raw()) })?;
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
+    fn remove_of_cpumask(&self, mut cpumask: Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from `from_of_cpumask` earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_raw()) };
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
+    pub fn max_clock_latency(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max volt latency of the OPPs in the table.
+    pub fn max_volt_latency(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max transition latency of the OPPs in the table.
+    pub fn max_transition_latency(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns the suspend OPP.
+    pub fn suspend_freq(&self) -> usize {
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
+            bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_raw())
+        })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_raw())
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
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.as_raw(), cpumask.as_raw())
+        })
+    }
+
+    /// Updates the voltage value for an OPP.
+    pub fn adjust_voltage(
+        &self,
+        freq: usize,
+        u_volt: usize,
+        u_volt_min: usize,
+        u_volt_max: usize,
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
+    pub fn set_rate(&self, freq: usize) -> Result<()> {
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
+        mut freq: usize,
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
+                bindings::dev_pm_opp_find_freq_ceil_indexed(rdev, &mut freq as *mut usize, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(rdev, &mut freq as *mut usize, index)
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
+    pub fn enable_opp(&self, freq: usize) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq) })
+    }
+
+    /// Disable the OPP.
+    pub fn disable_opp(&self, freq: usize) -> Result<()> {
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
+            bindings::dev_pm_opp_of_register_em(self.dev.as_raw(), cpumask.as_raw())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    // Unregisters with Energy model.
+    #[cfg(all(CONFIG_OF, CONFIG_ENERGY_MODEL))]
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
+            #[cfg(CONFIG_ENERGY_MODEL)]
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


