Return-Path: <linux-pm+bounces-20314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D551A0B59B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79DC3A1DBC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441EE3DABEB;
	Mon, 13 Jan 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHbLdA3c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261D3DABE0
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767453; cv=none; b=Hk7B+0gw0yQsf1BaiDk/9cTVfHEmX63V0TNg1OHqsNQvLFPwFFoPaSpALFQfr/egh8m8Va7OSo6619intzhqDpN44kyRHFntvdo5YV7QI9UWBTOQYbT8LeXLixpB7OHv1Kd2n3XCILTZm0gH3qQ1a+7wXNqDoLj/7PuWPY5kgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767453; c=relaxed/simple;
	bh=HvTNnupc2EFRJvcBV6gbrEBwWsZdiLH3T39OSFYdg68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owCpQws1J+E32gAFc2vg9zNSRwcrWA+L3Fp40C1eaEVfwOwBC3mvdzoA1X2yZx9+TdYjoGCffuK8vbFDKcjg43z/aMen3JBugd8LS03pnf5w0v4id1yqC32mF/ev2OzjJF8iyJ7Sv+nktCfXLrAgmy2Eg1FV+UCX7HYkg4240a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHbLdA3c; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216395e151bso49340445ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767451; x=1737372251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWWPIaDzJ6TtRNiPxhkMnMASI1Go/QPlOZW3kN1s+RM=;
        b=NHbLdA3cgyTxTgaphjxzRMtfE5z3gmd9sPuaGPLF4X7qS0gvbKC33NZTzPGNoC8PeH
         Rmncp3evwKAcO1y5WhDpUzBAIKu3+lKy+sTDz5lbhisFY5XookJA/n0MOb4MXRGklGrc
         bG4dip1U4vguIN+0n+X0m5RBlGrHxDCR3yFFXrQhjkC10sSv+MOQyZ+erxmoD10Lv/X8
         4FpPhhHgnrvU/lVFUV5npWW36Sj4c9U4Rt7dAS5r/WyBsF0tAOCvLvCUqeB+bEo7jwoD
         VqTVmuk9uTaRbAFZbzvJaMPOnA8cBfo3m3Nc/ihe+dlJt3ji1viic7bdc/KQ6LBkvBEH
         nczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767451; x=1737372251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWWPIaDzJ6TtRNiPxhkMnMASI1Go/QPlOZW3kN1s+RM=;
        b=gEo6HQ36rL8OXp04MkDfR+XjvHI1NIlq4iFCK0eYNMnM0smk2Kx3fmTzdh7E2yxlep
         ytClvoU3r9XJd0iAHt/kKC7mC0InuO6g6xB9Iu6SAxfg+LQBGhozwhsX4KAJOs8xf4V/
         maQQ1IQIKrNa8by9Bb0cm+tH5MgtRQfzAmNFHv0PwCoWQEZB0j9SsobFqkOg4RzjZT6/
         DVHYStrgk4gTbLQZnpriLmVoPzQ0fLE78hRBMxgESo9nhqnGwDnDC/YxRW70+8jyBpBx
         n8Gs0mMRyU/2wQMdcmdquRpOhUU8Oezr9MSvRt+DTwR7cYLHgXaMV6KZ7HieaHdbYXoW
         Rwvw==
X-Forwarded-Encrypted: i=1; AJvYcCVCNlnry8iWw3c+l6RAa6/PAL0gTkQzcxeNZIARd45j3Q9MsX+oN7vkExh6EeMzDIWiuJE5LWEXbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0EOBWhjk3ozxSLspeOWO6MSAn8JYRLYtClWjKaANa6GJeBBS
	djl9PitGdaAJ0rXINHIJ6IGAnQRBYVF5ECjzQZ2plP/4ETT8cHLtOCc8bjz4KIs=
X-Gm-Gg: ASbGnct7F3yppQny5O3ZqC44T0wwrO7yW9C4MKELN4Joyf4efDHW47DbQAhaIzB9YMK
	mz7bmkfkObeqQz5DUAxGSuTZgqK2Vh45oVjCfCNlrVIwtvhZ8bSue41VC2RoQS0rrqFmObPbBfa
	56P9Yj4P2UD2Bm5rcccxdm6UaOYF1d0v1cbwAiu9NtagYiQFpKb+5Ht3nSe+9Tg+D1huEHZixla
	LLyLrAdqqF6eUsCmnXTJx0hqSTPFhy96AZ/qLAUv3aJR3m05S8Abg3rMQE=
X-Google-Smtp-Source: AGHT+IGiyKcuVgM1Ys0i/tuRnV6jvK7jW7PsJedRIoMQWDTCXNoVpynGn0EranSE4BEcCImlbEEWdg==
X-Received: by 2002:a17:903:4084:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-21ae88b9d14mr109464815ad.23.1736767450746;
        Mon, 13 Jan 2025 03:24:10 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f138854sm52030505ad.96.2025.01.13.03.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:10 -0800 (PST)
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
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 10/16] rust: Extend OPP bindings for the configuration options
Date: Mon, 13 Jan 2025 16:53:05 +0530
Message-Id: <6a493402c7f856d2e0a9d7d1d296669e4b6a7010.1736766672.git.viresh.kumar@linaro.org>
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

This extends OPP bindings with the bindings for the OPP core
configuration options.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 262 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index d3b98d9a554e..22c4d543f456 100644
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
+use core::{marker::PhantomData, ptr};
+
+use macros::vtable;
+
+// Creates a null-terminated slice of pointers to Cstrings.
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
 
 /// Dynamically created Operating performance point (OPP).
 pub struct Token {
@@ -79,6 +96,247 @@ pub enum SearchType {
     Ceil,
 }
 
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
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
+        build_error!(VTABLE_DEFAULT_ERROR)
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
+    clk_names: Option<KVec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<KVec<CString>>,
+    supported_hw: Option<KVec<u32>>,
+    required_dev: Option<ARef<Device>>,
+    required_dev_index: Option<u32>,
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
+            supported_hw: None,
+            required_dev: None,
+            required_dev_index: None,
+            _data: PhantomData,
+        }
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(mut self, names: KVec<CString>) -> Result<Self> {
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
+    pub fn set_regulator_names(mut self, names: KVec<CString>) -> Result<Self> {
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
+    /// Initializes required devices.
+    pub fn set_required_dev(mut self, dev: ARef<Device>, index: u32) -> Result<Self> {
+        // Already configured.
+        if self.required_dev.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.required_dev = Some(dev);
+        self.required_dev_index = Some(index);
+        Ok(self)
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
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
+        let (required_dev, required_dev_index) = match &self.required_dev {
+            Some(x) => (x.as_raw(), self.required_dev_index.unwrap()),
+            None => (ptr::null_mut(), 0),
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
+            supported_hw,
+            supported_hw_count,
+
+            required_dev,
+            required_dev_index,
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
 /// Operating performance point (OPP) table.
 ///
 /// Wraps the kernel's `struct opp_table`.
-- 
2.31.1.272.g89b43f80a514


