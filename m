Return-Path: <linux-pm+bounces-21461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A18A2A47D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC47718898EE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C622F172;
	Thu,  6 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1LDwLou"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7822F16A
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834170; cv=none; b=hVGjt4U8qg74WYPOqWLMV9PeTM4UERFtcRkfKGkFj44UzTbQ52a5K+5a2R3XJxoAUJluPtaCZChilY3P0/ZgLJ38ZGgJBGlExoEMeFO1xQ41joYL2v7Dsu/6kWVQVGclaV6CX6UECw78dLAasIr3A9x5rV3ItybNgSn/bIxPEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834170; c=relaxed/simple;
	bh=Btyip5cttvaDpQ47Hobx3+HFANarQIo3DBo0MaIGqeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oT4Bpo3QfShOVbyqX+6M3O1BM45Get/pKoCucNrovIq4B7bszPml7TyrNugIOPTStbbobkWywrvZlgGmi87AN49LVSH2HCQ424GO0fMh0dOi71oERiVnDJm4JTnMbs8Z+T5enPDXEltvUmJnL741+F2Tcu8MjGkjJO3twtR8w28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u1LDwLou; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21661be2c2dso12919075ad.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834168; x=1739438968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCUMLmrIOnRhbVUxbyJm2yfzH22vl8wPDByGbPiWd2g=;
        b=u1LDwLou7bY0gbt3sI7wKyY873eAsAJyJtEaPltZHeMETsh3CPeRNci3ZrT/HzcI7h
         bJ+6BfrbvVj/p9RenwbTBpyIJ6RiuYBaW5b+0kXWM1uI4RHERj7UENOH5hhrkc9SbVX3
         e6+mX2QiJYzGxrB3qb97uYrFlYEXQN1hVuNnpW2XxyET/nOnRw4gzccCA6eZlUrV9zsn
         JpOHvs7e7TVjwyRXq8o6yhmeRgVK69xmXiimow6POEwyVN00bdI/GMuupyoKnnO4gNt/
         cgBSqKzKH/PeXAT59g6z7+DoiihZzOfgGdMii+PIfhQUOxT+wgnLzxZcgwWIZrzNvyiN
         qYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834168; x=1739438968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCUMLmrIOnRhbVUxbyJm2yfzH22vl8wPDByGbPiWd2g=;
        b=QofjLlc6+cRPC2/vS5kqsoe4chc1NyHRvDHQR7gLbssRU5ZNFb5VsFhvVbca7zZjPL
         ecP57dSynWUcpgjt2pOeOVeo2/McFXaIOfQUVV9hvf+OyBWKSzAvArpXiriCgqg1UsYE
         hotayTYZ9yHv1F24XQv1aET7PhbqyX+JPTTgCb1bzKR+iPBwRvUN5l1k/KTYRflqhR8k
         JeEkJy/4IYxiFOYzAJqYMH2uzQrk4l0TXNDWuiyJ9aXxcNrr9dx/sUDVgmo4KaJgJa1B
         2iC2Cg7nJv8YVJ+C30gfPRIpEHNkmRPjfBiui3JgOAcgk+3VG7dMNZg3O9Q0QGIIProv
         TT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUnSlKJc34zh1tQtabZhmpb16nygHFzoU/tEVf/n6deXqMFSkHS976GdC4aZIsygZNVlZxwpQHyTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoezHpNNC/gy66aAtfhA+CNNKZ5jr63lx4D80XmU/F4stUgiiD
	yb1+WWCjDVBdN4ICcumM3pm/le9aCOloGFUSZVSmWxrO1HfD/7BBPru+CWgOZqM=
X-Gm-Gg: ASbGnctJlrfeJy6g96BuVZuhc1iMma+2LLkfZeDsYC75iJmcf7rs6CXQg8O6v0EUFEO
	kkveHRbbdocVZ3Adl07Y5uSaa21wUzUYOc7LM7WKL/eeDRFsHQm0AzdOmVLBKA5+yydfk9CT98c
	GH5jla8AgVsOYpNYO5Cj0beZLQaEt+rXUdAT+heQqH89szOog2/fH6aJtxPQ63bVeaAcFQkREhH
	xI4Yl/MXTlB3j9syh1O0Zrrd6bjPQVjR5hBx6HObFXw1nHinL+qYZoqbyr7DJVq5rZ+IeYy0RQH
	/41rqnrllCO3BcjTpA==
X-Google-Smtp-Source: AGHT+IHmOhiNOHtcB647gHK2pP1h0sRGNI8hEpCMxo+dj0zatC2leoJLviSo0fMpbheyGPKxBwoovQ==
X-Received: by 2002:a05:6a21:8dca:b0:1e1:ae4a:1d42 with SMTP id adf61e73a8af0-1ede88ad419mr13625445637.31.1738834168119;
        Thu, 06 Feb 2025 01:29:28 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aeb8d09sm822696a12.15.2025.02.06.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:27 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
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
Subject: [PATCH V8 09/14] rust: Extend OPP bindings for the configuration options
Date: Thu,  6 Feb 2025 14:58:30 +0530
Message-Id: <a1c3b72c12508d12b2f73ed92cceafb27f241ecf.1738832119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
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
index c0daeadfb188..8028245e94aa 100644
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


