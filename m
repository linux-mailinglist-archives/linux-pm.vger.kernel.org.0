Return-Path: <linux-pm+bounces-8754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC48FFEF9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475E21F21DD4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCF15CD76;
	Fri,  7 Jun 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1T8ZkTE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC915CD56
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751571; cv=none; b=Hl/4fBlZYiB/7Ac1Kx7yWR/YlPVbL2AptKNz8f8JN0KJT1t1SKVNTQyTJidSkC5CCpNC9gsjCHGuKYXp4qkRm1/0a9F02dDrQpJ5M9s1hZ92l+U0UhL3cDbAv/uxBp7B5s2orCQoozV/gByhf8u4R0j8WzY523p2Oj1kgO9U02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751571; c=relaxed/simple;
	bh=yQbu2BzvfcyL06wty0oKxJIOgxPxe0NA+Oypu+rr8gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACJ8Q1DK7A7U8LHcs70w8eyKUN9ahg0wyg0cM9wDku00x5X5S8UZ6s3P3hT15g0bT3nERcagCPFrHH/eWSabS/ec/plNv4m34Pd7891gTxIIBzbmmACV2qWjpbXjJXQFYJTNvtMeeEDXXUr7mSWddD0WQ424dXfnfWARz2GEo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1T8ZkTE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6a837e9a3so12873865ad.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751567; x=1718356367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFgEQc5AxyZLZc/ZKTPUL3s2+RpIEiR6EvwV6W5lrPI=;
        b=J1T8ZkTELA5SI9D4hxC0pkjO6v3bd9v7W11iG/AmMtR0EZFLwxbINxtrs+Hk8PtX0I
         Pdad2urIax4uaRGxOcMbZYIBCj6T7d/R39n1i3VnSbzKXN1XIpU6bEFlDdRV//nleYXH
         VU6Mdi39oopr/8hCqgsLxYxXQuuJWwApMalmCdT9h0HprKNl4NFvEYPkdRbnxU1patbu
         0gXt08cyOu0nhe3QB55r3vJKwgei1ZVVuPV0LF4aX2j3qFxErMIEPgXT1py/K64Xnk76
         sqcLcJKMY+ZiATmd6rNoqGJfrSeJfIpCAeXJ7FMsSS/pMO+92FZGsZ5ymMa2tEihrCbm
         fKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751567; x=1718356367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFgEQc5AxyZLZc/ZKTPUL3s2+RpIEiR6EvwV6W5lrPI=;
        b=mOg1xnfPBcMzD28XPLSzLpLDUpzyjMuxfExF2Ey/s3ru1G9yrNFLYdNepP+DpO75oX
         zklZwIzaWWon+Cle74S6pyLJyMQ0Z7KJ1C2jFKblMJmc5+d+WN39hmnAhKv0jabt+qC2
         oh5kMdKh4Nosv2NgZhFlY4b3+8D6c6YdMFkU4qk/+DBOdp4kRqJx0iBNUKKUhV5aJS6/
         6vg7qjcmnOaRaii98G4AUJjLE/VgmclHoyIhNYu6oheTeA+sE1KFEnhpMm0VAtP8Ua1B
         DmBNXr8Lt1/UWpzpsffKomknxlatSmmfYX7Ikalu9meXn/F21rgISQvCLCiTsOBUjuUX
         6sIA==
X-Forwarded-Encrypted: i=1; AJvYcCXFLlsfNXgMzzY5N1SH1Z7rnLpvYmTsWMM+kA8j48lwqNVp0IHT5PO5vhGVIozChmpAr4D4e3S4fBdcAHtgEB3mKvhWduE0TCE=
X-Gm-Message-State: AOJu0Yx3Yng2qdKjhUHWOQHKPNBFvhnRUYApitZqa4OBKUpvoC2kBuw3
	2Ey6s+b4ZQd3cKOYMCA2xBPehsZlYsjzdDalYdVuLPTIXNYcktJhqm50/ss7uDM=
X-Google-Smtp-Source: AGHT+IEBd3DIoYngBelIp3hj7BJXY8CXcrTfGyQViok7B8N4sl1SBFb77/zOViK4tMx3pS79KHwrBg==
X-Received: by 2002:a17:903:984:b0:1f6:8235:dbbc with SMTP id d9443c01a7336-1f6d02f4747mr24505395ad.29.1717751567374;
        Fri, 07 Jun 2024 02:12:47 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7fd6cfsm29198765ad.274.2024.06.07.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:46 -0700 (PDT)
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
Subject: [RFC PATCH V2 3/8] rust: Extend OPP bindings for the configuration options
Date: Fri,  7 Jun 2024 14:42:18 +0530
Message-Id: <37bdd7ee7b74292830dd9977154b08ebcf08a138.1717750631.git.viresh.kumar@linaro.org>
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

This extends OPP bindings with the bindings for the OPP core
configuration options.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 305 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 303 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 06f36845047f..ebcb77b52558 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -9,11 +9,28 @@
 use crate::{
     bindings, cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Error, Result},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    str::CString,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::ptr;
+use core::{ffi::c_char, marker::PhantomData, ptr};
+
+use macros::vtable;
+
+// Creates a null-terminated slice of pointers to Cstrings.
+fn to_c_str_array(names: &Vec<CString>) -> Result<Vec<*const c_char>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = Vec::with_capacity(names.len() + 1, GFP_KERNEL)?;
+
+    for name in names.iter() {
+        list.push(name.as_ptr() as _, GFP_KERNEL)?;
+    }
+
+    list.push(ptr::null(), GFP_KERNEL)?;
+    Ok(list)
+}
 
 /// Equivalent to `struct dev_pm_opp_data` in the C Code.
 #[repr(transparent)]
@@ -42,6 +59,290 @@ pub enum SearchType {
     Ceil,
 }
 
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(
+        _dev: ARef<Device>,
+        _table: &Table,
+        _opp: ARef<OPP>,
+        _scaling_down: bool,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the OPP core to configure OPP regulators.
+    fn config_regulators(
+        _dev: ARef<Device>,
+        _opp_old: ARef<OPP>,
+        _opp_new: ARef<OPP>,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Config token returned by the C code.
+pub struct ConfigToken(i32);
+
+impl Drop for ConfigToken {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_config` in the C Code.
+pub struct Config<T: ConfigOps> {
+    clk_names: Option<Vec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<Vec<CString>>,
+    genpd_names: Option<Vec<CString>>,
+    supported_hw: Option<Vec<u32>>,
+    required_devs: Option<Vec<ARef<Device>>>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps> Config<T> {
+    /// Creates a new instance of [`Config`].
+    pub fn new() -> Self {
+        Self {
+            clk_names: None,
+            prop_name: None,
+            regulator_names: None,
+            genpd_names: None,
+            supported_hw: None,
+            required_devs: None,
+            _data: PhantomData,
+        }
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured.
+        if self.clk_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.clk_names = Some(names);
+        Ok(self)
+    }
+
+    /// Initializes property name.
+    pub fn set_prop_name(mut self, name: CString) -> Result<Self> {
+        // Already configured.
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(name);
+        Ok(self)
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured.
+        if self.regulator_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.regulator_names = Some(names);
+
+        Ok(self)
+    }
+
+    /// Initializes genpd names.
+    pub fn set_genpd_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.genpd_names = Some(names);
+        Ok(self)
+    }
+
+    /// Initializes required devices.
+    pub fn set_required_devs(mut self, devs: Vec<ARef<Device>>) -> Result<Self> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if devs.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.required_devs = Some(devs);
+        Ok(self)
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(mut self, hw: Vec<u32>) -> Result<Self> {
+        // Already configured.
+        if self.supported_hw.is_some() {
+            return Err(EBUSY);
+        }
+
+        if hw.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.supported_hw = Some(hw);
+        Ok(self)
+    }
+
+    /// Sets the configuration with the OPP core.
+    pub fn set(self, dev: ARef<Device>) -> Result<ConfigToken> {
+        let (_clk_list, clk_names) = match &self.clk_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_regulator_list, regulator_names) = match &self.regulator_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_genpd_list, genpd_names) = match &self.genpd_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let prop_name = match &self.prop_name {
+            Some(x) => x.as_char_ptr(),
+            None => ptr::null(),
+        };
+
+        let (supported_hw, supported_hw_count) = match &self.supported_hw {
+            Some(x) => (x.as_ptr(), x.len() as u32),
+            None => (ptr::null(), 0),
+        };
+
+        let (_required_devs_list, required_devs) = match &self.required_devs {
+            Some(x) => {
+                // Create a non-NULL-terminated vectorof pointers.
+                let mut list = Vec::with_capacity(x.len(), GFP_KERNEL)?;
+
+                for dev in x.iter() {
+                    list.push(dev.as_raw(), GFP_KERNEL)?;
+                }
+
+                let ptr = list.as_mut_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null_mut()),
+        };
+
+        let mut config = bindings::dev_pm_opp_config {
+            clk_names,
+            config_clks: if T::HAS_CONFIG_CLKS {
+                Some(Self::config_clks)
+            } else {
+                None
+            },
+            prop_name,
+            regulator_names,
+            config_regulators: if T::HAS_CONFIG_REGULATORS {
+                Some(Self::config_regulators)
+            } else {
+                None
+            },
+            genpd_names,
+            supported_hw,
+            supported_hw_count,
+
+            // Don't need to support virt_devs for now.
+            virt_devs: ptr::null_mut(),
+            required_devs,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. The OPP core guarantees to not use fields of `config`, after this call has
+        // returned and so we don't need to save a copy of them for future use
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ConfigToken(ret))
+        }
+    }
+
+    // Config's config_clks callback.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut core::ffi::c_void,
+        scaling_down: bool,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::from_raw(dev) };
+            T::config_clks(
+                dev.clone(),
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_ptr(opp_table, dev) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(opp)? },
+                scaling_down,
+            )
+            .map(|_| 0)
+        })
+    }
+
+    // Config's config_regulators callback.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::from_raw(dev) };
+            T::config_regulators(
+                dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(new_opp)? },
+                regulators,
+                count,
+            )
+            .map(|_| 0)
+        })
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
-- 
2.31.1.272.g89b43f80a514


