Return-Path: <linux-pm+bounces-8753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E663B8FFEF7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A0DB22797
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4815CD41;
	Fri,  7 Jun 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6ffCh6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819115B992
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751566; cv=none; b=Du94Ww7Z+vFbIjuKbY4wxLfUvofrQPtPL2nR570GvuiGGWHFwGUXamSkAXUZhDwcz4NCf0Btxb6btLEAbvVrWYti6ZmrjWXsD09Zq86jEYtsw7qRJFSn0hzi/kKqVBJ50hHx9NwiOXzvu+gSfGY3jHMiJrMRWK4p+L8ef3X6c6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751566; c=relaxed/simple;
	bh=LXCum04nUhrgyANF+gOb3ucpEsRPodn6dAeooMzOn1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTuzOBmA7C7wO8qgOMazP+R6SPM+9lHZyOuYsOW53LyaZ1NoqYBTubcOxUnAiuzhexu3JLi313eEMHtmQx14TRge377K8yM5DZx3cKisl6QVdjPcLl1yxSkzQGRiac/6bdmCkk7zlirLIFNc33VO+KOnrKuUa1mOInv2+W/lrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6ffCh6D; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d0fso17130445ad.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751564; x=1718356364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9btnKTfVMmtoCS/Jx3NLWU67XSnzWxib2jE3PLyV70=;
        b=H6ffCh6D0UAnTuxkMTeVcQtw8ak72iDES9e5sagr2R0k2UqMUCE21UpQgnOM2bKllW
         C4EIYtqTrwO31CFO61/UrNcAzRAoOTV52QhNhbuVvbRjWSlQRI/EvQDtUHsvBKnGjWDG
         Kzdtt/2aWF6hZiiajx0ht2QQ27K0UTMRYjdzahgz8g7OOzatfTebVr6C759V6SurepsS
         n5XnWU1XWqFoDMEIYhfZnzQqHESPEbpn0NUk8CezFityqI8ophVpFDPHkeYrxL7cIceM
         rDo7dNOqCfFDpTKVCdd99yFCpb4s2C5ufAp5VpXIc8hrnN/7eJLMMLkTe2JCzE0bRygA
         gASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751564; x=1718356364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9btnKTfVMmtoCS/Jx3NLWU67XSnzWxib2jE3PLyV70=;
        b=gBpum6cQARWTh4kHlHepgEGDtCbLiPIndaTCUW17nsuVYtTA96nMkhyrtsJ9uOmnHo
         K82d7AdpLrwPog+591vSADcoMNDDjhmG92qfAAF51RaTOdgbTw7Ird/THPVvuHMVNi31
         SzV69A301S4We7dxxFId4bLQ9AdAgpyzX3x7L48IlEYXUrbjR9zU3FTYLl1zPowX9nP1
         p/76jJci/xXWIoZ9m76lH5KkW12uWZKsJv2UylwgY+bz+Kgs+WKZaVsaHUWiKHcRDkrr
         TEN86okg1hvYkXnIbmAGpzhZNqu3k4ryqj+LFV+BKdzlmyt61FXyBNDFPOVHgZkpcWRC
         J5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzyOG9rvyRrg4UHlgFD/JsawLFykW942uhplAaMoIBrbWbcI80KRRQPJdUNm8+OEh/dNl9xJDhsg6GL0bt/sJqbq4iMDQwys=
X-Gm-Message-State: AOJu0Yzs5cR8kJ+S7MWyUJ/uRAiJWb1aImRwAJOi3cIgXIeocrL9Zfe4
	hxpvH3ArLdNqZGeBXVxRdxKqJcT9K/CsFuH7UrtA9sOfCg2hEuPXNCwj1oBFcXo=
X-Google-Smtp-Source: AGHT+IE3b0l/jD/45K8IZx1msoSy31zHFA37ziZd4QmuAXy5dOXcKcBDTiHkhFXbDie/5KX//NxijQ==
X-Received: by 2002:a17:902:ecc1:b0:1f6:7e02:6ae0 with SMTP id d9443c01a7336-1f6d03a1132mr23054295ad.44.1717751563661;
        Fri, 07 Jun 2024 02:12:43 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f316sm29440845ad.47.2024.06.07.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:43 -0700 (PDT)
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
Subject: [RFC PATCH V2 2/8] rust: Extend OPP bindings for the OPP table
Date: Fri,  7 Jun 2024 14:42:17 +0530
Message-Id: <dc156230814a899e5e3ffb6f3a0e5471d92506de.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
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
 rust/kernel/opp.rs | 374 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 372 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 9e5cf0412ed5..06f36845047f 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -7,9 +7,9 @@
 //! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
 
 use crate::{
-    bindings,
+    bindings, cpumask,
     device::Device,
-    error::{code::*, to_result, Result},
+    error::{code::*, from_err_ptr, to_result, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
@@ -31,6 +31,376 @@ pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
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
+    cpumask: Option<cpumask::Cpumask>,
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
+    unsafe fn from_ptr(ptr: *mut bindings::opp_table, dev: ARef<Device>) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev,
+            em: false,
+            of: false,
+            cpumask: None,
+        }
+    }
+
+    /// Find OPP table from device.
+    pub fn from_dev(dev: ARef<Device>) -> Result<Self> {
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
+    pub fn from_of(dev: ARef<Device>, index: i32) -> Result<Self> {
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
+    pub fn from_of_cpumask(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_ptr()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        // SAFETY: The `cpumask` is guaranteed by the C code to be valid.
+        table.cpumask = Some(unsafe { cpumask::Cpumask::new(cpumask.as_mut_ptr()) });
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    fn remove_of_cpumask(&self, cpumask: &cpumask::Cpumask) {
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
+    pub fn sharing_cpus(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&self, cpumask: &cpumask::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_ptr())
+        })
+    }
+
+    /// Gets sharing CPUs from Device tree.
+    #[cfg(CONFIG_OF)]
+    pub fn of_sharing_cpus(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<()> {
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
+    pub fn set_opp(&self, opp: ARef<OPP>) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_mut_ptr()) })
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
+        unsafe { OPP::from_ptr_owned(ptr) }
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
+        unsafe { OPP::from_ptr_owned(ptr) }
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
+        unsafe { OPP::from_ptr_owned(ptr) }
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
+    pub fn of_register_em(&mut self, cpumask: &mut cpumask::Cpumask) -> Result<()> {
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
+            } else if let Some(cpumask) = &self.cpumask {
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


