Return-Path: <linux-pm+bounces-25237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464EBA85AE9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FC944609A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51429DB95;
	Fri, 11 Apr 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKxEENK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFD238C06
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369187; cv=none; b=jU/AQeyG4U1JbEKEFTSHKwu7jt4zb5EUG5V0bvnSl556158bhXLBbFllTBIAfOx4OEQqyR2vbJ8m1IZSNjCpwGxRRdtJ2HwJVrPuXiuc9+zfJtFpb9ziEj1SNdvmUcPPA+E48o4sbT7Lr/stBenNhCYGx0PFADJzi0j3rtDVvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369187; c=relaxed/simple;
	bh=5Eq5CK5DJNRSRgLaEHiffky2SmkD7YuvQ0tSFHY4iSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSOtsw+OSwvIaLXXGRSNx2XNfIXnO4T7AahlMxXsjT3+FQDa0FZBGwzAqdqCNLBddGSJE9p51mZGAaRdXoBFYCmFXUk9UjhOzrboxqxlGN8Xxq+LYsjh2JBeK3jqxax4ImhCWCYtGDkVKv/sZ3nEtf1VxgVmQJMDEKfnqSFPnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKxEENK6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739525d4e12so1679697b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369184; x=1744973984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocHLGgroWw9XR29SBCdpCasA3D4zU5sFSewJv0c9Qwc=;
        b=kKxEENK6p7Yrk6EXbU1sEe85yHO75iAOmM0lZEmVH+7xKGwB3DzmDvzxFJb5FY7OyU
         S/DSPvXGsmCJ/Ox6S9xj2PuP94KgmZGhuHN4oxzR6G+DVro24956RKcEqd6y7da3n/5Q
         L7gi70g2YgVOQyvy95lDGk8F1EMvoIH+uADUtcdoHlMyigCPFAW2bKiSPr0P+hFvV7h9
         LTPfG6rIExkoPorV4/Wz6JKm3+0i0ygiQAnqZLrbRh5d4lcTmarnWjmlWqclHG8g/9Wf
         tcOIp9T9gHv29sJcf2fLe9ixNdEzyLHmyFFZMgb2yBQXRGM+h22b1MZKQFlJkrD+dV0d
         haEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369184; x=1744973984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocHLGgroWw9XR29SBCdpCasA3D4zU5sFSewJv0c9Qwc=;
        b=ZYZC8gVLfzOEHVmmpFA4GKeqekRmOpaBCzFuq3iU1epQQOk5VONYMqAoeqsEcLTNaw
         uO6e9U11U5H1aYOSj5yga40ebML1rpZyxy7iPh7DFfsdF5avZysNYJD6WV6L0III8i1N
         e5g8gpxKhDgFYai0aqj8wd2liEroE3bBSX8+qfg6eAxToQRxpdq8UFawHzAIfFjvIgzw
         ZE+ftjaahRoYJimlLgt8Af5b77cXZun90TzvjSA6UWnb17ouW59YBI6qRssmhNxD/F8H
         VoSRP3iz/5CS6MxRScp2J7z0kKPFTfnfVTZLeb0qIlR//ifa6uo/kuxT+UilOYoflREP
         HqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6eEpV3nSG9XSLV2wu9Ln1zUOfFgEes4hA3QSyA/o98q8SqZHBbxKLvq027eQJtAsN+QD9jmMb3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOoAmcfPESFPvuf3HB/yhsi+BonNkE5JEB3LlCjCZJjeBe27A
	2Gez1X/D7JdZ84nnajnW5dcDA35G+Fjjie8jcrG9EsV6a11UVLctd7GZM3G1IwI=
X-Gm-Gg: ASbGncuhx83r/qXGZrI71qAhYZcBiLR/8fr0yCa/BdnMLMXWnNymFPexyHAzQWo+2pE
	RCaX2+Abntx8zC1NGoMxRHPW70e//Wlw1eAojpFrMTGGtMou3PyenPqpdB8dTBjWKpG6nPGhw8I
	iIfdPOoWZi96jqQ4GQLM9TufoycACf2kJgIID5jcYruy6m7mMA3fUBvdXsg3OCiA9jPVZpvabb+
	VVbPSd/27q7D3HCEwvhW1Bf6ec8GDWPFmi273owyZWJFgIc6Vt5h3xeaxYZf8+ZxzYqs3x07Izl
	4Td84PiUm4M4YFw0jIxQh3UjES+TqroruMu/ZaHqCg==
X-Google-Smtp-Source: AGHT+IH1XxwScpzrO8aDsAp9VqOmTRGaFUuE6LCBwuUM+PoiHXy5XopQJocc7OocFzI61WrTtGmv9g==
X-Received: by 2002:a05:6a21:8cc5:b0:1f3:40a9:2c36 with SMTP id adf61e73a8af0-201797a079cmr3503827637.10.1744369183576;
        Fri, 11 Apr 2025 03:59:43 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198c17sm1200453b3a.36.2025.04.11.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:43 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 12/17] rust: opp: Add abstractions for the configuration options
Date: Fri, 11 Apr 2025 16:25:11 +0530
Message-Id: <5257b8065580d0218919d160170f301144a8939f.1744366571.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Rust abstractions for the OPP core configuration options,
enabling safe access to various configurable aspects of the OPP
framework.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 295 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index e074009e4b7a..7bf612fa0cc5 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -13,12 +13,29 @@
     clk::Hertz,
     cpumask::{Cpumask, CpumaskVar},
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Error, Result},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::c_ulong,
+    prelude::*,
+    str::CString,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::ptr;
+use core::{marker::PhantomData, ptr};
+
+use macros::vtable;
+
+// Creates a null-terminated slice of pointers to [`Cstring`]s.
+fn to_c_str_array(names: &[CString]) -> Result<KVec<*const u8>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
+
+    for name in names.iter() {
+        list.push(name.as_ptr() as _, GFP_KERNEL)?;
+    }
+
+    list.push(ptr::null(), GFP_KERNEL)?;
+    Ok(list)
+}
 
 /// The voltage unit.
 ///
@@ -206,6 +223,280 @@ pub enum SearchType {
     Ceil,
 }
 
+/// OPP configuration callbacks.
+///
+/// Implement this trait to customize OPP clock and regulator setup for your device.
+#[vtable]
+pub trait ConfigOps {
+    /// This is typically used to scale clocks when transitioning between OPPs.
+    #[inline]
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// This provides access to the old and new OPPs, allowing for safe regulator adjustments.
+    #[inline]
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: &OPP,
+        _opp_new: &OPP,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// OPP configuration token.
+///
+/// Returned by the OPP core when configuration is applied to a [`Device`]. The associated
+/// configuration is automatically cleared when the token is dropped.
+pub struct ConfigToken(i32);
+
+impl Drop for ConfigToken {
+    fn drop(&mut self) {
+        // SAFETY: This is the same token value returned by the C code via `dev_pm_opp_set_config`.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// OPP configurations.
+///
+/// Rust abstraction for the C `struct dev_pm_opp_config`.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to set OPP property-name configuration for a [`Device`].
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::{Config, ConfigOps, ConfigToken};
+/// use kernel::str::CString;
+/// use kernel::types::ARef;
+/// use kernel::macros::vtable;
+///
+/// #[derive(Default)]
+/// struct Driver;
+///
+/// #[vtable]
+/// impl ConfigOps for Driver {}
+///
+/// fn configure(dev: &ARef<Device>) -> Result<ConfigToken> {
+///     let name = CString::try_from_fmt(fmt!("{}", "slow"))?;
+///
+///     // The OPP configuration is cleared once the [`ConfigToken`] goes out of scope.
+///     Config::<Driver>::new()
+///         .set_prop_name(name)?
+///         .set(dev)
+/// }
+/// ```
+#[derive(Default)]
+pub struct Config<T: ConfigOps>
+where
+    T: Default,
+{
+    clk_names: Option<KVec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<KVec<CString>>,
+    supported_hw: Option<KVec<u32>>,
+
+    // Tuple containing (required device, index)
+    required_dev: Option<(ARef<Device>, u32)>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps + Default> Config<T> {
+    /// Creates a new instance of [`Config`].
+    #[inline]
+    pub fn new() -> Self {
+        Self::default()
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(mut self, names: KVec<CString>) -> Result<Self> {
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
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(name);
+        Ok(self)
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(mut self, names: KVec<CString>) -> Result<Self> {
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
+    /// Initializes required devices.
+    pub fn set_required_dev(mut self, dev: ARef<Device>, index: u32) -> Result<Self> {
+        if self.required_dev.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.required_dev = Some((dev, index));
+        Ok(self)
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
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
+    ///
+    /// The returned [`ConfigToken`] will remove the configuration when dropped.
+    pub fn set(self, dev: &Device) -> Result<ConfigToken> {
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
+        let prop_name = self
+            .prop_name
+            .as_ref()
+            .map_or(ptr::null(), |p| p.as_char_ptr());
+
+        let (supported_hw, supported_hw_count) = self
+            .supported_hw
+            .as_ref()
+            .map_or((ptr::null(), 0), |hw| (hw.as_ptr(), hw.len() as u32));
+
+        let (required_dev, required_dev_index) = self
+            .required_dev
+            .as_ref()
+            .map_or((ptr::null_mut(), 0), |(dev, idx)| (dev.as_raw(), *idx));
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
+            supported_hw,
+            supported_hw_count,
+
+            required_dev,
+            required_dev_index,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
+        // and so we don't need to save a copy of them for future use.
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ConfigToken(ret))
+        }
+    }
+
+    // Config's clk callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut kernel::ffi::c_void,
+        scaling_down: bool,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::get_device(dev) };
+            T::config_clks(
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_raw_table(opp_table, &dev) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(opp)? },
+                scaling_down,
+            )
+            .map(|()| 0)
+        })
+    }
+
+    // Config's regulator callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: kernel::ffi::c_uint,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::get_device(dev) };
+            T::config_regulators(
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(new_opp)? },
+                regulators,
+                count,
+            )
+            .map(|()| 0)
+        })
+    }
+}
+
 /// A reference-counted OPP table.
 ///
 /// Rust abstraction for the C `struct opp_table`.
-- 
2.31.1.272.g89b43f80a514


