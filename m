Return-Path: <linux-pm+bounces-11651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E4940F58
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 12:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798871F23332
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079519E815;
	Tue, 30 Jul 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT4TvYap"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B419E806
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335254; cv=none; b=EevSdGWV0EbCYrGwC3BT//GUVxRrxiTaGaLs4VsZvQ+7GSYJje1ZisAVq94b6e5O5RzrKdqGlqGSXYO4cJ/g4sAVdyFUmfA8tKtqp0huGaJ90Jui7boCp/xTUpLNUeYQSbyQ5eM6PudlOtMwDjelU3fFDcAjn9DoFbUzJqg6NKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335254; c=relaxed/simple;
	bh=OzPunyqGE/5TW6uLHohmOvJN9eUza1Duw/uCRtbeQoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g876X16/zGaXPPhFG34DANycEC8fk6K2C5EPBuPGpA5ggTioRU4ipAGpZOqfxQMHLdmX9l6WOb3Q6Ua5v7NMDyWxUxOIbtTMZVFnQoTu9w477Hgt2MD4hbF4GFJqZHZl6ELsOHmnzDpj6lYJ+EMg33sGKYTHwlsBvkkYVJNxxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eT4TvYap; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd70ba6a15so28713665ad.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335252; x=1722940052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeU9Cta51JYSW0ONrM7wbRe9y3vgozaJuy5zKjtbdGM=;
        b=eT4TvYapOoNF9J+4pb3lx387E27teVIcvVRd00TNs1Tsg6YhEjVAVBXs6qNuW/En+5
         UOajhe5XTxNXweThFHbTBRIrJx6te4GMJg3Hq0aYcgeYrtt5wyEdmG3b/itmtvZMHbZP
         Vu4JL01X6Jmmw3uuyt4r3L4tdGOYaaBMiXaOmL4HtI2o6t3AHi0melZsxzMadxRoKotQ
         fD9Vk1PEgJuXbO7zvWYYYtV/ax/2+kMIPeBm2UAfbpd86NOc5F6fqSkmLkZaveWI6tpD
         YGxGhgP880TnMb/FeYo12TxfONtMC+Z24/QZBMmD+xciwyCY/Lb9Hi0YrsA7jXMEGdmf
         pbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335252; x=1722940052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeU9Cta51JYSW0ONrM7wbRe9y3vgozaJuy5zKjtbdGM=;
        b=sOUPMysF3LjqgpgQHdhOS3UlUzjombN/SuL+Z85rSjgYu0gI2EIpKAnlc/Hr5N8mcU
         m74oSH6s7vAJWNt0vXoAQQm8jGZQFtJAbshTug6lfGgtFqLJDfMs2z+zmITSggc+jfPk
         3IlXwWDGRtnt+c+7ouPm5DJN01aMv7H1d5X59boI1IIqIxKXDV/ZdZHNGp9eiQoMpT6G
         KzuTIyuhQ6Z5kEsTeYlkaEYq9Masul3w+gHsAmAFfI5N4u2kMcvfTd9sG+ZmBRs9rwIj
         Ttl85DDE3xz3wng/0SUpItg2IeTyt2fOPTcXoqgoxujEsKYtD2zUQAudYIdZXjo+tz1J
         TdKg==
X-Forwarded-Encrypted: i=1; AJvYcCWhcwmCkmUJB7tk417bLOPK1jcXCakGoyxIXNft9DuF04564Ifsfp32JDXgmjgJjYLsV0jTeNV3uu/uxgB4Ntd0OkNBLkXfcyI=
X-Gm-Message-State: AOJu0YxULz9E/o6Isd10GEHGXvCttlhIWgqzGr8mK1BcghaotJtByBJM
	IZHUaLOtSN9cy241z09K2y2RRcukr/jd8HnoUFY3FL2Tpmbqkw3i6ybtnjoTVGk=
X-Google-Smtp-Source: AGHT+IHwAyVe6AgJ9Pe0S6EytajK8Bli6aq5tXPwFgiIY0LpnOjDuZ6s1Rr/Syjch7+m5c9f/vtN0w==
X-Received: by 2002:a17:903:1245:b0:1fd:70c4:8389 with SMTP id d9443c01a7336-1ff047eaea7mr110395435ad.7.1722335252007;
        Tue, 30 Jul 2024 03:27:32 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee115dsm98284695ad.143.2024.07.30.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:27:31 -0700 (PDT)
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
Subject: [PATCH V5 3/8] rust: Extend OPP bindings for the configuration options
Date: Tue, 30 Jul 2024 15:57:00 +0530
Message-Id: <a0e6e13c33ac1943b60fad3d64bc3a75766c87c9.1722334569.git.viresh.kumar@linaro.org>
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

This extends OPP bindings with the bindings for the OPP core
configuration options.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 301 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 299 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index c3433b0d8221..113652448056 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -10,11 +10,28 @@
     bindings,
     cpumask::Cpumask,
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
+fn to_c_str_array(names: &[CString]) -> Result<Vec<*const c_char>> {
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
 
 /// Dynamically created Operating performance point (OPP).
 pub struct Token {
@@ -79,6 +96,286 @@ pub enum SearchType {
     Ceil,
 }
 
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the OPP core to configure OPP regulators.
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: &OPP,
+        _opp_new: &OPP,
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
+        // SAFETY: Its safe to return the configuration token number previously received from the C
+        // code.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_config` in the C Code.
+#[derive(Default)]
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
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_raw_table(opp_table, &dev) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(opp)? },
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
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(new_opp)? },
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
 /// Wraps the kernel's `struct opp_table`.
-- 
2.31.1.272.g89b43f80a514


